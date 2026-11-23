
USE olist_ecommerce;

-- A. VALIDASI HARGA DAN ONGKOS KIRIM

SELECT
    COUNT(*) AS total_rows,

    SUM(CAST(price AS DECIMAL(18,2)) < 0)
        AS negative_price,

    SUM(CAST(price AS DECIMAL(18,2)) = 0)
        AS zero_price,

    MIN(CAST(price AS DECIMAL(18,2)))
        AS min_price,

    MAX(CAST(price AS DECIMAL(18,2)))
        AS max_price,

    SUM(CAST(freight_value AS DECIMAL(18,2)) < 0)
        AS negative_freight,

    SUM(CAST(freight_value AS DECIMAL(18,2)) = 0)
        AS zero_freight,

    MIN(CAST(freight_value AS DECIMAL(18,2)))
        AS min_freight,

    MAX(CAST(freight_value AS DECIMAL(18,2)))
        AS max_freight

FROM olist_order_items_raw;



-- B. VALIDASI PEMBAYARAN DAN CICILAN

SELECT
    COUNT(*) AS total_rows,

    SUM(CAST(payment_value AS DECIMAL(18,2)) < 0)
        AS negative_payment,

    SUM(CAST(payment_value AS DECIMAL(18,2)) = 0)
        AS zero_payment,

    MIN(CAST(payment_value AS DECIMAL(18,2)))
        AS min_payment,

    MAX(CAST(payment_value AS DECIMAL(18,2)))
        AS max_payment,

    SUM(CAST(payment_installments AS UNSIGNED) = 0)
        AS zero_installments,

    MIN(CAST(payment_installments AS UNSIGNED))
        AS min_installments,

    MAX(CAST(payment_installments AS UNSIGNED))
        AS max_installments

FROM olist_order_payments_raw;



-- C. VALIDASI REVIEW SCORE

SELECT
    COUNT(*) AS total_reviews,

    MIN(CAST(review_score AS UNSIGNED))
        AS min_score,

    MAX(CAST(review_score AS UNSIGNED))
        AS max_score,

    SUM(
        CAST(review_score AS UNSIGNED) NOT BETWEEN 1 AND 5
    ) AS invalid_score,

    SUM(CAST(review_score AS UNSIGNED) = 1)
        AS score_1,

    SUM(CAST(review_score AS UNSIGNED) = 2)
        AS score_2,

    SUM(CAST(review_score AS UNSIGNED) = 3)
        AS score_3,

    SUM(CAST(review_score AS UNSIGNED) = 4)
        AS score_4,

    SUM(CAST(review_score AS UNSIGNED) = 5)
        AS score_5

FROM olist_order_reviews_raw;
