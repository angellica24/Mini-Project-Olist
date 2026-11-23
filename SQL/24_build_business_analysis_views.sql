USE olist_ecommerce;

-- 24. BUSINESS ANALYSIS VIEWS (6 views; 1 file)
-- Semua tabel *_raw dan *_clean TIDAK diubah.
-- Angka penjualan = nilai barang (SUM order_items.price) untuk order DELIVERED,
-- bukan pengakuan pendapatan akuntansi/total pembayaran.
-- Seluruh nilai uang menggunakan mata uang dataset Olist (BRL).

-- 1. Penjualan barang per bulan pembelian (hanya delivered)
CREATE OR REPLACE VIEW vw_olist_monthly_sales AS
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS purchase_month,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    COUNT(*) AS sold_item_rows,
    ROUND(SUM(i.price), 2) AS merchandise_sales_brl,
    ROUND(SUM(i.freight_value), 2) AS freight_value_brl,
    ROUND(SUM(i.price) / COUNT(DISTINCT o.order_id), 2) AS avg_merchandise_per_order_brl
FROM olist_orders_clean o
JOIN olist_order_items_clean i ON i.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m');

-- 2. Kategori dengan nilai barang terbesar (hanya delivered)
CREATE OR REPLACE VIEW vw_olist_category_sales AS
SELECT
    COALESCE(t.product_category_name_english,
             p.product_category_name,
             'Unknown') AS product_category,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    COUNT(*) AS sold_item_rows,
    ROUND(SUM(i.price), 2) AS merchandise_sales_brl
FROM olist_order_items_clean i
JOIN olist_orders_clean o ON o.order_id = i.order_id
LEFT JOIN olist_products_clean p ON p.product_id = i.product_id
LEFT JOIN olist_category_translation_clean t
       ON t.product_category_name = p.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY COALESCE(t.product_category_name_english,
                  p.product_category_name,
                  'Unknown');

-- 3. Satu baris per order delivered yang tanggalnya dapat dianalisis.
-- Rating dihitung RATA-RATA PER ORDER dan hanya dari jawaban review
-- yang tercatat setelah/saat penerimaan barang.
CREATE OR REPLACE VIEW vw_olist_delivery_review AS
SELECT
    o.order_id,
    DATE(o.order_purchase_timestamp) AS purchase_date,
    DATE(o.order_delivered_customer_date) AS delivered_date,
    DATE(o.order_estimated_delivery_date) AS estimated_delivery_date,
    DATEDIFF(DATE(o.order_delivered_customer_date),
             DATE(o.order_estimated_delivery_date)) AS delivery_delay_days,
    CASE WHEN DATE(o.order_delivered_customer_date) >
              DATE(o.order_estimated_delivery_date)
         THEN 1 ELSE 0 END AS is_late,
    COUNT(r.review_id) AS post_delivery_review_count,
    ROUND(AVG(r.review_score), 2) AS avg_post_delivery_review_score
FROM olist_orders_clean o
LEFT JOIN olist_order_reviews_clean r
       ON r.order_id = o.order_id
      AND r.review_answer_timestamp >= o.order_delivered_customer_date
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.delivered_missing_date = 0
  AND o.carrier_before_purchase = 0
  AND o.customer_before_carrier = 0
  AND o.order_delivered_customer_date >= o.order_purchase_timestamp
GROUP BY o.order_id,
         o.order_purchase_timestamp,
         o.order_delivered_customer_date,
         o.order_estimated_delivery_date;

-- 4. Ringkasan keterlambatan vs rating: satu order hanya dihitung sekali
CREATE OR REPLACE VIEW vw_olist_delivery_rating_summary AS
SELECT
    is_late,
    CASE WHEN is_late = 1 THEN 'Late' ELSE 'On time / early' END AS delivery_group,
    COUNT(*) AS eligible_delivered_orders,
    COUNT(avg_post_delivery_review_score) AS orders_with_post_delivery_review,
    ROUND(AVG(avg_post_delivery_review_score), 2) AS avg_review_score_per_order
FROM vw_olist_delivery_review
GROUP BY is_late;

-- 5. Distribusi cara pembayaran: unit = catatan pembayaran.
-- Satu order dapat memiliki beberapa cara pembayaran.
CREATE OR REPLACE VIEW vw_olist_payment_methods AS
SELECT
    payment_type,
    COUNT(*) AS payment_records,
    COUNT(DISTINCT order_id) AS unique_orders_per_method,
    ROUND(SUM(payment_value), 2) AS recorded_payment_value_brl,
    ROUND(AVG(payment_value), 2) AS avg_payment_record_brl
FROM olist_order_payments_clean
GROUP BY payment_type;

-- 6. Pola cicilan khusus credit_card; angka nol tetap dipertahankan.
CREATE OR REPLACE VIEW vw_olist_credit_card_installments AS
SELECT
    CASE
        WHEN payment_installments = 0 THEN '0 (needs review)'
        WHEN payment_installments = 1 THEN '1'
        WHEN payment_installments BETWEEN 2 AND 3 THEN '2-3'
        WHEN payment_installments BETWEEN 4 AND 6 THEN '4-6'
        WHEN payment_installments BETWEEN 7 AND 12 THEN '7-12'
        ELSE '13+'
    END AS installment_group,
    COUNT(*) AS payment_records,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(SUM(payment_value), 2) AS recorded_payment_value_brl
FROM olist_order_payments_clean
WHERE payment_type = 'credit_card'
GROUP BY installment_group;

-- HASIL RINGKAS (jalankan sekali; output siap dikirim untuk dianalisis)
SELECT 'monthly_sales' AS report, COUNT(*) AS result_rows FROM vw_olist_monthly_sales
UNION ALL
SELECT 'category_sales', COUNT(*) FROM vw_olist_category_sales
UNION ALL
SELECT 'delivery_review_order_level', COUNT(*) FROM vw_olist_delivery_review
UNION ALL
SELECT 'delivery_rating_summary', COUNT(*) FROM vw_olist_delivery_rating_summary
UNION ALL
SELECT 'payment_methods', COUNT(*) FROM vw_olist_payment_methods
UNION ALL
SELECT 'credit_card_installments', COUNT(*) FROM vw_olist_credit_card_installments;

SELECT * FROM vw_olist_monthly_sales ORDER BY purchase_month DESC LIMIT 8;
SELECT * FROM vw_olist_category_sales ORDER BY merchandise_sales_brl DESC LIMIT 10;
SELECT * FROM vw_olist_delivery_rating_summary ORDER BY is_late;
SELECT * FROM vw_olist_payment_methods ORDER BY recorded_payment_value_brl DESC;
SELECT * FROM vw_olist_credit_card_installments
ORDER BY FIELD(installment_group, '0 (needs review)', '1', '2-3', '4-6', '7-12', '13+');
