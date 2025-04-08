-- NO JOIN = Returns data from tables without combining them
--Retrieve all data from customers and orders in two different results 
SELECT * FROM customers

SELECT * FROM orders

--iNNER JOIN = Returns only matching rows from both tables
--Get all customers along with their orders, but only for customers who have placed an order
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id

--LEFT JOIN = Return all rows from LEFT and only matching data from the RIGHT table.
--Get all customers along with their orders,including those without orders

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o 
ON c.id = o.customer_id

--RIGHT JOIN = Returns all rows from RIGHT and only matching data from the LEFT table
--Get all customers along with their orders, including orders without matching customers.

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id

-- USE LEFT JOIN
--Get all customers along with their orders, including orders without matching customers.

SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM orders AS O 
LEFT JOIN customers AS c
ON c.id = o.customer_id

-- FULL JOIN = Returns all rows from both tables
-- Get all customers and all orders, even if there is no match

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
