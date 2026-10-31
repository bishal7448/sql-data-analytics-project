/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - Compare category sales performance against total overall sales.
    - Measure percentage contribution of each product category to overall revenue.
===============================================================================
*/

-- Which categories contribute the most to overall sales?

WITH category_sales AS (
    SELECT
        p.category,
        SUM(sales_amount) AS total_sales
    FROM 
        gold.fact_sales AS f
    LEFT JOIN 
        gold.dim_products AS p
    ON 
        f.product_key = p.product_key
    GROUP BY
        p.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER() AS overall_sales,
    CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER()) * 100, 2), '%') AS percentage_of_total
FROM
    category_sales
ORDER BY
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER()) * 100, 2) DESC

