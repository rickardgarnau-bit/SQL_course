CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.joined_tables AS (
    SELECT
        *
    FROM
        read_csv_auto('data/joined_data.csv')
);