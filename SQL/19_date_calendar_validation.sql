
USE olist_ecommerce;

-- VALIDASI TANGGAL KALENDER
-- Memeriksa jumlah hari dalam bulan dan tahun kabisat

WITH date_fields AS (

    SELECT
        'orders.purchase' AS field_name,
        order_purchase_timestamp AS date_value
    FROM olist_orders_raw

    UNION ALL

    SELECT 'orders.approved', order_approved_at
    FROM olist_orders_raw

    UNION ALL

    SELECT 'orders.carrier', order_delivered_carrier_date
    FROM olist_orders_raw

    UNION ALL

    SELECT 'orders.customer', order_delivered_customer_date
    FROM olist_orders_raw

    UNION ALL

    SELECT 'orders.estimated', order_estimated_delivery_date
    FROM olist_orders_raw

    UNION ALL

    SELECT 'items.shipping_limit', shipping_limit_date
    FROM olist_order_items_raw

    UNION ALL

    SELECT 'reviews.creation', review_creation_date
    FROM olist_order_reviews_raw

    UNION ALL

    SELECT 'reviews.answer', review_answer_timestamp
    FROM olist_order_reviews_raw
),

date_parts AS (

    SELECT
        field_name,

        CAST(SUBSTRING(date_value, 1, 4) AS UNSIGNED)
            AS year_num,

        CAST(SUBSTRING(date_value, 6, 2) AS UNSIGNED)
            AS month_num,

        CAST(SUBSTRING(date_value, 9, 2) AS UNSIGNED)
            AS day_num

    FROM date_fields

    WHERE date_value IS NOT NULL
      AND TRIM(date_value) <> ''
)

SELECT
    field_name,

    COUNT(*) AS filled_dates,

    SUM(
        CASE
            WHEN year_num NOT BETWEEN 1000 AND 9999
              OR month_num NOT BETWEEN 1 AND 12
              OR day_num < 1
              OR day_num >
                CASE
                    WHEN month_num IN (4, 6, 9, 11)
                        THEN 30

                    WHEN month_num = 2
                        THEN
                            CASE
                                WHEN MOD(year_num, 400) = 0
                                  OR (
                                      MOD(year_num, 4) = 0
                                      AND MOD(year_num, 100) <> 0
                                  )
                                THEN 29
                                ELSE 28
                            END

                    ELSE 31
                END
            THEN 1
            ELSE 0
        END
    ) AS invalid_calendar_dates

FROM date_parts

GROUP BY field_name

ORDER BY field_name;
