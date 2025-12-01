/* =========================================
SETUP: Koppla in Sakila-databasen
========================================= */
-- 1. Skapa din arbetsyta (Schema)
-- Schemat 'staging' fungerar som en mapp där vi kan lägga våra tabeller.
CREATE SCHEMA IF NOT EXISTS staging;

-- 2. Aktivera SQLite-tillägget
-- DuckDB behöver detta för att förstå formatet i .db-filen.
INSTALL sqlite;

LOAD sqlite;

-- 3. Koppla in källdatan
-- Vi "monterar" filen så att DuckDB kan läsa den som en databas.
-- '../' betyder att vi backar ut ur nuvarande mapp för att hitta 'data'-mappen.
CALL sqlite_attach ('../data/sqlite-sakila.db');

/* =========================================
VERIFIERING: Kolla att det funkar
========================================= */
-- Lista alla tabeller vi har tillgång till nu (t.ex. actor, film, customer)
SHOW ALL TABLES;

/* =========================================
ÖVNING A: Enkel filtrering
========================================= */
-- Hämta alla kunder vars förnamn börjar på 'G'
SELECT
    *
FROM
    sakila.main.customer
WHERE
    first_name LIKE 'G%';

-- % betyder "vad som helst efter G"
/* =========================================
ÖVNING B: Mängdoperationer (Union)
========================================= */
-- Räkna hur många gånger "ann" förekommer i namn hos både kunder och skådisar.
SELECT
    COUNT(*) as name_ann -- Räkna totalen av den sammanslagna listan
FROM
    (
        -- Del 1: Hitta skådisar
        SELECT
            first_name
        FROM
            sakila.main.actor
        WHERE
            first_name ILIKE '%ann%' -- ILIKE hittar både 'Ann', 'ANN' och 'Susanna'
        UNION ALL -- Slå ihop listorna (ALL behåller dubbletter, viktigt här!)
        -- Del 2: Hitta kunder
        SELECT
            first_name
        FROM
            sakila.main.customer
        WHERE
            first_name ILIKE '%ann%'
    );

/* =========================================
ÖVNING C: Joins (Kedjan)
========================================= */
-- Ta reda på var kunderna bor (Stad och Land).
-- Vi måste hoppa: Customer -> Address -> City -> Country
SELECT
    c.first_name,
    c.last_name,
    ci.city,
    co.country
FROM
    sakila.main.customer c
    -- USING är genvägen när kolumnen heter samma sak i båda tabellerna (t.ex. address_id)
    LEFT JOIN sakila.main.address a USING (address_id)
    LEFT JOIN sakila.main.city ci USING (city_id)
    LEFT JOIN sakila.main.country co USING (country_id);

/* =========================================
ÖVNING C (ALTERNATIV): Med ON-syntax
========================================= */
-- Exakt samma resultat som ovan, men med den manuella syntaxen.
-- Detta är bra att kunna om kolumnerna heter olika (t.ex. id och customer_ref).
SELECT
    c.first_name,
    c.last_name,
    ci.city,
    co.country
FROM
    sakila.main.customer c
    -- Här pekar vi manuellt: c.id ska matcha a.id
    LEFT JOIN sakila.main.address a ON c.address_id = a.address_id
    LEFT JOIN sakila.main.city ci ON a.city_id = ci.city_id
    LEFT JOIN sakila.main.country co ON ci.country_id = co.country_id;

/* =========================================
ÖVNING D: Filtrering på Joinad data
========================================= */
-- Samma lista som ovan, men vi vill bara se personer med initialerna J.D.
SELECT
    c.first_name,
    c.last_name,
    ci.city,
    co.country
FROM
    sakila.main.customer c
    LEFT JOIN sakila.main.address a USING (address_id)
    LEFT JOIN sakila.main.city ci USING (city_id)
    LEFT JOIN sakila.main.country co USING (country_id)
WHERE
    first_name LIKE 'J%' -- Börjar på J
    AND last_name LIKE 'D%';

-- OCH slutar på D
/* =========================================
ÖVNING E: Den långa vägen (Many-to-Many)
========================================= */
-- Vilka filmer har kunderna hyrt?
-- Det finns ingen direkt koppling mellan Kund och Film.
-- Vi måste gå via: Rental (Uthyrning) -> Inventory (Lagerhyllan).
SELECT
    c.first_name,
    c.last_name,
    f.title
FROM
    sakila.main.customer c
    LEFT JOIN sakila.main.rental r USING (customer_id) -- Koppla kund till uthyrning
    LEFT JOIN sakila.main.inventory i USING (inventory_id) -- Koppla uthyrning till lagerexemplar
    LEFT JOIN sakila.main.film f USING (film_id) -- Koppla lagerexemplar till filmtitel
ORDER BY
    c.first_name,
    c.last_name;

/* =========================================
ÖVNING F: Aggregering (Topplista)
========================================= */
-- Vilken skådis har gjort flest filmer inom varje genre?
SELECT
    a.first_name,
    a.last_name,
    c.name AS genre, -- Kategori-namnet (t.ex. Horror, Action)
    COUNT(*) AS total_movies -- Räkna hur många rader vi hittar
FROM
    sakila.main.actor a
    -- Genvägen förbi 'film'-tabellen (eftersom film_category har film_id!)
    LEFT JOIN sakila.main.film_actor fa USING (actor_id)
    LEFT JOIN sakila.main.film_category fc USING (film_id)
    LEFT JOIN sakila.main.category c USING (category_id)
GROUP BY
    a.first_name,
    a.last_name,
    c.name -- Vi måste gruppera på allt som inte räknas (COUNT)
ORDER BY
    total_movies DESC;

-- Vinnaren hamnar överst