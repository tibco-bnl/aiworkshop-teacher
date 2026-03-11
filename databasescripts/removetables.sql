-- =================================================================
--  Script to Remove Chip Manufacturing Tables
-- =================================================================

-- Drop the junction table first (it depends on both orders and products)
DROP TABLE IF EXISTS order_items;

-- Drop the tables that depend on customers
DROP TABLE IF EXISTS orders;

-- Drop the independent tables
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- =================================================================
--  End of Script
-- =================================================================