-- Subquery = Query inside query 

-- Result Types Subqueries
	-- 1. Scalar Subquery = Returns single value

--EX:Scalar Subquery 
SELECT 
	AVG(Sales)
FROM Sales.Orders

	-- 2. Row Subquery = Returns multiple rows and single column

--EX: Row Subquery
SELECT 
	CustomerID
FROM Sales.Orders

	-- 3. Table Subquery = Returns multiple rows and multiple columns
--EX: Table Subquery
SELECT 
	OrderID,
	OrderDate
FROM Sales.Orders

-- Subquery in FROM Clause

-- Task:01 = Find the products that have a price higher than the average price of all products.

SELECT * FROM(
	SELECT 
		ProductID,
		Price,
		AVG(Price) OVER() AvgPrice
	FROM Sales.Products
)t WHERE Price > AvgPrice

-- Task:02 = Rank customers based on their total amount of sales

SELECT *,
RANK() OVER(ORDER BY TotalSales DESC) RankedBySales
FROM(
	SELECT 
		CustomerID,
		SUM(Sales) TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
)t 

-- Subquery in SELECT Clause = Must return one value 

-- Task:03 = Show the product IDs, names, prices and total number of orders.

--Main Query
SELECT 
	ProductID,
	Product,
	Price,
-- Subquery
	(SELECT COUNT(*) FROM Sales.Orders) TotalOrders
FROM Sales.Products

-- Subquery in JOIN Clause

-- Task:04 = Show all customer details and find the total orders for each customer.

--Main Query
SELECT 
	c.*,
	o.TotalOrders
FROM Sales.Customers c
LEFT JOIN (
	SELECT 
		CustomerID,
		COUNT(*) TotalOrders
	FROM Sales.Orders
	GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID