
USE olist_ecommerce;

-- ==========================================
-- 22. CREATE CLEAN ORDER ITEMS TABLE
-- ==========================================

-- A. VALIDASI ORDER ITEM ID

SELECT
    COUNT(*) AS total_raw_rows,

    SUM(
        order_item_id IS NULL
        OR NOT REGEXP_LIKE(
            TRIM(order_item_id),
            '^[0-9]+$'
        )
    ) AS invalid_item_ids,

    MAX(CAST(order_item_id AS UNSIGNED))
        AS max_item_id

FROM olist_order_items_raw;


-- B. MEMBUAT TABEL CLEAN

CREATE TABLE IF NOT EXISTS olist_order_items_clean (

    order_id VARCHAR(50) NOT NULL,

    order_item_id SMALLINT UNSIGNED NOT NULL,

    product_id VARCHAR(50) NOT NULL,

    seller_id VARCHAR(50) NOT NULL,

    shipping_limit_date DATETIME NOT NULL,

    price DECIMAL(12,2) NOT NULL,

    freight_value DECIMAL(12,2) NOT NULL,

    PRIMARY KEY (order_id, order_item_id),

    INDEX idx_product_id (product_id),

    INDEX idx_seller_id (seller_id)

);


-- C. MEMASUKKAN DATA

INSERT INTO olist_order_items_clean (

    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value

)

SELECT

    TRIM(i.order_id),

    CAST(TRIM(i.order_item_id) AS UNSIGNED),

    TRIM(i.product_id),

    TRIM(i.seller_id),

    STR_TO_DATE(
        TRIM(i.shipping_limit_date),
        '%Y-%m-%d %H:%i:%s'
    ),

    CAST(TRIM(i.price) AS DECIMAL(12,2)),

    CAST(TRIM(i.freight_value) AS DECIMAL(12,2))

FROM olist_order_items_raw i

WHERE NOT EXISTS (

    SELECT 1
    FROM olist_order_items_clean c
    WHERE c.order_id = i.order_id
      AND c.order_item_id =
          CAST(TRIM(i.order_item_id) AS UNSIGNED)

);


-- D. VALIDASI JUMLAH DATA DAN HARGA

SELECT
    COUNT(*) AS total_clean_items,

    COUNT(DISTINCT order_id) AS orders_with_items,

    SUM(price < 0) AS negative_price,

    SUM(freight_value < 0) AS negative_freight,

    SUM(freight_value = 0) AS zero_freight

FROM olist_order_items_clean;


-- E. VALIDASI HUBUNGAN DENGAN ORDERS

SELECT
    COUNT(*) AS total_items,

    SUM(
        CASE
            WHEN o.order_id IS NULL
            THEN 1 ELSE 0
        END
    ) AS unmatched_items

FROM olist_order_items_clean i

LEFT JOIN olist_orders_clean o
    ON i.order_id = o.order_id;


-- F. VALIDASI STRUKTUR TABEL

SHOW COLUMNS FROM olist_order_items_clean;
