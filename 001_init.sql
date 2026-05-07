-- Employees table
CREATE TABLE `employees` (
  `employee_id` int PRIMARY KEY, -- employee ID
  `first_name` varchar(255), -- first name
  `last_name` varchar(255), -- last name
  `ssn` varchar(255) UNIQUE, -- unique SSN
  `role_id` int, -- role link
  `access_token` varchar(255), -- login token
  `hourly_rate` decimal -- hourly pay
);

-- Employee roles
CREATE TABLE `employee_roles` (
  `role_id` int PRIMARY KEY, -- role ID
  `role_name` varchar(255) UNIQUE -- role name
);

-- Customers
CREATE TABLE `customers` (
  `customer_id` int PRIMARY KEY, -- customer ID
  `first_name` varchar(255),
  `last_name` varchar(255),
  `phone_number` varchar(255),
  `loyalty_id` int -- loyalty link
);

-- Loyalty levels
CREATE TABLE `loyalty_levels` (
  `loyalty_id` int PRIMARY KEY,
  `loyalty_name` varchar(255) UNIQUE
);

-- Locations
CREATE TABLE `locations` (
  `location_id` int PRIMARY KEY,
  `location_name` varchar(255) UNIQUE
);

-- Brands
CREATE TABLE `brands` (
  `brand_id` int PRIMARY KEY,
  `brand_name` varchar(255) UNIQUE
);

-- Categories
CREATE TABLE `categories` (
  `category_id` int PRIMARY KEY,
  `category_name` varchar(255) UNIQUE
);

-- Colors
CREATE TABLE `colors` (
  `color_id` int PRIMARY KEY,
  `color_name` varchar(255) UNIQUE
);

-- Sizes
CREATE TABLE `sizes` (
  `size_id` int PRIMARY KEY,
  `size_name` varchar(255) UNIQUE
);

-- Clothing items
CREATE TABLE `clothing_items` (
  `item_id` int PRIMARY KEY,
  `item_name` varchar(255),
  `brand_id` int,
  `category_id` int,
  `color_id` int,
  `size_id` int,
  `price` decimal -- item price
);

-- Item units
CREATE TABLE `item_units` (
  `rfid` varchar(255) PRIMARY KEY, -- RFID tag
  `item_id` int,
  `location_id` int,
  `unit_status_id` int
);

-- Unit statuses
CREATE TABLE `unit_statuses` (
  `unit_status_id` int PRIMARY KEY,
  `status_name` varchar(255) UNIQUE
);

-- Inventory
CREATE TABLE `inventory` (
  `item_id` int PRIMARY KEY,
  `quantity_available` int, -- stock amount
  `reorder_level` int, -- reorder point
  `future_shipment_quantity` int -- incoming stock
);

-- Orders
CREATE TABLE `orders` (
  `order_id` int PRIMARY KEY,
  `customer_id` int,
  `employee_id` int,
  `order_date` timestamp, -- order date
  `delivery_type_id` int,
  `order_status_id` int
);

-- Order items
CREATE TABLE `order_items` (
  `order_item_id` int PRIMARY KEY,
  `order_id` int,
  `item_id` int,
  `quantity` int, -- quantity ordered
  `unit_price` decimal -- sale price
);

-- Delivery types
CREATE TABLE `delivery_types` (
  `delivery_type_id` int PRIMARY KEY,
  `delivery_type_name` varchar(255) UNIQUE
);

-- Order statuses
CREATE TABLE `order_statuses` (
  `order_status_id` int PRIMARY KEY,
  `status_name` varchar(255) UNIQUE
);

-- Sales
CREATE TABLE `sales` (
  `sale_id` int PRIMARY KEY,
  `order_id` int UNIQUE,
  `payment_method_id` int,
  `sale_date` timestamp,
  `total_amount` decimal -- total sale
);

-- Payment methods
CREATE TABLE `payment_methods` (
  `payment_method_id` int PRIMARY KEY,
  `payment_method_name` varchar(255) UNIQUE
);

-- Commissions
CREATE TABLE `commissions` (
  `commission_id` int PRIMARY KEY,
  `employee_id` int,
  `order_id` int UNIQUE,
  `commission_amount` decimal -- commission earned
);

-- Suppliers
CREATE TABLE `suppliers` (
  `supplier_id` int PRIMARY KEY,
  `supplier_name` varchar(255),
  `phone_number` varchar(255),
  `email` varchar(255)
);

-- Supplier items
CREATE TABLE `supplier_items` (
  `supplier_id` int,
  `item_id` int,
  PRIMARY KEY (`supplier_id`, `item_id`) -- composite key
);

-- Restock orders
CREATE TABLE `restock_orders` (
  `restock_id` int PRIMARY KEY,
  `supplier_id` int,
  `order_date` timestamp,
  `expected_arrival` timestamp, -- expected delivery
  `restock_status_id` int
);

-- Restock items
CREATE TABLE `restock_order_items` (
  `restock_item_id` int PRIMARY KEY,
  `restock_id` int,
  `item_id` int,
  `quantity_ordered` int -- amount ordered
);

-- Restock statuses
CREATE TABLE `restock_statuses` (
  `restock_status_id` int PRIMARY KEY,
  `status_name` varchar(255) UNIQUE
);

-- Foreign keys
ALTER TABLE `employees`
ADD FOREIGN KEY (`role_id`) REFERENCES `employee_roles` (`role_id`);

ALTER TABLE `customers`
ADD FOREIGN KEY (`loyalty_id`) REFERENCES `loyalty_levels` (`loyalty_id`);

ALTER TABLE `clothing_items`
ADD FOREIGN KEY (`brand_id`) REFERENCES `brands` (`brand_id`);

ALTER TABLE `clothing_items`
ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

ALTER TABLE `clothing_items`
ADD FOREIGN KEY (`color_id`) REFERENCES `colors` (`color_id`);

ALTER TABLE `clothing_items`
ADD FOREIGN KEY (`size_id`) REFERENCES `sizes` (`size_id`);

ALTER TABLE `item_units`
ADD FOREIGN KEY (`item_id`) REFERENCES `clothing_items` (`item_id`);

ALTER TABLE `item_units`
ADD FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`);

ALTER TABLE `item_units`
ADD FOREIGN KEY (`unit_status_id`) REFERENCES `unit_statuses` (`unit_status_id`);

ALTER TABLE `clothing_items`
ADD FOREIGN KEY (`item_id`) REFERENCES `inventory` (`item_id`);

ALTER TABLE `orders`
ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `orders`
ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

ALTER TABLE `orders`
ADD FOREIGN KEY (`delivery_type_id`) REFERENCES `delivery_types` (`delivery_type_id`);

ALTER TABLE `orders`
ADD FOREIGN KEY (`order_status_id`) REFERENCES `order_statuses` (`order_status_id`);

ALTER TABLE `order_items`
ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

ALTER TABLE `order_items`
ADD FOREIGN KEY (`item_id`) REFERENCES `clothing_items` (`item_id`);

ALTER TABLE `orders`
ADD FOREIGN KEY (`order_id`) REFERENCES `sales` (`order_id`);

ALTER TABLE `sales`
ADD FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`payment_method_id`);

ALTER TABLE `commissions`
ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

ALTER TABLE `commissions`
ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

ALTER TABLE `supplier_items`
ADD FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);

ALTER TABLE `supplier_items`
ADD FOREIGN KEY (`item_id`) REFERENCES `clothing_items` (`item_id`);

ALTER TABLE `restock_orders`
ADD FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);

ALTER TABLE `restock_orders`
ADD FOREIGN KEY (`restock_status_id`) REFERENCES `restock_statuses` (`restock_status_id`);

ALTER TABLE `restock_order_items`
ADD FOREIGN KEY (`restock_id`) REFERENCES `restock_orders` (`restock_id`);

ALTER TABLE `restock_order_items`
ADD FOREIGN KEY (`item_id`) REFERENCES `clothing_items` (`item_id`);
