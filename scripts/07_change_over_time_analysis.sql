/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - Analyze sales performance, customer volume, and quantities over time.
    - Track monthly trends and seasonal variations across different years.
===============================================================================
*/

-- Sales and customer volume aggregated by month (Seasonality Analysis)

SELECT
	MONTH(order_date) AS order_month,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity,
	SUM(sales_amount) AS total_sales
FROM
	gold.fact_sales
WHERE
	order_date IS NOT NULL
GROUP BY
	MONTH(order_date)
ORDER BY
	SUM(sales_amount) DESC


-- Sales and customer trends aggregated by year and month

SELECT
	YEAR(order_date) AS order_year,
	MONTH(order_date) AS order_month,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity,
	SUM(sales_amount) AS total_sales
FROM
	gold.fact_sales
WHERE
	order_date IS NOT NULL
GROUP BY
	YEAR(order_date), MONTH(order_date)
ORDER BY
	YEAR(order_date), MONTH(order_date)


-- Monthly sales trends using DATETRUNC

SELECT
	DATETRUNC(month, order_date) AS order_date,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity,
	SUM(sales_amount) AS total_sales
FROM
	gold.fact_sales
WHERE
	order_date IS NOT NULL
GROUP BY
	DATETRUNC(month, order_date)
ORDER BY
	DATETRUNC(month, order_date)


-- Monthly sales trends using FORMAT (yyyy-MM)

SELECT
	FORMAT(order_date, 'yyyy-MM') AS order_date,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity,
	SUM(sales_amount) AS total_sales
FROM
	gold.fact_sales
WHERE
	order_date IS NOT NULL
GROUP BY
	FORMAT(order_date, 'yyyy-MM')
ORDER BY
	FORMAT(order_date, 'yyyy-MM')

