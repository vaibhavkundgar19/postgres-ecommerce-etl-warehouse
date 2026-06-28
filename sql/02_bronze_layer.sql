-- Create Bronze Tables (Raw Layer)

 --customers
CREATE TABLE bronze.customers_raw(
customer_id varchar(100),
customer_unique_id varchar(100),
customer_zip_code_prefix int,
customer_city varchar(100),
customer_state varchar(20));

--orders 
CREATE TABLE bronze.orders_raw (
    order_id VARCHAR(100),
    customer_id VARCHAR(100),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);
 
--products
CREATE TABLE bronze.products_raw (
    product_id VARCHAR(100),
    product_category_name VARCHAR(255),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

-- order items
CREATE TABLE bronze.order_items_raw (
order_id VARCHAR(100),
order_item_id INT,
product_id VARCHAR(100),
seller_id VARCHAR(100),
shipping_limit_date TIMESTAMP,
price NUMERIC(10,2),
freight_value NUMERIC(10,2)
);