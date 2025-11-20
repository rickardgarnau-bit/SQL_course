CREATE SCHEMA IF NOT EXISTS refined;

CREATE TABLE
    IF NOT EXISTS refined.sql_glossary AS (
        SELECT
            upper(trim(sql_word)) AS sql_word,
            regexp_replace (trim(description), ' +', ' ', 'g') as description,
            example
        FROM
            staging.sql_glossary
    )