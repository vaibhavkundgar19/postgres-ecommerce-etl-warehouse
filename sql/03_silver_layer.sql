-- SILVER CUSTOMERS

DROP TABLE IF EXISTS silver.customers;

CREATE TABLE silver.customers AS

SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    UPPER(customer_city) AS customer_city,
    UPPER(customer_state) AS customer_state

FROM bronze.customers_raw;


-- SILVER ORDERS

DROP TABLE IF EXISTS silver.orders;

CREATE TABLE silver.orders AS

SELECT
    order_id,
    customer_id,
    order_status,

    order_purchase_timestamp,

    EXTRACT(YEAR FROM order_purchase_timestamp)
        AS purchase_year,

    EXTRACT(MONTH FROM order_purchase_timestamp)
        AS purchase_month,

    DATE_TRUNC(
        'month',
        order_purchase_timestamp
    ) AS month_start,

    COALESCE(
        order_approved_at,
        order_purchase_timestamp
    ) AS order_approved_at,

    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date

FROM bronze.orders_raw;


-- SILVER PRODUCTS

DROP TABLE IF EXISTS silver.products;

CREATE TABLE silver.products AS

SELECT
    product_id,

    COALESCE(
        product_category_name,
        'UNKNOWN'
    ) AS product_category_name,

    NULLIF(
        product_weight_g,
        0
    ) AS product_weight_g,

    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_length_cm,
    product_height_cm,
    product_width_cm

FROM bronze.products_raw;


-- SILVER ORDER ITEMS

DROP TABLE IF EXISTS silver.order_items;

CREATE TABLE silver.order_items AS

SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value,

    price + freight_value
        AS total_amount

FROM bronze.order_items_raw;