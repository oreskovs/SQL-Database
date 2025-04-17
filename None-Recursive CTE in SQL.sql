-- Common Table Expression CTE = Temporary, named result set(virtual table), that can be used multiple times within a query.

-- None-Recursive CTE = CTE that is executed only one without any repetition.

	--1.Standalone CTE = Defined and Used independently.

-- PROJECT:1
-- STEP1: Find the total Sales Per Customer. (Standalone CTE)

WITH CTE_TotalSales AS 
(
	SELECT 
		CustomerID,
		SUM(Sales) AS TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
)

-- STEP2: Find the last order date per customer. (Standalone CTE)

, CTE_Last_Order AS
(
	SELECT 
		CustomerID,
		MAX(OrderDate) AS LastOrder
	FROM Sales.Orders
	GROUP BY CustomerID

)

	--2.Nested CTE = CTE inside another CTE 
-- STEP3: Rank customers based on total sales per customer.(Nested CTE)

, CTE_Customer_Rank AS
(
	SELECT 
		CustomerID,
		TotalSales,
		RANK() OVER(ORDER BY TotalSales DESC) AS CustomerRank
	FROM CTE_TotalSales
)

-- STEP4: Segment customers based on their total sales.(Nested CTE)

, CTE_Customer_Segments AS
(
	SELECT 
		CustomerID,
		TotalSales,
			CASE WHEN TotalSales > 100 THEN 'High'
				 WHEN TotalSales > 80 THEN 'Medium'
				 ELSE 'Low'
			END CustomerSegments
	FROM CTE_TotalSales
)



--Main Query
SELECT 
	 c.CustomerID,
	 c.FirstName,
	 c.LastName,
	 cts.TotalSales,
	 clo.LastOrder,
	 ccr.CustomerRank,
	 ccs.CustomerSegments
FROM Sales.Customers c 
LEFT JOIN CTE_TotalSales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
ON clo.CustomerID = c.CustomerID 
LEFT JOIN CTE_Customer_Rank ccr
ON ccr.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segments ccs
ON ccs.CustomerID = c.CustomerID









