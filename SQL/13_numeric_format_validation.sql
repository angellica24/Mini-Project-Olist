
USE olist_ecommerce;

-- DATA TYPE VALIDATION
-- Pemeriksaan format numerik

-- 1. PRICE
SELECT
    'order_items.price' AS field_name,
    COUNT(*) AS total_rows,
    SUM(
        price IS NULL OR TRIM(price) = ''
    ) AS empty_values,
    SUM(
        price IS NOT NULL
        AND TRIM(price) <> ''
        AND NOT REGEXP_LIKE(
            TRIM(price),
            '^-?[0-9]+([.][0-9]+)?$'
        )
    ) AS invalid_format
FROM olist_order_items_raw

UNION ALL

-- 2. FREIGHT VALUE
SELECT
    'order_items.freight_value',
    COUNT(*),
    SUM(
        freight_value IS NULL
        OR TRIM(freight_value) = ''
    ),
    SUM(
        freight_value IS NOT NULL
        AND TRIM(freight_value) <> ''
        AND NOT REGEXP_LIKE(
            TRIM(freight_value),
            '^-?[0-9]+([.][0-9]+)?$'
        )
    )
FROM olist_order_items_raw

UNION ALL

-- 3. PAYMENT VALUE
SELECT
    'payments.payment_value',
    COUNT(*),
    SUM(
        payment_value IS NULL
        OR TRIM(payment_value) = ''
    ),
    SUM(
        payment_value IS NOT NULL
        AND TRIM(payment_value) <> ''
        AND NOT REGEXP_LIKE(
            TRIM(payment_value),
            '^-?[0-9]+([.][0-9]+)?$'
        )
    )
FROM olist_order_payments_raw

UNION ALL

-- 4. PAYMENT INSTALLMENTS
SELECT
    'payments.payment_installments',
    COUNT(*),
    SUM(
        payment_installments IS NULL
        OR TRIM(payment_installments) = ''
    ),
    SUM(
        payment_installments IS NOT NULL
        AND TRIM(payment_installments) <> ''
        AND NOT REGEXP_LIKE(
            TRIM(payment_installments),
            '^[0-9]+$'
        )
    )
FROM olist_order_payments_raw

UNION ALL

-- 5. REVIEW SCORE
SELECT
    'reviews.review_score',
    COUNT(*),
    SUM(
        review_score IS NULL
        OR TRIM(review_score) = ''
    ),
    SUM(
        review_score IS NOT NULL
        AND TRIM(review_score) <> ''
        AND NOT REGEXP_LIKE(
            TRIM(review_score),
            '^[0-9]+$'
        )
    )
FROM olist_order_reviews_raw;
