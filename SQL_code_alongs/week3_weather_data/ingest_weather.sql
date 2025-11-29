CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.weather AS (
    SELECT
        *
    FROM
        read_csv_auto('data/daily_weather_2020.csv')
);

DESCRIBE staging.weather;

SELECT
    sunriseTime,
    sunsetTime,
    windGustTime
FROM
    staging.weather
LIMIT
    5;

--
SELECT
    "Country/Region",
    "Province/State",
    COUNT(*) as num_rows
FROM
    staging.weather
GROUP BY
    "Country/Region",
    "Province/State";

--
SELECT
    DISTINCT "Country/Region"
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden';

--
SELECT
    month(to_timestamp(sunriseTime)) AS month_num,
    to_timestamp(sunriseTime) AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Stockholm' AS sunrise_swe,
    to_timestamp(sunsetTime) AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Stockholm' AS sunset_swe,
    (sunsetTime - sunriseTime) / 3600.0 AS big_diff,
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden',
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY month_num
        ORDER BY
            big_diff DESC
    ) = 1;