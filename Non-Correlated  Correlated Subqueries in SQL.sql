-- Non-Correlated | Correlated Subqueries
-- Non-Correlated Subquery = A subquery that can run independtly from the Main Query
-- Correlated Subquery = A subquery that relays on values from the Main Query

-- Task:01 = Show all customer details and find the total orders for each customer.
SELECT *,
	(SELECT COUNT(*) FROM Sales.Orders o WHERE o.CustomerID = c.CustomerID ) TotalSales
FROM Sales.Customers c


-- Correlated Subquery EXISTS = Checks if a subquery returns any rows.

-- Task:02 = Show the details of orders made by customers in Germany.

SELECT *
FROM Sales.Orders o
WHERE EXISTS (
	SELECT * FROM Sales.Customers c WHERE Country = 'Germany' 
	AND o.CustomerID = c.CustomerID
)
