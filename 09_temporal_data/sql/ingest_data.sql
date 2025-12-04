-- 1. SKAPA SCHEMA (MAPPSTRUKTUR)
-- Vi skapar ett schema som heter 'staging'.
-- Detta fungerar som en mapp för att hålla isär rådata från färdig data.
-- "IF NOT EXISTS" gör koden säker att köra flera gånger utan att krascha.
CREATE SCHEMA IF NOT EXISTS staging;

-- 2. IMPORTERA TÅGTIDTABELLER
-- Vi skapar tabellen 'train_schedules' inuti schemat 'staging'.
-- "AS SELECT * FROM read_csv_auto..." är en så kallad CTAS (Create Table As Select).
-- Det skapar tabellen OCH fyller den med data från filen i ett enda steg.
CREATE TABLE
    IF NOT EXISTS staging.train_schedules AS (
        SELECT
            *
        FROM
            read_csv_auto ('data/train_schedules.csv')
    );

-- 3. IMPORTERA HELGDAGAR
-- Samma princip här: Vi läser in filen med svenska helgdagar.
-- read_csv_auto är en "magisk" funktion i DuckDB som gissar datatyperna (datum, text, etc.) åt dig.
CREATE TABLE
    IF NOT EXISTS staging.sweden_holidays AS (
        SELECT
            *
        FROM
            read_csv_auto ('data/sweden_holidays.csv')
    );