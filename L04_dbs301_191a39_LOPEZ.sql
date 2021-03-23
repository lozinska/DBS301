-- ***********************
-- Name: Krystyna Lopez
-- ID: 146736178
-- Date: Feb 4, 2019
-- Purpose: Lab 4 DBS301
-- ***********************

-- Question 1 - Display the difference between the Average pay and Lowest pay in the company.  Name this result Real Amount.
-- Format the output as currency with 2 decimal places.

-- Q1 Solution

    SELECT to_char(avg(salary)-min(salary),'$99,999.00') AS "Real Amount"
    FROM employees;
    
-- Question 2 - Display the department number and Highest, Lowest and Average pay per each department.
-- Name these results High, Low and Avg.  Sort the output so that the department with highest average salary is shown first. 
-- Format the output as currency where appropriate.

-- Q2 Solution

    SELECT  DISTINCT department_id,
            to_char(max(salary),'$99,999.99') AS "High",
            to_char(min(salary),'$99,999.99') AS "Low",
            to_char(avg(salary),'$99,999.99') AS "Avg"
    FROM employees
    GROUP BY department_id
    ORDER BY "Avg" DESC;
            
-- Question 3 - Display how many people work the same job in the same department. Name these results Dept#, Job and How Many. 
-- Include only jobs that involve more than one person.  
-- Sort the output so that jobs with the most people involved are shown first.

-- Q3 Solution

    SELECT  department_id AS "Dept#", job_id AS "Job", count(employee_id) AS "How Many"
    FROM employees
    GROUP BY job_id,department_id
    HAVING  count(employee_id)>1
    ORDER BY "How Many" DESC;
    
-- Question 4 - For each job title display the job title and total amount paid each month for this type of the job. 
-- Exclude titles AD_PRES and AD_VP and also include only jobs that require more than $11,000.  
-- Sort the output so that top paid jobs are shown first.

-- Q4 Solution

    SELECT job_id, sum(salary) AS "Total Amount Paid"
    FROM employees
    WHERE upper(job_id) NOT IN(upper('AD_PRES'),upper('AD_VP'))
    GROUP BY job_id
    HAVING sum(salary)>11000;

-- Question 5 - For each manager number display how many persons he / she supervises. 
-- Exclude managers with numbers 100, 101 and 102 and also include only those managers that supervise more than 2 persons.  
-- Sort the output so that manager numbers with the most supervised persons are shown first.

    SELECT manager_id, count(employee_id) AS "Number of people"
    FROM employees
    WHERE manager_id NOT IN( 100,101,102)
    GROUP BY manager_id
    HAVING count(employee_id)>2
    ORDER BY "Number of people" DESC;
    
-- Question 6 - For each department show the latest and earliest hire date, BUT
-- exclude departments 10 and 20 
-- exclude those departments where the last person was hired in this decade. 
-- (it is okay to hard code dates in this question only)
-- Sort the output so that the most recent, meaning latest hire dates, are shown first.

-- Q6 Solution
    SELECT department_id, min(hire_date) AS "Earliest hire date", max(hire_date) AS "Latest hire date"
    FROM employees
    WHERE department_id NOT IN (10,20)
    GROUP BY department_id
    HAVING max(hire_date) NOT BETWEEN to_date('01012011','ddmmyyyy') AND to_date('01012021','ddmmyyyy')
    ORDER BY "Latest hire date";