-- SQL Functions 
--Single row Functions

--String functions

--CONCAT = Combines multiple strings into one 
--Concatenate first name and country into one column
SELECT 
	first_name,
	country,
	CONCAT(first_name,' ',country) AS name_country
FROM customers

-- UPPER = Converts all characters to uppercase
-- Transform the first name to uppercase
SELECT 
	first_name,
	country,
	UPPER(first_name) AS upper_name
FROM customers


-- LOWER = Converts all characters to lowercase
-- Transform the first name to lowercase
SELECT 
	first_name,
	country,
	LOWER(first_name) AS low_name
FROM customers

-- TRIM = Remove leading and trailing spaces
-- Find customers whose first name contains leading or trailing spaces
SELECT 
	first_name
FROM customers
WHERE first_name != TRIM(first_name)

-- REPLACE = Replaces specific character with a new character
-- Remove dashes (-) from a phone number
SELECT 
'123-456-7890' AS phone,
REPLACE('123-456-7890', '-', '/') AS clean_phone

-- Another example
SELECT 
'sqldata.txt' AS old_data,
REPLACE('sqldata.txt', '.txt', '.csv')

-- LEN = Counts how many characters we have in one value
-- Calculate the length of each customer`s first name
SELECT 
	first_name,
	LEN(first_name) AS len_name
FROM customers

-- LEFT = Extracts specific number of characters from the start
-- Retrieve the first two characters of each first name
SELECT 
	first_name,
	LEFT(TRIM(first_name), 2) AS First_two_char
FROM customers

-- RIGHT = Extracts specific number of characters from the end
-- Retrieve the last two characters of each first name
SELECT 
	first_name,
	RIGHT(TRIM(first_name) , 2) AS last_two_char
FROM customers

-- SUBSTRING = Extracts a part of string at a specified position
-- Retrieve a list of customer`s first name after removing the first character.
SELECT 
	first_name,
	SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS sub_name
FROM customers