/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - Explore the structure of the database including tables, views, and schemas.
    - Inspect column names, data types, and properties of specific tables.
===============================================================================
*/

-- Explore All Objects in the Database

SELECT
	*
FROM
	INFORMATION_SCHEMA.TABLES


-- Explore All Columns in the Database

SELECT
	*
FROM
	INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'

