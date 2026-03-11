-- =================================================================
--  PostgreSQL DDL for Chip Manufacturing Business
-- =================================================================
--  This script creates four tables to manage customers, products,
--  orders, and the items within those orders.

--  Author: Gemini
--  Date: July 22, 2025
-- =================================================================

-- Drop tables if they exist to ensure a clean slate.
-- The CASCADE option will automatically remove dependent objects.
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- =================================================================
--  Table: customers
--  Stores information about each client company.
-- =================================================================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255) UNIQUE NOT NULL,
    contact_phone VARCHAR(50),
    billing_address TEXT NOT NULL,
    shipping_address TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE customers IS 'Stores information about each client company.';
COMMENT ON COLUMN customers.customer_id IS 'Unique identifier for each customer.';
COMMENT ON COLUMN customers.company_name IS 'The legal name of the customer company.';
COMMENT ON COLUMN customers.contact_email IS 'Primary contact email, must be unique.';

-- =================================================================
--  Table: products
--  Contains details for each type of computer chip manufactured.
-- =================================================================
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    chip_model VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE products IS 'Contains details for each type of computer chip manufactured.';
COMMENT ON COLUMN products.chip_model IS 'The unique model name or number for the chip.';
COMMENT ON COLUMN products.price IS 'The unit price of the chip. Must be a positive value.';
COMMENT ON COLUMN products.stock_quantity IS 'Current quantity in inventory. Cannot be negative.';

-- =================================================================
--  Table: orders
--  Tracks each order placed by a customer.
-- =================================================================
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    total_amount DECIMAL(12, 2) NOT NULL CHECK (total_amount >= 0),
    status VARCHAR(50) NOT NULL DEFAULT 'Pending', -- e.g., Pending, Shipped, Delivered, Cancelled
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_customer
      FOREIGN KEY(customer_id)
      REFERENCES customers(customer_id)
      ON DELETE CASCADE -- If a customer is deleted, their orders are also deleted.
);

COMMENT ON TABLE orders IS 'Tracks each order placed by a customer.';
COMMENT ON COLUMN orders.status IS 'The current status of the order (e.g., Pending, Shipped, Delivered).';
COMMENT ON CONSTRAINT fk_customer ON orders IS 'Ensures that every order is linked to a valid customer.';

-- =================================================================
--  Table: order_items
--  A junction table linking products to orders.
-- =================================================================
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL, -- Price at the time of purchase

    CONSTRAINT fk_order
      FOREIGN KEY(order_id)
      REFERENCES orders(order_id)
      ON DELETE CASCADE, -- If an order is deleted, its line items are also deleted.

    CONSTRAINT fk_product
      FOREIGN KEY(product_id)
      REFERENCES products(product_id)
      ON DELETE RESTRICT, -- Prevents deleting a product that has been part of an order.

    UNIQUE (order_id, product_id) -- Ensures a product appears only once per order.
);

COMMENT ON TABLE order_items IS 'Junction table linking products to orders, representing line items.';
COMMENT ON COLUMN order_items.unit_price IS 'Captures the historical price of the product at the time of the order.';
COMMENT ON CONSTRAINT fk_product ON order_items IS 'Ensures line items refer to a valid product and prevents deletion of ordered products.';
COMMENT ON CONSTRAINT order_items_order_id_product_id_key ON order_items IS 'Ensures a product can only be listed once per order. To change quantity, update the existing record.';

-- =================================================================
--  Create Indexes for Performance
-- =================================================================
-- Indexes are automatically created for PRIMARY KEY and UNIQUE constraints.
-- We will add indexes on foreign key columns for faster joins.
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- =================================================================
--  End of Script
-- =================================================================
