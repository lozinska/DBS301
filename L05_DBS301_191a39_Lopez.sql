-- ***********************
-- Name: Krystyna Lopez
-- ID: 146736178
-- Date: February 11, 2019
-- Purpose: Lab 5 DBS301
-- ***********************

-- Question 1 - Display the department name, city, street address and postal code
-- for departments sorted by city and department name.

-- Q1 Solution

 SELECT department_name AS "Department Name",
        city AS "City",
        street_address "Street Address",
        postal_code AS "Postal Code"
    FROM locations,departments
    WHERE locations.location_id = departments.location_id
    ORDER BY city, department_name;

-- Question 2 - Display full name of employees as a single field using format of Last, First, their hire date, salary, 
-- department name and city, but only for departments with names starting with an A or S 
-- sorted by department name and employee name. 

-- Q2 Solution

SELECT  first_name||','||last_name AS "Full Name",
        hire_date AS "Hire Date", 
        salary AS "Salary",
        department_name AS "Department Name",
        city AS "City"
    FROM employees,departments,locations
    WHERE employees.department_id=departments.department_id AND
          locations.location_id = departments.location_id AND 
          (UPPER(department_name) LIKE 'S%' OR  UPPER(department_name) LIKE 'K%')
    ORDER BY department_name, "Full Name";
    
-- Question 3 - Display the full name of the manager of each department in states/provinces of Ontario, 
-- New Jersey and Washington along with the department name, city, postal code and province name.   
-- Sort the output by city and then by department name.

-- Q3 Solution

SELECT  first_name||' '||last_name AS "Full Name", 
        department_name AS "Department Name",
        city AS "City",
        postal_code AS "Postal Code",
         state_province AS "Province Name"
    FROM employees, departments, locations
    WHERE employees.department_id=departments.department_id AND
          locations.location_id = departments.location_id AND 
          UPPER(state_province) IN ('ONTARIO','NEW JERSEY','WASHINGTON') AND
          employees.employee_id=departments.manager_id
    ORDER BY city, department_name;

-- Question 4 - Display employee’s last name and employee number along with their manager’s last name and manager number. 
-- Label the columns Employee, Emp#, Manager, and Mgr# respectively.

--Q4 Solution

SELECT  a.last_name AS "Employee",
        a.employee_id AS "Emp#",
        b.last_name AS "Manager",
        b.employee_id AS "Mgr#"
    FROM employees a, employees b
        WHERE a.manager_id=b.employee_id;
  
-- Question 5 - Display the department name, city, street address, postal code and country name for all Departments. 
-- Use the JOIN and USING form of syntax.  Sort the output by department name descending.        

-- Q5 - Solution

SELECT  department_name AS "Department Name", 
        city AS "City", 
        street_address AS "Street Address",
        postal_code AS "Postal Code", 
        country_name AS "Country"
    FROM departments LEFT OUTER JOIN locations
        USING (location_id)
    LEFT OUTER JOIN countries
        USING (country_id)
    ORDER BY department_name DESC;

-- Question 6 - Display full name of the employees, their hire date and salary together with their department name, 
-- but only for departments which names start with A or S.
-- a.	Full name should be formatted:  First / Last. 
-- b.	Use the JOIN and ON form of syntax.
-- c.	Sort the output by department name and then by last name.

-- Q6 - Solution

SELECT  first_name||'/'||last_name AS "Full Name",
        hire_date AS " Hire Date",
        salary AS "Salary",
        department_name AS "Department"
    FROM departments INNER JOIN employees
        ON departments.department_id=employees.department_id
    WHERE UPPER(department_name) LIKE 'A%' OR UPPER(department_name) LIKE 'S%'
    ORDER BY departments.department_name, employees.last_name;

-- Question 7 - Display full name of the manager of each department in provinces Ontario, 
-- New Jersey and Washington plus department name, city, postal code and province name. 
-- a.	Full name should be formatted: Last, First.  
-- b.	Use the JOIN and ON form of syntax.
-- c.	Sort the output by city and then by department name. 

SELECT  last_name||','||first_name AS "Full Name", 
        department_name AS "Department Name", 
        city AS "City", 
        postal_code AS "Postal code", 
        state_province AS "State Province"
    FROM departments LEFT OUTER JOIN employees
        ON departments.manager_id=employees.employee_id
    LEFT OUTER JOIN locations
        ON departments.location_id=locations.location_id
    WHERE upper(state_province) IN ('ONTARIO','NEW JERSEY','WASHINGTON')
    ORDER BY locations.city, departments.department_name;

-- Question 8 - Display the department name and Highest, Lowest and Average pay per each department. 
-- Name these results High, Low and Avg.
-- a.	Use JOIN and ON form of the syntax.
-- b.	Sort the output so that department with highest average salary are shown first.

-- Q8 - Solution

SELECT  department_name, 
        max(salary) AS "High", 
        min(salary) AS "Low", 
        round(avg(salary)) AS "Avg"
    FROM departments INNER JOIN employees
        ON departments.department_id=employees.department_id
    GROUP BY department_name
    ORDER BY "Avg" DESC;

--Question 9 - Display the employee last name and employee number along with their manager’s last name and manager number. 
-- Label the columns Employee, 
-- a.	Emp#, Manager, and Mgr#, respectively. 
-- b.	Include also employees who do NOT have a manager and also employees who do NOT supervise anyone 
-- (or you could say managers without employees to supervise).

SELECT  a.last_name AS "Employee", 
        a.employee_id AS "Emp#",
        b.last_name AS "Manager", 
        b.manager_id AS "Mgr#"
    FROM employees a FULL JOIN employees b
        ON b.employee_id=a.manager_id;
        


