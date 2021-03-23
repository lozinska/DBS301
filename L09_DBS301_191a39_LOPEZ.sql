-- ***********************
-- Name: Krystyna Lopez
-- ID: 146736178
-- Date: March 25, 2019
-- Purpose: Lab 9 DBS301
-- ***********************

-- Question 1 - Create table L09SalesRep and load it with data from table EMPLOYEES table. Use only the equivalent columns 
-- from EMPLOYEE as shown below and only for people in department 80.

-- Q1 - Solution

CREATE TABLE L09SalesRep AS (
    SELECT  employee_id AS repid, first_name AS fname,last_name AS lname, phone_number AS phone#, 
            salary,commission_pct AS commission
        FROM employees
        WHERE department_id=80);


-- Question 2 - Create L09Cust table.
-- Q2 - Solution

CREATE TABLE L09Cust (
   CUST#	  	NUMBER(6),
   CUSTNAME 	VARCHAR2(30),
   CITY 		VARCHAR2(20),
   RATING		CHAR(1),
   COMMENTS	VARCHAR2(200),
   SALESREP#	NUMBER(7) );

INSERT ALL 
    INTO L09Cust (cust#,custname,city,rating,salesrep#)
    VALUES(501,'ABC LTD.','Montreal','C',201 )
    INTO L09Cust (cust#,custname,city,rating,salesrep#)
    VALUES(502,'Black Giant','Ottawa','B',202) 
    INTO L09Cust (cust#,custname,city,rating,salesrep#)
    VALUES(503,'Mother Goose','London','B',202)
    INTO L09Cust (cust#,custname,city,rating,salesrep#)
    VALUES(701,'BLUE SKY LTD','Vancouver','B',102)
    INTO L09Cust (cust#,custname,city,rating,salesrep#)
    VALUES(702,'MIKE and SAM Inc.','Kingston','A',107)
    INTO L09Cust (cust#,custname,city,rating,salesrep#)
    VALUES(703,'RED PLANET','Mississauga','C',107)
    INTO L09Cust (cust#,custname,city,rating,salesrep#)
    VALUES(717,'BLUE SKY LTD','Regina','D',102)
    SELECT * FROM dual;
    
-- Question 3 - Create table L09GoodCust by using following columns but only if their rating is A or B. 
-- Q3 - Solution
CREATE TABLE L09GoodCust AS(
    SELECT cust# AS cust_id, custname AS "name", city AS "location",salesrep# AS repid
    FROM L09Cust
    WHERE upper(rating)='A' OR upper(rating)='B');
    
-- Question 4 - Now add new column to table L09SalesRep called JobCode that will be of variable character type with 
-- max length of 12. Do a DESCRIBE L09SalesRep to ensure it executed

-- Q4 - Solution
ALTER TABLE L09SalesRep
    ADD JobCode VARCHAR2(12);
    
DESCRIBE L09SalesRep; 

-- Question 5 - Declare column Salary in table L09SalesRep as mandatory one and Column Location in table L09GoodCust 
-- as optional one. You can see location is already optional.

-- Q5 - Solution

ALTER TABLE L09SalesRep
    MODIFY salary NOT NULL;

ALTER TABLE L09GoodCust
    MODIFY ("location" NULL);

DESCRIBE L09GoodCust; 

-- Question 5 - Lengthen FNAME in L09SalesRep to 37. The result of a DESCRIBE should show it happening
-- Q5 - Solution

ALTER TABLE L09SalesRep
    MODIFY fname VARCHAR2(37);
    
DESCRIBE L09SalesRep;

SELECT max(length("name")) AS max_len
    FROM L09GoodCust;
ALTER TABLE L09GoodCust
    MODIFY "name" VARCHAR(17);
    
DESCRIBE L09GoodCust;
    
-- Question 6 - Now get rid of the column JobCode in table L09SalesRep in a way that will not affect daily performance. 
-- Q6 - Solution 

ALTER TABLE L09SalesRep
    DROP COLUMN jobcode;

-- Question 7 -Declare PK constraints in both new tables ? RepId and CustId
-- Q7 - Solution

ALTER TABLE L09SalesRep
    ADD CONSTRAINT pk_repid 
    PRIMARY KEY (repid);
    
ALTER TABLE L09GoodCust
    ADD CONSTRAINT pk_cust 
    PRIMARY KEY (cust_id);
    
-- Question 8 - Declare UK constraints in both new tables ? Phone# and Name
-- Q8 - Solution

ALTER TABLE L09SalesRep
    ADD CONSTRAINT uk_phone 
    UNIQUE (phone#);
    
ALTER TABLE L09GoodCust
    ADD CONSTRAINT uk_name
    UNIQUE ("name");
    
-- Question 9 - Restrict amount of Salary column to be in the range [6000, 12000] and Commission to be not more than 50%.
-- Q9 - Solution

ALTER TABLE L09SalesRep
    ADD CONSTRAINT ck_salary 
    CHECK ((salary>=6000 AND salary<=12000) AND (commission<0.5));

-- Question 10 - Ensure that only valid RepId numbers from table L09SalesRep may be entered in the table L09GoodCust. 
-- Why this statement has failed?
-- Q10 - Solution

ALTER TABLE L09GoodCust
    ADD CONSTRAINT fk_repid
    FOREIGN KEY (repid)
    REFERENCES L09SalesRep(repid);

--this statement failed because there were data already inserted

-- Question 11 - Firstly write down the values for RepId column in table L09GoodCust and then make all these values blank. 
-- Now redo the question 10. Was it successful?

UPDATE L09GoodCust
SET repid='';

ALTER TABLE L09GoodCust
    ADD CONSTRAINT fk_repid
    FOREIGN KEY (repid)
    REFERENCES L09SalesRep(repid);
    
-- it is working now because there is no data 

-- Question 12 - Disable this FK constraint now and enter old values for RepId in table L09GoodCust and save them.
-- Then try to enable your FK constraint. What happened? 
-- Q12 - Solution

ALTER TABLE L09GoodCust
DISABLE CONSTRAINT fk_repid; 

UPDATE L09GoodCust
SET repid = CASE when cust_id = 502 then 202
                 when cust_id = 503 then 202
                 when cust_id = 504 then 202
                 when cust_id = 701 then 10
             ELSE null
             END;
             
ALTER TABLE L09GoodCust
ENABLE CONSTRAINT fk_repid; 
-- it did not work because can't validate

--Question 13 - Get rid of this FK constraint. Then modify your CK constraint from question 9 to allow Salary amounts 
-- from 5000 to 15000.
-- Q13 - Solution

ALTER TABLE L09GoodCust
    DROP CONSTRAINT fk_repid;
    
ALTER TABLE L09SalesRep
    DROP CONSTRAINT ck_salary;
    
ALTER TABLE L09SalesRep
   ADD CONSTRAINT ck_salary CHECK (salary>5000 AND salary<15000);


-- Question 14 - Describe both new tables L09SalesRep and L09GoodCust and then show all constraints for these 
-- two tables by running the following query:
-- Q14 - Solution
DESCRIBE L09SalesRep;

DESCRIBE L09GoodCust;

SELECT  constraint_name, constraint_type, search_condition, table_name
FROM     user_constraints
WHERE table_name IN (' L09SalesRep',' L09GoodCust')
ORDER  BY  4 , 2;

SELECT * FROM L09SalesRep;
