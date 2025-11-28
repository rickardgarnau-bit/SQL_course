a) What is SQL, and why is it important in relational databases?
SQL (Structured Query Language) is the standard programming language used to manage and communicate with relational databases.

Why it is important: It provides a standardized way to interact with data. Whether you are using PostgreSQL, MySQL, or DuckDB, the core syntax remains largely the same. It allows you to describe what data you want (declarative) rather than having to write the code for how to fetch it from the hard drive. It handles everything from retrieving data to updating records and managing database security.

b) Explain the difference between FROM and WHERE clauses.
These two clauses serve different steps in the logical execution of a query:

FROM: This is the source. It specifies which table(s) or view(s) the database should access to find the data. It is the first part of the query the database engine looks at.

WHERE: This is the filter. It restricts the rows returned by the FROM clause based on specific conditions (e.g., age > 18).

Key Distinction: The database technically executes FROM first to gather the raw data, and then runs WHERE to filter out the rows you don't want.

c) Explain the purpose of the LIMIT or OFFSET clause in a SQL query.
These are primarily used for pagination (breaking large datasets into pages) or sampling data.

LIMIT: Dictates the maximum number of rows the query should return. (e.g., LIMIT 5 gives you only the top 5 results).

OFFSET: Dictates how many rows to skip before beginning to return data.

Example: If you want to show "Page 2" of search results, you might use LIMIT 10 OFFSET 10 (Skip the first 10 results, then show the next 10).

d) What are the primary functions of the Data Definition Language (DDL) in SQL?
DDL is the subset of SQL used to define and manage the structure (schema) of the database, rather than the data inside it. Its primary functions are to create and modify containers for data.

Common DDL Commands:

CREATE: Builds a new table, view, or database.

ALTER: Modifies an existing structure (e.g., adding a column).

DROP: Deletes a structure entirely.

e) Explain the differences between Data Manipulation Language (DML) and Data Definition Language (DDL).
The difference lies in whether you are changing the container or the contents.

Feature,DDL (Data Definition Language),DML (Data Manipulation Language)
Focus,The Structure (Schema),The Data (Records/Rows)
Analogy,Building or renovating a house.,Moving furniture or people into the house.
Commands,"CREATE, ALTER, DROP, TRUNCATE","SELECT, INSERT, UPDATE, DELETE"
Rollback,"In some databases, DDL cannot be rolled back (undone).",DML is transactional and can usually be rolled back.

e) Explain the differences between Data Manipulation Language (DML) and Data Definition Language (DDL).
The difference lies in whether you are changing the container or the contents.

g) Is DuckDB suitable for real-time data processing?
It depends on the definition of "real-time."

No for OLTP (Transactional): If "real-time" means thousands of users simultaneously inserting, updating, and deleting individual shopping cart items (like an e-commerce site), DuckDB is not suitable. It is not designed for high-concurrency write operations.

Yes for Analytical Real-time: If "real-time" means analyzing a stream of data or a large CSV file instantly as it arrives to get immediate insights, DuckDB is excellent. It can query data files directly without needing a long "loading" phase.

h) Difference between read_csv and read_csv_auto
Both functions are used to load data from CSV files, but they differ in automation:

read_csv_auto: The "easy button." It automatically guesses the parameters of the file. It detects the separator (comma vs semicolon), infers the data types (integers vs strings), and checks if there is a header row.

read_csv: The "manual mode." You must explicitly specify parameters if the automatic detection fails. It provides more control if your CSV file has weird formatting, custom date formats, or no headers.