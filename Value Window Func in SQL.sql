-- VALUE WINDOW FUNCTIONS 
-- Rules:
	-- 1.Expression = Any data type
	-- 2.ORDER BY = Required
	-- 3.FRAME = Optional

-- LAG() = Acces a value from the previous row within a window.

-- Task:01 = Analyze the month-over-month performance by finding the percentage change in sales, 
		  -- between the current and previous month.
SELECT *, 
CurrentMonthSales - PreviousMonthSales AS MoM_Change,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT) / PreviousMonthSales * 100, 1) AS MoM_Perc
FROM( 
	SELECT 
		MONTH(OrderDate) OrderMonth,
		SUM(Sales) CurrentMonthSales,
		LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
	FROM Sales.Orders
	GROUP BY MONTH(OrderDate)
)t

-- LEAD() = Access a value from the next row within a window.

-- Task:02 = In order to analyze customer loyalty,
		  -- rank customers based on the average days between their orders.
SELECT
CustomerID,
AVG(DaysBetweenOrders) AvgDays,
RANK() OVER(ORDER BY COALESCE(AVG(DaysBetweenOrders), 9999999)) RankAVG
FROM(
	SELECT 
		OrderID,
		CustomerID, 
		OrderDate CurrentOrder,
		LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
		DATEDIFF(day, OrderDate,LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DaysBetweenOrders
	FROM Sales.Orders
)t
GROUP BY CustomerID


-- FIRST_VALUE() = Access a value from the first row within a window.
-- LAST_VALUE() = Access a value from the last row within a window.

-- Task:03 = Find the lowest and highest sales for each product.
SELECT 
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSale,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales 
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSale
FROM Sales.Orders

-- Another solution of task number 3:

SELECT 
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSale,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) HighestSale
FROM Sales.Orders

-- Task:04 = Find the lowest and highest sales for each product,
		  -- and find the difference in sales between the current and the lowest sales

SELECT 
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSale,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales 
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSale,
	Sales - FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) SalesDiff
FROM Sales.Orders


