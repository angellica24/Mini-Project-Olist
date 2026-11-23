
USE olist_ecommerce;

-- A. VALIDASI URUTAN TANGGAL ORDERS

SELECT
    COUNT(*) AS total_orders,

    SUM(
        CASE
            WHEN TRIM(order_approved_at) <> ''
            AND order_approved_at < order_purchase_timestamp
            THEN 1 ELSE 0
        END
    ) AS approved_before_purchase,

    SUM(
        CASE
            WHEN TRIM(order_delivered_carrier_date) <> ''
            AND order_delivered_carrier_date < order_purchase_timestamp
            THEN 1 ELSE 0
        END
    ) AS carrier_before_purchase,

    SUM(
        CASE
            WHEN TRIM(order_delivered_customer_date) <> ''
            AND order_delivered_customer_date < order_purchase_timestamp
            THEN 1 ELSE 0
        END
    ) AS customer_before_purchase,

    SUM(
        CASE
            WHEN TRIM(order_delivered_carrier_date) <> ''
            AND TRIM(order_delivered_customer_date) <> ''
            AND order_delivered_customer_date < order_delivered_carrier_date
            THEN 1 ELSE 0
        END
    ) AS customer_before_carrier,

    SUM(
        CASE
            WHEN LEFT(order_estimated_delivery_date, 10)
                 < LEFT(order_purchase_timestamp, 10)
            THEN 1 ELSE 0
        END
    ) AS estimated_before_purchase

FROM olist_orders_raw;



-- B. VALIDASI URUTAN TANGGAL REVIEWS

SELECT
    COUNT(*) AS total_reviews,

    SUM(
        CASE
            WHEN r.review_answer_timestamp
                 < r.review_creation_date
            THEN 1 ELSE 0
        END
    ) AS answered_before_created,

    SUM(
        CASE
            WHEN TRIM(o.order_delivered_customer_date) <> ''
            AND LEFT(r.review_creation_date, 10)
                < LEFT(o.order_delivered_customer_date, 10)
            THEN 1 ELSE 0
        END
    ) AS review_before_delivery_date

FROM olist_order_reviews_raw r

LEFT JOIN olist_orders_raw o
    ON r.order_id = o.order_id;



-- C. VALIDASI SHIPPING LIMIT DATE

SELECT
    COUNT(*) AS total_order_items,

    SUM(
        CASE
            WHEN i.shipping_limit_date
                 < o.order_purchase_timestamp
            THEN 1 ELSE 0
        END
    ) AS shipping_limit_before_purchase,

    SUM(
        CASE
            WHEN o.order_id IS NULL
            THEN 1 ELSE 0
        END
    ) AS unmatched_order_items

FROM olist_order_items_raw i

LEFT JOIN olist_orders_raw o
    ON i.order_id = o.order_id;
