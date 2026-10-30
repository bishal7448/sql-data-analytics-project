/*
===============================================================================
Date Range Exploration
===============================================================================
Purpose:
    - Determine temporal boundaries of sales transactions (first and last order dates).
    - Calculate order timespan in years and months.
    - Analyze customer demographic age range (youngest and oldest customers).
===============================================================================
*/

-- Find the Date of the First and Last Order

SELECT
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date
FROM
	gold.fact_sales


-- How Many Years of Sales are Available

SELECT
	DATEDIFF(year, first_order_date, last_order_date) AS order_range_years,
	DATEDIFF(month, first_order_date, last_order_date) AS order_range_months
FROM (
	SELECT
		MIN(order_date) AS first_order_date,
		MAX(order_date) AS last_order_date
	FROM
		gold.fact_sales
) AS t


-- Find the Youngest and Oldest Customers

SELECT
	MIN(birthdate) AS youngest_birthdate,
	DATEDIFF(year, MIN(birthdate), GETDATE()) AS youngest_age,
	MAX(birthdate) AS oldest_birthdate,
	DATEDIFF(year, MAX(birthdate), GETDATE()) AS oldest_age
FROM
	gold.dim_customers

