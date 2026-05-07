// Employee table stores worker information
Table employees {
  employee_id int [pk] // primary key for each employee
  first_name varchar // employee first name
  last_name varchar // employee last name
  ssn varchar [unique] // unique social security number
  role_id int // connects employee to their role
  access_token varchar // employee system access token
  hourly_rate decimal // employee hourly pay rate
}

// Stores possible employee roles
Table employee_roles {
  role_id int [pk] // primary key for each role
  role_name varchar [unique] // unique role name
}

// Customer table stores customer information
Table customers {
  customer_id int [pk] // primary key for each customer
  first_name varchar // customer first name
  last_name varchar // customer last name
  phone_number varchar // customer phone number
  loyalty_id int // connects customer to loyalty level
}

// Stores customer loyalty levels
Table loyalty_levels {
  loyalty_id int [pk] // primary key for each loyalty level
  loyalty_name varchar [unique] // unique loyalty level name
}

// Stores store or warehouse locations
Table locations {
  location_id int [pk] // primary key for each location
  location_name varchar [unique] // unique location name
}

// Stores clothing brands
Table brands {
  brand_id int [pk] // primary key for each brand
  brand_name varchar [unique] // unique brand name
}

// Stores clothing categories
Table categories {
  category_id int [pk] // primary key for each category
  category_name varchar [unique] // unique category name
}

// Stores item colors
Table colors {
  color_id int [pk] // primary key for each color
  color_name varchar [unique] // unique color name
}

// Stores item sizes
Table sizes {
  size_id int [pk] // primary key for each size
  size_name varchar [unique] // unique size name
}

// Stores general clothing item information
Table clothing_items {
  item_id int [pk] // primary key for each clothing item
  item_name varchar // name of the clothing item
  brand_id int // connects item to brand
  category_id int // connects item to category
  color_id int // connects item to color
  size_id int // connects item to size
  price decimal // item price
}

// Stores each physical item unit using RFID
Table item_units {
  rfid varchar [pk] // primary key RFID for each item unit
  item_id int // connects unit to clothing item
  location_id int // connects unit to location
  unit_status_id int // connects unit to status
}

// Stores statuses for item units
Table unit_statuses {
  unit_status_id int [pk] // primary key for each unit status
  status_name varchar [unique] // unique status name
}

// Stores inventory counts for each item
Table inventory {
  item_id int [pk] // primary key and link to clothing item
  quantity_available int // amount currently available
  reorder_level int // minimum amount before reorder
  future_shipment_quantity int // amount expected in future shipments
}

// Stores customer orders
Table orders {
  order_id int [pk] // primary key for each order
  customer_id int // connects order to customer
  employee_id int // connects order to employee
  order_date timestamp // date and time order was placed
  delivery_type_id int // connects order to delivery type
  order_status_id int // connects order to order status
}

// Stores items inside each order
Table order_items {
  order_item_id int [pk] // primary key for each order item
  order_id int // connects item to order
  item_id int // connects to clothing item
  quantity int // number of items ordered
  unit_price decimal // price per item at purchase time
}

// Stores delivery type options
Table delivery_types {
  delivery_type_id int [pk] // primary key for delivery type
  delivery_type_name varchar [unique] // unique delivery type name
}

// Stores order status options
Table order_statuses {
  order_status_id int [pk] // primary key for order status
  status_name varchar [unique] // unique order status name
}

// Stores completed sale information
Table sales {
  sale_id int [pk] // primary key for each sale
  order_id int [unique] // one sale connects to one order
  payment_method_id int // connects sale to payment method
  sale_date timestamp // date and time of sale
  total_amount decimal // total sale amount
}

// Stores payment methods
Table payment_methods {
  payment_method_id int [pk] // primary key for payment method
  payment_method_name varchar [unique] // unique payment method name
}

// Stores employee commission information
Table commissions {
  commission_id int [pk] // primary key for each commission
  employee_id int // connects commission to employee
  order_id int [unique] // one commission per order
  commission_amount decimal // commission amount earned
}

// Stores supplier information
Table suppliers {
  supplier_id int [pk] // primary key for each supplier
  supplier_name varchar // supplier name
  phone_number varchar // supplier phone number
  email varchar // supplier email
}

// Junction table connecting suppliers and items
Table supplier_items {
  supplier_id int // connects to supplier
  item_id int // connects to clothing item

  indexes {
    (supplier_id, item_id) [pk] // composite primary key
  }
}

// Stores restock orders from suppliers
Table restock_orders {
  restock_id int [pk] // primary key for each restock order
  supplier_id int // connects restock order to supplier
  order_date timestamp // date restock order was placed
  expected_arrival timestamp // expected arrival date
  restock_status_id int // connects to restock status
}

// Stores items inside restock orders
Table restock_order_items {
  restock_item_id int [pk] // primary key for each restock item
  restock_id int // connects to restock order
  item_id int // connects to clothing item
  quantity_ordered int // amount ordered
}

// Stores restock status options
Table restock_statuses {
  restock_status_id int [pk] // primary key for restock status
  status_name varchar [unique] // unique restock status name
}

// Employee role relationship
Ref: employees.role_id > employee_roles.role_id // many employees can have one role

// Customer loyalty relationship
Ref: customers.loyalty_id > loyalty_levels.loyalty_id // many customers can have one loyalty level

// Clothing item lookup relationships
Ref: clothing_items.brand_id > brands.brand_id // many items can have one brand
Ref: clothing_items.category_id > categories.category_id // many items can have one category
Ref: clothing_items.color_id > colors.color_id // many items can have one color
Ref: clothing_items.size_id > sizes.size_id // many items can have one size

// Item unit relationships
Ref: item_units.item_id > clothing_items.item_id // many units can belong to one item
Ref: item_units.location_id > locations.location_id // many units can be at one location
Ref: item_units.unit_status_id > unit_statuses.unit_status_id // many units can share one status

// Inventory relationship
Ref: inventory.item_id - clothing_items.item_id // one inventory record per clothing item

// Order relationships
Ref: orders.customer_id > customers.customer_id // many orders can belong to one customer
Ref: orders.employee_id > employees.employee_id // many orders can be handled by one employee
Ref: orders.delivery_type_id > delivery_types.delivery_type_id // many orders can use one delivery type
Ref: orders.order_status_id > order_statuses.order_status_id // many orders can share one status

// Order item relationships
Ref: order_items.order_id > orders.order_id // many order items can belong to one order
Ref: order_items.item_id > clothing_items.item_id // many order items can reference one clothing item

// Sales relationships
Ref: sales.order_id - orders.order_id // one sale connects to one order
Ref: sales.payment_method_id > payment_methods.payment_method_id // many sales can use one payment method

// Commission relationships
Ref: commissions.employee_id > employees.employee_id // many commissions can belong to one employee
Ref: commissions.order_id > orders.order_id // commission connects to an order

// Supplier item relationships
Ref: supplier_items.supplier_id > suppliers.supplier_id // many supplier item rows can belong to one supplier
Ref: supplier_items.item_id > clothing_items.item_id // many supplier item rows can belong to one item

// Restock order relationships
Ref: restock_orders.supplier_id > suppliers.supplier_id // many restock orders can come from one supplier
Ref: restock_orders.restock_status_id > restock_statuses.restock_status_id // many restock orders can share one status
Ref: restock_order_items.restock_id > restock_orders.restock_id // many restock items can belong to one restock order
Ref: restock_order_items.item_id > clothing_items.item_id // many restock items can reference one clothing item
