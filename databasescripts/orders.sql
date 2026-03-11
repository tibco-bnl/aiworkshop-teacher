-- =================================================================
--  Sample Data: 
-- =================================================================
--  This script inserts sample orders and their corresponding
--  line items into the database.
--
--  NOTE: This script assumes the first 5 orders have already been
--  inserted and the next order_id will start at 6.
-- =================================================================

-- Order 1: Placed by Kyoto Dynamics (customer_id=4) on March 15, 2021
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(4, '2021-03-15', 1357.50, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 3, 1, 950.00),  -- 1 x PROC-Z900-AI @ 950.00
(1, 5, 1, 407.50);  -- Note: Price was different in the past. Example of capturing historical price.

-- Order 2: Placed by Rhine Automata GmbH (customer_id=2) on August 2, 2022
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(2, '2022-08-02', 3770.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(2, 8, 100, 15.25), -- 100 x NET-ETH-1G @ 15.25
(2, 12, 100, 9.75), -- 100 x CTRL-SATA3 @ 9.75
(2, 16, 200, 6.35); -- 200 x MCU-ARM-CORTEX-M4 @ 6.35

-- Order 3: Placed by Silicon Valley Robotics (customer_id=3) on January 20, 2024
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(3, '2024-01-20', 11330.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(3, 18, 10, 620.00), -- 10 x NPU-T1 @ 620.00
(3, 14, 5, 450.25),  -- 5 x FPGA-H500 @ 450.25
(3, 7, 35, 82.00);   -- 35 x MEM-DDR5-16GB @ 82.00 (Historical Price)

-- Order 4: Placed by QuantumLeap B.V. (customer_id=1) on June 5, 2025
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2025-06-05', 13800.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(4, 3, 10, 950.00),   -- 10 x PROC-Z900-AI @ 950.00
(4, 5, 5, 780.75),    -- 5 x GPU-V5-RT @ 780.75
(4, 7, 5, 85.50);     -- 5 x MEM-DDR5-16GB @ 85.50

-- Order 5: Placed by Maple Innovations (customer_id=9) on July 18, 2025
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(9, '2025-07-18', 2112.50, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(5, 15, 250, 8.45); -- 250 x TPM-20 @ 8.45

-- Order 6
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2023-11-08', 2905.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(6, 13, 20, 110.00),
(6, 16, 100, 7.05);

-- Order 7
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2024-01-22', 17010.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(7, 2, 40, 350.50),
(7, 7, 30, 85.50),
(7, 11, 20, 22.80);

-- Order 8
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2022-05-14', 1015.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(8, 19, 150, 5.50),
(8, 20, 40, 4.75);

-- Order 9
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2025-02-19', 16905.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(9, 3, 15, 950.00),
(9, 18, 4, 620.00);

-- Order 10
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (8, '2021-09-01', 3090.25, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(10, 5, 1, 780.75),
(10, 14, 5, 450.25),
(10, 10, 5, 12.50);

-- Order 11
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2024-08-30', 4890.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(11, 1, 20, 180.00),
(11, 6, 20, 45.00),
(11, 8, 20, 15.25),
(11, 12, 10, 9.75);

-- Order 12
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2023-04-11', 10800.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(12, 1, 60, 180.00);

-- Order 13
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2025-07-07', 8550.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(13, 7, 100, 85.50);

-- Order 14
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (6, '2022-12-01', 5250.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(14, 4, 25, 210.00);

-- Order 15
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2024-03-25', 1335.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(15, 15, 100, 8.50),
(15, 19, 50, 5.50),
(15, 20, 50, 4.10);

-- Order 16
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2023-01-15', 3855.50, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(16, 8, 110, 15.50),
(16, 12, 130, 9.80),
(16, 17, 25, 35.00);

-- Order 17
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2024-11-20', 10512.50, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(17, 3, 10, 955.00),
(17, 15, 100, 8.75),
(17, 10, 10, 12.50);

-- Order 18
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2021-04-02', 12345.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(18, 5, 15, 785.00),
(18, 6, 12, 45.00);

-- Order 19
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2025-01-05', 7357.50, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(19, 2, 20, 350.50),
(19, 9, 5, 65.00);

-- Order 20
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2022-07-30', 1800.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(20, 1, 10, 180.00);

-- Order 21
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (6, '2024-10-01', 21000.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(21, 4, 100, 210.00);

-- Order 22
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2023-07-19', 6525.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(22, 7, 50, 85.50),
(22, 6, 50, 45.00);

-- Order 23
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2022-03-05', 1860.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(23, 18, 3, 620.00);

-- Order 24
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2021-12-12', 780.75, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(24, 5, 1, 780.75);

-- Order 25
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2025-01-28', 15700.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(25, 16, 1000, 7.20),
(25, 15, 1000, 8.50);

-- Order 26
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2024-06-12', 4505.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(26, 2, 10, 350.50),
(26, 7, 10, 85.50),
(26, 6, 10, 45.00);

-- Order 27
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2023-09-05', 9500.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(27, 3, 10, 950.00);

-- Order 28
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2025-04-21', 1240.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(28, 17, 25, 35.80),
(28, 10, 20, 12.50),
(28, 12, 10, 9.75);

-- Order 29
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (8, '2022-02-14', 1561.50, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(29, 5, 2, 780.75);

-- Order 30
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2024-08-01', 3600.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(30, 1, 20, 180.00);

-- Order 31
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2023-05-16', 701.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(31, 8, 20, 15.25),
(31, 11, 10, 22.80),
(31, 12, 10, 9.75),
(31, 15, 10, 8.50);

-- Order 32
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2021-11-30', 2200.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(32, 13, 20, 110.00);

-- Order 33
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2025-03-03', 4200.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(33, 4, 20, 210.00);

-- Order 34
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2022-10-10', 12400.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(34, 18, 20, 620.00);

-- Order 35
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (6, '2024-02-28', 1350.75, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(35, 14, 3, 450.25);

-- Order 36
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2023-01-20', 1710.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(36, 7, 20, 85.50);

-- Order 37
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2022-08-19', 180.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(37, 1, 1, 180.00);

-- Order 38
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2024-12-01', 3505.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(38, 2, 10, 350.50);

-- Order 39
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (8, '2021-07-25', 164.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(39, 19, 10, 5.50),
(39, 20, 20, 4.10),
(39, 15, 3, 8.50);

-- Order 40
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2023-10-02', 2100.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(40, 4, 10, 210.00);

-- Order 41
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2025-05-25', 19000.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(41, 3, 20, 950.00);

-- Order 42
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2022-06-18', 228.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(42, 11, 10, 22.80);

-- Order 43
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2024-04-04', 144.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(43, 16, 20, 7.20);

-- Order 44
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2023-03-20', 780.75, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(44, 5, 1, 780.75);

-- Order 45
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2025-02-10', 900.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(45, 6, 20, 45.00);

-- Order 46
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (8, '2023-06-22', 450.25, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(46, 14, 1, 450.25);

-- Order 47
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2024-09-15', 305.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(47, 8, 20, 15.25);

-- Order 48
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2022-01-10', 360.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(48, 1, 2, 180.00);

-- Order 49
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2025-07-01', 35050.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(49, 2, 100, 350.50);

-- Order 50
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (6, '2023-12-24', 210.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(50, 4, 1, 210.00);

-- Order 51
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2024-01-15', 1710.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(51, 7, 20, 85.50);

-- Order 52
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2022-04-01', 125.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(52, 10, 10, 12.50);

-- Order 53
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2025-06-11', 6200.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(53, 18, 10, 620.00);

-- Order 54
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2023-08-08', 450.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(54, 6, 10, 45.00);

-- Order 55
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2024-05-09', 7807.50, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(55, 5, 10, 780.75);

-- Order 56
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (8, '2022-09-13', 220.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(56, 13, 2, 110.00);

-- Order 57
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (3, '2021-06-06', 97.50, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(57, 12, 10, 9.75);

-- Order 58
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (9, '2024-11-11', 19000.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(58, 3, 20, 950.00);

-- Order 59
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (2, '2023-02-02', 85.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(59, 15, 10, 8.50);

-- Order 60
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (6, '2025-03-17', 716.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(60, 17, 20, 35.80);

-- Order 61
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (5, '2022-05-20', 305.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(61, 8, 20, 15.25);

-- Order 62
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (1, '2024-07-29', 55.00, 'Shipped');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(62, 19, 10, 5.50);

-- Order 63
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (10, '2023-11-01', 41.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(63, 20, 10, 4.10);

-- Order 64
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (4, '2021-10-18', 72.00, 'Delivered');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(64, 16, 10, 7.20);

-- Order 65
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (7, '2025-01-02', 650.00, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(65, 9, 10, 65.00);