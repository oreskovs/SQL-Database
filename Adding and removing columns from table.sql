-- Add a new column called email to the persons table

ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL

SELECT * FROM persons

-- Remove the phome column from the persons table

ALTER TABLE persons
DROP COLUMN phone 

SELECT * FROM persons