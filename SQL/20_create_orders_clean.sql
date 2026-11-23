
USE olist_ecommerce;

-- ==========================================
-- 20. CREATE CLEAN ORDERS TABLE
-- ==========================================

-- A. MEMBUAT STRUKTUR TABEL CLEAN

CREATE TABLE IF NOT EXISTS olist_orders_clean (

    order_id VARCHAR(50) NOT NULL PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(50) NOT NULL,

    order_purchase_timestamp DATETIME NOT NULL,
    order_approved_at DATETIME NULL,
    order_delivered_carrier_date DATETIME NULL,
    order_delivered_customer_date DATETIME NULL,
    order_estimated_delivery_date DATETIME NOT NULL,

    carrier_before_purchase TINYINT NOT NULL,
    customer_before_carrier TINYINT NOT NULL,
    delivered_missing_date TINYINT NOT NULL

);


-- B. MEMASUKKAN DATA DARI TABEL RAW

INSERT INTO olist_orders_clean (

    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    carrier_before_purchase,
    customer_before_carrier,
    delivered_missing_date

)

SELECT

    TRIM(o.order_id),
    TRIM(o.customer_id),
    TRIM(o.order_status),

    STR_TO_DATE(
        TRIM(o.order_purchase_timestamp),
        '%Y-%m-%d %H:%i:%s'
    ),

    STR_TO_DATE(
        NULLIF(TRIM(o.order_approved_at), ''),
        '%Y-%m-%d %H:%i:%s'
    ),

    STR_TO_DATE(
        NULLIF(TRIM(o.order_delivered_carrier_date), ''),
        '%Y-%m-%d %H:%i:%s'
    ),

    STR_TO_DATE(
        NULLIF(TRIM(o.order_delivered_customer_date), ''),
        '%Y-%m-%d %H:%i:%s'
    ),

    STR_TO_DATE(
        TRIM(o.order_estimated_delivery_date),
        '%Y-%m-%d %H:%i:%s'
    ),

    CASE
        WHEN TRIM(o.order_delivered_carrier_date) <> ''
         AND o.order_delivered_carrier_date
             < o.order_purchase_timestamp
        THEN 1 ELSE 0
    END,

    CASE
        WHEN TRIM(o.order_delivered_carrier_date) <> ''
         AND TRIM(o.order_delivered_customer_date) <> ''
         AND o.order_delivered_customer_date
             < o.order_delivered_carrier_date
        THEN 1 ELSE 0
    END,

    CASE
        WHEN o.order_status = 'delivered'
         AND (
             TRIM(o.order_approved_at) = ''
             OR TRIM(o.order_delivered_carrier_date) = ''
             OR TRIM(o.order_delivered_customer_date) = ''
         )
        THEN 1 ELSE 0
    END

FROM olist_orders_raw o

WHERE NOT EXISTS (
    SELECT 1
    FROM olist_orders_clean c
    WHERE c.order_id = o.order_id
);


-- C. VALIDASI JUMLAH BARIS DAN ANOMALI

SELECT
    COUNT(*) AS total_clean_orders,

    SUM(carrier_before_purchase)
        AS carrier_before_purchase,

    SUM(customer_before_carrier)
        AS customer_before_carrier,

    SUM(delivered_missing_date)
        AS delivered_missing_date

FROM olist_orders_clean;


-- D. VALIDASI TIPE DATA

SHOW COLUMNS FROM olist_orders_clean;
