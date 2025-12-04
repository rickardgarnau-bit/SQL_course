--1. Exploring hemnet data
-- a) Create a database file called hemnet.duckdb and ingest the data from the csv file into your database.
CREATE TABLE
    IF NOT EXISTS hemnet AS
SELECT
    *
FROM
    read_csv_auto ('data/hemnet_data_clean.csv');

-- b) Make a wildcard selection to checkout the data (use the asterisk symbol)
SELECT
    *
FROM
    hemnet
    -- c) Find out how many rows there are in the table
SELECT
    COUNT(*)
FROM
    hemnet;

-- d) Describe the table that you have ingested to see the columns and data types.
DESCRIBE hemnet;

-- e) Find out the 5 most expensive homes sold.
SELECT
    *
FROM
    hemnet
ORDER BY
    final_price DESC
LIMIT
    5;

-- f) Find out the 5 cheapest homes sold.
SELECT
    *
FROM
    hemnet
ORDER BY
    final_price ASC
LIMIT
    5;

-- g) Find out statistics on minimum, mean, median and maximum prices of homes sold.
SELECT
    MIN(final_price)
FROM
    hemnet;

SELECT
    MEAN (final_price)
FROM
    hemnet;

SELECT
    MEDIAN (final_price)
FROM
    hemnet;

SELECT
    MAX(final_price)
FROM
    hemnet;

-- h) Find out statistics on minimum, mean, median and maximum prices of price per area.
SELECT
    MIN(price_per_area)
FROM
    hemnet;

SELECT
    MEAN (price_per_area)
FROM
    hemnet;

SELECT
    MEDIAN (price_per_area)
FROM
    hemnet;

SELECT
    MAX(price_per_area)
FROM
    hemnet;

-- i) How many unique communes are represented in the dataset.
SELECT
    COUNT(DISTINCT commune)
FROM
    hemnet;

-- j) How many percentage of homes cost more than 10 million?
SELECT
    AVG((final_price / asked_price) / (asked_price * 100)) AS avg_procent
FROM
    hemnet
WHERE
    final_price > 10000000;

-- k) Feel free to explore anything else you find interesting in this dataset.