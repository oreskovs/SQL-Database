-- Subquery in WHERE clause


-- With Comparison operators.
-- Task:01 = Find the products that have a price higher than the average price of all products.

-- Main Query
SELECT 
	ProductID,
	Price
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)


-- With Logical operators
-- Task:02 = Show the details of orders made by customers in Germany.

-- Main Query
SELECT 
	*
FROM Sales.Orders
WHERE CustomerID IN
	-- SubQuery
	(SELECT 
		CustomerID
	FROM Sales.Customers
	WHERE Country = 'Germany')

-- Task:03 = Show the details of orders for customers who are not from Germany.

-- Main Query
SELECT 
	*
FROM Sales.Orders
WHERE CustomerID NOT IN
	-- SubQuery
	(SELECT 
		CustomerID
	FROM Sales.Customers
	WHERE Country = 'Germany')

-- ANY Operator = Checks if a value matches ANY value within a list.

-- Task:04 = Find female employees whose salaries are greater 
-- than the salaries of any male employees.

-- Main Query
SELECT 
	EmployeeID,
	FirstName,
	Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender = 'M')

SELECT FirstName, Salary FROM Sales.Employees WHERE Gender = 'M'


-- ALL Operator = Checks if a value matches ALL values within a list.

-- Task:05 = Find female employees whose salaries are greater 
-- than the salaries of all male employees.

-- Main Query
SELECT 
	EmployeeID,
	FirstName,
	Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ALL (SELECT Salary FROM Sales.Employees WHERE Gender = 'M')

SELECT FirstName, Salary FROM Sales.Employees WHERE Gender = 'M'