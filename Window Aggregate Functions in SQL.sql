-- Window Aggregate Functions

-- COUNT(*) = Returns the number of rows within a window.
-- COUNT(column) = Counts the number of non-NULL values in the column.

-- Task:01 = Find the total number of orders.
SELECT 
	COUNT(*) TotalOrders
FROM Sales.Orders

-- Task:02 = Find the total number of orders and 
		  -- additionally provide details such order id & order date

SELECT 
	OrderID,
	OrderDate,
	COUNT(*) OVER() TotalOrders
FROM Sales.Orders

-- Task:03 = Find the total number of Customers
		  -- Additionally provide All customers Details

SELECT 
	*,
	COUNT(*) OVER() TotalNumOfCustomers
FROM Sales.Customers

-- SUM() = Returns the sum of values within a window.

-- Task:04 = Find the total sales across all orders and the total sales for each product.

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) OVER() TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesPerProduct
FROM Sales.Orders

-- Task:05 = Find the percentage contribution of each product`s sales to the total sales
SELECT
	OrderID,
	ProductID,
	Sales,
	SUM(Sales) OVER() TotalSales,
	ROUND(CAST(Sales AS Float) / SUM(Sales) OVER() * 100, 2) PercentageTotal
FROM Sales.Orders

-- AVG() = Returns the average of values within a window.

-- Task:06 = Find the average sales across all orders.
		  -- And Find the average sales for each product.
		  -- Additionally provide details such orderID, OrderDate.

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	AVG(Sales) OVER() AvgSales,
	AVG(Sales) OVER(PARTITION BY ProductID) AvgProductSale
FROM Sales.Orders

-- Task:07 = Find the average scores of customers
		  -- Additionally provide details such CustomerID and LastName

SELECT 
	CustomerID,
	LastName,
	Score,
	AVG(COALESCE(Score, 0)) OVER() AvgScore
FROM Sales.Customers

-- Task:08 = Find all orders where sales are higher than the average sales across all orders.

SELECT 
*
FROM(
	SELECT 
		OrderID,
		ProductID,
		Sales,
		AVG(Sales) OVER() AvgSales
	FROM Sales.Orders
)t WHERE Sales > AvgSales	

-- MIN() = Returns the lowest value within a window.
-- MAX() = Returns the highest value within a window.

-- Task:09 = Find the highest and lowest sales of all orders
		  -- Find the highest and lowest sales for each product
		  -- Additionally provide details such OrderID, OrderDate

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER() HighestSale,
	MIN(Sales) OVER() LowestSale,
	MAX(Sales) OVER(PARTITION BY ProductID) HighestSaleByProduct,
	MIN(Sales) OVER(PARTITION BY ProductID) LowestSaleByProduct
FROM Sales.Orders

-- Task:10 = Show the employees who have the highest salaries.
SELECT *
FROM(
SELECT 
	EmployeeID,
	FirstName,
	LastName,
	Salary,
	MAX(Salary) OVER() HighestSalary 
FROM Sales.Employees
)t WHERE Salary = HighestSalary

-- Running & Rolling Total

-- Task:11 = Calculate the moving average of sales for each product over time
SELECT 
	OrderID,
	ProductID,
	OrderDate,
	Sales,
	AVG(Sales) OVER(PARTITION BY ProductID) AvgSalesByProduct,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovingAVG
FROM Sales.Orders

-- Task:12 = Calculate the moving average of sales for each product over time,
		  -- Including only the next order.

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate 
		ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAVG
FROM Sales.Orders