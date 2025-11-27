-- 0. Cleaning malformed text data
-- Continue working on the data from lecture 08_strings. In this lecture you created a schema called staging and ingested the raw data into the staging schema.
--  a) Create a schema called refined. This is the schema where you'll put the transformed data.
CREATE SCHEMA IF NOT EXISTS refined;

--  b) Now transform and clean the data and place the cleaned table inside the refined schema.
CREATE TABLE
    IF NOT EXISTS refined.sql_terms AS (
        SELECT
            *
        FROM
            read_csv_auto ('data/sql_terms.csv')
    );

--  c) Practice filtering and searching for different keywords in different columns. Discuss with a friend why this could be useful in this case.

/* =========================================
   STEG 1: Tjuvkika och testa (SELECT)
   Här ändrar vi ingenting permanent, vi bara
   testar hur det skulle se ut.
   ========================================= */

-- Visa ordet, men snygga till det först för att se hur det blir
SELECT 
  -- 1. trim: Tar bort mellanslag i kanterna
  -- 2. upper: Gör om allt till VERSALER (STORA BOKSTÄVER)
  upper(trim(sql_word, ' ')) as trimmed_word,
  
  -- Plocka ut första bokstaven i det tvättade ordet
  trimmed_word[1] as first_character,
  
  -- Plocka ut sista bokstaven (index -1 betyder "första bakifrån")
  trimmed_word[-1] as last_character

FROM refined.sql_terms
ORDER BY trimmed_word; -- Sortera listan A-Ö


-- Testa att städa beskrivningen
SELECT 
  description,
  -- Leta efter dubbla mellanslag '  ' och byt ut dem mot ett enkelt ' '
  replace(description, '  ', ' ') as cleaned_description
FROM refined.sql_terms;


/* =========================================
   STEG 2: Bygg om strukturen (ALTER)
   Nu ändrar vi själva "skelettet" i tabellen.
   ========================================= */

-- Byt namn på kolumnen 'sql_word' till 'STATEMENT'
-- Detta är en permanent ändring av tabellens design.
ALTER TABLE refined.sql_terms
RENAME COLUMN sql_word to STATEMENT;


/* =========================================
   STEG 3: Tvätta datat permanent (UPDATE)
   Nu skriver vi över datat i tabellen med de
   nya, tvättade värdena.
   ========================================= */

-- Här kör vi tre funktioner i en "kedja" (inifrån och ut):
-- 1. replace: Ta bort '  ' (dubbla mellanslag) helt.
-- 2. trim: Ta bort mellanslag i början/slutet.
-- 3. upper: Gör om resultatet till VERSALER.
UPDATE refined.sql_terms
SET STATEMENT = upper(trim(replace(STATEMENT, '  ', '')));

-- Städa beskrivningen: Byt dubbla mellanslag mot enkla
UPDATE refined.sql_terms
SET description = replace(description, '  ', ' ');

-- Finlir på beskrivningen: Ta bort mellanslag som ligger först (Vänster sida)
UPDATE refined.sql_terms
SET description = ltrim(description);