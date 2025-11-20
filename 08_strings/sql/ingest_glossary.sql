-- 1. Create a logical container (schema) to organize your tables.
-- 'IF NOT EXISTS' ensures this script won't fail if you run it multiple times.
CREATE SCHEMA IF NOT EXISTS staging;

-- 2. Create a new table named 'sql_glossary' inside the 'staging' schema.
-- This uses the CTAS (Create Table As Select) pattern to create the structure
-- and fill it with data simultaneously.
CREATE TABLE
    IF NOT EXISTS staging.sql_glossary AS (
        SELECT
            *
        FROM
            -- 3. Read the raw CSV file.
            -- 'auto' detects the column types (Integer, Varchar, Date) automatically
            -- so you don't have to manually define the table schema.
            read_csv_auto ('data/sql_terms.csv')
    );

/* Key Concepts Used
Idempotency (IF NOT EXISTS): You have written this script so it is "idempotent."
This means you can run this script 1 time or 100 times, and the result is always the same
(it won't crash trying to create things that are already there).
Namespacing (staging schema): You are using a schema to separate your raw/staging data from your final production data.
This is a data engineering best practice to keep the database clean.
Type Inference (read_csv_auto): You are leveraging the database engine's ability to guess data types (numbers vs. text)
without writing a long CREATE TABLE (id INT, name TEXT...) statement manually.*/