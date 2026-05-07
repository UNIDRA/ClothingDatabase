CREATE TABLE "employees" (
  "employee_id" int PRIMARY KEY,
  "first_name" varchar,
  "last_name" varchar,
  "ssn" varchar UNIQUE,
  "role_id" int,
  "access_token" varchar,
  "hourly_rate" decimal
);

CREATE TABLE "employee_roles" (
  "role_id" int PRIMARY KEY,
  "role_name" varchar UNIQUE
);

CREATE TABLE "customers" (
  "customer_id" int PRIMARY KEY,
  "first_name" varchar,
  "last_name" varchar,
  "phone_number" varchar,
  "loyalty_id" int
);

CREATE TABLE "loyalty_levels" (
  "loyalty_id" int PRIMARY KEY,
  "loyalty_name" varchar UNIQUE
);

CREATE TABLE "locations" (
  "location_id" int PRIMARY KEY,
  "location_name" varchar UNIQUE
);

CREATE TABLE "brands" (
  "brand_id" int PRIMARY KEY,
  "brand_name" varchar UNIQUE
);

CREATE TABLE "categories" (
  "category_id" int PRIMARY KEY,
  "category_name" varchar UNIQUE
);

CREATE TABLE "colors" (
  "color_id" int PRIMARY KEY,
  "color_name" varchar UNIQUE
);

CREATE TABLE "sizes" (
  "size_id" int PRIMARY KEY,
  "size_name" varchar UNIQUE
);

CREATE TABLE "clothing_items" (
  "item_id" int PRIMARY KEY,
  "item_name" varchar,
  "brand_id" int,
  "category_id" int,
  "color_id" int,
  "size_id" int,
  "price" decimal
);

CREATE TABLE "item_units" (
  "rfid" varchar PRIMARY KEY,
  "item_id" int,
  "location_id" int,
  "unit_status_id" int
);

CREATE TABLE "unit_statuses" (
  "unit_status_id" int PRIMARY KEY,
  "status_name" varchar UNIQUE
);

CREATE TABLE "inventory" (
  "item_id" int PRIMARY KEY,
  "quantity_available" int,
  "reorder_level" int,
  "future_shipment_quantity" int
);

CREATE TABLE "orders" (
  "order_id" int PRIMARY KEY,
  "customer_id" int,
  "employee_id" int,
  "order_date" timestamp,
  "delivery_type_id" int,
  "order_status_id" int
);

CREATE TABLE "order_items" (
  "order_item_id" int PRIMARY KEY,
  "order_id" int,
  "item_id" int,
  "quantity" int,
  "unit_price" decimal
);

CREATE TABLE "delivery_types" (
  "delivery_type_id" int PRIMARY KEY,
  "delivery_type_name" varchar UNIQUE
);

CREATE TABLE "order_statuses" (
  "order_status_id" int PRIMARY KEY,
  "status_name" varchar UNIQUE
);

CREATE TABLE "sales" (
  "sale_id" int PRIMARY KEY,
  "order_id" int UNIQUE,
  "payment_method_id" int,
  "sale_date" timestamp,
  "total_amount" decimal
);

CREATE TABLE "payment_methods" (
  "payment_method_id" int PRIMARY KEY,
  "payment_method_name" varchar UNIQUE
);

CREATE TABLE "commissions" (
  "commission_id" int PRIMARY KEY,
  "employee_id" int,
  "order_id" int UNIQUE,
  "commission_amount" decimal
);

CREATE TABLE "suppliers" (
  "supplier_id" int PRIMARY KEY,
  "supplier_name" varchar,
  "phone_number" varchar,
  "email" varchar
);

CREATE TABLE "supplier_items" (
  "supplier_id" int,
  "item_id" int,
  PRIMARY KEY ("supplier_id", "item_id")
);

CREATE TABLE "restock_orders" (
  "restock_id" int PRIMARY KEY,
  "supplier_id" int,
  "order_date" timestamp,
  "expected_arrival" timestamp,
  "restock_status_id" int
);

CREATE TABLE "restock_order_items" (
  "restock_item_id" int PRIMARY KEY,
  "restock_id" int,
  "item_id" int,
  "quantity_ordered" int
);

CREATE TABLE "restock_statuses" (
  "restock_status_id" int PRIMARY KEY,
  "status_name" varchar UNIQUE
);

ALTER TABLE "employees" ADD FOREIGN KEY ("role_id") REFERENCES "employee_roles" ("role_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "customers" ADD FOREIGN KEY ("loyalty_id") REFERENCES "loyalty_levels" ("loyalty_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clothing_items" ADD FOREIGN KEY ("brand_id") REFERENCES "brands" ("brand_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clothing_items" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clothing_items" ADD FOREIGN KEY ("color_id") REFERENCES "colors" ("color_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clothing_items" ADD FOREIGN KEY ("size_id") REFERENCES "sizes" ("size_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "item_units" ADD FOREIGN KEY ("item_id") REFERENCES "clothing_items" ("item_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "item_units" ADD FOREIGN KEY ("location_id") REFERENCES "locations" ("location_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "item_units" ADD FOREIGN KEY ("unit_status_id") REFERENCES "unit_statuses" ("unit_status_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clothing_items" ADD FOREIGN KEY ("item_id") REFERENCES "inventory" ("item_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "orders" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("customer_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "orders" ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("employee_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "orders" ADD FOREIGN KEY ("delivery_type_id") REFERENCES "delivery_types" ("delivery_type_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "orders" ADD FOREIGN KEY ("order_status_id") REFERENCES "order_statuses" ("order_status_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "order_items" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "order_items" ADD FOREIGN KEY ("item_id") REFERENCES "clothing_items" ("item_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "orders" ADD FOREIGN KEY ("order_id") REFERENCES "sales" ("order_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "sales" ADD FOREIGN KEY ("payment_method_id") REFERENCES "payment_methods" ("payment_method_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "commissions" ADD FOREIGN KEY ("employee_id") REFERENCES "employees" ("employee_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "commissions" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "supplier_items" ADD FOREIGN KEY ("supplier_id") REFERENCES "suppliers" ("supplier_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "supplier_items" ADD FOREIGN KEY ("item_id") REFERENCES "clothing_items" ("item_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "restock_orders" ADD FOREIGN KEY ("supplier_id") REFERENCES "suppliers" ("supplier_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "restock_orders" ADD FOREIGN KEY ("restock_status_id") REFERENCES "restock_statuses" ("restock_status_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "restock_order_items" ADD FOREIGN KEY ("restock_id") REFERENCES "restock_orders" ("restock_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "restock_order_items" ADD FOREIGN KEY ("item_id") REFERENCES "clothing_items" ("item_id") DEFERRABLE INITIALLY IMMEDIATE;
