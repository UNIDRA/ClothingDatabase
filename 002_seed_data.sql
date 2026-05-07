-- 002_seed_data.sql
-- Purpose: Insert sample data (seed data)

-- Employee roles (lookup)
INSERT INTO employee_roles (role_id, role_name) VALUES
(1, 'Manager'),
(2, 'Sales Associate'),
(3, 'Cashier'),
(4, 'Stock Clerk');

-- Loyalty levels (lookup)
INSERT INTO loyalty_levels (loyalty_id, loyalty_name) VALUES
(1, 'Bronze'),
(2, 'Silver'),
(3, 'Gold'),
(4, 'Platinum');

-- Locations (lookup)
INSERT INTO locations (location_id, location_name) VALUES
(1, 'Sales Floor'),
(2, 'Stockroom'),
(3, 'Fitting Room'),
(4, 'Display Window');

-- Brands (lookup)
INSERT INTO brands (brand_id, brand_name) VALUES
(1, 'UrbanEdge'),
(2, 'ClassicWear'),
(3, 'ActiveFit'),
(4, 'LuxeThread');

-- Categories (lookup)
INSERT INTO categories (category_id, category_name) VALUES
(1, 'Tops'),
(2, 'Bottoms'),
(3, 'Outerwear'),
(4, 'Footwear'),
(5, 'Accessories');

-- Colors (lookup)
INSERT INTO colors (color_id, color_name) VALUES
(1, 'Black'),
(2, 'White'),
(3, 'Navy Blue'),
(4, 'Charcoal Gray'),
(5, 'Crimson Red');

-- Sizes (lookup)
INSERT INTO sizes (size_id, size_name) VALUES
(1, 'XS'),
(2, 'S'),
(3, 'M'),
(4, 'L'),
(5, 'XL');

-- Unit statuses (lookup)
INSERT INTO unit_statuses (unit_status_id, status_name) VALUES
(1, 'Available'),
(2, 'Sold'),
(3, 'Reserved'),
(4, 'Damaged');

-- Delivery types (lookup)
INSERT INTO delivery_types (delivery_type_id, delivery_type_name) VALUES
(1, 'In-Store Pickup'),
(2, 'Standard Shipping'),
(3, 'Express Shipping');

-- Order statuses (lookup)
INSERT INTO order_statuses (order_status_id, status_name) VALUES
(1, 'Pending'),
(2, 'Processing'),
(3, 'Shipped'),
(4, 'Delivered'),
(5, 'Cancelled');

-- Payment methods (lookup)
INSERT INTO payment_methods (payment_method_id, payment_method_name) VALUES
(1, 'Cash'),
(2, 'Credit Card'),
(3, 'Debit Card'),
(4, 'Digital Wallet');

-- Restock statuses (lookup)
INSERT INTO restock_statuses (restock_status_id, status_name) VALUES
(1, 'Ordered'),
(2, 'In Transit'),
(3, 'Received'),
(4, 'Cancelled');

-- Employees
INSERT INTO employees (employee_id, first_name, last_name, ssn, role_id, access_token, hourly_rate) VALUES
(1, 'Jordan', 'Rivera',  '123-45-6789', 1, 'tok_mgr_001', 28.50),
(2, 'Sana',   'Patel',   '234-56-7890', 2, 'tok_sa_002',  17.00),
(3, 'Marcus', 'Chen',    '345-67-8901', 2, 'tok_sa_003',  17.00),
(4, 'Layla',  'Johnson', '456-78-9012', 3, 'tok_csh_004', 15.50),
(5, 'Ethan',  'Brooks',  '567-89-0123', 4, 'tok_stk_005', 14.75);

-- Customers
INSERT INTO customers (customer_id, first_name, last_name, phone_number, loyalty_id) VALUES
(1, 'Ava',    'Mitchell', '555-101-2030', 3),
(2, 'Carlos', 'Nguyen',   '555-202-3040', 1),
(3, 'Priya',  'Sharma',   '555-303-4050', 4),
(4, 'Devin',  'Park',     '555-404-5060', 2),
(5, 'Zoe',    'Williams', '555-505-6070', 1);

-- Inventory
INSERT INTO inventory (item_id, quantity_available, reorder_level, future_shipment_quantity) VALUES
(1, 24, 5,  50),
(2, 12, 5,  25),
(3, 18, 8,  30),
(4,  6, 3,  10),
(5, 20, 5,  40),
(6, 15, 5,  30),
(7, 30, 10, 50),
(8, 22, 5,  40);

-- Clothing items
INSERT INTO clothing_items (item_id, item_name, brand_id, category_id, color_id, size_id, price) VALUES
(1, 'Essential Crewneck Tee',    1, 1, 1, 3, 29.99),
(2, 'Slim Fit Chinos',           2, 2, 3, 4, 59.99),
(3, 'Fleece Zip-Up Hoodie',      3, 3, 1, 3, 79.99),
(4, 'Wool Blend Overcoat',       4, 3, 3, 4, 199.99),
(5, 'Classic White Button-Down', 2, 1, 2, 3, 49.99),
(6, 'Athletic Running Shorts',   3, 2, 3, 5, 34.99),
(7, 'Leather Belt',              2, 5, 1, 3, 24.99),
(8, 'Knit Beanie',               1, 5, 1, 2, 19.99);

-- Item units (RFID-tagged physical units)
INSERT INTO item_units (rfid, item_id, location_id, unit_status_id) VALUES
('RFID-0001', 1, 1, 1),
('RFID-0002', 1, 1, 1),
('RFID-0003', 2, 1, 1),
('RFID-0004', 2, 2, 3),
('RFID-0005', 3, 1, 1),
('RFID-0006', 4, 1, 1),
('RFID-0007', 5, 1, 2),
('RFID-0008', 6, 2, 1),
('RFID-0009', 7, 1, 1),
('RFID-0010', 8, 4, 1);

-- Sales (one per completed/shipped order)
INSERT INTO sales (sale_id, order_id, payment_method_id, sale_date, total_amount) VALUES
(1, 1, 2, NOW() - INTERVAL '10 days', 84.97),
(2, 2, 3, NOW() - INTERVAL '5 days',  79.99),
(3, 3, 4, NOW() - INTERVAL '2 days',  239.97),
(4, 4, 4, NOW() - INTERVAL '1 days',  174.99),
(5, 5, 4, NOW() - INTERVAL '1 days',  174.99);

-- Orders
INSERT INTO orders (order_id, customer_id, employee_id, order_date, delivery_type_id, order_status_id) VALUES
(1, 1, 2, NOW() - INTERVAL '10 days', 1, 4),
(2, 2, 3, NOW() - INTERVAL '5 days',  2, 3),
(3, 3, 2, NOW() - INTERVAL '2 days',  3, 2),
(4, 4, 4, NOW() - INTERVAL '1 day',   1, 1),
(5, 5, 3, NOW(),                       2, 1);

-- Order items
INSERT INTO order_items (order_item_id, order_id, item_id, quantity, unit_price) VALUES
(1, 1, 1, 2, 29.99),
(2, 1, 7, 1, 24.99),
(3, 2, 3, 1, 79.99),
(4, 3, 4, 1, 199.99),
(5, 3, 8, 2, 19.99),
(6, 4, 2, 1, 59.99),
(7, 5, 5, 1, 49.99),
(8, 5, 6, 2, 34.99);



-- Commissions
INSERT INTO commissions (commission_id, employee_id, order_id, commission_amount) VALUES
(1, 2, 1, 8.50),
(2, 3, 2, 8.00),
(3, 2, 3, 24.00);

-- Suppliers
INSERT INTO suppliers (supplier_id, supplier_name, phone_number, email) VALUES
(1, 'Apex Apparel Co.',    '800-111-2222', 'orders@apexapparel.com'),
(2, 'Metro Textiles Ltd.', '800-333-4444', 'supply@metrotextiles.com'),
(3, 'PrimeFit Wholesale',  '800-555-6666', 'wholesale@primefit.com');

-- Supplier items
INSERT INTO supplier_items (supplier_id, item_id) VALUES
(1, 1), (1, 2), (1, 5),
(2, 3), (2, 4),
(3, 6), (3, 7), (3, 8);

-- Restock orders
INSERT INTO restock_orders (restock_id, supplier_id, order_date, expected_arrival, restock_status_id) VALUES
(1, 1, NOW() - INTERVAL '7 days',  NOW() + INTERVAL '3 days', 2),
(2, 2, NOW() - INTERVAL '3 days',  NOW() + INTERVAL '7 days', 1),
(3, 3, NOW() - INTERVAL '14 days', NOW() - INTERVAL '2 days', 3);

-- Restock order items
INSERT INTO restock_order_items (restock_item_id, restock_id, item_id, quantity_ordered) VALUES
(1, 1, 1, 50),
(2, 1, 2, 25),
(3, 1, 5, 40),
(4, 2, 3, 30),
(5, 2, 4, 10),
(6, 3, 6, 30),
(7, 3, 7, 50),
(8, 3, 8, 40);
