USE olist_ecommerce;

-- 25. REVISI ANALISIS RATING VS KETERLAMBATAN
-- Alasan: filter review yang dijawab setelah penerimaan barang
-- mengurangi cakupan review pada kelompok terlambat secara tajam.
-- Buat analisis utama memakai semua review (rata-rata per pesanan).
-- View nomor 24 tetap dipertahankan sebagai analisis pembanding.
-- Semua tabel *_raw dan *_clean tidak diubah.

-- A. SATU BARIS PER ORDER ELIGIBLE + RATING DARI SEMUA REVIEW
CREATE OR REPLACE VIEW vw_olist_delivery_review_all AS
SELECT
    d.order_id,
    d.purchase_date,
    d.delivered_date,
    d.estimated_delivery_date,
    d.delivery_delay_days,
    d.is_late,
    COALESCE(r.review_count, 0) AS review_count,
    r.avg_review_score_per_order,
    d.post_delivery_review_count,
    d.avg_post_delivery_review_score
FROM vw_olist_delivery_review AS d
LEFT JOIN (
    SELECT
        order_id,
        COUNT(*) AS review_count,
        AVG(review_score) AS avg_review_score_per_order
    FROM olist_order_reviews_clean
    GROUP BY order_id
) AS r
    ON r.order_id = d.order_id;

-- B. RINGKASAN DUA PENDEKATAN BESERTA CAKUPAN REVIEW
CREATE OR REPLACE VIEW vw_olist_delivery_rating_comparison AS
SELECT
    is_late,
    CASE WHEN is_late = 1 THEN 'Late' ELSE 'On time / early' END AS delivery_group,
    COUNT(*) AS eligible_delivered_orders,
    COUNT(avg_review_score_per_order) AS orders_with_any_review,
    ROUND(100.0 * COUNT(avg_review_score_per_order) / COUNT(*), 2) AS any_review_coverage_pct,
    ROUND(AVG(avg_review_score_per_order), 2) AS avg_score_all_reviews,
    SUM(post_delivery_review_count > 0) AS orders_with_post_delivery_review,
    ROUND(100.0 * SUM(post_delivery_review_count > 0) / COUNT(*), 2) AS post_delivery_review_coverage_pct,
    ROUND(AVG(avg_post_delivery_review_score), 2) AS avg_score_post_delivery_only
FROM vw_olist_delivery_review_all
GROUP BY is_late;

-- C. HASIL: CEK CAKUPAN DAN PERBANDINGAN RATING
SELECT *
FROM vw_olist_delivery_rating_comparison
ORDER BY is_late;

-- D. CEK JUMLAH PESANAN: HARUS 96.267 SESUAI HASIL SCRIPT 24
SELECT COUNT(*) AS eligible_orders_in_revised_view
FROM vw_olist_delivery_review_all;
