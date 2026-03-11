-- =================================================================
--  Sample Data: Dynamic ID Assignment
-- =================================================================
--  This script inserts sample orders and their corresponding
--  line items using CTEs to automatically link IDs.
-- =================================================================

-- Order 1: Placed by Kyoto Dynamics (customer_id=4)
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2021-03-15', 1357.50, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 3, 1, 950.00 FROM o UNION ALL SELECT order_id, 5, 1, 407.50 FROM o;

-- Order 2: Placed by Rhine Automata GmbH (customer_id=2)
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2022-08-02', 3770.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 8, 100, 15.25 FROM o UNION ALL SELECT order_id, 12, 100, 9.75 FROM o UNION ALL SELECT order_id, 16, 200, 6.35 FROM o;

-- Order 3: Placed by Silicon Valley Robotics (customer_id=3)
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2024-01-20', 11330.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 18, 10, 620.00 FROM o UNION ALL SELECT order_id, 14, 5, 450.25 FROM o UNION ALL SELECT order_id, 7, 35, 82.00 FROM o;

-- Order 4: Placed by QuantumLeap B.V. (customer_id=1)
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2025-06-05', 13800.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 3, 10, 950.00 FROM o UNION ALL SELECT order_id, 5, 5, 780.75 FROM o UNION ALL SELECT order_id, 7, 5, 85.50 FROM o;

-- Order 5: Placed by Maple Innovations (customer_id=9)
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2025-07-18', 2112.50, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 15, 250, 8.45 FROM o;

-- Order 6
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2023-11-08', 2905.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 13, 20, 110.00 FROM o UNION ALL SELECT order_id, 16, 100, 7.05 FROM o;

-- Order 7
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2024-01-22', 17010.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 2, 40, 350.50 FROM o UNION ALL SELECT order_id, 7, 30, 85.50 FROM o UNION ALL SELECT order_id, 11, 20, 22.80 FROM o;

-- Order 8
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2022-05-14', 1015.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 19, 150, 5.50 FROM o UNION ALL SELECT order_id, 20, 40, 4.75 FROM o;

-- Order 9
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2025-02-19', 16905.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 3, 15, 950.00 FROM o UNION ALL SELECT order_id, 18, 4, 620.00 FROM o;

-- Order 10
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (8, '2021-09-01', 3090.25, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 5, 1, 780.75 FROM o UNION ALL SELECT order_id, 14, 5, 450.25 FROM o UNION ALL SELECT order_id, 10, 5, 12.50 FROM o;

-- Order 11
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2024-08-30', 4890.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 1, 20, 180.00 FROM o UNION ALL SELECT order_id, 6, 20, 45.00 FROM o UNION ALL SELECT order_id, 8, 20, 15.25 FROM o UNION ALL SELECT order_id, 12, 10, 9.75 FROM o;

-- Order 12
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2023-04-11', 10800.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 1, 60, 180.00 FROM o;

-- Order 13
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2025-07-07', 8550.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 7, 100, 85.50 FROM o;

-- Order 14
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (6, '2022-12-01', 5250.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 4, 25, 210.00 FROM o;

-- Order 15
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2024-03-25', 1335.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 15, 100, 8.50 FROM o UNION ALL SELECT order_id, 19, 50, 5.50 FROM o UNION ALL SELECT order_id, 20, 50, 4.10 FROM o;

-- Order 16
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2023-01-15', 3855.50, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 8, 110, 15.50 FROM o UNION ALL SELECT order_id, 12, 130, 9.80 FROM o UNION ALL SELECT order_id, 17, 25, 35.00 FROM o;

-- Order 17
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2024-11-20', 10512.50, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 3, 10, 955.00 FROM o UNION ALL SELECT order_id, 15, 100, 8.75 FROM o UNION ALL SELECT order_id, 10, 10, 12.50 FROM o;

-- Order 18
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2021-04-02', 12345.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 5, 15, 785.00 FROM o UNION ALL SELECT order_id, 6, 12, 45.00 FROM o;

-- Order 19
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2025-01-05', 7357.50, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 2, 20, 350.50 FROM o UNION ALL SELECT order_id, 9, 5, 65.00 FROM o;

-- Order 20
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2022-07-30', 1800.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 1, 10, 180.00 FROM o;

-- Order 21
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (6, '2024-10-01', 21000.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 4, 100, 210.00 FROM o;

-- Order 22
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2023-07-19', 6525.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 7, 50, 85.50 FROM o UNION ALL SELECT order_id, 6, 50, 45.00 FROM o;

-- Order 23
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2022-03-05', 1860.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 18, 3, 620.00 FROM o;

-- Order 24
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2021-12-12', 780.75, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 5, 1, 780.75 FROM o;

-- Order 25
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2025-01-28', 15700.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 16, 1000, 7.20 FROM o UNION ALL SELECT order_id, 15, 1000, 8.50 FROM o;

-- Order 26
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2024-06-12', 4505.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 2, 10, 350.50 FROM o UNION ALL SELECT order_id, 7, 10, 85.50 FROM o UNION ALL SELECT order_id, 6, 10, 45.00 FROM o;

-- Order 27
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2023-09-05', 9500.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 3, 10, 950.00 FROM o;

-- Order 28
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2025-04-21', 1240.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 17, 25, 35.80 FROM o UNION ALL SELECT order_id, 10, 20, 12.50 FROM o UNION ALL SELECT order_id, 12, 10, 9.75 FROM o;

-- Order 29
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (8, '2022-02-14', 1561.50, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 5, 2, 780.75 FROM o;

-- Order 30
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2024-08-01', 3600.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 1, 20, 180.00 FROM o;

-- Order 31
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2023-05-16', 701.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 8, 20, 15.25 FROM o UNION ALL SELECT order_id, 11, 10, 22.80 FROM o UNION ALL SELECT order_id, 12, 10, 9.75 FROM o UNION ALL SELECT order_id, 15, 10, 8.50 FROM o;

-- Order 32
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2021-11-30', 2200.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 13, 20, 110.00 FROM o;

-- Order 33
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2025-03-03', 4200.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 4, 20, 210.00 FROM o;

-- Order 34
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2022-10-10', 12400.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 18, 20, 620.00 FROM o;

-- Order 35
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (6, '2024-02-28', 1350.75, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 14, 3, 450.25 FROM o;

-- Order 36
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2023-01-20', 1710.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 7, 20, 85.50 FROM o;

-- Order 37
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2022-08-19', 180.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 1, 1, 180.00 FROM o;

-- Order 38
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2024-12-01', 3505.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 2, 10, 350.50 FROM o;

-- Order 39
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (8, '2021-07-25', 164.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 19, 10, 5.50 FROM o UNION ALL SELECT order_id, 20, 20, 4.10 FROM o UNION ALL SELECT order_id, 15, 3, 8.50 FROM o;

-- Order 40
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2023-10-02', 2100.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 4, 10, 210.00 FROM o;

-- Order 41
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2025-05-25', 19000.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 3, 20, 950.00 FROM o;

-- Order 42
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2022-06-18', 228.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 11, 10, 22.80 FROM o;

-- Order 43
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2024-04-04', 144.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 16, 20, 7.20 FROM o;

-- Order 44
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2023-03-20', 780.75, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 5, 1, 780.75 FROM o;

-- Order 45
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2025-02-10', 900.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 6, 20, 45.00 FROM o;

-- Order 46
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (8, '2023-06-22', 450.25, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 14, 1, 450.25 FROM o;

-- Order 47
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2024-09-15', 305.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 8, 20, 15.25 FROM o;

-- Order 48
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2022-01-10', 360.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 1, 2, 180.00 FROM o;

-- Order 49
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2025-07-01', 35050.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 2, 100, 350.50 FROM o;

-- Order 50
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (6, '2023-12-24', 210.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 4, 1, 210.00 FROM o;

-- Order 51
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2024-01-15', 1710.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 7, 20, 85.50 FROM o;

-- Order 52
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2022-04-01', 125.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 10, 10, 12.50 FROM o;

-- Order 53
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2025-06-11', 6200.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 18, 10, 620.00 FROM o;

-- Order 54
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2023-08-08', 450.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 6, 10, 45.00 FROM o;

-- Order 55
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2024-05-09', 7807.50, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 5, 10, 780.75 FROM o;

-- Order 56
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (8, '2022-09-13', 220.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 13, 2, 110.00 FROM o;

-- Order 57
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2021-06-06', 97.50, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 12, 10, 9.75 FROM o;

-- Order 58
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2024-11-11', 19000.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 3, 20, 950.00 FROM o;

-- Order 59
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2023-02-02', 85.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 15, 10, 8.50 FROM o;

-- Order 60
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (6, '2025-03-17', 716.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 17, 20, 35.80 FROM o;

-- Order 61
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2022-05-20', 305.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 8, 20, 15.25 FROM o;

-- Order 62
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2024-07-29', 55.00, 'Shipped') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 19, 10, 5.50 FROM o;

-- Order 63
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2023-11-01', 41.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 20, 10, 4.10 FROM o;

-- Order 64
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2021-10-18', 72.00, 'Delivered') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 16, 10, 7.20 FROM o;

-- Order 65
WITH o AS (INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2025-01-02', 650.00, 'Pending') RETURNING order_id)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT order_id, 9, 10, 65.00 FROM o;