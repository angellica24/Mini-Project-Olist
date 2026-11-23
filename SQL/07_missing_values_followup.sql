
USE olist_ecommerce;

SELECT
    COUNT(*) AS total_canceled,

    SUM(
        order_delivered_carrier_date IS NOT NULL
        AND TRIM(order_delivered_carrier_date) <> ''
    ) AS has_carrier_date,

    SUM(
        order_delivered_customer_date IS NOT NULL
        AND TRIM(order_delivered_customer_date) <> ''
    ) AS has_customer_date,

    SUM(
        order_delivered_carrier_date IS NOT NULL
        AND TRIM(order_delivered_carrier_date) <> ''
        AND
        order_delivered_customer_date IS NOT NULL
        AND TRIM(order_delivered_customer_date) <> ''
    ) AS has_both_dates

FROM olist_orders_raw
WHERE order_status = 'canceled';



SELECT
    COUNT(DISTINCT p.product_id) AS total_missing_products,

    COUNT(DISTINCT
        CASE
            WHEN oi.product_id IS NOT NULL
            THEN p.product_id
        END
    ) AS products_used_in_transactions,

    COUNT(oi.product_id) AS related_order_item_rows

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


