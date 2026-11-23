USE olist_ecommerce;

-- 23. Membuat lima tabel clean dalam SATU file.
-- Semua tabel *_raw tetap utuh. Aman dijalankan ulang (menambah ID yang belum ada).

-- 1. PAYMENTS (103886 baris)
CREATE TABLE IF NOT EXISTS olist_order_payments_clean (
    order_id VARCHAR(50) NOT NULL,
    payment_sequential VARCHAR(10) NOT NULL,
    payment_type VARCHAR(50) NOT NULL,
    payment_installments SMALLINT UNSIGNED NOT NULL,
    payment_value DECIMAL(14,2) NOT NULL,
    PRIMARY KEY (order_id, payment_sequential)
);

INSERT INTO olist_order_payments_clean
    (order_id, payment_sequential, payment_type, payment_installments, payment_value)
SELECT TRIM(r.order_id), TRIM(r.payment_sequential), TRIM(r.payment_type),
       CAST(TRIM(r.payment_installments) AS UNSIGNED),
       CAST(TRIM(r.payment_value) AS DECIMAL(14,2))
FROM olist_order_payments_raw r
WHERE NOT EXISTS (
    SELECT 1 FROM olist_order_payments_clean c
    WHERE c.order_id = r.order_id AND c.payment_sequential = r.payment_sequential
);

-- 2. REVIEWS (99224 baris)
-- Kunci gabungan; review_id sendiri boleh berulang di order_id berbeda.
CREATE TABLE IF NOT EXISTS olist_order_reviews_clean (
    review_id VARCHAR(50) NOT NULL,
    order_id VARCHAR(50) NOT NULL,
    review_score TINYINT UNSIGNED NOT NULL,
    review_comment_title TEXT NULL,
    review_comment_message TEXT NULL,
    review_creation_date DATETIME NOT NULL,
    review_answer_timestamp DATETIME NOT NULL,
    PRIMARY KEY (review_id, order_id),
    INDEX idx_reviews_order_id (order_id)
);

INSERT INTO olist_order_reviews_clean
    (review_id, order_id, review_score, review_comment_title,
     review_comment_message, review_creation_date, review_answer_timestamp)
SELECT TRIM(r.review_id), TRIM(r.order_id),
       CAST(TRIM(r.review_score) AS UNSIGNED),
       NULLIF(TRIM(r.review_comment_title), ''),
       NULLIF(TRIM(r.review_comment_message), ''),
       STR_TO_DATE(TRIM(r.review_creation_date), '%Y-%m-%d %H:%i:%s'),
       STR_TO_DATE(TRIM(r.review_answer_timestamp), '%Y-%m-%d %H:%i:%s')
FROM olist_order_reviews_raw r
WHERE NOT EXISTS (
    SELECT 1 FROM olist_order_reviews_clean c
    WHERE c.review_id = r.review_id AND c.order_id = r.order_id
);

-- 3. PRODUCTS (32951 baris)
-- Atribut kosong menjadi NULL, BUKAN angka 0.
CREATE TABLE IF NOT EXISTS olist_products_clean (
    product_id VARCHAR(50) NOT NULL PRIMARY KEY,
    product_category_name VARCHAR(100) NULL,
    product_name_lenght INT UNSIGNED NULL,
    product_description_lenght INT UNSIGNED NULL,
    product_photos_qty INT UNSIGNED NULL,
    product_weight_g DECIMAL(14,2) NULL,
    product_length_cm DECIMAL(14,2) NULL,
    product_height_cm DECIMAL(14,2) NULL,
    product_width_cm DECIMAL(14,2) NULL,
    INDEX idx_product_category (product_category_name)
);

INSERT INTO olist_products_clean
    (product_id, product_category_name, product_name_lenght,
     product_description_lenght, product_photos_qty, product_weight_g,
     product_length_cm, product_height_cm, product_width_cm)
SELECT TRIM(r.product_id),
       NULLIF(TRIM(r.product_category_name), ''),
       CAST(NULLIF(TRIM(r.product_name_lenght), '') AS UNSIGNED),
       CAST(NULLIF(TRIM(r.product_description_lenght), '') AS UNSIGNED),
       CAST(NULLIF(TRIM(r.product_photos_qty), '') AS UNSIGNED),
       CAST(NULLIF(TRIM(r.product_weight_g), '') AS DECIMAL(14,2)),
       CAST(NULLIF(TRIM(r.product_length_cm), '') AS DECIMAL(14,2)),
       CAST(NULLIF(TRIM(r.product_height_cm), '') AS DECIMAL(14,2)),
       CAST(NULLIF(TRIM(r.product_width_cm), '') AS DECIMAL(14,2))
FROM olist_products_raw r
WHERE NOT EXISTS (
    SELECT 1 FROM olist_products_clean c WHERE c.product_id = r.product_id
);

-- 4. SELLERS (3095 baris)
CREATE TABLE IF NOT EXISTS olist_sellers_clean (
    seller_id VARCHAR(50) NOT NULL PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10) NOT NULL,
    seller_city VARCHAR(100) NOT NULL,
    seller_state VARCHAR(10) NOT NULL
);

INSERT INTO olist_sellers_clean
    (seller_id, seller_zip_code_prefix, seller_city, seller_state)
SELECT TRIM(r.seller_id), TRIM(r.seller_zip_code_prefix),
       TRIM(r.seller_city), TRIM(r.seller_state)
FROM olist_sellers_raw r
WHERE NOT EXISTS (
    SELECT 1 FROM olist_sellers_clean c WHERE c.seller_id = r.seller_id
);

-- 5. CATEGORY TRANSLATION (71 baris)
CREATE TABLE IF NOT EXISTS olist_category_translation_clean (
    product_category_name VARCHAR(100) NOT NULL PRIMARY KEY,
    product_category_name_english VARCHAR(100) NOT NULL
);

INSERT INTO olist_category_translation_clean
    (product_category_name, product_category_name_english)
SELECT TRIM(r.product_category_name), TRIM(r.product_category_name_english)
FROM olist_category_translation_raw r
WHERE NOT EXISTS (
    SELECT 1 FROM olist_category_translation_clean c
    WHERE c.product_category_name = r.product_category_name
);

-- 6. VALIDASI JUMLAH BARIS (harus sama dengan raw)
SELECT 'payments' AS tabel, (SELECT COUNT(*) FROM olist_order_payments_raw) AS raw_rows,
       (SELECT COUNT(*) FROM olist_order_payments_clean) AS clean_rows
UNION ALL
SELECT 'reviews', (SELECT COUNT(*) FROM olist_order_reviews_raw),
       (SELECT COUNT(*) FROM olist_order_reviews_clean)
UNION ALL
SELECT 'products', (SELECT COUNT(*) FROM olist_products_raw),
       (SELECT COUNT(*) FROM olist_products_clean)
UNION ALL
SELECT 'sellers', (SELECT COUNT(*) FROM olist_sellers_raw),
       (SELECT COUNT(*) FROM olist_sellers_clean)
UNION ALL
SELECT 'category_translation', (SELECT COUNT(*) FROM olist_category_translation_raw),
       (SELECT COUNT(*) FROM olist_category_translation_clean);

-- 7. VALIDASI NILAI PENTING
SELECT
    (SELECT COUNT(*) FROM olist_order_payments_clean WHERE payment_value = 0)
        AS zero_payments,
    (SELECT COUNT(*) FROM olist_order_payments_clean WHERE payment_installments = 0)
        AS zero_installments,
    (SELECT COUNT(*) FROM olist_products_clean WHERE product_category_name IS NULL)
        AS missing_product_category,
    (SELECT COUNT(*) FROM olist_products_clean WHERE product_weight_g IS NULL)
        AS missing_product_weight,
    (SELECT COUNT(*) FROM olist_order_reviews_clean WHERE review_score NOT BETWEEN 1 AND 5)
        AS invalid_review_scores;

-- 8. VALIDASI RELASI KE TABEL LAIN
SELECT
    (SELECT COUNT(*) FROM olist_order_payments_clean p
     LEFT JOIN olist_orders_clean o ON p.order_id = o.order_id
     WHERE o.order_id IS NULL) AS unmatched_payments,
    (SELECT COUNT(*) FROM olist_order_reviews_clean r
     LEFT JOIN olist_orders_clean o ON r.order_id = o.order_id
     WHERE o.order_id IS NULL) AS unmatched_reviews,
    (SELECT COUNT(*) FROM olist_order_items_clean i
     LEFT JOIN olist_products_clean p ON i.product_id = p.product_id
     WHERE p.product_id IS NULL) AS unmatched_products,
    (SELECT COUNT(*) FROM olist_order_items_clean i
     LEFT JOIN olist_sellers_clean s ON i.seller_id = s.seller_id
     WHERE s.seller_id IS NULL) AS unmatched_sellers;
