
USE olist_ecommerce;

-- 1. ORDERS
SELECT 'orders.order_approved_at' AS field_name,
       SUM(order_approved_at IS NULL OR TRIM(order_approved_at) = '') AS missing_count
FROM olist_orders_raw

UNION ALL

SELECT 'orders.order_delivered_carrier_date',
       SUM(order_delivered_carrier_date IS NULL OR TRIM(order_delivered_carrier_date) = '')
FROM olist_orders_raw

UNION ALL

SELECT 'orders.order_delivered_customer_date',
       SUM(order_delivered_customer_date IS NULL OR TRIM(order_delivered_customer_date) = '')
FROM olist_orders_raw

UNION ALL

SELECT 'orders.order_estimated_delivery_date',
       SUM(order_estimated_delivery_date IS NULL OR TRIM(order_estimated_delivery_date) = '')
FROM olist_orders_raw

UNION ALL

-- 2. CUSTOMERS
SELECT 'customers.zip_code',
       SUM(customer_zip_code_prefix IS NULL OR TRIM(customer_zip_code_prefix) = '')
FROM olist_customers_raw

UNION ALL

SELECT 'customers.city',
       SUM(customer_city IS NULL OR TRIM(customer_city) = '')
FROM olist_customers_raw

UNION ALL

SELECT 'customers.state',
       SUM(customer_state IS NULL OR TRIM(customer_state) = '')
FROM olist_customers_raw

UNION ALL

-- 3. ORDER ITEMS
SELECT 'order_items.order_item_id',
       SUM(order_item_id IS NULL OR TRIM(order_item_id) = '')
FROM olist_order_items_raw

UNION ALL

SELECT 'order_items.shipping_limit_date',
       SUM(shipping_limit_date IS NULL OR TRIM(shipping_limit_date) = '')
FROM olist_order_items_raw

UNION ALL

SELECT 'order_items.price',
       SUM(price IS NULL OR TRIM(price) = '')
FROM olist_order_items_raw

UNION ALL

SELECT 'order_items.freight_value',
       SUM(freight_value IS NULL OR TRIM(freight_value) = '')
FROM olist_order_items_raw

UNION ALL

-- 4. PAYMENTS
SELECT 'payments.payment_sequential',
       SUM(payment_sequential IS NULL OR TRIM(payment_sequential) = '')
FROM olist_order_payments_raw

UNION ALL

SELECT 'payments.payment_installments',
       SUM(payment_installments IS NULL OR TRIM(payment_installments) = '')
FROM olist_order_payments_raw

UNION ALL

SELECT 'payments.payment_value',
       SUM(payment_value IS NULL OR TRIM(payment_value) = '')
FROM olist_order_payments_raw

UNION ALL

-- 5. REVIEWS
SELECT 'reviews.review_score',
       SUM(review_score IS NULL OR TRIM(review_score) = '')
FROM olist_order_reviews_raw

UNION ALL

SELECT 'reviews.review_comment_title',
       SUM(review_comment_title IS NULL OR TRIM(review_comment_title) = '')
FROM olist_order_reviews_raw

UNION ALL

SELECT 'reviews.review_comment_message',
       SUM(review_comment_message IS NULL OR TRIM(review_comment_message) = '')
FROM olist_order_reviews_raw

UNION ALL

SELECT 'reviews.review_creation_date',
       SUM(review_creation_date IS NULL OR TRIM(review_creation_date) = '')
FROM olist_order_reviews_raw

UNION ALL

SELECT 'reviews.review_answer_timestamp',
       SUM(review_answer_timestamp IS NULL OR TRIM(review_answer_timestamp) = '')
FROM olist_order_reviews_raw

UNION ALL

-- 6. PRODUCTS
SELECT 'products.category',
       SUM(product_category_name IS NULL OR TRIM(product_category_name) = '')
FROM olist_products_raw

UNION ALL

SELECT 'products.name_length',
       SUM(product_name_lenght IS NULL OR TRIM(product_name_lenght) = '')
FROM olist_products_raw

UNION ALL

SELECT 'products.description_length',
       SUM(product_description_lenght IS NULL OR TRIM(product_description_lenght) = '')
FROM olist_products_raw

UNION ALL

SELECT 'products.photos_qty',
       SUM(product_photos_qty IS NULL OR TRIM(product_photos_qty) = '')
FROM olist_products_raw

UNION ALL

SELECT 'products.weight',
       SUM(product_weight_g IS NULL OR TRIM(product_weight_g) = '')
FROM olist_products_raw

UNION ALL

SELECT 'products.length',
       SUM(product_length_cm IS NULL OR TRIM(product_length_cm) = '')
FROM olist_products_raw

UNION ALL

SELECT 'products.height',
       SUM(product_height_cm IS NULL OR TRIM(product_height_cm) = '')
FROM olist_products_raw

UNION ALL

SELECT 'products.width',
       SUM(product_width_cm IS NULL OR TRIM(product_width_cm) = '')
FROM olist_products_raw

UNION ALL

-- 7. SELLERS
SELECT 'sellers.zip_code',
       SUM(seller_zip_code_prefix IS NULL OR TRIM(seller_zip_code_prefix) = '')
FROM olist_sellers_raw

UNION ALL

SELECT 'sellers.city',
       SUM(seller_city IS NULL OR TRIM(seller_city) = '')
FROM olist_sellers_raw

UNION ALL

SELECT 'sellers.state',
       SUM(seller_state IS NULL OR TRIM(seller_state) = '')
FROM olist_sellers_raw

UNION ALL

-- 8. GEOLOCATION
SELECT 'geolocation.city',
       SUM(geolocation_city IS NULL OR TRIM(geolocation_city) = '')
FROM olist_geolocation_raw

UNION ALL

SELECT 'geolocation.state',
       SUM(geolocation_state IS NULL OR TRIM(geolocation_state) = '')
FROM olist_geolocation_raw;
