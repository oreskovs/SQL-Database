-- Window Ranking Functions -- 
-- Expression must be empty.
-- PARTITION BY is optional.
-- ORDER BY is required.

-- ROW_NUMBER() = Assign a unique number to each row, and It doesn`t handle ties.

--Task:01 = Rank the orders based on their sales from highest to lowest.
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) RankedSales
FROM Sales.Orders

-- RANK() = Assign a rank to each row, and it handle ties.
		 -- It leaves gaps in ranking.

--Task:02 = Rank the orders based on their sales from highest to lowest.

SELECT 
	OrderID,
	ProductID,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) RankedSales
FROM Sales.Orders

-- DENSE_RANK() = Assign a rank to each row,and it handle ties.
			   -- It doesn`t leaves gaps in ranking.

--Task:02 = Rank the orders based on their sales from highest to lowest.

SELECT 
	OrderID,
	ProductID,
	Sales,
	DENSE_RANK() OVER(ORDER BY Sales DESC) RankedSales
FROM Sales.Orders

--TOP-N ANALYSIS
--Task:03 = Find the top highest sales for each product.

SELECT
*
FROM(
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankedSales
FROM Sales.Orders
)t WHERE RankedSales = 1

--BOTTOM-N ANALYSIS

--Task:04 = Find the lowest 2 customers based on their total sales.
SELECT *
FROM(
SELECT 
	CustomerID,
	SUM(Sales) TotalSales,
	ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankCustomers
FROM Sales.Orders
GROUP BY 
CustomerID
)t WHERE RankCustomers <=2

--Task:05 = Assign unique IDs to the rows of the Orders Archive table.
SELECT
ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) UniqueID,
*
FROM Sales.OrdersArchive

--Task:06 = Identify duplicate rows in the table Orders Archive,
		 -- and return a clean result without any duplicates.
SELECT * FROM(
SELECT
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,
* FROM Sales.OrdersArchive
)t WHERE rn=1

-- NTILE() = Divides the rows into a specified number of approximately equal groups.

SELECT 
	OrderID,
	Sales,
	NTILE(1) OVER(ORDER BY Sales DESC) OneBucket,
	NTILE(2) OVER(ORDER BY Sales DESC) TwoBuckets,
	NTILE(3) OVER(ORDER BY Sales DESC) ThreeBuckets,
	NTILE(4) OVER(ORDER BY Sales DESC) FourBuckets
FROM Sales.Orders

--Task:07 = Segment all orders into 3 categories: high,medium and low sales.
SELECT *,
CASE WHEN Buckets = 1 THEN 'High'
	 WHEN Buckets = 2 THEN 'Medium'
	 WHEN Buckets = 3 THEN 'Low'
END SalesSegmentations
FROM(
	SELECT 
		OrderID,
		ProductID,
		Sales,
		NTILE(3) OVER(ORDER BY Sales DESC) Buckets
	FROM Sales.Orders
)t

--Task:08 = In order to export data, divide the orders into 2 groups.
SELECT 
NTILE(2) OVER(ORDER BY OrderID) Buckets,
*	
FROM Sales.Orders