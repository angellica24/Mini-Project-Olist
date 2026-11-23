
USE olist_ecommerce;

-- A. INVESTIGASI MISSING VALUES ORDERS

SELECT
    order_status,
    COUNT(*) AS total_orders,

    SUM(
        order_approved_at IS NULL
        OR TRIM(order_approved_at) = ''
    ) AS missing_approved,

    SUM(
        order_delivered_carrier_date IS NULL
        OR TRIM(order_delivered_carrier_date) = ''
    ) AS missing_carrier,

    SUM(
        order_delivered_customer_date IS NULL
        OR TRIM(order_delivered_customer_date) = ''
    ) AS missing_customer

FROM olist_orders_raw

GROUP BY order_status
ORDER BY total_orders DESC;


-- B. INVESTIGASI MISSING VALUES REVIEWS

SELECT
    SUM(
        (review_comment_title IS NULL OR TRIM(review_comment_title) = '')
        AND
        (review_comment_message IS NULL OR TRIM(review_comment_message) = '')
    ) AS both_missing,

    SUM(
        (review_comment_title IS NULL OR TRIM(review_comment_title) = '')
        AND
        (review_comment_message IS NOT NULL AND TRIM(review_comment_message) <> '')
    ) AS title_only_missing,

    SUM(
        (review_comment_title IS NOT NULL AND TRIM(review_comment_title) <> '')
        AND
        (review_comment_message IS NULL OR TRIM(review_comment_message) = '')
    ) AS message_only_missing,

    SUM(
        (review_comment_title IS NOT NULL AND TRIM(review_comment_title) <> '')
        AND
        (review_comment_message IS NOT NULL AND TRIM(review_comment_message) <> '')
    ) AS both_filled

FROM olist_order_reviews_raw;


-- C. INVESTIGASI MISSING VALUES PRODUCTS

SELECT
    SUM(product_category_name IS NULL OR TRIM(product_category_name) = '') AS missing_category,

    SUM(product_name_lenght IS NULL OR TRIM(product_name_lenght) = '') AS missing_name_length,

    SUM(product_description_lenght IS NULL OR TRIM(product_description_lenght) = '') AS missing_description,

    SUM(product_photos_qty IS NULL OR TRIM(product_photos_qty) = '') AS missing_photos,

    SUM(
        (product_category_name IS NULL OR TRIM(product_category_name) = '')
        AND
        (product_name_lenght IS NULL OR TRIM(product_name_lenght) = '')
        AND
        (product_description_lenght IS NULL OR TRIM(product_description_lenght) = '')
        AND
        (product_photos_qty IS NULL OR TRIM(product_photos_qty) = '')
    ) AS all_four_missing

FROM olist_products_raw;


-- D. PERIKSA PRODUK DENGAN DIMENSI KOSONG

SELECT *
FROM olist_products_raw
WHERE
    product_weight_g IS NULL OR TRIM(product_weight_g) = ''
    OR product_length_cm IS NULL OR TRIM(product_length_cm) = ''
    OR product_height_cm IS NULL OR TRIM(product_height_cm) = ''
    OR product_width_cm IS NULL OR TRIM(product_width_cm) = '';
