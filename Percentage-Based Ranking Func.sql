-- PERCENTAGE-BASED RANKING

-- CUME_DIST() = Calculates the distribution of data points within a window.

-- Task:01 = Find the products that fall within the highest 40% of prices.

SELECT *,
CONCAT(DistRANK * 100, '%') DistRankPerc
FROM(
	SELECT 
		Product,
		Price,
		CUME_DIST() OVER(ORDER BY Price DESC) DistRank
	FROM Sales.Products
)t 
WHERE DistRANK <= 0.4

-- PERCENT_RANK() = Calculates the relative position of each row.
-- Task:02 = Find the products that fall within the highest 40% of prices

SELECT *,
CONCAT(DistRANK * 100, '%') DistRankPerc
FROM(
	SELECT 
		Product,
		Price,
		PERCENT_RANK() OVER(ORDER BY Price DESC) DistRank
	FROM Sales.Products
)t 
WHERE DistRANK <= 0.4
