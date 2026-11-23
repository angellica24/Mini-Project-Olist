
USE olist_ecommerce;

-- ==========================================
-- 21. CREATE CLEAN CUSTOMERS TABLE
-- ==========================================

-- A. MEMBUAT STRUKTUR TABEL CLEAN

CREATE TABLE IF NOT EXISTS olist_customers_clean (

    customer_id VARCHAR(50) NOT NULL PRIMARY KEY,

    customer_unique_id VARCHAR(50) NOT NULL,

    customer_zip_code_prefix VARCHAR(10) NOT NULL,

    customer_city VARCHAR(100) NOT NULL,

    customer_state VARCHAR(10) NOT NULL

);


-- B. MEMASUKKAN DATA DARI TABEL RAW

INSERT INTO olist_customers_clean (

    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state

)

SELECT

    TRIM(c.customer_id),

    TRIM(c.customer_unique_id),

    TRIM(c.customer_zip_code_prefix),

    TRIM(c.customer_city),

    TRIM(c.customer_state)

FROM olist_customers_raw c

WHERE NOT EXISTS (

    SELECT 1
    FROM olist_customers_clean cc
    WHERE cc.customer_id = c.customer_id

);


-- C. VALIDASI JUMLAH PELANGGAN

SELECT

    COUNT(*) AS total_clean_customers,

    COUNT(DISTINCT customer_id)
        AS unique_customer_ids,

    COUNT(DISTINCT customer_unique_id)
        AS unique_customer_unique_ids

FROM olist_customers_clean;


-- D. VALIDASI HUBUNGAN ORDERS DAN CUSTOMERS

SELECT

    COUNT(*) AS total_clean_orders,

    SUM(
        CASE
            WHEN c.customer_id IS NULL
            THEN 1 ELSE 0
        END
    ) AS unmatched_orders

FROM olist_orders_clean o

LEFT JOIN olist_customers_clean c
    ON o.customer_id = c.customer_id;


-- E. VALIDASI STRUKTUR TABEL

SHOW COLUMNS FROM olist_customers_clean;
