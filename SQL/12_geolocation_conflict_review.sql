
USE olist_ecommerce;

-- A. KODE POS DENGAN NEGARA BAGIAN BERBEDA

SELECT
    geolocation_zip_code_prefix AS zip_code,
    COUNT(*) AS total_records,
    COUNT(DISTINCT geolocation_state) AS total_states,
    GROUP_CONCAT(
        DISTINCT geolocation_state
        ORDER BY geolocation_state
        SEPARATOR ', '
    ) AS state_list,
    COUNT(DISTINCT geolocation_city) AS total_cities

FROM olist_geolocation_raw

GROUP BY geolocation_zip_code_prefix

HAVING COUNT(DISTINCT geolocation_state) > 1

ORDER BY zip_code;



-- B. DISTRIBUSI NEGARA BAGIAN PADA KODE POS KONFLIK

SELECT
    g.geolocation_zip_code_prefix AS zip_code,
    g.geolocation_state AS state,
    COUNT(*) AS total_records,
    COUNT(DISTINCT g.geolocation_city) AS unique_cities

FROM olist_geolocation_raw g

WHERE g.geolocation_zip_code_prefix IN (
    SELECT geolocation_zip_code_prefix
    FROM olist_geolocation_raw
    GROUP BY geolocation_zip_code_prefix
    HAVING COUNT(DISTINCT geolocation_state) > 1
)

GROUP BY
    g.geolocation_zip_code_prefix,
    g.geolocation_state

ORDER BY
    zip_code,
    total_records DESC;
