/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - Explore unique values and hierarchies within dimension tables.
    - Understand customer geographical distribution and product categorization.
===============================================================================
*/

-- Explore All Countries Our Customers Comes From

SELECT DISTINCT
	country
FROM
	gold.dim_customers


-- Explore All Product Categories "The Major Divisions"

SELECT DISTINCT
	category
FROM
	gold.dim_products

SELECT DISTINCT
	category,
	subcategory
FROM
	gold.dim_products

SELECT DISTINCT
	category,
	subcategory,
	product_name
FROM
	gold.dim_products
ORDER BY 1, 2, 3

