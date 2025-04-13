-- Window Functions Basics = Perform calculations within a window
-- Can be used only in SELECT and ORDER BY Clauses
-- Nesting Window Functions is not allowed!


-- Task:01 = Find the total Sales Across all orders.
SELECT 
	SUM(Sales) TotalSales
FROM Sales.Orders

-- Task:02 = Find the total sales for each product.
SELECT 
	ProductID,
	SUM(Sales) TotalSales
FROM Sales.Orders
GROUP BY ProductID

-- PARTITON BY
-- Task:03 = Find the total sales for each product. 
		  -- Additionally provide details such order Id, orderDate

SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders

-- Task:04 = Find the total sales across all orders 
           --additionally provide details such order id & order date
SELECT 
	OrderID,
	OrderDate,
	SUM(Sales) OVER() TotalSales
FROM Sales.Orders

-- Task:05 = Find the total sales for each product,
		  -- Additionally provide details such orderid & orderdate
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) AS TotalSales
FROM Sales.Orders

-- Task:06 = Find the total sales for each combination of product and order status

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) SalesByProductsAndStatus
FROM Sales.Orders

-- ORDER BY = Sort data within a window (ASCENDING | DESCENDING)

-- Task:07 = Rank each order based on their sales from highest to lowest.
		  -- Additionally provide details such orderid & orderdate

SELECT 
	OrderID,
	OrderDate,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders

-- WINDOW FRAME = Defines a subset of rows within each window that is relevant for calculation

SELECT 
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders

-- SQL execute WINDOW Functions after WHERE Clause!

-- Task:08 = Find the total sales for each order status, only for two products 101 and 102.
SELECT 
	OrderID,
	OrderStatus,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN (101,102)

-- Window Function can be used together with GROUP BY in the same query,
-- ONLY if the same columns are used.

-- Task:09 = Rank customers based on their total sales 

SELECT 
	CustomerID,
	SUM(Sales)  TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID
