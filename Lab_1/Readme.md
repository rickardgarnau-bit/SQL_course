# Lab 1 - Sakila Data Pipeline & Dashboard
Ett Data Engineering-projekt där jag byggt en End-to-End datapipeline för att analysera en DVD-hyrbutiks affärsdata. Fokus låg på att gå från rå SQL-data till interaktiva insikter med moderna verktyg som DuckDB och Evidence.dev.

### Vad Går Projektet Ut På?
Målet var att agera Data Engineer och skapa beslutsunderlag för ledningen. Hela projektet innehåller:

- Ingestion & ETL: Extrahering av data från en operationell databas (SQLite) och transformering med DuckDB.

- Explorativ Analys (EDA): En Jupyter Notebook där jag undersöker datakvalitet, relationer och trender med Python och Pandas.

- Business Intelligence: En interaktiv dashboard byggd i Evidence.dev som visualiserar KPI:er som intäkter, kundbeteende och lagerstatus.

- SQL-Analys: Avancerade SQL-frågor för att svara på affärskritiska frågor (t.ex. "Vilka filmer hyrs ut mest?" och "Var finns våra bästa kunder?").

- Code-as-Configuration: Hela rapporten är versionshanterad via kod (Markdown + SQL).

### Affärsinsikter (Bonus)
Jag nöjde mig inte bara med att visa data, utan tog fram konkreta rekommendationer:

- Marknadsfokus: Identifierade att Kina och Indien är de största marknaderna sett till antal kunder.

- Produktstrategi: "Sports"-kategorin genererar mest intäkter och bör prioriteras vid inköp.

- Kundvård: Tog fram en "VIP-lista" på de kunder som spenderar mest för riktade kampanjer.

### Min Pipeline-plan
Här är flödet jag designade för att flytta datan från källa till insikt. Planen var att använda DuckDB som en analytisk motor (OLAP) för att snabbt kunna aggregera stora mängder data utan att belasta källsystemet.

#### Pipeline-struktur
1. Källa (SQLite)

- Originaldatabasen sakila.db.

- Innehåller normaliserade tabeller (3NF) för film, customer, rental, payment etc.

2. Transformation (Python & DuckDB)

- Koppling: Python-script kopplar upp mot SQLite.

- DuckDB: Används för att köra tunga JOINs och GROUP BY-operationer i minnet.

- Cleaning: Hantering av datumformat och NULL-värden i Notebooken.

3. Presentation (Evidence.dev)

- Markdown: Rapporterna skrivs i Markdown med inbäddade SQL-block.

- Visualisering: Grafer (<BarChart>, <LineChart>) renderas automatiskt baserat på query-resultaten.

- Interaktivitet: Dropdown-menyer för att filtrera data på t.ex. filmgenre.

## Mina Designval

* **DuckDB:** DuckDB för transformationerna för att kunna använda SQL syntax hela vägen.
* **Evidence:** Jag ville ha en "Developer Experience"-känsla där rapporten ligger i git-repot.
* **Färgkodning:** Jag designade dashboarden tematiskt: **Grönt** för finansiella siffror (Sales) och **Rött** för operativa data (Lager/Tid) för att användaren snabbt ska förstå kontexten.

## Källor och Resurser

**Lärresurser**
* **DuckDB Documentation:** SQL-referens och Python API-guide.
* **Evidence.dev Docs:** För att förstå komponenter som `<BigValue>` och `<Dropdown>`.
* **Sakila Database Schema:** Dokumentation över tabellrelationerna (ER-diagram).

**AI-Användning (LLM)**
Jag använde Google Gemini som ett bollplank under projektet. Jag bad den om:
* Optimering av komplexa SQL-queries (särskilt de med 5+ JOINS).
* Hjälp med CSS-styling för att snygga till dashboarden.
* Feedback på affärsinsikter – "Vad skulle en VD vilja veta utifrån denna data?".
* All kod och logik har jag granskat och testat själv.

## Hur man kör projektet

**Förutsättningar:**
Du behöver ha **Node.js** och **Python** installerat.

1.  **Installera beroenden:**
    ```bash
    npm install
    pip install duckdb pandas notebook
    ```

2.  **Kör Notebooken (Valfritt för analys):**
    Öppna `Lab_1.ipynb` i VS Code eller Jupyter för att se min EDA-process.

3.  **Starta Dashboarden:**
    Gå in i dashboard-mappen och kör:
    ```bash
    npm run dev
    ```
    Öppna sedan `http://localhost:3000` i din webbläsare.

## Projektstruktur

```text
sakila_project/
├── README.md
├── Lab_1.ipynb           # Jupyter Notebook för EDA & Data Cleaning
│
├── dashboard/            # Evidence.dev-projektet
│   ├── sources/          # Datakällor
│   ├── pages/            # Markdown-sidorna för rapporten
│   │   ├── index.md      # Startsida (Executive Overview)
│   │   └── inventory.md  # Lagersida (Products & Markets)
│   └── evidence.settings.json
│
└── data/
    └── sqlite-sakila.db  # Källdatabasen
