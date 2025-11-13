# Projekt: Analys av Data Engineer-löner med DuckDB

Detta projekt använder SQL och DuckDB för att ladda in och ställa frågor mot en datamängd om löner för data-relaterade yrken under 2024.

Datamängden är hämtad från Kaggle: [Data Engineer Salary in 2024](https://www.kaggle.com/datasets/chopper53/data-engineer-salary-in-2024/data)

## 1. Inladdning av Data (Ingest)

Datat från `salaries.csv` laddades in i en DuckDB-databasfil (`data_jobs.duckdb`) med hjälp av ett SQL-skript.

**Databas:** `data_jobs.duckdb`
**Skript:** `sql/ingest_salaries.sql`

Innehållet i `ingest_salaries.sql` skapar en tabell som heter `data_jobs` i `main`-schemat:

```sql
CREATE TABLE IF NOT EXISTS data_jobs AS
SELECT * FROM read_csv_auto('data/salaries.csv');
```
