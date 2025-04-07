--Retrieve all customers from either Germany or USA

SELECT * FROM customers
WHERE country IN ('Germany', 'USA')