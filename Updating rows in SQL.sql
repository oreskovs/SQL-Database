-- Change the score of customer 6 to 0

UPDATE customers
SET score = 0
WHERE id = 6


-- Change the score fo customer with ID 8 to 0 and update the country to UK

UPDATE customers
SET score = 0, country = 'UK'
WHERE id = 8


-- Update all customers with a NULL score by setting their score to 0 

UPDATE customers 
SET score = 0 
WHERE score IS NULL

-- Update all customers with a NULL country by setting their country to Unknown
UPDATE customers
SET country = 'Unknown'
WHERE country IS NULL
SELECT * FROM customers