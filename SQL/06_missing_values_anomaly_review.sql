USE olist_ecommerce;

SELECT
    order_id,
    order_status,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date
FROM olist_orders_raw
WHERE order_status = 'delivered'
AND (
    order_approved_at IS NULL
    OR TRIM(order_approved_at) = ''
    OR order_delivered_carrier_date IS NULL
    OR TRIM(order_delivered_carrier_date) = ''
    OR order_delivered_customer_date IS NULL
    OR TRIM(order_delivered_customer_date) = ''
)
ORDER BY order_id;


SELECT
    order_id,
    order_status,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date
FROM olist_orders_raw
WHERE order_status = 'canceled'
AND (
    (order_delivered_carrier_date IS NOT NULL
     AND TRIM(order_delivered_carrier_date) <> '')
    OR
    (order_delivered_customer_date IS NOT NULL
     AND TRIM(order_delivered_customer_date) <> '')
)
ORDER BY order_id;


SELECT
    COUNT(*) AS products_missing_information,

    COUNT(DISTINCT
        CASE
            WHEN oi.product_id IS NOT NULL
            THEN p.product_id
        END
    ) AS products_used_in_transactions

FROM olist_products_raw p

LEFT JOIN olist_order_items_raw oi
    ON p.product_id = oi.product_id

WHERE
    (p.product_category_name IS NULL OR TRIM(p.product_category_name) = '')
    AND
    (p.product_name_lenght IS NULL OR TRIM(p.product_name_lenght) = '')
    AND
    (p.product_description_lenght IS NULL OR TRIM(p.product_description_lenght) = '')
    AND
    (p.product_photos_qty IS NULL OR TRIM(p.product_photos_qty) = '');


SELECT
    p.product_id,
    p.product_category_name,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,
    COUNT(oi.product_id) AS total_order_items

FROM olist_products_raw p

LEFT JOIN olist_order_items_raw oi
    ON p.product_id = oi.product_id

WHERE
    p.product_weight_g IS NULL
    OR TRIM(p.product_weight_g) = ''
    OR p.product_length_cm IS NULL
    OR TRIM(p.product_length_cm) = ''
    OR p.product_height_cm IS NULL
    OR TRIM(p.product_height_cm) = ''
    OR p.product_width_cm IS NULL
    OR TRIM(p.product_width_cm) = ''

GROUP BY
    p.product_id,
    p.product_category_name,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm;
