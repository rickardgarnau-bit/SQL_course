-- 1. TRIMMING AND SLICING
-- Remove leading/trailing spaces and extract specific characters.
SELECT
    trim(sql_word, ' ') as trimmed_word,
    -- specific to DuckDB: accessing string characters like an array/list.
    -- [1] gets the first character.
    trimmed_word[1] as first_character,
    -- [-1] is Python-style indexing to get the LAST character.
    trimmed_word[-1] as last_character
FROM
    staging.sql_glossary;

-- 2. NORMALIZATION (UPPERCASE)
-- Standardize data to uppercase to ensure consistency (e.g., 'Select' becomes 'SELECT').
SELECT
    upper(trim(sql_word, ' ')) as sql_term,
    -- DuckDB Feature: You are reusing the 'sql_term' alias defined
    -- in the line above. In standard SQL (Postgres/MySQL), this would usually
    -- cause an error, but DuckDB allows it!
    sql_term[1] as first_character,
    sql_term[-1] as last_character
FROM
    staging.sql_glossary;

-- 3. CLEANING WHITESPACE
-- Fix formatting issues where two spaces were typed instead of one.
SELECT
    description,
    -- Looks for '  ' (double space) and replaces it with ' ' (single space).
    replace(description, '  ', ' ') as cleaned_description
FROM staging.sql_glossary;

-- 4. CONCATENATION
-- Two ways to join strings together.
SELECT
    -- Option A: Using the CONCAT function (cleaner for many arguments).
    concat(upper(trim(sql_word)), ' command') as sql_command_func,
    -- Option B: Using the double pipe operator (standard ANSI SQL).
    upper(trim(sql_word)) || ' command' as sql_command_pipe
FROM
    staging.sql_glossary;

-- 5. SUBSTRINGS
-- Extracting a specific portion of a word.
SELECT
    trim(sql_word, ' ') as trimmed_word,
    -- Standard SQL way: Start at 1, take 5 characters.
    substring(trim(sql_word), 1, 5) as first_five_chars,
    -- DuckDB/Python way: Slice from index 1 to 5.
    trimmed_word[1:5] as sliced_five_chars
FROM
    staging.sql_glossary;

-- 6. REVERSING
-- Useful for finding palindromes or matching suffixes.
SELECT
    reverse(trim(sql_word)) as reversed_word
FROM
    staging.sql_glossary;

-- 7. SEARCHING TEXT (INSTR)
-- Checking if a specific keyword exists in the description.
SELECT
    description,
    -- Returns the position number where 'select' starts.
    -- If not found, it returns 0.
    instr(description, 'select') as select_position,
    -- Creates a Boolean (True/False) column based on the result.
    select_position != 0 as about_select
FROM staging.sql_glossary;

-- 8. SCALAR TEST
-- A simple test to see how concatenation works without a table.
SELECT 'fun' || ' joke';

/* Key Observations
Trailing Commas: You have trailing commas in your SELECT lists (e.g., as last_character, FROM).
DuckDB allows this, but be aware that strict SQL databases (like SQL Server or older MySQL)
will throw a syntax error if you leave a comma before the FROM.
1-Based Indexing: Even though DuckDB supports Python-like slicing [1:5], SQL is 1-based, not 0-based.
SQL: The first letter is at index 1.
Python: The first letter is at index 0. */