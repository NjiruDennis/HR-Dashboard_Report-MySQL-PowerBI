-- QUESTIONS

-- 1. What is the gender breakdown of the employees in the company?
SELECT 
	gender,
    COUNT(*) AS Nr_of_Employees
FROM human_resources
WHERE age >= 18 
	AND termdate = '0000-00-00'
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of the employees in the company?
SELECT 
	race,
    COUNT(*) AS Nr_of_Employees
FROM human_resources
WHERE age >= 18 
	AND termdate = '0000-00-00'
GROUP BY RACE
ORDER BY Nr_of_Employees DESC;

-- 3. What is the age distribution of the employees in the company?
SELECT 
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM human_resources
WHERE age >= 18 
	AND termdate = '0000-00-00';
    
SELECT 
	CASE 
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    COUNT(*) AS Nr_of_Employees
FROM human_resources
WHERE age >= 18 
	AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;

SELECT 
	CASE 
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS age_group, 
    gender,
    COUNT(*) AS Nr_of_Employees
FROM human_resources
WHERE age >= 18 
	AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4. How many emplyees work at the headquarters verses remote locations?
SELECT 
	location,
    COUNT(*) AS Nr_of_Employees
FROM human_resources
WHERE age >= 18 
	AND termdate = '0000-00-00'
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT 
	ROUND(AVG(datediff(termdate, hire_date))/365,0) AS avg_length_employment
FROM human_resources
WHERE age >= 18 
	AND termdate <= curdate()
	AND termdate <> '0000-00-00';

-- 6. How does the gender distribution vary across departments?
SELECT 
	department,
    gender,
    COUNT(*) AS Nr_of_Employees
FROM human_resources
WHERE age >= 18 
	AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?
SELECT 
	jobtitle,
    COUNT(*) AS Nr_of_Employees
FROM human_resources
WHERE age >= 18 
	AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate?
SELECT 
	department,
    total_Nr_of_Employees,
    terminated_Employees,
    terminated_Employees/total_Nr_of_Employees AS termination_rate
FROM (
	SELECT department,
		COUNT(*) AS total_Nr_of_Employees,
		SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_Employees
    FROM human_resources
	WHERE age >= 18 
    GROUP BY department
    ) AS subquery
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by state?
SELECT 
	location_state,
    COUNT(*) AS total_Nr_of_Employees
FROM human_resources
WHERE age >= 18 
	AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY total_Nr_of_Employees DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT
	hire_year,
	hires,
    terminations,
    hires - terminations AS net_change,
	ROUND((hires - terminations)/hires * 100, 2) AS net_change_percent
FROM (
	SELECT 
		YEAR(hire_date) AS hire_year,
		COUNT(*) AS hires,
		SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
    FROM human_resources
    WHERE age >= 18
    GROUP BY hire_year
	) AS subquery
ORDER BY hire_year ASC;

-- 11. What is the tenure distribution for each department?
SELECT 
	department,
    ROUND(AVG(datediff(termdate, hire_date)/365), 0) AS avg_tenure
FROM human_resources
WHERE age >= 18 
	AND termdate <> '0000-00-00' 
    AND termdate <= curdate()
GROUP BY department
ORDER BY department;

