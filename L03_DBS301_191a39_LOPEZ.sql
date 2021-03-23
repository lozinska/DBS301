-- ***********************
-- Name: Krystyna Lopez
-- ID: 146736178
-- Date: 1/22/2019
-- Purpose: Lab 3 DBS301
-- ***********************

-- Q1. Write a query to display the tomorrow’s date in the following format:
--   January 10th of year 2019
-- the result will depend on the day when you RUN/EXECUTE this query.  Label the column “Tomorrow”.
-- Advanced Option:  Define an SQL variable called “tomorrow”, assign it a value of tomorrow’s date, use it in an SQL statement.
--Don’t forget to undefine it!

-- Q1 SOLUTION --

SELECT to_char(sysdate+1, 'Month ddth" of year "yyyy' ) AS "Tomorrow" 
    FROM dual;


-- Q2 2. For each employee in departments 20, 50 and 60 display last name, first name, salary, and salary increased by 4% 
-- and expressed as a whole number.  Label the column “Good Salary”.  
-- Also add a column that subtracts the old salary from the new salary and multiplies by 12. 
-- Label the column "Annual Pay Increase".

-- Q2 SOLUTION --

SELECT  last_name AS "Last Name", 
        first_name AS "First Name", 
        salary AS "Salary",
          round(salary*1.04) AS "Good Salary",
        round((salary*1.04-salary)*12) AS "Annual Pay Increase"
    FROM employees
    WHERE department_id IN(20,50,60);    

-- Q3. Write a query that displays the employee’s Full Name and Job Title in the following format:
--        DAVIES, CURTIS is ST_CLERK 
-- Only employees whose last name ends with S and first name starts with C or K.  
-- Give this column an appropriate label like Person and Job. 
-- Sort the result by the employees’ last names.

-- Q3. SOLUTION

SELECT last_name||' , '||first_name||' is '||job_id AS "Employee Information"
    FROM employees
    WHERE UPPER(last_name) LIKE '%S' AND (UPPER(first_name)LIKE 'C%' OR UPPER(first_name)LIKE 'K%')
    ORDER BY last_name;

-- Q4.For each employee hired before 2012, display the employee’s last name, hire date 
-- and calculate the number of YEARS between TODAY and the date the employee was hired.
-- a.	Label the column Years worked. 
-- b.	Order your results by the number of years employed.  
-- Round the number of years employed up to the closest whole number.

SELECT  last_name AS "Last Name",
        hire_date AS "Hire Date",
       ceil(months_between( sysdate, hire_date)/12) AS "Years worked"
    FROM employees
    WHERE extract(year FROM hire_date)<2012
    ORDER BY "Years worked";
    
-- Q5.Create a query that displays the city names, country codes and state province names, but only for those cities 
-- that starts with S and has at least 8 characters in their name. 
-- If city does not have a province name assigned, then put Unknown Province.  
-- Be cautious of case sensitivity!

-- Q5 SOLUTION

SELECT  city AS "City Names",
        country_id AS "Country Code",
        nvl(state_province,'Unknown Province') AS "State province name"
    FROM locations
    WHERE upper(city) LIKE 'S%' AND LENGTH(city)>=8;
    
-- Q6.Display each employee’s last name, hire date, and salary review date, which is the first Thursday after a year of service,
-- but only for those hired after 2017.  
-- a.	Label the column REVIEW DAY. 
-- b.	Format the dates to appear in the format like:
--  THURSDAY, August the Thirty-First of year 2018
-- c.	Sort by review date

--Q6 SOLUTION

SELECT  last_name AS "Employee's last name",
        hire_date AS "Hire Date",
        to_char(next_day(add_months(hire_date,+12)-1,'Thursday'),'fmDAY", " Month" the "Ddspth" of year "yyyy') AS "Review Day"
    FROM employees
    WHERE hire_date>=to_date('01012018','ddmmyyyy')
    ORDER BY extract(year FROM hire_date),extract(month FROM hire_date),extract(day FROM hire_date);

    
