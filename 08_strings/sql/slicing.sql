-- 1. INDIVIDUAL INDEXING
-- Note: SQL uses 1-based indexing (counting starts at 1), not 0-based like Python.
SELECT 
    sql_word,
    -- Returns an empty string (or NULL). 
    -- Since SQL starts counting at 1, index 0 is technically "out of bounds".
    sql_word[0],
    -- Returns the 1st character (e.g., 'S' in 'SELECT').
    sql_word[1], 
    -- Returns the last character.
    -- Negative numbers count backwards from the end (Python-style).
    sql_word[-1]
FROM staging.sql_glossary;

-- 2. SLICING (RANGES)
-- DuckDB slicing is [start : end], but unlike Python, the 'end' is usually INCLUSIVE.
SELECT 
    sql_word,
    -- "Everything up to index 2".
    -- In DuckDB (1-based), this gives chars 1 and 2. 
    -- Result: First 2 characters.
    sql_word[:2],
    -- "From index 2 up to index 5".
    -- Important: This includes BOTH index 2 and index 5.
    -- Example for 'SELECT':
    --   1=S, 2=E, 3=L, 4=E, 5=C
    --   Result: 'ELEC' (4 characters).
    --   (Python [2:5] would exclude the end and give 3 characters).
    sql_word[2:5]
FROM staging.sql_glossary;

/* Key Takeaway: The "Inclusive" Trap
In Python, the slice [2:5] means "start at 2, but stop before 5" (Exclusive End).
In DuckDB SQL, the slice [2:5] often means "start at 2 and include 5" (Inclusive End).
Always check your output when slicing in SQL to ensure you aren't grabbing one extra character! */