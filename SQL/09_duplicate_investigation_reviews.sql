
USE olist_ecommerce;

-- A. INVESTIGASI REVIEW ID BERULANG

SELECT
    COUNT(*) AS duplicated_review_ids,

    SUM(
        CASE
            WHEN distinct_orders = 1 THEN 1
            ELSE 0
        END
    ) AS same_order_groups,

    SUM(
        CASE
            WHEN distinct_orders > 1 THEN 1
            ELSE 0
        END
    ) AS different_order_groups,

    SUM(record_count - 1) AS excess_rows

FROM (
    SELECT
        review_id,
        COUNT(*) AS record_count,
        COUNT(DISTINCT order_id) AS distinct_orders

    FROM olist_order_reviews_raw

    GROUP BY review_id
    HAVING COUNT(*) > 1
) AS review_duplicates;



-- B. MELIHAT CONTOH REVIEW ID BERULANG

WITH repeated_reviews AS (

    SELECT
        review_id,
        COUNT(*) AS record_count,
        COUNT(DISTINCT order_id) AS distinct_orders

    FROM olist_order_reviews_raw

    GROUP BY review_id
    HAVING COUNT(*) > 1

    ORDER BY record_count DESC, review_id
    LIMIT 5
)

SELECT
    r.review_id,
    r.order_id,
    r.review_score,
    r.review_creation_date,
    r.review_answer_timestamp,
    LEFT(r.review_comment_message, 60) AS comment_preview,
    d.record_count,
    d.distinct_orders

FROM olist_order_reviews_raw r

JOIN repeated_reviews d
    ON r.review_id = d.review_id

ORDER BY
    d.record_count DESC,
    r.review_id,
    r.order_id;
