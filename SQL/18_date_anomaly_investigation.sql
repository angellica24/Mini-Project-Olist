
USE olist_ecommerce;

-- A. ANOMALI TANGGAL BERDASARKAN STATUS PESANAN

SELECT
    order_status,
    COUNT(*) AS total_orders,

    SUM(
        CASE
            WHEN TRIM(order_delivered_carrier_date) <> ''
            AND order_delivered_carrier_date < order_purchase_timestamp
            THEN 1 ELSE 0
        END
    ) AS carrier_before_purchase,

    SUM(
        CASE
            WHEN TRIM(order_delivered_carrier_date) <> ''
            AND TRIM(order_delivered_customer_date) <> ''
            AND order_delivered_customer_date < order_delivered_carrier_date
            THEN 1 ELSE 0
        END
    ) AS customer_before_carrier

FROM olist_orders_raw

GROUP BY order_status

ORDER BY carrier_before_purchase DESC,
         customer_before_carrier DESC;


-- B. INVESTIGASI REVIEW SEBELUM PENERIMAAN BARANG

SELECT
    o.order_status,
    COUNT(*) AS review_rows,
    COUNT(DISTINCT r.order_id) AS unique_orders,

    SUM(
        CASE
            WHEN r.review_answer_timestamp
                 < o.order_delivered_customer_date
            THEN 1 ELSE 0
        END
    ) AS answered_before_delivery,

    SUM(
        CASE
            WHEN r.review_answer_timestamp
                 >= o.order_delivered_customer_date
            THEN 1 ELSE 0
        END
    ) AS answered_after_or_at_delivery

FROM olist_order_reviews_raw r

JOIN olist_orders_raw o
    ON r.order_id = o.order_id

WHERE
    TRIM(o.order_delivered_customer_date) <> ''
    AND LEFT(r.review_creation_date, 10)
        < LEFT(o.order_delivered_customer_date, 10)

GROUP BY o.order_status

ORDER BY review_rows DESC;


-- C. CONTOH PESANAN DENGAN ANOMALI KRONOLOGIS

SELECT
    order_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_carrier_date,
    order_delivered_customer_date,

    CONCAT_WS(
        ', ',

        IF(
            TRIM(order_delivered_carrier_date) <> ''
            AND order_delivered_carrier_date < order_purchase_timestamp,
            'carrier_before_purchase',
            NULL
        ),

        IF(
            TRIM(order_delivered_carrier_date) <> ''
            AND TRIM(order_delivered_customer_date) <> ''
            AND order_delivered_customer_date < order_delivered_carrier_date,
            'customer_before_carrier',
            NULL
        )
    ) AS anomaly_type

FROM olist_orders_raw

WHERE
    (
        TRIM(order_delivered_carrier_date) <> ''
        AND order_delivered_carrier_date < order_purchase_timestamp
    )
    OR
    (
        TRIM(order_delivered_carrier_date) <> ''
        AND TRIM(order_delivered_customer_date) <> ''
        AND order_delivered_customer_date < order_delivered_carrier_date
    )

ORDER BY order_purchase_timestamp

LIMIT 15;
