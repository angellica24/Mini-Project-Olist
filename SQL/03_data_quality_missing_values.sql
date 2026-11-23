
USE olist_ecommerce;

SELECT 'orders.order_id' AS field_name,
       SUM(order_id IS NULL OR TRIM(order_id) = '') AS missing_count
FROM olist_orders_raw

UNION ALL

SELECT 'orders.customer_id',
       SUM(customer_id IS NULL OR TRIM(customer_id) = '')
FROM olist_orders_raw

UNION ALL

SELECT 'orders.order_status',
       SUM(order_status IS NULL OR TRIM(order_status) = '')
FROM olist_orders_raw

UNION ALL

SELECT 'orders.order_purchase_timestamp',
       SUM(order_purchase_timestamp IS NULL OR TRIM(order_purchase_timestamp) = '')
FROM olist_orders_raw

UNION ALL

SELECT 'customers.customer_id',
       SUM(customer_id IS NULL OR TRIM(customer_id) = '')
FROM olist_customers_raw

UNION ALL

SELECT 'customers.customer_unique_id',
       SUM(customer_unique_id IS NULL OR TRIM(customer_unique_id) = '')
FROM olist_customers_raw

UNION ALL

SELECT 'order_items.order_id',
       SUM(order_id IS NULL OR TRIM(order_id) = '')
FROM olist_order_items_raw

UNION ALL

SELECT 'order_items.product_id',
       SUM(product_id IS NULL OR TRIM(product_id) = '')
FROM olist_order_items_raw

UNION ALL

SELECT 'order_items.seller_id',
       SUM(seller_id IS NULL OR TRIM(seller_id) = '')
FROM olist_order_items_raw

UNION ALL

SELECT 'payments.order_id',
       SUM(order_id IS NULL OR TRIM(order_id) = '')
FROM olist_order_payments_raw

UNION ALL

SELECT 'payments.payment_type',
       SUM(payment_type IS NULL OR TRIM(payment_type) = '')
FROM olist_order_payments_raw

UNION ALL

SELECT 'reviews.review_id',
       SUM(review_id IS NULL OR TRIM(review_id) = '')
FROM olist_order_reviews_raw

UNION ALL

SELECT 'reviews.order_id',
       SUM(order_id IS NULL OR TRIM(order_id) = '')
FROM olist_order_reviews_raw

UNION ALL

SELECT 'products.product_id',
       SUM(product_id IS NULL OR TRIM(product_id) = '')
FROM olist_products_raw

UNION ALL

SELECT 'sellers.seller_id',
       SUM(seller_id IS NULL OR TRIM(seller_id) = '')
FROM olist_sellers_raw

UNION ALL

SELECT 'geolocation.zip_code',
       SUM(geolocation_zip_code_prefix IS NULL OR TRIM(geolocation_zip_code_prefix) = '')
FROM olist_geolocation_raw

UNION ALL

SELECT 'geolocation.latitude',
       SUM(geolocation_lat IS NULL OR TRIM(geolocation_lat) = '')
FROM olist_geolocation_raw

UNION ALL

SELECT 'geolocation.longitude',
       SUM(geolocation_lng IS NULL OR TRIM(geolocation_lng) = '')
FROM olist_geolocation_raw

UNION ALL

SELECT 'category.portuguese',
       SUM(product_category_name IS NULL OR TRIM(product_category_name) = '')
FROM olist_category_translation_raw

UNION ALL

SELECT 'category.english',
       SUM(product_category_name_english IS NULL OR TRIM(product_category_name_english) = '')
FROM olist_category_translation_raw;
