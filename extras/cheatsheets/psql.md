# Postgres PSQL Cheat Sheet
*Sources: [https://github.com/chubin/cheat.sheets], [https://github.com/Grimm-Child/.Matrix]*


## Shell
#### Connect to a specific database
    \c database_name

#### To quite the psql
    \q

#### List all databases in the PostgreSQL database server
    \l

#### List all schemas
    \dn

#### List all stored procedures and functions
    \df

#### List all views
    \dv

#### Lists all tables in a current database
    \dt

#### Get more information on tables in the current database
    \dt+

#### Get detailed information on a table
    \d+ table_name

#### Show a stored procedure or function code
    \df+ function_name

#### Show query output in the pretty-format
    \x

#### List all users
    \du

#### Export table into CSV file
    \copy <table_name> TO '<file_path>' CSV

#### Export table, only specific columns, to CSV file
    \copy <table_name>(<column_1>,<column_1>,<column_1>) TO '<file_path>' CSV

#### Import CSV file into table
    \copy <table_name> FROM '<file_path>' CSV

#### Import CSV file into table, only specific columns
    \copy <table_name>(<column_1>,<column_1>,<column_1>) FROM '<file_path>' CSV

## Schemas
#### List schemas
    SELECT schema_name FROM information_schema.schemata;
    SELECT nspname FROM pg_catalog.pg_namespace;

#### Create schema
    CREATE SCHEMA IF NOT EXISTS <schema_name>;

#### Drop schema
    DROP SCHEMA IF EXISTS <schema_name> CASCADE;

## Users
#### List roles
    SELECT rolname FROM pg_roles;

#### Create user
    CREATE USER <user_name> WITH PASSWORD '<password>';

#### Drop user
    DROP USER IF EXISTS <user_name>;

#### Alter user password
    ALTER ROLE <user_name> WITH PASSWORD '<password>';

#### Assign roles to a user
    ALTER USER <user_name> WITH <ROLE1> <ROLE2> <ROLE3>;

#### Make a user a superuser
    ALTER USER <user_name> WITH SUPERUSER;

## Tables
#### Create a new table or a temporary table
    CREATE [TEMP] TABLE [IF NOT EXISTS] table_name(
       pk SERIAL PRIMARY KEY,
       c1 type(size) NOT NULL,
       c2 type(size) NULL,
       ...
    );

#### Add a new column into a table
    ALTER TABLE table_name ADD COLUMN new_column_name TYPE;

#### Drop a column in a table
    ALTER TABLE table_name DROP COLUMN column_name;

#### Rename a column
    ALTER TABLE table_name RENAME column_name TO new_column_name;

#### Set or remove a default value for a column
    ALTER TABLE table_name ALTER COLUMN [SET DEFAULT value | DROP DEFAULT]

#### Add a primary key to a table
    ALTER TABLE table_name ADD PRIMARY KEY (column,...);

#### Remove the primary key from a table
    ALTER TABLE table_name
    DROP CONSTRAINT primary_key_constraint_name;

#### Rename a table
    ALTER TABLE table_name RENAME TO new_table_name;

#### Drop a table and its dependent objects:
    DROP TABLE [IF EXISTS] table_name CASCADE;

#### Change the owner of a table
    ALTER TABLE table_name OWNER TO <user_name>;

## Roles
#### Create a new role
    CREATE ROLE role_name;

#### Create a new role with a username and password:
    CREATE ROLE username NOINHERIT LOGIN PASSWORD password;

#### Change role for current sesion to the new_role:
    SET ROLE new_role;

#### Allow role_1 to set its role as role_2:
    GRANT role_2 TO role_1;

## Permissions
#### Grant all permissions on database
    GRANT ALL PRIVILEGES ON DATABASE <db_name> TO <user_name>;

#### Grant connection permissions on database
    GRANT CONNECT ON DATABASE <db_name> TO <user_name>;

#### Grant permissions on schema
    GRANT USAGE ON SCHEMA public TO <user_name>;

#### Grant permissions to functions
    GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO <user_name>;

#### Grant permissions to select, update, insert, delete, on a all tables
    GRANT SELECT, UPDATE, INSERT ON ALL TABLES IN SCHEMA public TO <user_name>;

#### Grant permissions, on a table
    GRANT SELECT, UPDATE, INSERT ON <table_name> TO <user_name>;

#### Grant permissions, to select, on a table
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO <user_name>;

## Databases
#### Create a new database
    CREATE DATABASE [IF NOT EXISTS] db_name;

#### Delete a database permanently
    DROP DATABASE [IF EXISTS] db_name;

#### Change the owner of a database
    ALTER DATABASE "db_name" OWNER TO <user_name>;

## Views
#### Create a view
    CREATE OR REPLACE view_name AS
query;

#### Create a recurisve view:
    CREATE RECURSIVE VIEW view_name(columns) AS
    SELECT columns;

#### Create a materialized view:
    CREATE MATERIALIZED VIEW view_name
    AS
    query
    WITH [NO] DATA;

#### Refresh a materialized view
    REFRESH MATERIALIZED VIEW CONCURRENTLY view_name;

#### Drop a view
    DROP VIEW [ IF EXISTS ] view_name;

#### Drop a materialized view
    DROP MATERIALIZED VIEW view_name;

#### Rename a view
    ALTER VIEW view_name RENAME TO new_name;

## Indexes
#### Creating an index with the specified name on a table
    CREATE [UNIQUE] INDEX index_name ON table (column,...)

#### Removing a specified index from table
    DROP INDEX index_name;

## Columns
#### Add column
    ALTER TABLE <table_name> IF EXISTS
    ADD <column_name> <data_type> [<constraints>];

#### Update column
    ALTER TABLE <table_name> IF EXISTS
    ALTER <column_name> TYPE <data_type> [<constraints>];

#### Delete column
    ALTER TABLE <table_name> IF EXISTS
    DROP <column_name>;

#### Update column to be an auto-incrementing primary key
    ALTER TABLE <table_name>
    ADD COLUMN <column_name> SERIAL PRIMARY KEY;

#### Insert into a table, with an auto-incrementing primary key
    INSERT INTO <table_name>
    VALUES (DEFAULT, <value1>);
-----
    INSERT INTO <table_name> (<column1_name>,<column2_name>)
    VALUES ( <value1>,<value2> );

## Performance
#### Show the query plan for a query
    EXPLAIN query;

#### Show and execute the query plan for a query
    EXPLAIN ANALYZE query;

#### Collect statistics
    ANALYZE table_name;

## Update
#### Insert a new row into a table
    INSERT INTO table(column1,column2,...)
    VALUES(value_1,value_2,...);

#### Insert multiple rows into a table
    INSERT INTO table_name(column1,column2,...)
    VALUES(value_1,value_2,...),
      (value_1,value_2,...),
      (value_1,value_2,...)...

#### Update data for all rows
    UPDATE table_name
    SET column_1 = value_1,
      ...;

#### Update data for a set of rows specified by a condition in WHERE clause
    UPDATE table
    SET column_1 = value_1,
        ...
    WHERE condition;

#### Delete all rows of a table
    DELETE FROM table_name;

#### Delete specific rows based on a condition
    DELETE FROM table_name
    WHERE condition;

## Select
#### Query all data from a table
    SELECT * FROM table_name;

#### Query data from specified columns of all rows in a table
    SELECT column, column2... FROM table;

#### Query data and select only unique rows
    SELECT DISTINCT (column) FROM table;

#### Query data from a table with a filter
    SELECT * FROM table WHERE condition;

#### Set an alias for a column in the result set
    SELECT column_1 AS new_column_1, ...
    FROM table;

#### Query data using the LIKE operator
    SELECT * FROM table_name
    WHERE column LIKE '%value%'

#### Query data using the BETWEEN operator
    SELECT * FROM table_name
    WHERE column BETWEEN low AND high;

#### Query data using the IN operator
    SELECT * FROM table_name
    WHERE column IN (value1, value2,...);

#### Constrain the returned rows with LIMIT clause
    SELECT * FROM table_name
    LIMIT limit OFFSET offset
    ORDER BY column_name;

#### Query data from multiple using the inner join, left join, full outer join, cross join and natural join:
    SELECT * FROM table1 INNER JOIN table2 ON conditions
    SELECT * FROM table1 LEFT JOIN table2 ON conditions
    SELECT * FROM table1 FULL OUTER JOIN table2 ON conditions
    SELECT * FROM table1 CROSS JOIN table2;
    SELECT * FROM table1 NATURAL JOIN table2;

#### Return the number of rows of a table.
    SELECT COUNT (*)
    FROM table_name;

#### Sort rows in ascending or descending order
    SELECT column, column2, ...
    FROM table
    ORDER BY column ASC [DESC], column2 ASC [DESC],...;

#### Group rows using GROUP BY clause.
    SELECT *
    FROM table
    GROUP BY column_1, column_2, ...;

#### Filter groups using the HAVING clause.
    SELECT *
    FROM table
    GROUP BY column_1
    HAVING condition;

#### Combine the result set of two or more queries with UNION operator:
    SELECT * FROM table1
    UNION
    SELECT * FROM table2;

#### Minus a result set using EXCEPT operator:
    SELECT * FROM table1
    EXCEPT
    SELECT * FROM table2;

#### Get intersection of the result sets of two queries:
    SELECT * FROM table1
    INTERSECT
    SELECT * FROM table2;
