-- ***********************
-- Name: Krystyna Lopez
-- ID: 146736178
-- Date: March 11, 2019
-- Purpose: Lab 7 DBS301
-- ***********************


-- Question 1 -- The HR department needs a list of Department IDs for departments that do not conbtain the job ID of ST_CLERK>
-- Use a set operator to create this report.

-- Q1 - Solution
SELECT department_id AS "Department ID"
    FROM departments
MINUS
SELECT department_id
    FROM employees
    WHERE job_id='ST_CLERK';
    
-- Question 2 -- Same department requests a list of countries that have no departments located in them. Display country ID 
-- and the country name. Use SET operators.

-- Q2 - Solution
SELECT country_id AS "Country Id", country_name AS "Country Name"
   FROM countries
MINUS
SELECT country_id, country_name
    FROM countries
    WHERE country_id IN(
        SELECT country_id
            FROM locations
            WHERE location_id IN (
                SELECT location_id
                    FROM departments
    )
    );
    
-- Question 3 -- The Vice President needs very quickly a list of departments 10, 50, 20 in that order. job and department ID
-- are to be displayed.

--Q3 - Solution

SELECT job_id AS "Job Id",department_id AS "Department ID"
    FROM employees
    WHERE department_id=10
UNION 
SELECT job_id,department_id
    FROM employees
    WHERE department_id=50
UNION ALL
SELECT job_id,department_id
    FROM employees
    WHERE department_id=20;
    
-- Question 4 -- Create a statement that lists the employeeIDs and JobIDs of those employees who currently have a job 
-- title that is the same as their job title when they were initially hired by the company (that is, they changed jobs but 
-- have now gone back to doing their original job).

-- Q4 - Solution

SELECT employees.employee_id AS "Employee ID",employees.job_id AS "Job Id"
    FROM employees JOIN job_history
        ON(employees.employee_id=job_history.employee_id)
    WHERE hire_date=start_date
INTERSECT 
SELECT employee_id, job_id
    FROM job_history;


-- Question 5 - The HR department needs a SINGLE report with the following specifications:
-- a.	Last name and department ID of all employees regardless of whether they belong to a department or not.
-- b.	Department ID and department name of all departments regardless of whether they have employees in them or not.

-- Q5 - Solution 
SELECT last_name AS "Last Name", department_id AS "Department Id", NULL AS "Department Name"
    FROM employees
    UNION
SELECT NULL, department_id,department_name
    FROM departments;
   
