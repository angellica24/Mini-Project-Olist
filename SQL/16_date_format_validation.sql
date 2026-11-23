
USE olist_ecommerce;

-- DATA TYPE VALIDATION
-- Pemeriksaan format tanggal dan timestamp

WITH date_fields AS (

    SELECT
        'orders.purchase_timestamp' AS field_name,
        order_purchase_timestamp AS date_value
    FROM olist_orders_raw

    UNION ALL

    SELECT
        'orders.approved_at',
        order_approved_at
    FROM olist_orders_raw

    UNION ALL

    SELECT
        'orders.delivered_carrier',
        order_delivered_carrier_date
    FROM olist_orders_raw

    UNION ALL

    SELECT
        'orders.delivered_customer',
        order_delivered_customer_date
    FROM olist_orders_raw

    UNION ALL

    SELECT
        'orders.estimated_delivery',
        order_estimated_delivery_date
    FROM olist_orders_raw

    UNION ALL

    SELECT
        'order_items.shipping_limit',
        shipping_limit_date
    FROM olist_order_items_raw

    UNION ALL

    SELECT
        'reviews.creation_date',
        review_creation_date
    FROM olist_order_reviews_raw

    UNION ALL

    SELECT
        'reviews.answer_timestamp',
        review_answer_timestamp
    FROM olist_order_reviews_raw
)

SELECT
    field_name,

    COUNT(*) AS total_rows,

    SUM(
        date_value IS NULL
        OR TRIM(date_value) = ''
    ) AS empty_values,

    SUM(
        date_value IS NOT NULL
        AND TRIM(date_value) <> ''
        AND NOT REGEXP_LIKE(
            TRIM(date_value),
            '^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01]) ([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$'
        )
    ) AS invalid_format

FROM date_fields

GROUP BY field_name

ORDER BY field_name;
