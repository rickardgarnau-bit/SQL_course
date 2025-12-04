CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE
    IF NOT EXISTS staging.bikeorders AS (
        SELECT
            *
        FROM
            read_csv_auto ('data/order_items.csv')
    );

CREATE TABLE
    IF NOT EXISTS staging.bikeproducts AS (
        SELECT
            *
        FROM
            read_csv_auto ('data/products.csv')
    );