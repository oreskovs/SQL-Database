--SET Operator - Combining the results of multiple queries into a single result set (rows)
--RULES FOR SET OPERATOR:
--ORDER BY can be used only once
--The number of the rows must be equal
--Data types of columns in each query must be compatible
--The order of the columns in each query must be the same 

-- UNION = Returns all district rows from both queries (Return all rows from both tables)
-- Will remove all duplicate rows
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

UNION

SELECT 
	FirstName,
	LastName
FROM Sales.Employees

-- TASK:1 = Combine the data from employees and customers into one table.
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

UNION

SELECT 
	FirstName,
	LastName
FROM Sales.Employees

-- UNION ALL = Returns all rows from both queries, including duplicates.
--Combine the data from employees and customers into one table, including duplicates.
SELECT 
	FirstName,
	LastName
FROM Sales.Customers
UNION ALL
SELECT 
	FirstName,
	LastName
FROM Sales.Employees

-- EXCEPT = Returns all distinct rows from the first query that are not found in the second query
-- Find employees who are not customers at the same time 
SELECT 
	FirstName,
	LastName
FROM Sales.Employees
EXCEPT
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

-- INTERSECT = Returns only the rows that are common in both queries.
-- Find empolyees who are also customers.
SELECT
	FirstName,
	LastName
FROM Sales.Customers
INTERSECT
SELECT 
	FirstName,
	LastName
FROM Sales.Employees

-- TASK:2 = Combine all orders into one report without duplicates (Orders data are stored in separte tables Orders and OrdersArchive)
SELECT 
	'Orders' AS SourceTable,
	[OrderID],
	[ProductID],
	[CustomerID],
	[SalesPersonID],
	[OrderDate],
	[ShipDate],
	[OrderStatus],
	[ShipAddress],
	[BillAddress],
	[Quantity],
	[Sales],
	[CreationTime]
FROM Sales.Orders
UNION
SELECT  
	'OrdersArchive' AS SourceTable,
	[OrderID],
	[ProductID],
	[CustomerID],
	[SalesPersonID],
	[OrderDate],
	[ShipDate],
	[OrderStatus],
	[ShipAddress],
	[BillAddress],
	[Quantity],
	[Sales],
	[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID

-- DELTA DETECTION = Identifying the differences or changes between two brenches of data
