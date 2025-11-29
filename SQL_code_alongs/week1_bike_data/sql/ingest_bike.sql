/*First create a SCHEMA*/
-- staging to store raw data
-- IF NOT EXISTS to make sure it doesen't already exists, if it does it will still work
CREATE SCHEMA IF NOT EXISTS staging;

/*Join the TABLES*/
-- staging.costumers
-- read_csv_auto will look into the costumer and define the datatype 
CREATE TABLE IF NOT EXISTS staging.customers AS (
    SELECT
        *
    FROM
        read_csv_auto('data/customers.csv')
);

CREATE TABLE IF NOT EXISTS staging.brands AS (
    SELECT
        *
    FROM
        read_csv_auto('data/brands.csv')
);

CREATE TABLE IF NOT EXISTS staging.categories AS (
    SELECT
        *
    FROM
        read_csv_auto('data/categories.csv')
);

CREATE TABLE IF NOT EXISTS staging.order_items AS (
    SELECT
        *
    FROM
        read_csv_auto('data/order_items.csv')
);

CREATE TABLE IF NOT EXISTS staging.orders AS (
    SELECT
        *
    FROM
        read_csv_auto('data/orders.csv')
);

CREATE TABLE IF NOT EXISTS staging.products AS (
    SELECT
        *
    FROM
        read_csv_auto('data/products.csv')
);

CREATE TABLE IF NOT EXISTS staging.staffs AS (
    SELECT
        *
    FROM
        read_csv_auto('data/staffs.csv')
);

CREATE TABLE IF NOT EXISTS staging.stocks AS (
    SELECT
        *
    FROM
        read_csv_auto('data/stocks.csv')
);

CREATE TABLE IF NOT EXISTS staging.stores AS (
    SELECT
        *
    FROM
        read_csv_auto('data/stores.csv')
);

-- To create a duckdb file with the data from sql file -> duckdb bike_temp.duckdb < (inputting) sql/ingest_bike.sql