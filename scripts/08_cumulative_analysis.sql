/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - Calculate cumulative metrics and running totals of sales over time.
    - Track progressive performance across months partitioned by year.
===============================================================================
*/

-- Calculate the total sales per month
-- and the running total of sales over time

SELECT
	*,
	SUM(total_sales) OVER (
		PARTITION BY YEAR(order_date)
		ORDER BY order_date
	) AS running_total_sales
FROM (
	SELECT
		DATETRUNC(month, order_date) AS order_date,
		SUM(sales_amount) AS total_sales
	FROM
		gold.fact_sales
	WHERE
		order_date IS NOT NULL
	GROUP BY
		DATETRUNC(month, order_date)
) AS t

