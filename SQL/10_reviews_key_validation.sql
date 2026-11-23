
USE olist_ecommerce;

-- A. CEK DUPLIKASI KOMBINASI REVIEW_ID DAN ORDER_ID

SELECT
    COUNT(*) AS duplicate_pairs,
    COALESCE(SUM(record_count - 1), 0) AS excess_rows
FROM (
    SELECT
        review_id,
        order_id,
        COUNT(*) AS record_count
    FROM olist_order_reviews_raw
    GROUP BY review_id, order_id
    HAVING COUNT(*) > 1
) AS duplicates;


-- B. CEK PESANAN YANG MEMILIKI LEBIH DARI SATU REVIEW

SELECT
    COUNT(*) AS orders_with_multiple_reviews,
    COALESCE(SUM(review_count - 1), 0) AS additional_review_rows,
    COALESCE(MAX(review_count), 0) AS max_reviews_per_order
FROM (
    SELECT
        order_id,
        COUNT(*) AS review_count
    FROM olist_order_reviews_raw
    GROUP BY order_id
    HAVING COUNT(*) > 1
) AS multiple_reviews;


-- C. CEK APAKAH ORDER_ID REVIEWS TERDAFTAR DI ORDERS

SELECT
    COUNT(*) AS unmatched_review_rows,
    COUNT(DISTINCT r.order_id) AS unmatched_order_ids
FROM olist_order_reviews_raw r
LEFT JOIN olist_orders_raw o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;
