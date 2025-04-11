-- WHAT IS NULL? = Null means nothing,unknown! Null is not equal to anything!
-- NULL Functions

-- ISNULL(value, replacement_value) = Replaces 'NULL' with a specific value.
-- COALESCE(value1, value2, value3,....) = Returns the first non-null value from a list.
 
 -- Task:01 = Find the average scores of the customers
SELECT 
	CustomerID,
	Score,
	COALESCE(Score,0) Score2,
	AVG(Score) OVER() AvgScores,
	AVG(COALESCE(Score,0)) OVER () AvgScores2
FROM Sales.Customers

-- Task:02 = 
/*
	Display the full name of customers in a single field by merging their first and last names.
	and add 10 bonus points to each customers`s score.
*/
SELECT 
	CustomerID,
	FirstName,
	LastName,
	FirstName + ' ' + COALESCE(LastName, '') AS FullName,
	Score,
	COALESCE(Score, 0) + 10 AS ScoreWithBonus
FROM Sales.Customers

-- Task:03 = Sort the customers from lowest to highest scores, with NULLs appearing last.
SELECT 
	CustomerID,
	Score
	--COALESCE(Score, 99999),
FROM Sales.Customers
--ORDER BY COALESCE(Score, 99999)
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score

-- NULLIF(value1, value2) = Compares two expressions returns:
	-- NULL,if they are equal.
	-- First value, if they are not equal

-- Find the sales price for each order by dividing the sales by the quantity.
SELECT 
	OrderID,
	Sales,
	Quantity,
	Sales / NULLIF(Quantity, 0) AS Price
FROM Sales.Orders

-- Identify the customers who have no scores.
SELECT *
FROM Sales.Customers
WHERE Score IS NULL

-- List all customers who have scores
SELECT * FROM Sales.Customers
WHERE Score IS NOT NULL


-- List all details for customers who have not placed any orders
SELECT c.*, o.OrderID
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL 

