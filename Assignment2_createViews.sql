----------------------------------------------------------------------
-- Name: Jonathan Mani, Portia Siddiqua, Krystyna Lopez
-- Student: 123280182, 146736178,107741179
-- DBS301 Assignment2
-- April 9, 2019
-- Purpose: Create database for John Wick. Creating views
-- dbs301_191a39 contains all the tables with data
----------------------------------------------------------------------

--Creates view that will produce the state of John Wick business

CREATE VIEW stateOfBusiness AS(
SELECT propertyId#,propertytype,area,listprice FROM property
);

--Creates view that will help to see John Wick his sales for the specified year

CREATE VIEW salesOfYear AS (
SELECT sum(sellPrice) AS total_sale
    FROM sales
    WHERE yearOfSale=&enterYear
);

--Creates view that will help John Wick to see his all clients 

CREATE VIEW clients AS (
SELECT clientid#, firstname, lastname, typeofclient
    FROM clientinfo
);

--Create view that can help John Wick to determine which properties are currently for sale

CREATE VIEW notSoldProperties AS(
SELECT propertyId#, propertytype,listprice,lotsize, maintenanceFee, sold
    FROM property FULL JOIN property_sales
        ON property.propertyid#=property_sales.propertyid
    WHERE upper(sold)='N'
);