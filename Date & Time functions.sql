-- SQL Functions
-- Date & Time functions 

SELECT 
	OrderID,
	CreationTime,
	'2025-08-20' HardCoded
FROM Sales.Orders

-- GETDATE() = Returns the current date and time at the moment when the query is executed.
SELECT 
	OrderID,
	CreationTime,
	'2025-08-20' HardCoded,
	GETDATE() Today
FROM Sales.Orders

-- DAY(date) = Returns the day from a date 
-- MONTH(date) = Returns the month from a date
-- YEAR(date) = Returns the year from a date
SELECT 
	CreationTime,
	DAY(CreationTime) CreationDay,
	MONTH(CreationTime) CreationMonth,
	YEAR(CreationTime) CreationYear
FROM Sales.Orders

-- DATEPART(part, date) = Returns a specific part of a date as a number 
SELECT
	OrderID,
	CreationTime,
	DATEPART(year, CreationTime) AS dp_year,
	DATEPART(month, CreationTime) AS dp_month,
	DATEPART(day, CreationTime) AS dp_day,
	DATEPART(hour, CreationTime) AS dp_hour,
	DATEPART(quarter, CreationTime) AS dp_quarter,
	DATEPART(week, CreationTime) AS dp_week,
	DATEPART(weekday, CreationTime) AS dp_weekday
FROM Sales.Orders

-- DATENAME(part, date) = Returns the name of a specific part of a date.
SELECT 
	OrderID,
	CreationTime,
	DATENAME(month, CreationTime) AS Dn_month,
	DATENAME(weekday, CreationTime) AS Dn_weekday,
	DATENAME(day, CreationTime) AS Dn_day,
	DATENAME(year, CreationTime) AS Dn_year
FROM Sales.Orders

-- DATETRUNC() = Truncates the date to the specific part.
SELECT 
	OrderID,
	CreationTime,
	DATETRUNC(minute, CreationTime) AS dt_minutes,
	DATETRUNC(hour, CreationTime) AS dt_hours, 
	DATETRUNC(day, CreationTime) AS dt_day,
	DATETRUNC(month, CreationTime) AS dt_month,
	DATETRUNC(year, CreationTime) AS dt_year
FROM Sales.Orders

-- DATETRUNC = EXAMPLE
SELECT 
	DATETRUNC(year, CreationTime) Creation,
	COUNT(*) AS NumberOfOrders
FROM Sales.Orders
GROUP BY DATETRUNC(year, CreationTime)
 
-- EOMONTH(date) = Returns the last day of a month.
SELECT 
	OrderID,
	CreationTime,
	EOMONTH(CreationTime) EndOfMonth
FROM Sales.Orders

-- TASK:01 = How many orders were placed each year?
SELECT 
	YEAR(OrderDate),
	COUNT(*) NumberOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

-- TASK:02 = How many orders were placed each month?
SELECT 
	DATENAME(month,OrderDate) OrderDate,
	COUNT(*) NumberOfOrders
FROM Sales.Orders
GROUP BY DATENAME(month,OrderDate)

-- TASK:03 = Show all orders that were placed during the month of february
SELECT * FROM Sales.Orders
WHERE MONTH(OrderDate) = 2

-- FORMATTING = Changing the format of a value from one to another.
-- FORMAT(value, format [,culture]=optional) = Formats a date or time value
SELECT 
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'MM-dd-yyyy') USA_Format,
	FORMAT(CreationTime, 'dd-MM-yyyy') EU_Format,
	FORMAT(CreationTime, 'dd') dd,
	FORMAT(CreationTime, 'ddd') ddd,
	FORMAT(CreationTime, 'dddd') dddd,
	FORMAT(CreationTime, 'MM') MM,
	FORMAT(CreationTime, 'MMM') MMM,
	FORMAT(CreationTime, 'MMMM') MMMM 
FROM Sales.Orders

-- TASK:04 = Show CreationTime using the following format: 
-- Day Wed Jan Q1 2025 12:34:56 PM
SELECT 
	OrderID,
	CreationTime,
	'Day ' + FORMAT(CreationTime, 'ddd MMM') + 
	' Q'+ DATENAME(quarter, CreationTime) + ' ' + FORMAT(CreationTime, 'yyyy hh:mm:ss tt')
	CustomFormat
FROM Sales.Orders

-- Data Aggregations 
SELECT 
	FORMAT(OrderDate, 'MMM yy') OrderDate,
	COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy')

-- CASTING = Changing the data type from one to another.

-- CONVERT(data_type, value [,style]=optional) = Converts a date or time value to a different data type & Formats the value.
SELECT
	CONVERT(INT, '123') AS [String to int Convert],
	CONVERT(DATE, '2025-08-20') AS [String to Date Convert],
	CreationTime,
	CONVERT(DATE, CreationTime) AS [Datetime to Date Convert]
FROM Sales.Orders

SELECT 
	CreationTime,
	CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],
	CONVERT(VARCHAR, CreationTime, 32) AS [USA Std. Style:32],
	CONVERT(VARCHAR, CreationTime, 34) AS [EU Std. Style:34]
FROM Sales.Orders

-- CAST(value AS data_type) = Converts a value to a specified data type.
SELECT
	CAST('123' AS INT) AS [String to INT],
	CAST(123 AS VARCHAR) AS [INT to String],
	CAST('2025-08-20' AS DATE) AS [String to Date],
	CAST('2025-08-20' AS DATETIME2) AS [String to DATETIME],
	CAST(CreationTime AS DATE) AS [DATETIME TO DATE]
FROM Sales.Orders

-- DATE Calculations

-- DATEADD(part, interval, date) = Adds or subtracts a specific time interval to/from a date.
SELECT 
	OrderID,
	OrderDate,
	DATEADD(year, 2, OrderDate) AS TwoYearsLater,
	DATEADD(month, 2, OrderDate) AS TwoMonthsLater,
	DATEADD(day, -10, OrderDate) AS TenDaysBefore
FROM Sales.Orders

-- DATEDIFF(part, start_date, end_date) = Find the difference between two dates.
-- Calculate the age of employees
SELECT 
	EmployeeID,
	BirthDate,
	DATEDIFF(year, BirthDate, GETDATE()) Age
FROM Sales.Employees

-- Find the average shipping duration in days for each month.
SELECT 
	MONTH(OrderDate) OrderDate, 
	AVG(DATEDIFF(day, OrderDate, ShipDate)) AvgShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- Find the number of days between each order and previous order.
SELECT 
	OrderID,
	OrderDate CurrentOrderDate,
	LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate,
	DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate ) DaysBetweenOrders
FROM Sales.Orders

-- Date Validation 

-- ISDATE(value) = Checks if a value is a date. Returns 1 if the string value is a valid date.
SELECT
	ISDATE('123') DateCheck1,
	ISDATE('2025-08-20') DateCheck2,
	ISDATE('20-08-2025') DateCheck3,
	ISDATE('2025') DateCheck4,
	ISDATE('08') DateCheck5

	