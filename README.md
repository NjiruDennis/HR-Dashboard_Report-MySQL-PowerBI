# HR Employee Report Project

## Table of Contents

* [Project Overview](#project-overview)
* [Data Source](#data-source)
* [Tools Used](#tools-used)
* [Data Cleaning/Preparation](#data-cleaningpreparation)
* [Exploratory Data Analysis](#exploratory-data-analysis)
* [Data Analysis](#data-analysis)
* [Results/Findings](#resultsfindings)
* [Recommendations](#recommendations)
* [Limitations](#limitations)

## Project Overview

This project aims to provide insights into the employee distribution, demographics, and trends within a human resources department. The analysis includes employee turnover, gender distribution, tenure, and location analysis to help HR departments make data-driven decisions.

## Data Source

The primary dataset used for this analysis is the **"Human Resources"** dataset, containing over **22,000** rows of detailed employee information spanning from **2000 to 2020**, including birthdate, hire date, termination date, department, location, and more.

## Tools Used

* **Excel** - Data Cleaning [Download here](https://www.microsoft.com/en-us/microsoft-365/excel)
* **SQL Server** - Data Cleaning and Analysis [Download here](https://www.mysql.com/products/workbench/)
* **Power BI** - Data Visualization [Download here](https://app.powerbi.com/)

## Data Cleaning/Preparation

The data preparation phase included the following steps:

1. **Database Creation and Setup**: Created a new database named **projects**.
2. **Data Loading and Inspection**: Loaded the data into the SQL server and inspected it.
3. **Column Name Correction**: Renamed the **ï»¿id** column to **employee\_id**.
4. **Date Format Correction**: Standardized **birthdate**, **hire\_date**, and **termdate** columns to **YYYY-MM-DD**.
5. **Age Calculation**: Added an **age** column to calculate employee ages.
6. **Outlier Detection**: Checked for employees under 18 years old to ensure data accuracy.

## Exploratory Data Analysis

Key questions explored in this analysis include:

1. What is the gender breakdown of the employees?
2. What is the race/ethnicity distribution?
3. What is the age distribution?
4. How many employees work at headquarters versus remote locations?
5. What is the average length of employment for terminated employees?
6. How does the gender distribution vary across departments?
7. What is the distribution of job titles?
8. Which department has the highest turnover rate?
9. What is the distribution of employees across locations by state?
10. How has the employee count changed over time?
11. What is the tenure distribution for each department?

## Data Analysis

Include some interesting code/features worked with, for example:

```sql
-- Calculate age based on birthdate
ALTER TABLE human_resources ADD COLUMN age INT;
UPDATE human_resources
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

-- Calculate turnover rate
SELECT department, terminated_Employees/total_Nr_of_Employees AS turnover_rate
FROM (
    SELECT department,
           COUNT(*) AS total_Nr_of_Employees,
           SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) AS terminated_Employees
    FROM human_resources
    GROUP BY department
) AS subquery
ORDER BY turnover_rate DESC;
```

## Results/Findings

From the analysis, the following key insights were discovered:

* **Gender Distribution:** The majority of employees are male (8.9K), closely followed by female employees (8.1K), with a small group of non-conforming employees (0.5K).
* **Location Distribution:** About 75% of the workforce is based at the headquarters (13K), while 25% (4K) work remotely.
* **Race Distribution:** The majority of employees belong to three main racial groups, with the largest group being 5.0K, followed by two groups with 2.8K each.
* **Age Group Distribution:** The largest age groups are 35-44 (5.1K), 25-34 (4.9K), and 45-54 (4.9K), indicating a mature workforce, with fewer younger (18-24, 1.2K) and older (55-64, 1.5K) employees.
* **Gender Distribution by Department:** Engineering and Accounting departments have the highest number of male employees, while Human Resources and Training departments have a more balanced gender distribution.
* **Termination Rates:** Auditing (0.18), Legal (0.15), and Training (0.13) departments have the highest termination rates, potentially indicating high employee turnover or role-specific challenges.
* **Employee Growth:** The company's workforce has seen steady growth over the past two decades, despite some dips around 2005 and 2010.
* **Employee Distribution by State:** Most employees are concentrated in states like Michigan, Ohio, and Indiana.

### Power BI Visuals

To provide a more comprehensive understanding of the data, here are the Power BI visualizations used in this analysis:

#### Employee Overview Page
<img width="786" alt="image" src="https://github.com/user-attachments/assets/f4b30056-45cb-4cf5-8282-8ab6b9d4e697" />

* Provides an overview of the workforce distribution, including gender, location, and racial composition.

#### Department and Age Breakdown Page
<img width="750" alt="image" src="https://github.com/user-attachments/assets/a18a410e-af65-41c6-9c12-94fe9c5a6178" />

* Focuses on department-level analysis, including gender distribution by department, age group breakdown, and termination rates.


## Recommendations

Based on these findings, the following actions are recommended:

* **Retention Strategies:** Focus on improving retention in departments like Auditing, Legal, and Training, where turnover rates are highest.
* **Targeted Recruitment:** Consider attracting younger employees to balance the age distribution and reduce potential future skill gaps as the workforce matures.
* **Diversity and Inclusion:** Implement initiatives to support non-conforming employees and promote gender balance, especially in male-dominated departments like Engineering.
* **Remote Work Support:** Continue to support remote work options, as a significant portion of the workforce operates remotely.
* **Talent Development:** Invest in training and career development, particularly for departments with high turnover rates, to improve retention and overall employee satisfaction.
* **Regional Focus:** Consider expanding operations in high-employee-density states to further boost local engagement.

## Limitations

* Some records had negative ages (967 records) and these were excluded during querying. Ages below 18 were assumed to be incorrect as 18 is the legal working age.
* Some termination dates were far into the future (1,599 records) and were not included in the analysis. Only termination dates less than or equal to the current date were used to maintain data accuracy.


