
USE olist_ecommerce;

-- A. RINGKASAN GEOLOCATION BERDASARKAN KODE POS

SELECT
    COUNT(*) AS total_zip_prefixes,

    SUM(total_records > 1) AS zip_with_multiple_records,

    SUM(unique_coordinates > 1) AS zip_with_multiple_coordinates,

    SUM(unique_cities > 1) AS zip_with_multiple_cities,

    SUM(unique_states > 1) AS zip_with_multiple_states

FROM (
    SELECT
        geolocation_zip_code_prefix,

        COUNT(*) AS total_records,

        COUNT(
            DISTINCT geolocation_lat,
            geolocation_lng
        ) AS unique_coordinates,

        COUNT(DISTINCT geolocation_city) AS unique_cities,

        COUNT(DISTINCT geolocation_state) AS unique_states

    FROM olist_geolocation_raw

    GROUP BY geolocation_zip_code_prefix

) AS geo_summary;



-- B. CONTOH KODE POS DENGAN DATA TERBANYAK

SELECT
    geolocation_zip_code_prefix AS zip_code,

    COUNT(*) AS total_records,

    COUNT(
        DISTINCT geolocation_lat,
        geolocation_lng
    ) AS unique_coordinates,

    COUNT(DISTINCT geolocation_city) AS unique_cities,

    COUNT(DISTINCT geolocation_state) AS unique_states

FROM olist_geolocation_raw

GROUP BY geolocation_zip_code_prefix

ORDER BY total_records DESC

LIMIT 10;
