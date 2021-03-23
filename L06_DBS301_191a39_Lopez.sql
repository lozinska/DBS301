-- ***********************
-- Name: Krystyna Lopez
-- ID: 146736178
-- Date: February 18, 2019
-- Purpose: Lab 6 DBS301
-- ***********************

-- Question 1 - SET AUTOCOMMIT ON (do this each time you log on) so any updates, deletes and inserts are automatically 
-- committed before you exit from Oracle.

-- Q1 - Solution

SET AUTOCOMMIT ON

-- Question 2 - Create an INSERT statement to do this.  Add yourself as an employee with a NULL salary, 0.21 commission_pct,
-- in department 90, and Manager 100.  You started TODAY.  

-- Q2 - Solution

INSERT INTO employees 
    VALUES (207,'Krystyna','Lopez','klopez8@myseneca.ca',0,'16-FEB-19','AD_PRES',NULL,0.21,100,90);

-- Question 3 - Create an Update statement to: Change the salary of the employees with a last name of 
-- Matos and Whalen to be 2500.

--Q3 - Solution
UPDATE employees
    SET salary=2500
    WHERE upper(last_name)='MATOS' OR upper(last_name)='WHALEN';

-- Question 4 - Display the last names of all employees who are in the same department as the employee named Abel.

-- Q4 - Solution
SELECT last_name AS "Last name"
    FROM employees
    WHERE department_id=
    (
        SELECT department_id 
             FROM employees
             WHERE upper(last_name)='ABEL'
    );
    
-- Question 5 - Display the last name of the lowest paid employee(s)

-- Q5 - Solution
SELECT last_name AS "Last Name"
    FROM employees
    WHERE NVL(salary,0) =
    (
SELECT min(NVL(salary,0))
    FROM employees
    );

-- Question 6 - Display the city that the lowest paid employee(s) are located in.

--Q6 - Solution
SELECT city AS "City"
    FROM locations
    WHERE location_id IN (
        SELECT location_id
            FROM departments
            WHERE department_id IN 
            (
                SELECT department_id
                    FROM employees
                    WHERE NVL(salary,0)=
                    (
                        SELECT min(NVL(salary,0))
                            FROM employees
             )
                     )
                             );
    
-- Question 7 - Display the last name, department_id, and salary of the lowest paid employee(s) in each department. 
-- Sort by Department_ID. (HINT: careful with department 60)

--Q7 - Solution
SELECT  last_name AS "Last Name",
        department_id AS "Department#",
        salary AS "Salary"
    FROM employees 
    WHERE department_id ||salary IN (
        SELECT department_id || min(salary)
            FROM employees
            GROUP BY department_id
)
    ORDER BY department_id;

-- Question 8 - Display the last name of the lowest paid employee(s) in each city

-- Q8 - Solution
SELECT last_name AS "Last Name"
    FROM employees JOIN departments
        USING (department_id)
    JOIN locations
        USING(location_id)
    WHERE ( salary,city) IN(
        SELECT min(salary),city
            FROM employees JOIN departments
                USING (department_id)
            JOIN locations
                USING(location_id)
            GROUP BY city
);
-- Question 9 -	Display last name and salary for all employees who earn less than the lowest salary in ANY department.  
-- Sort the output by top salaries first and then by last name.

-- Q9 - Solution

SELECT last_name AS "Last Name"
    FROM employees
    WHERE salary < ANY (
        SELECT min(salary)
            FROM employees
            GROUP BY department_id
)
    ORDER BY salary, last_name;

-- Question 10 - Display last name, job title and salary for all employees whose salary matches any of the salaries from the IT 
-- Department. Do NOT use Join method.  Sort the output by salary ascending first and then by last_name

-- Q10 - Solution

SELECT  last_name AS "Last Name",
        job_id AS "Job Title", 
        salary AS "Salary"
    FROM employees
    WHERE salary IN (
        SELECT salary
            FROM employees
            WHERE department_id IN(
                SELECT department_id
                    FROM employees
                    WHERE upper(job_id) LIKE 'IT%'
)
)
    ORDER BY salary,last_name;
