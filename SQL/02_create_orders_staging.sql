
-- =====================================================
-- 02. CREATE RAW STAGING TABLES
-- Project: Olist E-Commerce Data Analysis
--
-- Membuat struktur staging untuk seluruh 9 dataset Olist.
--
-- Raw tables menggunakan VARCHAR/TEXT untuk menjaga
-- nilai asli sebelum proses validasi dan pembersihan.
--
-- Tidak menggunakan PRIMARY KEY atau UNIQUE constraint
-- agar duplikasi data tetap dapat diinvestigasi.
-- =====================================================

USE olist_ecommerce;


-- =====================================================
-- 1. CUSTOMERS
-- =====================================================

CREATE TABLE IF NOT EXISTS olist_customers_raw (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================
-- 2. GEOLOCATION
-- =====================================================

CREATE TABLE IF NOT EXISTS olist_geolocation_raw (
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat VARCHAR(50),
    geolocation_lng VARCHAR(50),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================
-- 3. ORDERS
-- =====================================================

CREATE TABLE IF NOT EXISTS olist_orders_raw (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp VARCHAR(50),
    order_approved_at VARCHAR(50),
    order_delivered_carrier_date VARCHAR(50),
    order_delivered_customer_date VARCHAR(50),
    order_estimated_delivery_date VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================
-- 4. ORDER ITEMS
-- =====================================================

CREATE TABLE IF NOT EXISTS olist_order_items_raw (
    order_id VARCHAR(50),
    order_item_id VARCHAR(50),
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date VARCHAR(50),
    price VARCHAR(50),
    freight_value VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================
-- 5. ORDER PAYMENTS
-- =====================================================

CREATE TABLE IF NOT EXISTS olist_order_payments_raw (
    order_id VARCHAR(50),
    payment_sequential VARCHAR(50),
    payment_type VARCHAR(50),
    payment_installments VARCHAR(50),
    payment_value VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================
-- 6. ORDER REVIEWS
-- =====================================================

CREATE TABLE IF NOT EXISTS olist_order_reviews_raw (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score VARCHAR(50),
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date VARCHAR(50),
    review_answer_timestamp VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================
-- 7. PRODUCTS
-- =====================================================

CREATE TABLE IF NOT EXISTS olist_products_raw (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght VARCHAR(50),
    product_description_lenght VARCHAR(50),
    product_photos_qty VARCHAR(50),
    product_weight_g VARCHAR(50),
    product_length_cm VARCHAR(50),
    product_height_cm VARCHAR(50),
    product_width_cm VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================
-- 8. SELLERS
-- =====================================================

CREATE TABLE IF NOT EXISTS olist_sellers_raw (
    seller_id VARCHAR(50),
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================
-- 9. CATEGORY TRANSLATION
-- =====================================================

CREATE TABLE IF NOT EXISTS olist_category_translation_raw (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =====================================================
-- 10. VALIDASI STRUKTUR TABEL
-- Memastikan seluruh 9 tabel tersedia dan jumlah
-- kolom sesuai dengan struktur yang direncanakan.
-- =====================================================

SELECT
    expected.table_name,
    expected.expected_columns,
    COUNT(c.COLUMN_NAME) AS actual_columns,
    CASE
        WHEN COUNT(c.COLUMN_NAME) = expected.expected_columns
        THEN 'OK'
        ELSE 'CHECK'
    END AS validation_status

FROM (
    SELECT 'olist_customers_raw' AS table_name, 5 AS expected_columns
    UNION ALL
    SELECT 'olist_geolocation_raw', 5
    UNION ALL
    SELECT 'olist_orders_raw', 8
    UNION ALL
    SELECT 'olist_order_items_raw', 7
    UNION ALL
    SELECT 'olist_order_payments_raw', 5
    UNION ALL
    SELECT 'olist_order_reviews_raw', 7
    UNION ALL
    SELECT 'olist_products_raw', 9
    UNION ALL
    SELECT 'olist_sellers_raw', 4
    UNION ALL
    SELECT 'olist_category_translation_raw', 2
) AS expected

LEFT JOIN INFORMATION_SCHEMA.COLUMNS AS c
    ON c.TABLE_SCHEMA = 'olist_ecommerce'
    AND c.TABLE_NAME = expected.table_name

GROUP BY
    expected.table_name,
    expected.expected_columns

ORDER BY
    expected.table_name;
