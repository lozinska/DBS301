-- ***********************
-- Name: Krystyna Lopez
-- ID: 146736178
-- Date: March 18, 2019
-- Purpose: Lab 8 DBS301
-- ***********************

-- Question 1 - Display the names of the employees whose salary is the same as the lowest salaried employee in any department.

-- Q1 - Solution

SELECT first_name||' '||last_name AS "Names"
    FROM employees
    WHERE  salary = (
        SELECT min(salary)
            FROM employees
);

-- Question 2 - Display the names of the employee(s) whose salary is the lowest in each department.

-- Q2 - Solution

SELECT first_name||' '||last_name AS "Names"
    FROM employees
    WHERE salary||department_id IN(
        SELECT min(salary)||department_id
            FROM employees
            GROUP BY department_id
    );
    
-- Question 3 - Give each of the employees in question 2 a $120 bonus.

-- Q3 - Solution

SELECT first_name||' '||last_name AS "Names", to_char(salary+120, '$99,999.00') AS "Slary+Bonus"
    FROM employees
    WHERE salary||department_id IN(
        SELECT min(salary)||department_id
            FROM employees
            GROUP BY department_id
    );

-- Question 4 - Create a view named vwAllEmps that consists of all employees includes employee_id, last_name, salary, 
-- department_id, department_name, city and country (if applicable)

-- Q4 - Solution

CREATE VIEW vwAllEmps AS
SELECT  employees.employee_id , employees.last_name, employees.salary,
        departments.department_id, departments.department_name, 
        locations.city, locations.country_id
    FROM employees JOIN departments
        ON employees.department_id=departments.department_id
    JOIN locations
        ON departments.location_id=locations.location_id;

-- Question 5 -   Use the vwAllEmps view to:
-- a.	Display the employee_id, last_name, salary and city for all employees
-- b.	Display the total salary of all employees by city
-- c.	Increase the salary of the lowest paid employee(s) in each department by 120
-- d.	What happens if you try to insert an employee by providing values for all columns in this view?
-- e.	Delete the employee named Vargas. Did it work? Show proof.

--Q5 - a) Solution
SELECT employee_id, last_name, salary, city
FROM vwAllEmps;

--Q5 - b) Solution
SELECT sum(salary), city
    FROM vwAllEmps
    GROUP BY city;

--Q5 - c) Solution
UPDATE vwAllEmps
    SET salary=salary+120
WHERE salary IN(
SELECT min(salary)
    FROM vwAllEmps
    GROUP BY department_id
);

--Q5 - d) Solution
-- it will not insert because this is just a view made out of 3 JOIN tables, if we put all together under 
--one statement it will ask to do in separate statements according to the number of JOIN tables
-- if we try to insert them all separate it will try to insert into original tables but not in the view

INSERT INTO vwAllEmps (employee_id,last_name,salary) VALUES(9999,'Leese',1700.00);
INSERT INTO vwAllEmps(department_id,department_name) VALUES(10,'Administration');
INSERT INTO vwAllEmps(city,country_id) VALUES('Roma','IT');

--Q5 -e) Solution
-- Yes DELETE statement work in this case;

DELETE FROM vwAllEmps
    WHERE upper(last_name)='VARGAS';

SELECT last_name 
    FROM vwAllEmps
    WHERE upper(last_name)='VARGAS';

-- Question 6 - Create a view named vwAllDepts that consists of all departments and includes department_id, department_name,
-- city and country (if applicable)

-- Q6 - Solution

CREATE VIEW vwAllDepts AS
SELECT  departments.department_id, departments.department_name,
        locations.city, locations.country_id
    FROM departments JOIN locations
    ON(departments.location_id=locations.location_id);
    
-- Question 7 - Use the vwAllDepts view to:

-- a.	For all departments display the department_id, name and city
-- b.	For each city that has departments located in it display the number of departments by city

-- Q7 - a) Solution

SELECT department_id, department_name, city
    FROM vwAllDepts;
    
-- Q7 - b) Solution

SELECT count(department_name) AS "Number", city
    FROM vwAllDepts
    GROUP BY city;

-- Question 8 - Create a view called vwAllDeptSumm that consists of all departments and includes for each department: 
-- department_id, department_name, number of employees, number of salaried employees, total salary of all employees. 
-- Number of Salaried must be different from number of employees. The difference is some get commission.

-- Q8 - Solution

CREATE VIEW vwAllDeptSumm AS
SELECT department_id, department_name, count(employee_id) AS NumEmp, count(employee_id)-count(commission_pct)
AS SalEmp
    FROM departments JOIN employees
    USING(department_id)
    GROUP BY department_id, department_name;
    
-- Question 9 - Use the vwAllDeptSumm view to display department name and number of employees for departments that have 
-- more than the average number of employees 

-- Q9 - Solution

SELECT department_name, "Number of Employees"
    FROM vwAllDeptSumm
    WHERE "Number of Employees"> (
    SELECT avg("Number of Employees")
    FROM vwAllDeptSumm
    );
    
--Question 10 -	A) Use the GRANT statement to allow another student (Neptune account) to retrieve data for your employees 
-- table and to allow them to retrieve, insert and update data in your departments table. Show proof
-- B) Use the REVOKE statement to remove permission for that student to insert and update data in your departments table

--Q10 - A) Solution

GRANT 
    SELECT 
ON employees
TO dbs301_191b04;
    
GRANT 
    SELECT, 
    INSERT,
    UPDATE
ON departments
TO dbs301_191b04;

-- Q10 -B)

REVOKE 
    INSERT,
    UPDATE
ON departments
FROM dbs301_191b04;
    
    