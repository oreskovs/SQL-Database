/*Using SalesDB retrieve a list of all orders,along with the related customer,product, and employee details
For each order, display:
-Order ID
-Customer`s name
-Product name
-Sales amount
-Product price
-Saleperson`s name
*/

USE SalesDB
SELECT
	o.OrderID,
	o.Sales,
	c.FirstName AS Customer_FirstName,
	c.LastName AS Customer_LastName,
	p.Product AS product_name,
	p.price,
	e.FirstName AS Employee_FirstName,
	e.LastName AS Employee_LastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID
