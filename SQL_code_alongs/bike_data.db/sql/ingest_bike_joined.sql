CREATE SCHEMA staging:

CREATE TABLE IF NOT EXISTS staging.joined_table AS (
    SELECT * FROM read_csv_auto('data/joined_table.
    csv')
);