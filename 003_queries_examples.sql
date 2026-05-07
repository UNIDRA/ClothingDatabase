
-- TRIGGER
-- TRIGGER: Reduce inventory quantity after an item is added to an order
CREATE OR REPLACE FUNCTION reduce_inventory_after_order()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE inventory
  SET quantity_available = quantity_available - NEW.quantity
  WHERE item_id = NEW.item_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER: Run inventory update after inserting an order item
CREATE TRIGGER trg_reduce_inventory_after_order
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION reduce_inventory_after_order();
-- VIEW
-- VIEW: Show item details with brand, category, color, size, and stock
CREATE OR REPLACE VIEW item_inventory_view AS
SELECT
  ci.item_id,
  ci.item_name,
  b.brand_name,
  c.category_name,
  co.color_name,
  s.size_name,
  ci.price,
  i.quantity_available,
  i.reorder_level,
  i.future_shipment_quantity
FROM clothing_items ci
JOIN brands b ON ci.brand_id = b.brand_id
JOIN categories c ON ci.category_id = c.category_id
JOIN colors co ON ci.color_id = co.color_id
JOIN sizes s ON ci.size_id = s.size_id
JOIN inventory i ON ci.item_id = i.item_id;
-- READ QUERIES
-- READ: Show all clothing items with full item details
SELECT *
FROM item_inventory_view;

-- READ: Show orders with customer and employee names
SELECT
  o.order_id,
  c.first_name AS customer_first_name,
  c.last_name AS customer_last_name,
  e.first_name AS employee_first_name,
  e.last_name AS employee_last_name,
  o.order_date,
  os.status_name AS order_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN employees e ON o.employee_id = e.employee_id
JOIN order_statuses os ON o.order_status_id = os.order_status_id;

-- READ: Show order items with item names and total line price
SELECT
  oi.order_id,
  ci.item_name,
  oi.quantity,
  oi.unit_price,
  (oi.quantity * oi.unit_price) AS line_total
FROM order_items oi
JOIN clothing_items ci ON oi.item_id = ci.item_id;

-- READ: Show low stock items that need restocking
SELECT
  ci.item_name,
  i.quantity_available,
  i.reorder_level
FROM inventory i
JOIN clothing_items ci ON i.item_id = ci.item_id
WHERE i.quantity_available <= i.reorder_level;

-- READ: Show sales with payment method and order total
SELECT
  s.sale_id,
  s.order_id,
  pm.payment_method_name,
  s.sale_date,
  s.total_amount
FROM sales s
JOIN payment_methods pm ON s.payment_method_id = pm.payment_method_id;

-- READ: Show suppliers and the items they provide
SELECT
  sup.supplier_name,
  ci.item_name,
  ci.price
FROM supplier_items si
JOIN suppliers sup ON si.supplier_id = sup.supplier_id
JOIN clothing_items ci ON si.item_id = ci.item_id;
-- UPDATE QUERIES
-- UPDATE: Change a customer phone number
UPDATE customers
SET phone_number = '555-222-1000'
WHERE customer_id = 1;

-- UPDATE: Change an employee hourly rate
UPDATE employees
SET hourly_rate = 22.50
WHERE employee_id = 1;

-- UPDATE: Update an order status to completed
UPDATE orders
SET order_status_id = 2
WHERE order_id = 1;

-- UPDATE: Update inventory after receiving shipment
UPDATE inventory
SET quantity_available = quantity_available + future_shipment_quantity,
    future_shipment_quantity = 0
WHERE item_id = 1;

-- UPDATE: Change the price of a clothing item
UPDATE clothing_items
SET price = 49.99
WHERE item_id = 1;

-- UPDATE: Update restock order expected arrival date
UPDATE restock_orders
SET expected_arrival = '2026-05-15 10:00:00'
WHERE restock_id = 1;
-- DELETE QUERIES
-- DELETE: Remove a commission record for a canceled order
DELETE FROM commissions
WHERE order_id = 1;

-- DELETE: Remove order items from a canceled order
DELETE FROM order_items
WHERE order_id = 1;

-- DELETE: Remove the canceled order before deleting its sale
DELETE FROM orders
WHERE order_id = 1;

-- DELETE: Remove sale record after deleting related order
DELETE FROM sales
WHERE order_id = 1;

-- DELETE: Remove a supplier item relationship
DELETE FROM supplier_items
WHERE supplier_id = 1
  AND item_id = 1;

-- DELETE: Remove restock order items for a canceled restock order
DELETE FROM restock_order_items
WHERE restock_id = 1;
