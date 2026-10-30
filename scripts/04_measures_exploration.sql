/*
===============================================================================
Measures Exploration (Key Business Metrics)
===============================================================================
Purpose:
    - Calculate core business metrics (KPIs) such as total sales, quantities sold, average price, total orders, products, and customer counts.
    - Generate a unified summary report aggregating key business metrics.
===============================================================================
*/

-- Find the Total Sales

SELECT
	SUM(sales_amount) AS total_sales
FROM
	gold.fact_sales


-- Find how many items are sold

SELECT
	SUM(quantity) AS total_quantity
FROM
	gold.fact_sales


-- Find the average selling price

SELECT
	AVG(price) AS avg_price
FROM
	gold.fact_sales


-- Find the Total number of Orders

SELECT
	COUNT(order_number) AS total_orders
FROM
	gold.fact_sales

SELECT
	COUNT(DISTINCT order_number) AS total_orders
FROM
	gold.fact_sales

SELECT
	*
FROM
	gold.fact_sales


-- Find the total number of products

SELECT
	COUNT(DISTINCT product_name) AS total_products
FROM
	gold.dim_products


-- Find the total number of customers

SELECT
	COUNT(DISTINCT customer_key) AS total_customers
FROM
	gold.dim_customers


-- Find the total number of customers that has placed an order

SELECT
	COUNT(customer_key) AS total_customers
FROM
	gold.dim_customers AS sc
WHERE EXISTS (
	SELECT
		1
	FROM
		gold.fact_sales AS fs
	WHERE 
		sc.customer_key = fs.customer_key
)


-- Generate a Report that shows all key metrics of the business

SELECT
    'Total Sales' AS measure_name,
    SUM(sales_amount) AS measure_value
FROM
    gold.fact_sales

UNION ALL

SELECT
    'Total Quantity' AS measure_name,
    SUM(quantity) AS measure_value
FROM
    gold.fact_sales

UNION ALL

SELECT
    'Average Selling Price' AS measure_name,
    AVG(price) AS measure_value
FROM
    gold.fact_sales

UNION ALL

SELECT
    'Total Orders' AS measure_name,
    COUNT(DISTINCT order_number) AS measure_value
FROM
    gold.fact_sales

UNION ALL

SELECT
    'Total Products' AS measure_name,
    COUNT(DISTINCT product_key) AS measure_value
FROM
    gold.dim_products

UNION ALL

SELECT
    'Total Customers' AS measure_name,
    COUNT(DISTINCT customer_key) AS measure_value
FROM
    gold.dim_customers

UNION ALL

SELECT
    'Customers Who Placed Orders' AS measure_name,
    COUNT(DISTINCT customer_key) AS measure_value
FROM
    gold.fact_sales;

