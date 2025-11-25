/* ============
 DDL - CREATE
 ============ */
-- 1. Skapa schema
CREATE SCHEMA IF NOT EXISTS library;

-- 2. Skapa sekvens
CREATE SEQUENCE IF NOT EXISTS book_seq_id START 1;

-- 3. Skapa tabell
CREATE TABLE IF NOT EXISTS library.books (
    book_id INTEGER DEFAULT nextval('book_seq_id'),
    title VARCHAR,
    genre VARCHAR
);

/* =============
 CRUD - CREATE 
 ============= */
-- 4. Lägg in 2 böcker manuellt
INSERT INTO
    library.books (title, genre)
VALUES
    ('Harry Potter', 'Fantasy'),
    -- <--- Kommatecken här!
    ('1984', 'Sci-Fi');

-- 5. Lägg in böcker via read_csv
INSERT INTO
    library.books (title, genre)
SELECT
    *
FROM
    read_csv('new_books.csv');

/* =============
 CRUD - Read 
 ============= */
-- 6. Visa alla böcker
SELECT
    *
FROM
    library.books;

/* ==============
 CRUD - Update 
 ============== */
-- 7. Ändra genre på boken med ID 2
UPDATE
    library.books
SET
    genre = 'Dystopi'
WHERE
    book_id = 2;

/* ============
 DDL - Alter
 ============ */
-- 8. Lägg till kolumnen is_borrowed
ALTER TABLE
    library.books
ADD
    COLUMN is_borrowed BOOLEAN DEFAULT FALSE;

-- <--- Inga fnuttar på namnet, och avsluta med semikolon!
/* ==============
 CRUD - Update 
 ============== */
-- 9. Markera alla Fantasy-böcker som utlånade
UPDATE
    library.books
SET
    is_borrowed = TRUE
WHERE
    genre = 'Fantasy';

/* ==============
 CRUD - Delete 
 ============== */
-- 10. Kolla först
SELECT
    *
FROM
    library.books
WHERE
    book_id = 1;

-- 11. Ta bort
DELETE FROM
    library.books
WHERE
    book_id = 1;