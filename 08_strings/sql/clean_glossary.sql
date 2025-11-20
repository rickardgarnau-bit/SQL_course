-- 1. ARCHITECTURE
-- Create a new schema for 'clean' data.
-- This separates raw inputs (staging) from trusted outputs (refined).
CREATE SCHEMA IF NOT EXISTS refined;

-- 2. TRANSFORMATION PIPELINE
-- Create the final table and populate it with the cleaned data immediately.
CREATE TABLE
    IF NOT EXISTS refined.sql_glossary AS (
        SELECT
            -- Standardize the ID/Key column:
            -- Remove surrounding whitespace and force Uppercase (e.g. ' select ' -> 'SELECT').
            upper(trim(sql_word)) AS sql_word,
            -- 3. ADVANCED CLEANING (REGEX)
            -- Look at the 'description' column.
            -- pattern ' +': Find any instance of 1 OR MORE spaces.
            -- replacement ' ': Replace them with a single space.
            -- flag 'g': Global. Do this for every occurrence in the string, not just the first one.
            regexp_replace (trim(description), ' +', ' ', 'g') as description,
            -- Pass the example column through unchanged.
            example
        FROM
            staging.sql_glossary
    );

/* 1. The Power of regexp_replace
You replaced the simple replace() function with the much more powerful Regex version.
The Problem: replace(col, ' ', ' ') only fixes exactly two spaces. If you had three spaces, it might leave two behind.
The Solution (' +'): This RegEx pattern matches "one or more" spaces. It effectively collapses any gap—whether it's 2 spaces or 20 spaces—down to a single space.
2. "Medallion" Architecture
You are effectively building a Medallion Architecture (or Multi-Hop Architecture).
Bronze (Your staging): The raw data you loaded from CSV. It had extra spaces, mixed casing, and formatting errors.
Silver (Your refined): The data you just created. It is standardized, trimmed, and deduplicated. It is ready for analysis. */