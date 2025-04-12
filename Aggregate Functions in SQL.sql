-- Aggregate Functions 

-- Task:01 = Find the total number of customers
SELECT 
	COUNT(*) AS TotalNumberOfOrders
FROM orders 

-- Task:02 = Find the total sales of all orders
SELECT 
	SUM(sales) AS TotalSales
FROM orders

-- Task:03 = Find the average sales of all orders.
SELECT 
	AVG(sales) AS AvgSales
FROM orders

-- Task:04 = Find the highest sale among customers
SELECT 
	MAX(sales) AS HighestSale
FROM orders

-- Task:05 = Find the lowest sale among customers.
SELECT 
	MIN(sales) AS LowestSale
FROM orders