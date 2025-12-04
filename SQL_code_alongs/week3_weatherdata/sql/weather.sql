CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE
    IF NOT EXISTS staging.weather AS (
        SELECT
            *
        FROM
            read_csv_auto ('data/daily_weather_2020.csv')
    );

/* =========
Task 2
========= */
-- find the data types of columns
DESC staging.weather;

DESC
SELECT
    sunriseTime,
    sunsetTime,
    temperatureHighTime,
    temperatureLowTime,
    windGustTime,
    precipIntensityMaxTime
FROM
    staging.weather;

-- show the UNIX values of these columns
-- the values are the numbers of seconds counted from a reference time point (1970-01-01 00:00:00)
SELECT
    sunriseTime,
    sunsetTime,
    temperatureHighTime,
    temperatureLowTime,
    windGustTime,
    precipIntensityMaxTime
FROM
    staging.weather;

/* ========
Task 3
======== */
-- each row in the dataset contains weather data for each combination of Country/Region, Province/State and date (time column)
-- it's important to understand which columns can be used to uniquely identify each row
-- use aggregation function together with group by 
SELECT
    "Country/Region" AS Country, -- use of "" for column names
    "Province/State" AS State,
    COUNT(*) AS Nr_Records,
FROM
    staging.weather
GROUP BY
    Country,
    State -- you can use the original column names
ORDER BY
    Country,
    State;

/* ========
Task 4
======== */
SELECT
    to_timestamp (sunriseTime) AS sunrise_utc, -- this function transform numberic columns to timestamp
    to_timestamp (sunriseTime) AT TIME ZONE 'Europe/Stockholm' AS sunrise_swtime,
    to_timestamp (sunsetTime) AS sunset_utc,
    to_timestamp (sunsetTime) AT TIME ZONE 'Europe/Stockholm' AS sunset_swtime,
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden';

-- note the use of single and double quotations
/* ========
Task 5
======== */
-- the new year and month columns involves subtracting a part of timestamp
-- to pick up the date with the largest gap within a month involves
-- the use of aggregation function
-- the gaps can be calculated directly with UNIX time
SELECT
    year (to_timestamp (sunriseTime)) AS year_num,
    month (to_timestamp (sunriseTime)) AS month_num,
    (sunriseTime - sunsetTime) / 3600.0 AS gap_hours,
    to_timestamp (sunriseTime) AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Stockholm' AS sunrise_swe,
    to_timestamp (sunsetTime) AT TIME ZONE 'UTC' AT TIME ZONE 'Europe/Stockholm' AS sunset_swe,
FROM
    staging.weather
WHERE
    "Country/Region" = 'Sweden' QUALIFY ROW_NUMBER() OVER (
        PARTITION BY
            year_num,
            month_num
        ORDER BY
            gap_hours DESC
    ) = 1;

/* ========
Task 6
======== */
SELECT
    'It''s dangerous to use the crane at kl.'