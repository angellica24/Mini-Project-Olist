
USE olist_ecommerce;

-- 1. ORDERS
SELECT
    'orders.order_id' AS key_checked,
    COUNT(*) AS duplicate_groups,
    COALESCE(SUM(dup_count - 1), 0) AS excess_rows
FROM (
    SELECT order_id, COUNT(*) AS dup_count
    FROM olist_orders_raw
    GROUP BY order_id
    HAVING COUNT(*) > 1
) AS d

UNION ALL

-- 2. CUSTOMERS
SELECT
    'customers.customer_id',
    COUNT(*),
    COALESCE(SUM(dup_count - 1), 0)
FROM (
    SELECT customer_id, COUNT(*) AS dup_count
    FROM olist_customers_raw
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS d

UNION ALL

-- 3. ORDER ITEMS
SELECT
    'order_items (order_id, order_item_id)',
    COUNT(*),
    COALESCE(SUM(dup_count - 1), 0)
FROM (
    SELECT order_id, order_item_id,
           COUNT(*) AS dup_count
    FROM olist_order_items_raw
    GROUP BY order_id, order_item_id
    HAVING COUNT(*) > 1
) AS d

UNION ALL

-- 4. PAYMENTS
SELECT
    'payments (order_id, payment_sequential)',
    COUNT(*),
    COALESCE(SUM(dup_count - 1), 0)
FROM (
    SELECT order_id, payment_sequential,
           COUNT(*) AS dup_count
    FROM olist_order_payments_raw
    GROUP BY order_id, payment_sequential
    HAVING COUNT(*) > 1
) AS d

UNION ALL

-- 5. REVIEWS
SELECT
    'reviews.review_id',
    COUNT(*),
    COALESCE(SUM(dup_count - 1), 0)
FROM (
    SELECT review_id, COUNT(*) AS dup_count
    FROM olist_order_reviews_raw
    GROUP BY review_id
    HAVING COUNT(*) > 1
) AS d

UNION ALL

-- 6. PRODUCTS
SELECT
    'products.product_id',
    COUNT(*),
    COALESCE(SUM(dup_count - 1), 0)
FROM (
    SELECT product_id, COUNT(*) AS dup_count
    FROM olist_products_raw
    GROUP BY product_id
    HAVING COUNT(*) > 1
) AS d

UNION ALL

-- 7. SELLERS
SELECT
    'sellers.seller_id',
    COUNT(*),
    COALESCE(SUM(dup_count - 1), 0)
FROM (
    SELECT seller_id, COUNT(*) AS dup_count
    FROM olist_sellers_raw
    GROUP BY seller_id
    HAVING COUNT(*) > 1
) AS d

UNION ALL

-- 8. CATEGORY TRANSLATION (PORTUGUESE)
SELECT
    'category.portuguese',
    COUNT(*),
    COALESCE(SUM(dup_count - 1), 0)
FROM (
    SELECT product_category_name,
           COUNT(*) AS dup_count
    FROM olist_category_translation_raw
    GROUP BY product_category_name
    HAVING COUNT(*) > 1
) AS d

UNION ALL

-- 9. CATEGORY TRANSLATION (ENGLISH)
SELECT
    'category.english',
    COUNT(*),
    COALESCE(SUM(dup_count - 1), 0)
FROM (
    SELECT product_category_name_english,
           COUNT(*) AS dup_count
    FROM olist_category_translation_raw
    GROUP BY product_category_name_english
    HAVING COUNT(*) > 1
) AS d

UNION ALL

-- 10. GEOLOCATION (EXACT DUPLICATE ROWS)
SELECT
    'geolocation.exact_rows',
    COUNT(*),
    COALESCE(SUM(dup_count - 1), 0)
FROM (
    SELECT
        geolocation_zip_code_prefix,
        geolocation_lat,
        geolocation_lng,
        geolocation_city,
        geolocation_state,
        COUNT(*) AS dup_count
    FROM olist_geolocation_raw
    GROUP BY
        geolocation_zip_code_prefix,
        geolocation_lat,
        geolocation_lng,
        geolocation_city,
        geolocation_state
    HAVING COUNT(*) > 1
) AS d;
