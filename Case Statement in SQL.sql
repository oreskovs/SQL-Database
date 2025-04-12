-- CASE Statement = Evaluates a list of conditions and returns a value when the first condition is met.

-- TASK:01 = Generate a report showing the total sales for each category:
		  -- High: If the sales higher than 50.
		  -- Medium: If the sales between 20 and 50.
		  -- Low: If the sales equal or lower than 20 .
		  -- Sort the results from highest to lowest.

SELECT 
Category,
SUM(Sales) AS TotalSales
FROM(
	SELECT 
		OrderID,
		Sales,
	CASE 
		WHEN Sales > 50 THEN 'High'
		WHEN Sales > 20 THEN 'Medium'
		ELSE 'Low' 
	END  Category
	FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC

-- TASK:02 = Retrieve employee details with gender displayed as full text

SELECT 
	EmployeeID,
	FirstName,
	LastName,
	Gender,
CASE 
	WHEN Gender = 'M' THEN 'Male'
	WHEN Gender = 'F' THEN 'Female'
	ELSE 'Not Avaiable'
END FullGenderName
FROM Sales.Employees

-- TASK:03 = Retrieve customer details with abbreviated country code.

SELECT 
	CustomerID,
	FirstName,
	LastName,
	Country,
CASE 
	WHEN Country = 'Germany' THEN 'GER'
	WHEN Country = 'USA' THEN 'US'
	ELSE 'N/A'
END AbbriviatedCountryName
FROM Sales.Customers

-- Quick Form

SELECT 
	CustomerID,
	FirstName,
	LastName,
	Country,
CASE Country
	WHEN 'Germany' THEN 'GER'
	WHEN 'USA' THEN 'US'
	ELSE 'N/A'
END AbbriviatedCountryName
FROM Sales.Customers

-- TASK:04 = Find the average scores of customers and treat Nulls as 0 
          -- And additional provide details such CustomerID & LastName
SELECT 
	CustomerID,
	LastName,
	Score,
CASE 
	WHEN Score IS NULL THEN 0 
	ELSE Score
END ScoreClean,
AVG(CASE 
		WHEN Score IS NULL THEN 0 
		ELSE Score
	END) OVER() AvgCustomerClean,
	AVG(Score) OVER() AvgCustomerScore
FROM Sales.Customers

-- TASK:05 = Count how many times each customer has made an order with sales greater than 30.
SELECT 
	CustomerID,
SUM(CASE 
	WHEN Sales > 30 THEN 1
	ELSE 0
END) TotalOrdersHighSales,
	COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID
