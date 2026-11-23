
USE olist_ecommerce;

-- A. INVESTIGASI PEMBAYARAN DAN CICILAN NOL

SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value

FROM olist_order_payments_raw

WHERE
    CAST(payment_value AS DECIMAL(18,2)) = 0
    OR
    CAST(payment_installments AS UNSIGNED) = 0

ORDER BY order_id, payment_sequential;


-- B. RINGKASAN NILAI NOL BERDASARKAN METODE PEMBAYARAN

SELECT
    payment_type,

    COUNT(*) AS total_payment_records,

    SUM(
        CAST(payment_value AS DECIMAL(18,2)) = 0
    ) AS zero_payment_records,

    SUM(
        CAST(payment_installments AS UNSIGNED) = 0
    ) AS zero_installment_records

FROM olist_order_payments_raw

GROUP BY payment_type

ORDER BY total_payment_records DESC;


-- C. PERIKSA ONGKOS KIRIM NOL BERDASARKAN STATUS ORDER

SELECT
    o.order_status,

    COUNT(*) AS zero_freight_items,

    COUNT(DISTINCT i.order_id) AS total_orders

FROM olist_order_items_raw i

LEFT JOIN olist_orders_raw o
    ON i.order_id = o.order_id

WHERE CAST(i.freight_value AS DECIMAL(18,2)) = 0

GROUP BY o.order_status

ORDER BY zero_freight_items DESC;
