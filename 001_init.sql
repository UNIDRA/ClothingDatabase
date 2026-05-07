-- Create employee table
CREATE TABLE employees (
  employee_id INT PRIMARY KEY, -- Employee ID
  first_name VARCHAR(50), -- First name
  last_name VARCHAR(50), -- Last name
  ssn VARCHAR(20) UNIQUE, -- Unique SSN
  role_id INT, -- Employee role
  access_token VARCHAR(255), -- Login token
  hourly_rate DECIMAL(10,2) -- Hourly pay
);

-- Create employee roles table
CREATE TABLE employee_roles (
  role_id INT PRIMARY KEY, -- Role ID
  role_name VARCHAR(50) UNIQUE -- Role name
);

-- Create customers table
CREATE TABLE customers (
  customer_id INT PRIMARY KEY, -- Customer ID
  first_name VARCHAR(50), -- First name
  last_name VARCHAR(50), -- Last name
  phone_number VARCHAR(20), -- Phone number
  loyalty_id INT -- Loyalty level
);

-- Create loyalty levels table
CREATE TABLE loyalty_levels (
  loyalty_id INT PRIMARY KEY, -- Loyalty ID
  loyalty_name VARCHAR(50) UNIQUE -- Loyalty level name
);

-- Create locations table
CREATE TABLE locations (
  location_id INT PRIMARY KEY, -- Location ID
  location_name VARCHAR(100) UNIQUE -- Store/location name
);

-- Create brands table
CREATE TABLE brands (
  brand_id INT PRIMARY KEY, -- Brand ID
  brand_name VARCHAR(50) UNIQUE -- Brand name
);

-- Create categories table
CREATE TABLE categories (
  category_id INT PRIMARY KEY, -- Category ID
  category_name VARCHAR(50) UNIQUE -- Category name
);

-- Create colors table
CREATE TABLE colors (
  color_id INT PRIMARY KEY, -- Color ID
  color_name VARCHAR(50) UNIQUE -- Color name
);

-- Create sizes table
CREATE TABLE sizes (
  size_id INT PRIMARY KEY, -- Size ID
  size_name VARCHAR(20) UNIQUE -- Size label
);

-- Create clothing items table
CREATE TABLE clothing_items (
  item_id INT PRIMARY KEY, -- Item ID
  item_name VARCHAR(100), -- Clothing item name
  brand_id INT, -- Brand reference
  category_id INT, -- Category reference
  color_id INT, -- Color reference
  size_id INT, -- Size reference
  price DECIMAL(10,2) -- Item price
);

-- Create unit statuses table
CREATE TABLE unit_statuses (
  unit_status_id INT PRIMARY KEY, -- Status ID
  status_name VARCHAR(50) UNIQUE -- Status name
);

-- Create item units table
CREATE TABLE item_units (
  rfid VARCHAR(100) PRIMARY KEY, -- RFID tag
  item_id INT, -- Clothing item
  location_id INT, -- Current location
  unit_status_id INT -- Item status
);

-- Create inventory table
CREATE TABLE inventory (
  item_id INT PRIMARY KEY, -- Item reference
  quantity_available INT, -- Available stock
  reorder_level INT, -- Minimum stock level
  future_shipment_quantity INT -- Incoming stock
);

-- Create delivery types table
CREATE TABLE delivery_types (
  delivery_type_id INT PRIMARY KEY, -- Delivery ID
  delivery_type_name VARCHAR(50) UNIQUE -- Delivery method
);

-- Create order statuses table
CREATE TABLE order_statuses (
  order_status_id INT PRIMARY KEY, -- Status ID
  status_name VARCHAR(50) UNIQUE -- Order status
);

-- Create orders table
CREATE TABLE orders (
  order_id INT PRIMARY KEY, -- Order ID
  customer_id INT, -- Customer reference
  employee_id INT, -- Employee reference
  order_date TIMESTAMP, -- Date ordered
  delivery_type_id INT, -- Delivery method
  order_status_id INT -- Order status
);

-- Create order items table
CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY, -- Order item ID
  order_id INT, -- Order reference
  item_id INT, -- Item reference
  quantity INT, -- Quantity ordered
  unit_price DECIMAL(10,2) -- Price per unit
);

-- Create payment methods table
CREATE TABLE payment_methods (
  payment_method_id INT PRIMARY KEY, -- Payment ID
  payment_method_name VARCHAR(50) UNIQUE -- Payment type
);

-- Create sales table
CREATE TABLE sales (
  sale_id INT PRIMARY KEY, -- Sale ID
  order_id INT UNIQUE, -- Linked order
  payment_method_id INT, -- Payment method
  sale_date TIMESTAMP, -- Sale date
  total_amount DECIMAL(10,2) -- Total sale
);

-- Create commissions table
CREATE TABLE commissions (
  commission_id INT PRIMARY KEY, -- Commission ID
  employee_id INT, -- Employee reference
  order_id INT UNIQUE, -- Order reference
  commission_amount DECIMAL(10,2) -- Commission earned
);

-- Create suppliers table
CREATE TABLE suppliers (
  supplier_id INT PRIMARY KEY, -- Supplier ID
  supplier_name VARCHAR(100), -- Supplier name
  phone_number VARCHAR(20), -- Supplier phone
  email VARCHAR(100) -- Supplier email
);

-- Create supplier items table
CREATE TABLE supplier_items (
  supplier_id INT, -- Supplier reference
  item_id INT, -- Item reference
  PRIMARY KEY (supplier_id, item_id) -- Composite key
);

-- Create restock statuses table
CREATE TABLE restock_statuses (
  restock_status_id INT PRIMARY KEY, -- Status ID
  status_name VARCHAR(50) UNIQUE -- Restock status
);

-- Create restock orders table
CREATE TABLE restock_orders (
  restock_id INT PRIMARY KEY, -- Restock order ID
  supplier_id INT, -- Supplier reference
  order_date TIMESTAMP, -- Order date
  expected_arrival TIMESTAMP, -- Arrival estimate
  restock_status_id INT -- Restock status
);

-- Create restock order items table
CREATE TABLE restock_order_items (
  restock_item_id INT PRIMARY KEY, -- Restock item ID
  restock_id INT, -- Restock order reference
  item_id INT, -- Item reference
  quantity_ordered INT -- Quantity ordered
);

-- Employee role relationship
ALTER TABLE employees
ADD FOREIGN KEY (role_id)
REFERENCES employee_roles(role_id);

-- Customer loyalty relationship
ALTER TABLE customers
ADD FOREIGN KEY (loyalty_id)
REFERENCES loyalty_levels(loyalty_id);

-- Clothing item relationships
ALTER TABLE clothing_items
ADD FOREIGN KEY (brand_id)
REFERENCES brands(brand_id);

ALTER TABLE clothing_items
ADD FOREIGN KEY (category_id)
REFERENCES categories(category_id);

ALTER TABLE clothing_items
ADD FOREIGN KEY (color_id)
REFERENCES colors(color_id);

ALTER TABLE clothing_items
ADD FOREIGN KEY (size_id)
REFERENCES sizes(size_id);

-- Item unit relationships
ALTER TABLE item_units
ADD FOREIGN KEY (item_id)
REFERENCES clothing_items(item_id);

ALTER TABLE item_units
ADD FOREIGN KEY (location_id)
REFERENCES locations(location_id);

ALTER TABLE item_units
ADD FOREIGN KEY (unit_status_id)
REFERENCES unit_statuses(unit_status_id);

-- Inventory relationship
ALTER TABLE inventory
ADD FOREIGN KEY (item_id)
REFERENCES clothing_items(item_id);

-- Order relationships
ALTER TABLE orders
ADD FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE orders
ADD FOREIGN KEY (employee_id)
REFERENCES employees(employee_id);

ALTER TABLE orders
ADD FOREIGN KEY (delivery_type_id)
REFERENCES delivery_types(delivery_type_id);

ALTER TABLE orders
ADD FOREIGN KEY (order_status_id)
REFERENCES order_statuses(order_status_id);

-- Order item relationships
ALTER TABLE order_items
ADD FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE order_items
ADD FOREIGN KEY (item_id)
REFERENCES clothing_items(item_id);

-- Sales relationships
ALTER TABLE sales
ADD FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE sales
ADD FOREIGN KEY (payment_method_id)
REFERENCES payment_methods(payment_method_id);

-- Commission relationships
ALTER TABLE commissions
ADD FOREIGN KEY (employee_id)
REFERENCES employees(employee_id);

ALTER TABLE commissions
ADD FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- Supplier item relationships
ALTER TABLE supplier_items
ADD FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);

ALTER TABLE supplier_items
ADD FOREIGN KEY (item_id)
REFERENCES clothing_items(item_id);

-- Restock order relationships
ALTER TABLE restock_orders
ADD FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);

ALTER TABLE restock_orders
ADD FOREIGN KEY (restock_status_id)
REFERENCES restock_statuses(restock_status_id);

-- Restock item relationships
ALTER TABLE restock_order_items
ADD FOREIGN KEY (restock_id)
REFERENCES restock_orders(restock_id);

ALTER TABLE restock_order_items
ADD FOREIGN KEY (item_id)
REFERENCES clothing_items(item_id);
