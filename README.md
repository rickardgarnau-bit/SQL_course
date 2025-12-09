# SQL-Kursstruktur
Detta repository innehåller material, övningar och projekt för en kurs i SQL och dataanalys. Fokus ligger på moderna databasfunktioner, datateknik med Python, och analysverktyg som DuckDB och Evidence.

## Kursöversikt (Struktur)
Kursen är uppdelad i följande moduler, baserat på mappstrukturen i detta repo:

### Grundläggande SQL
- 04_querying_data

Grunderna i att hämta data med SELECT från tabeller.

- 05_filtering

Filtrera rader och data med WHERE-satsen och logiska operatorer.

- 06_crud_operations

Skapa, läsa, uppdatera och radera data (Create, Read, Update, Delete).

### Aggregering och Datatyper
- 07_grouping_data

Gruppera data med GROUP BY och använda aggregeringsfunktioner (SUM, AVG, COUNT).

-08_strings

Hantering och manipulering av textsträngar i SQL.

- 09_temporal_data

Arbeta med datum och tid (timestamps, date functions).

### Databasstruktur och Relationer
- 10_enforce_constraints

Dataintegritet med Primary Keys, Foreign Keys och CHECK-constraints.

- 11_set_operations

Kombinera resultatset med UNION, INTERSECT och EXCEPT.

- 12_joins

Koppla ihop data från flera tabeller med olika typer av JOINS (INNER, LEFT, RIGHT).

### Python-integration och Modern Data Stack
- 17_python_connect_duckdb

Hur man kopplar Python till DuckDB och exekverar SQL-kod via script.

- 18_pandas_duckdb

Integration mellan SQL och Pandas DataFrames för avancerad analys.

- 19_dlt

Data Ingestion: Använda verktyget dlt för att bygga pipelines (t.ex. flytta data från SQLite till DuckDB).

### Visualisering och Projekt
- 20_evidence

Bygga BI-dashboards och rapporter "as code" med Evidence och DuckDB.

- Lab_1

Ett större projektarbete som knyter ihop kursens moment: migrering, analys (EDA) och visualisering av Sakila-databasen.

### Övningar
- exercise_0, exercise_1, exercise_2

Fristående övningsuppgifter för att testa och befästa kunskaperna löpande under kursen.

### Verktyg
DuckDB: Analytisk databas optimerad för snabba frågor.

Python: För skriptning och datahantering.

dlt: För automatisering av dataflöden (ELT/ETL).

Evidence: För att skapa datadrivna rapporter.
