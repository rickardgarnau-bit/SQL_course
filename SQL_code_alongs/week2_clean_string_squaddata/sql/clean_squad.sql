-- TASK 1
-- Skapa ett schema (en logisk gruppering/mapp) för dina tabeller om det inte redan finns.
CREATE SCHEMA IF NOT EXISTS staging;

-- Skapa tabellen 'squad' inuti schemat 'staging'.
-- Data laddas direkt från CSV-filen. 'read_csv_auto' gissar automatiskt datatyperna.
CREATE TABLE IF NOT EXISTS staging.squad AS (
    SELECT
        *
    FROM
        read_csv_auto ('data/squad.csv')
);

-- TASK 2
-- Analysera rader där titeln INTE finns inuti texten (context)
SELECT
    title,
    context,
    -- INSTR returnerar positionen av en sträng i en annan.
    -- OBS: Du hade lämnat denna tom, så jag antar att du vill söka efter 'title' i 'context'.
    INSTR(context, title) AS position_of_title
FROM
    staging.squad
WHERE
    -- Filtrera bort rader där 'context' innehåller 'title' (Regex-matchning)
    NOT regexp_matches(context, title);

-- TASK 3
--  Hitta rader där texten (context) BÖRJAR med titeln
-- 'starts_with' är oftast mer prestandaeffektivt än Regex för enkla prefix-sökningar.
SELECT
    title,
    context
FROM
    staging.squad
WHERE
    starts_with(context, title);

--
-- Samma sökning som ovan, men med Regular Expressions (Regex)
SELECT
    *
FROM
    staging.squad
WHERE
    -- Bygg ihop ett regex-mönster dynamiskt:
    -- '^' är ett ankare som betyder "början av strängen".
    -- Resultatet blir t.ex. '^Super Bowl' om titeln är 'Super Bowl'.
    regexp_matches(context, CONCAT('^', title));

-- TASK 4
SELECT
    -- 1. Tar bort de första 17 tecknen (börjar på index 18).
    -- Detta görs antagligen för att skippa metadata som "{'text': ['"
    answers [18:],
    -- 2. Kollar vilket tecken som ligger exakt på index 18.
    answers [18],
    -- 3. Skapar 'striped_answers'.
    -- Om tecknet på plats 18 är ett kommatecken hoppar vi över raden (sätter NULL).
    -- Annars behåller vi den "skivade" strängen.
    CASE
        WHEN answers [18] = ',' THEN NULL
        ELSE answers [18:]
    END AS striped_answers,
    -- 4. Hittar var nästa enkelfnutt (') finns inuti 'striped_answers'.
    -- Detta markerar slutet på själva svaret.
    INSTR(striped_answers, '''') AS first_quotation_index,
    -- 5. EXTRAHERAR SVARET ('first_answers')
    -- Här använder vi indexet vi nyss räknade ut ('first_quotation_index').
    -- Vi skivar 'striped_answers' från början fram till (men inte med) fnutten (-1).
    striped_answers [:first_quotation_index-1] AS first_answers,
    -- 6. Originaldatat för referens.
    answers
FROM
    staging.squad;

-- TASK 5
SELECT
    -- 1. REGEX_EXTRACT: Extraherar text baserat på ett mönster.
    -- Mönstret är: '''([^'']+)'','
    -- Vi bryter ner det nedan.
    regexp_extract(answers, '''([^'']+)'',') AS first_answer,
    -- Jämförelse med dina bortkommenterade rader:
    -- Denna rad var för specifik: [A-Za-z0-9 ,]+
    -- Den hade missat tecken som bindestreck (-), punkter (.) eller accenter (é).
    -- regexp_extract(answers, '''([A-Za-z0-9 ,]+)'',') AS first_answer,
    answers
FROM
    staging.squad;