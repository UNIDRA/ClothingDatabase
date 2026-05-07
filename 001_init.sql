// Employee info
Table employees {
  employee_id int [pk] // employee ID
  first_name varchar // first name
  last_name varchar // last name
  ssn varchar [unique] // unique SSN
  role_id int // role link
  access_token varchar // login token
  hourly_rate decimal // pay rate
}

// Employee roles
Table employee_roles {
  role_id int [pk] // role ID
  role_name varchar [unique] // role name
}

// Customer info
Table customers {
  customer_id int [pk] // customer ID
  first_name varchar
  last_name varchar
  phone_number varchar
  loyalty_id int // loyalty link
}

// Loyalty levels
Table loyalty_levels {
  loyalty_id int [pk]
  loyalty_name varchar [unique]
}

// Store locations
Table locations {
  location_id int [pk]
  location_name varchar [unique]
}

// Brands
Table brands {
  brand_id int [pk]
  brand_name varchar [unique]
}

// Categories
Table categories {
  category_id int [pk]
  category_name varchar [unique]
}

// Colors
Table colors {
  color_id int [pk]
  color_name varchar [unique]
}

// Sizes
Table sizes {
  size_id int [pk]
  size_name varchar [unique]
}

// Clothing items
Table clothing_items {
  item_id int [pk]
  item_name varchar
  brand_id int // brand link
  category_id int // category link
  color_id int // color link
  size_id int // size link
  price decimal
}

// Physical item units
Table item_units {
  rfid varchar [pk] // RFID tag
  item_id int
  location_id int
  unit_status_id int
}

// Unit statuses
Table unit_statuses {
  unit_status_id int [pk]
  status_name varchar [unique]
}

// Inventory counts
Table inventory {
  item_id int [pk]
  quantity_available int
  reorder_level int
  future_shipment_quantity int
}

// Orders
Table orders {
  order_id int [pk]
  customer_id int
  employee_id int
  order_date timestamp
  delivery_type_id int
  order_status_id int
}

// Items in orders
Table order_items {
  order_item_id int [pk]
  order_id int
  item_id int
  quantity int
  unit_price decimal
}

// Delivery methods
Table delivery_types {
  delivery_type_id int [pk]
  delivery_type_name varchar [unique]
}

// Order statuses
Table order_statuses {
  order_status_id int [pk]
  status_name varchar [unique]
}

// Sales
Table sales {
  sale_id int [pk]
  order_id int [unique]
  payment_method_id int
  sale_date timestamp
  total_amount decimal
}

// Payment methods
Table payment_methods {
  payment_method_id int [pk]
  payment_method_name varchar [unique]
}

// Employee commissions
Table commissions {
  commission_id int [pk]
  employee_id int
  order_id int [unique]
  commission_amount decimal
}

// Suppliers
Table suppliers {
  supplier_id int [pk]
  supplier_name varchar
  phone_number varchar
  email varchar
}

// Supplier-item links
Table supplier_items {
  supplier_id int
  item_id int

  indexes {
    (supplier_id, item_id) [pk] // composite PK
  }
}

// Restock orders
Table restock_orders {
  restock_id int [pk]
  supplier_id int
  order_date timestamp
  expected_arrival timestamp
  restock_status_id int
}

// Restock items
Table restock_order_items {
  restock_item_id int [pk]
  restock_id int
  item_id int
  quantity_ordered int
}

// Restock statuses
Table restock_statuses {
  restock_status_id int [pk]
  status_name varchar [unique]
}

// Relationships
Ref: employees.role_id > employee_roles.role_id
Ref: customers.loyalty_id > loyalty_levels.loyalty_id

Ref: clothing_items.brand_id > brands.brand_id
Ref: clothing_items.category_id > categories.category_id
Ref: clothing_items.color_id > colors.color_id
Ref: clothing_items.size_id > sizes.size_id

Ref: item_units.item_id > clothing_items.item_id
Ref: item_units.location_id > locations.location_id
Ref: item_units.unit_status_id > unit_statuses.unit_status_id

Ref: inventory.item_id - clothing_items.item_id

Ref: orders.customer_id > customers.customer_id
Ref: orders.employee_id > employees.employee_id
Ref: orders.delivery_type_id > delivery_types.delivery_type_id
Ref: orders.order_status_id > order_statuses.order_status_id

Ref: order_items.order_id > orders.order_id
Ref: order_items.item_id > clothing_items.item_id

Ref: sales.order_id - orders.order_id
Ref: sales.payment_method_id > payment_methods.payment_method_id

Ref: commissions.employee_id > employees.employee_id
Ref: commissions.order_id > orders.order_id

Ref: supplier_items.supplier_id > suppliers.supplier_id
Ref: supplier_items.item_id > clothing_items.item_id

Ref: restock_orders.supplier_id > suppliers.supplier_id
Ref: restock_orders.restock_status_id > restock_statuses.restock_status_id
Ref: restock_order_items.restock_id > restock_orders.restock_id
Ref: restock_order_items.item_id > clothing_items.item_id
