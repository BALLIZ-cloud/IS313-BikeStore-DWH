CREATE DATABASE BikeStore_STG;
GO

USE BikeStore_STG;
GO

-- 1. STG_brands
CREATE TABLE STG_brands (
    brand_id INT,
    brand_name NVARCHAR(100)
);

-- 2. STG_categories
CREATE TABLE STG_categories (
    category_id INT,
    category_name NVARCHAR(100)
);

-- 3. STG_customers
CREATE TABLE STG_customers (
    customer_id INT,
    first_name NVARCHAR(100),
    last_name NVARCHAR(100),
    phone NVARCHAR(50),
    email NVARCHAR(150),
    street NVARCHAR(255),
    city NVARCHAR(100),
    [state] NVARCHAR(50),
    zip_code NVARCHAR(20)
);

-- 4. STG_stores
CREATE TABLE STG_stores (
    store_id INT,
    store_name NVARCHAR(100),
    phone NVARCHAR(50),
    email NVARCHAR(150),
    street NVARCHAR(255),
    city NVARCHAR(100),
    [state] NVARCHAR(50),
    zip_code NVARCHAR(20)
);

-- 5. STG_staffs
CREATE TABLE STG_staffs (
    staff_id INT,
    first_name NVARCHAR(100),
    last_name NVARCHAR(100),
    email NVARCHAR(150),
    phone NVARCHAR(50),
    active INT,
    store_id INT,
    manager_id INT NULL
);

-- 6. STG_products
CREATE TABLE STG_products (
    product_id INT,
    product_name NVARCHAR(100),
    brand_id INT,
    category_id INT,
    model_year INT,
    list_price FLOAT
);



DROP TABLE STG_products

-- 7. STG_stocks
CREATE TABLE STG_stocks (
    store_id INT,
    product_id INT,
    quantity INT
);

-- 8. STG_orders
CREATE TABLE STG_orders (
    order_id INT,
    customer_id INT,
    order_status INT,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    store_id INT,
    staff_id INT
);

-- 9. STG_order_items
CREATE TABLE STG_order_items (
    order_id INT,
    item_id INT,
    product_id INT,
    quantity INT,
    list_price FLOAT,
    discount FLOAT
);
GO

ALTER TABLE STG_orders
ALTER COLUMN shipped_date NVARCHAR(50);

ALTER TABLE [dbo].[STG_products]
ALTER COLUMN manager_id NVARCHAR(50);

