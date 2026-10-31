/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - Segment products into defined cost ranges and count product distributions.
    - Group customers into behavioral segments (VIP, Regular, New) based on spending and lifespan.
===============================================================================
*/

/* Segment products into cost ranges and
   count how many products fall into each segment */

WITH product_segments AS (
	SELECT
		product_key,
		product_name,
		cost,
		CASE
			WHEN cost < 100 THEN 'Below 100'
			WHEN cost BETWEEN 100 AND 500 THEN '100-500'
			WHEN cost BETWEEN 100 AND 1000 THEN '100-1000'
			ELSE 'Above 1000'
		END AS cost_range
	FROM
		gold.dim_products
)
SELECT
	cost_range,
	COUNT(product_key) AS total_products
FROM
	product_segments
GROUP BY
	cost_range
ORDER BY total_products DESC;



/* Group customers into three segments based on their spending behavior:
   - VIP: Customers with at least 12 months of history and spending more than €5,000.
   - Regular: Customers with at least 12 months of history but spending €5,000 or less.
   - New: Customers with a lifespan less than 12 months.
   And find the total number of customers by each group
*/

WITH customer_spending AS (
	SELECT
		dc.customer_key,
		SUM(fs.sales_amount) AS total_sales,
		MIN(fs.order_date) AS first_order,
		MAX(fs.order_date) AS last_order,
		DATEDIFF(month, MIN(fs.order_date), MAX(fs.order_date)) AS life_span
	FROM
		gold.fact_sales AS fs
	LEFT JOIN
		gold.dim_customers AS dc
	ON
		fs.customer_key = dc.customer_key
	GROUP BY
		dc.customer_key
)
SELECT
	customer_segment,
	COUNT(customer_key) AS customer_count
FROM (
	SELECT
		*,
		CASE
			WHEN life_span >= 12 AND total_sales > 5000 THEN 'VIP'
			WHEN life_span >= 12 AND total_sales <= 5000 THEN 'Regular'
			ELSE 'New'
		END AS customer_segment
	FROM
		customer_spending
) AS t
GROUP BY
	customer_segment
ORDER BY
	customer_count DESC

