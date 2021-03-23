-- ***********************
-- Name: Krystyna Lopez
-- ID: 146736178
-- Date: April 1, 2019
-- Purpose: Lab 10 DBS301
-- ***********************

-- Question 1 - Create table L10Cities from table LOCATIONS, but only for location numbers less than 2000 
-- (do NOT create this table from scratch, i.e. create and insert in one statement).

-- Q1 - Solution
CREATE TABLE L10Cities AS(
    SELECT * FROM locations
        WHERE location_id<2000
);

-- Question 2 - Create table L10Towns from table LOCATIONS, but only for location numbers less than 1500 
-- (do NOT create this table from scratch). This table will have same structure as table L10Cities. 

-- Q2 - Solution 

CREATE TABLE L10Towns AS(
    SELECT * FROM locations
        WHERE location_id<1500
);

-- Question 3 - Now you will empty your RECYCLE BIN with one powerful command. Then remove your table L10Towns,
-- so that will remain in the recycle bin. Check that it is really there and what time was removed.  
-- Hint: Show RecycleBin,   Purge,  Flashback

-- Q3 - Solution
PURGE RecycleBin;

DROP TABLE L10Towns;

SHOW RecycleBin;

-- L10TOWNS      BIN$hXp+wDXBG/vgUxhrZgp6SA==$0 TABLE       2019-04-01:11:15:47 

-- Question 4 - Restore your table L10Towns from recycle bin and describe it. Check what is in your recycle bin now.

-- Q4 - Solution

FLASHBACK TABLE L10Towns TO BEFORE DROP; 

-- Question 5 - Now remove table L10Towns so that does NOT remain in the recycle bin. Check that is really NOT there and then
-- try to restore it. Explain what happened?

-- Q5 - Solution

DROP TABLE L10Towns;
PURGE RecycleBin;
FLASHBACK TABLE L10Towns TO BEFORE DROP;
-- Once we PURGE RecycleBin we are not able to restore table that 
--was droped in there. PURGE command clear the recycle bin and system does not see that table anymore
-- that table can not be restore from RecycleBin anymore .

-- Question 6 - Create simple view called CAN_CITY_VU, based on table L10Cities so that will contain only columns 
-- Street_Address, Postal_Code, City and State_Province for locations only in CANADA. Then display all data from this view.

-- Q6 - Solution
CREATE OR REPLACE VIEW CAN_CITY_VU AS (
    SELECT street_address, postal_code, city, state_province
        FROM L10Cities
        WHERE upper(country_id)='CA'
);

-- Question 7 - Modify your simple view so that will have following aliases instead of original column names:
-- Str_Adr, P_Code, City and Prov and also will include cities from ITALY as well. Then display all data from this view. 

-- Q7 - Solution

CREATE OR REPLACE VIEW CAN_CITY_VU AS(
    SELECT  street_address AS "Str_Adr",
            postal_code AS "P_Code",
            city AS "City",
            state_province AS "Prov"
        FROM locations
        WHERE upper(country_id) IN ('CA','IT')
    );

SELECT * FROM CAN_CITY_VU;

-- Question 8 - Create complex view called vwCity_DName_VU, based on tables LOCATIONS and DEPARTMENTS, so that will contain 
-- only columns Department_Name, City and State_Province for locations in ITALY or CANADA. Include situations even when city 
-- does NOT have department established yet. Then display all data from this view.

-- Q8 - Solution

CREATE OR REPLACE VIEW vwCity_DName_VU AS (
    SELECT department_name, city,state_province
        FROM locations LEFT JOIN departments
        USING(location_id)
        WHERE upper(country_id) IN ('CA','IT') 
    );

SELECT * FROM vwCity_DName_VU;

-- Question 9 - Modify your complex view so that will have following aliases instead of original column names: 
-- DName, City and Prov and also will include all cities outside United States 
-- Include situations even when city does NOT have department established yet. Then display all data from this view.

-- Q9 - Solution

CREATE OR REPLACE VIEW vwCity_DName_VU AS (
    SELECT  department_name AS  "Dname", 
            city AS "City",
            state_province AS "Prov"
        FROM locations LEFT JOIN departments
            USING(location_id)
        WHERE upper(country_id) NOT IN ('US') 
    );

SELECT * FROM vwCity_DName_VU;

-- Question 10 - Check in the Data Dictionary what Views (their names and definitions) are created so far in your account. 
-- Then drop your vwCity_DName_VU and check Data Dictionary again. What is different?

-- Q10 - Solution

SELECT * FROM ALL_OBJECTS 
    WHERE upper(Object_Type) = 'VIEW' AND upper(owner) = 'DBS301_191A39';
    
DROP VIEW vwCity_DName_VU;

SELECT * FROM ALL_OBJECTS 
    WHERE upper(Object_Type) = 'VIEW' AND upper(owner) = 'DBS301_191A39';

-- After dropping the view it disappered from the Data Dictionary