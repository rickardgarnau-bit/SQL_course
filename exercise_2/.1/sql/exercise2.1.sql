-- 1. Förbered DuckDB för att läsa SQLite
INSTALL sqlite;
LOAD sqlite;

-- 2. Koppla upp mot filen (OBS: Kontrollera att sökvägen stämmer!)
ATTACH 'data/sqlite-sakila.db' AS sqlite_db (TYPE SQLITE);

-- 3. Skapa schemat
CREATE SCHEMA IF NOT EXISTS staging;

-- 4. Ladda in FILM (Inga konstigheter här)
DROP TABLE IF EXISTS staging.film;
CREATE TABLE staging.film AS 
SELECT * FROM sqlite_db.film;

-- 5. Ladda in RENTAL (Här fixar vi krasch-felet med CAST)
DROP TABLE IF EXISTS staging.rental;
CREATE TABLE staging.rental AS 
SELECT 
    rental_id,
    CAST(rental_date AS TIMESTAMP) AS rental_date, -- Fixar datumformatet
    inventory_id,
    customer_id,
    CAST(return_date AS TIMESTAMP) AS return_date, -- Fixar datumformatet
    staff_id,
    last_update
FROM 
    sqlite_db.rental;

-- 6. Ladda in INVENTORY (Behövs för att koppla ihop saker senare)
DROP TABLE IF EXISTS staging.inventory;
CREATE TABLE staging.inventory AS 
SELECT * FROM sqlite_db.inventory;
--------------------------------------------------------------------------
-- Kolla att tabellen ser bra ut
DESCRIBE staging.film;
--------------------------------------------------------------------------
-- Visa de första raderna
SELECT * FROM staging.film LIMIT 5;
--------------------------------------------------------------------------
-- Hur många filmer finns det?
SELECT COUNT(*) FROM staging.film;
--------------------------------------------------------------------------
-- Statistik om filmlängd (Mean, Median, Min, Max)
SELECT
    MAX(length) as max_length,
    MIN(length) as min_length,
    AVG(length) as avg_length,
    MEDIAN(length) as median_length,
    STDDEV(length) as variation_in_length,
    COUNT(*) as total_movies
FROM
    staging.film;
--------------------------------------------------------------------------
-- Vilken filmlängd är vanligast (Typvärde/Mode)?
SELECT
    length,
    COUNT(*) as frequency
FROM
    staging.film  -- Rättat: Lade till "staging."
GROUP BY
    length
ORDER BY
    frequency DESC
LIMIT 1;
--------------------------------------------------------------------------
-- Vilken tid på dygnet hyr folk mest?
SELECT
    HOUR(rental_date) as hour,
    COUNT(*) as total_rentals
FROM
    staging.rental
GROUP BY
    1
ORDER BY
    total_rentals DESC;
--------------------------------------------------------------------------
-- Hur många filmer finns i varje rating-kategori?
SELECT
    rating,
    COUNT(*) as total_rating
FROM
    staging.film
GROUP BY
    1
ORDER BY 
    total_rating DESC;
--------------------------------------------------------------------------
-- Vilka kunder lämnar tillbaka flest filmer samma dag?
SELECT
    DATE(return_date) as return_day, -- Använder DATE för att gruppera per dag
    customer_id,
    COUNT(*) as total_returns
FROM
    staging.rental
GROUP BY
    return_day,
    customer_id
ORDER BY
    total_returns DESC
LIMIT 10;
--------------------------------------------------------------------------
SELECT 
    -- Vi hämtar kolumner från olika tabeller nu när de sitter ihop:
    r.customer_id,   -- Vem hyrde? (Från rental-tabellen)
    f.title,         -- Vad heter filmen? (Från film-tabellen)
    r.rental_date    -- När hyrdes den? (Från rental-tabellen)

FROM 
    staging.rental AS r -- Vi ger tabellen smeknamnet "r" för att slippa skriva hela namnet

-- STEG 1: Koppla ihop Uthyrning med Lagret (Inventory)
-- Vi måste göra detta för att "rental" bara vet vilket ID dvd-skivan har, inte vilken film det är.
JOIN 
    staging.inventory AS i       -- Smeknamn "i"
    ON r.inventory_id = i.inventory_id  -- "Limmet": Matcha raderna där Inventory ID är samma.

-- STEG 2: Koppla ihop Lagret med Film-informationen
-- Nu när vi har Inventory-raden, kan vi se vilket film_id den pekar på.
JOIN 
    staging.film AS f            -- Smeknamn "f"
    ON i.film_id = f.film_id     -- "Limmet": Matcha raderna där Film ID är samma.

-- Sortera så att de senaste uthyrningarna hamnar överst
ORDER BY 
    r.rental_date DESC;
--------------------------------------------------------------------------

SELECT 
    f.title,                -- Vi vill se titeln
    COUNT(*) as times_rented -- Vi räknar hur många gånger den dyker upp
FROM 
    staging.rental AS r
-- Vi gör exakt samma kopplingar (JOINS) som förut:
JOIN 
    staging.inventory AS i ON r.inventory_id = i.inventory_id
JOIN 
    staging.film AS f ON i.film_id = f.film_id

-- HÄR är skillnaden: Vi måste gruppera på titeln för att kunna räkna
GROUP BY 
    f.title

-- Sortera så att den med högst antal hamnar överst
ORDER BY 
    times_rented DESC
LIMIT 10; -- Visa topp 10