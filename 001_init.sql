-- Create the "employees" table
CREATE TABLE "employees" (
  "employee_id" int PRIMARY KEY, -- ID for each employee
  "first_name" varchar, -- Employee's first name
  "last_name" varchar, -- Employee's last name
  "ssn" varchar UNIQUE, -- Unique Social Security Number
  "role_id" int, -- Role reference
  "access_token" varchar, -- Auth token
  "hourly_rate" decimal -- Hourly wage
);

-- Create the "employee_roles" table
CREATE TABLE "employee_roles" (
  "role_id" int PRIMARY KEY, -- ID for each role
  "role_name" varchar UNIQUE -- Unique role name
);

-- Create the "customers" table
CREATE TABLE "customers" (
  "customer_id" int PRIMARY KEY, -- ID for each customer
  "first_name" varchar, -- Customer's first name
  "last_name" varchar, -- Customer's last name
  "phone_number" varchar, -- Phone number
  "loyalty_id" int -- Loyalty level reference
);

-- Create the "loyalty_levels" table
CREATE TABLE "loyalty_levels" (
  "loyalty_id" int PRIMARY KEY, -- ID for each loyalty level
  "loyalty_name" varchar UNIQUE -- Unique loyalty name
);

-- Create the "locations" table
CREATE TABLE "locations" (
  "location_id" int PRIMARY KEY, -- ID for each location
  "location_name" varchar UNIQUE -- Unique location name
);

-- Create the "brands" table
CREATE TABLE "brands" (
  "brand_id" int PRIMARY KEY, -- ID for each brand
  "brand_name" varchar UNIQUE -- Unique brand name
);

-- Create the "categories" table
CREATE TABLE "categories" (
  "category_id" int PRIMARY KEY, -- ID for each category
  "category_name" varchar UNIQUE -- Unique category name
);

-- Create the "colors" table
CREATE TABLE "colors" (
  "color_id" int PRIMARY KEY, -- ID for each color
  "color_name" varchar UNIQUE -- Unique color name
);

-- Create the "sizes" table
CREATE TABLE "sizes" (
  "size_id" int PRIMARY KEY, -- ID for each size
  "size_name" varchar UNIQUE -- Unique size name
);

-- Create the "clothing_items" table
CREATE TABLE "clothing_items" (
  "item_id" int PRIMARY KEY, -- ID for each item
  "item_name" varchar, -- Item name
  "brand_id" int, -- Brand reference
  "category_id" int, -- Category reference
  "color_id" int, -- Color reference
  "size_id" int, -- Size reference
  "price" decimal -- Item price
);

-- Create the "item_units" table
CREATE TABLE "item_units" (
  "rfid" varchar PRIMARY KEY, -- Unique RFID
  "item_id" int, -- Item reference
  "location_id" int, -- Location reference
  "unit_status_id" int -- Status reference
);

-- Create the "unit_statuses" table
CREATE TABLE "unit_statuses" (
  "unit_status_id" int PRIMARY KEY, -- ID for each status
  "status_name" varchar UNIQUE -- Unique status name
);

-- Create the "inventory" table
CREATE TABLE "inventory" (
  "item_id" int PRIMARY KEY, -- Item reference
  "quantity_available" int, -- Available quantity
  "reorder_level" int, -- Reorder level
  "future_shipment_quantity" int -- Future shipment quantity
);

-- Create the "orders" table
CREATE TABLE "orders" (
  "order_id" int PRIMARY KEY, -- ID for each order
  "customer_id" int, -- Customer reference
  "employee_id" int, -- Employee reference
  "order_date" timestamp, -- Order date
  "delivery_type_id" int, -- Delivery type reference
  "order_status_id" int -- Order status reference
);

-- Create the "order_items" table
CREATE TABLE "order_items" (
  "order_item_id" int PRIMARY KEY, -- ID for each order item
  "order_id" int, -- Order reference
  "item_id" int, -- Item reference
  "quantity" int, -- Quantity ordered
  "unit_price" decimal -- Price per unit
);

-- Create the "delivery_types" table
CREATE TABLE "delivery_types" (
  "delivery_type_id" int PRIMARY KEY, -- ID for each delivery type
  "delivery_type_name" varchar UNIQUE -- Unique delivery type name
);

-- Create the "order_statuses" table
CREATE TABLE "order_statuses" (
  "order_status_id" int PRIMARY KEY, -- ID for
