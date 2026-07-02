-- GROUP BY + HAVING
SELECT customer_id, COUNT(*)
FROM bronze.customers_raw
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- ROW_NUMBER
WITH customer_duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY customer_id
               ORDER BY customer_id
           ) AS rn
    FROM bronze.customers_raw
)
SELECT *
FROM customer_duplicates
WHERE rn = 1;


-- CASE
SELECT
    order_id,

    CASE
        WHEN order_status='delivered'
        THEN 'COMPLETED'

        WHEN order_status='shipped'
        THEN 'IN_PROGRESS'

        ELSE 'OTHER'
    END AS order_category

FROM silver.orders;


-- DISTINCT
SELECT DISTINCT
product_category_name
FROM silver.products;


-- OFFSET + FETCH
SELECT *
FROM silver.orders
ORDER BY order_purchase_timestamp
OFFSET 100 ROWS
FETCH NEXT 20 ROWS ONLY;


-- TEMP TABLE
CREATE TEMP TABLE top_products AS

SELECT
    product_id,
    SUM(price) revenue

FROM silver.order_items

GROUP BY product_id;