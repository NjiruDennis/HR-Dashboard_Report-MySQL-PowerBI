-- Create the database
CREATE DATABASE projects;

USE projects;


-- Run the data
SELECT * FROM human_resources;


-- Change the column name to the right name
ALTER TABLE human_resources
CHANGE COLUMN ï»¿id employee_id VARCHAR(20) NULL;


-- Check the format of the columns
DESCRIBE human_resources;


SET sql_safe_updates = 0;

-- Update Columns to correct formats
-- Update birthdate column to date
SELECT birthdate FROM human_resources;

UPDATE human_resources
SET birthdate = CASE 
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL  
    END;

ALTER TABLE human_resources
MODIFY COLUMN birthdate DATE;
    
-- Update hire_date column to date
SELECT hire_date FROM human_resources;

UPDATE human_resources
SET hire_date = CASE 
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL  
    END;

ALTER TABLE human_resources
MODIFY COLUMN hire_date DATE;

-- Update termdate column to date
SELECT termdate FROM human_resources;

UPDATE human_resources
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

ALTER TABLE human_resources
MODIFY COLUMN termdate DATE;


-- Add an age column
ALTER TABLE human_resources ADD COLUMN age INT;

UPDATE human_resources
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM human_resources;

-- Check the age outliers
SELECT 
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM human_resources;

SELECT COUNT(*) FROM human_resources 
WHERE age < 18;

