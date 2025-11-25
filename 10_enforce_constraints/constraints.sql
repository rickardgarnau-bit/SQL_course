/* =============================================
 Enforce constraints with CREATE TABLE
 ============================================= */
-- 1. NOT NULL CONSTRAINT
-- This constraint ensures a column must always have data (no missing values).
CREATE TABLE students (name VARCHAR NOT NULL);

-- Attempting to insert two rows at once.
-- The first value is NULL (which is illegal here), the second is 'Amy' (which is legal).
INSERT INTO
    students (name)
VALUES
    (NULL),
    ('Amy');

-- RESULT: Error! 
-- Because one row failed (the NULL one), the entire INSERT statement is cancelled. 
-- 'Amy' is NOT inserted. The table remains empty.
DROP TABLE students;

-- 2. UNIQUE CONSTRAINT
-- This ensures all values in this column are different from one another.
CREATE TABLE students (name VARCHAR UNIQUE, age INTEGER);

-- Attempting to insert 'Amy' (okay), 'Bill' (okay), and 'Bill' again (duplicate).
INSERT INTO
    students (name, age)
VALUES
    ('Amy', 4),
    ('Bill', 8),
    ('Bill', 6);

-- RESULT: Error!
-- The second 'Bill' violates the UNIQUE constraint.
-- Again, because one failed, NO rows are inserted. The table is empty.
DROP TABLE students;

-- 3. CHECK CONSTRAINT
-- This validates data against a specific condition (logic check).
CREATE TABLE students (
    name VARCHAR UNIQUE,
    age INTEGER CHECK (age >= 10) -- Age must be 10 or higher
);

-- Attempting to insert Amy (13 is valid) and Bill (5 is invalid).
INSERT INTO
    students (name, age)
VALUES
    ('Amy', 13),
    ('Bill', 5);

-- RESULT: Error!
-- Bill's age (5) is less than 10. Constraint violation.
-- The transaction rolls back, so Amy is NOT inserted.
DROP TABLE students;

-- 4. DEFAULT CONSTRAINT
-- Automatically fills in a value if the user doesn't provide one.
CREATE TABLE students (
    name VARCHAR UNIQUE,
    school_year INTEGER DEFAULT 2025
);

-- We only specify the 'name' here, ignoring 'school_year'.
INSERT INTO
    students (name)
VALUES
    ('Amy'),
    ('Bill');

-- RESULT: Success.
-- Both rows are inserted. Since we didn't provide a year, DuckDB used 2025.
-- Amy: 2025, Bill: 2025.
DROP TABLE students;

/* =============================================
 Enforce constraints with ALTER TABLE
 ============================================= */
-- create a base table with no special constraints on age
CREATE TABLE students (name VARCHAR, age INTEGER);

-- Insert Amy without specifying age.
INSERT INTO
    students (name)
VALUES
    ('Amy');

-- Current state: Amy's age is NULL because we haven't set a default yet.
-- Modify the table structure to add a DEFAULT for *future* inserts.
ALTER TABLE
    students
ALTER COLUMN
    age
SET
    DEFAULT 10;

-- Insert Bill without specifying age.
INSERT INTO
    students (name)
VALUES
    ('Bill');

-- Current state: 
-- Amy is still NULL (changing the default doesn't update old data).
-- Bill is 10 (he used the new default).
-- Remove the default constraint.
ALTER TABLE
    students
ALTER COLUMN
    age DROP DEFAULT;

-- Any future inserts without an age will go back to being NULL.