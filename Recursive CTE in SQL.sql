-- Recursive CTE = Self-referencing query that repeatedly processes data until a specific condtition is met.

-- Task:01 = Generate a sequence of numbers from 1 to 20


WITH Series AS(
	-- Anchor Query
	SELECT
	1 AS MyNumber
	UNION ALL
	-- Recursive Query
	SELECT 
	MyNumber + 1
	FROM Series
	WHERE MyNumber < 20
)

-- Main Query
SELECT * FROM Series
OPTION(MAXRECURSION 20)


-- Task:02 = Show the employee hierarchy by displaying each employee`s level within the organization.



WITH CTE_Emp_Hierarchy AS
(
	-- Anchor Query
	SELECT 
		EmployeeID,
		FirstName,
		ManagerID,
		1 AS Level
	FROM Sales.Employees
	WHERE ManagerID IS NULL
	UNION ALL
	--Recursive Query
	SELECT 
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		Level + 1 
	FROM Sales.Employees AS e
	INNER JOIN CTE_Emp_Hierarchy ceh
	ON e.ManagerID = ceh.EmployeeID

		
)

-- Main Query
SELECT
*
FROM CTE_Emp_Hierarchy