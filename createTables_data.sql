----------------------------------------------------------------------
-- Name: Jonathan Mani, Portia Siddiqua, Krystyna Lopez
-- Student: 123280182, 146736178,107741179
-- DBS301 Assignment2
-- April 9, 2019
-- Purpose: Create database for John Wick
----------------------------------------------------------------------


CREATE TABLE property 
		(propertyID#        NUMBER(10)       PRIMARY KEY, 
		addressID          NUMBER(10),       
		noOfBedrooms       NUMBER(10)       NOT NULL,
		noOfBathrooms      NUMBER(10)       NOT NULL,
		area               NUMBER(7,2)      NOT NULL,
		propertyType       VARCHAR(5)       NOT NULL,
		maintenanceFee     NUMBER(7,2)      NULL,
		lotSize            NUMBER(8,2)      NULL,
		listPrice          NUMBER (10,2)     NOT NULL);


CREATE TABLE agency (

		agencyName varchar2(25) NOT NULL,
		phoneNumber number(10) NOT NULL,
		propertyId  number (10) NOT NULL,
		agencyId# number (10) primary Key,
        CONSTRAINT fk_propertyId FOREIGN KEY(propertyId) 
        REFERENCES  property(propertyId#));

CREATE TABLE ownershipinfo(
ownershipId# NUMBER(4) PRIMARY KEY,
pctOwnership NUMBER(3) NOT NULL,
propertyId NUMBER(10),
CONSTRAINT fk_property_id
FOREIGN KEY (propertyId)
REFERENCES property(propertyId#)
);    

CREATE TABLE clientinfo(
clientId# NUMBER(6) PRIMARY KEY,
firstName CHAR(30) NOT NULL,
lastName CHAR(30) NOT NULL,
phoneNumber NUMBER(10) NOT NULL,
email CHAR(30) NOT NULL,
typeOfClient CHAR(6) NOT NULL,
ownershipId NUMBER(4),
CONSTRAINT fk_ownershipId FOREIGN KEY(ownershipId) 
REFERENCES  ownershipinfo(ownershipId#)
);

CREATE TABLE client_ownership(
clientOwnershipId# NUMBER(6) PRIMARY KEY,
clientId NUMBER(6),
ownershipId NUMBER(4),
CONSTRAINT fk_client_id
FOREIGN KEY (clientId)
REFERENCES clientinfo(clientId#),
CONSTRAINT fk_ownership_id
FOREIGN KEY (ownershipId)
REFERENCES ownershipinfo(ownershipId#)
);

create table referal(
referalId# number (10) primary key,
clientId number(6)  NOT NULL,
amtPaid decimal (6,2) NOT NULL,
CONSTRAINT fk_clientId FOREIGN KEY(clientId) 
REFERENCES  clientinfo(clientId#)
);

CREATE TABLE residential (
		areaCode#            NUMBER(5)       PRIMARY KEY,
		nameOfArea          VARCHAR(20)     NOT NULL,
		nameOfSchool        VARCHAR(40)     NOT NULL );

CREATE TABLE address (
		addressID#           NUMBER(10)      PRIMARY KEY,
		street              VARCHAR(25)     NOT NULL,
		province            VARCHAR(3)      NOT NULL,
		postalCode          VARCHAR(7)      NOT NULL,
		areaCode            NUMBER(5),
		city                VARCHAR(20)     NOT NULL,
        CONSTRAINT areaCode_fk FOREIGN KEY (areaCode)
        REFERENCES residential(areaCode#));
        
CREATE TABLE typeofads(
outletId# NUMBER(1) PRIMARY KEY,
typeOfOutlet CHAR(10) NOT NULL,
numberOfAds NUMBER(3)
);

CREATE TABLE advertisement (
adId# number (10) primary Key,
ouletId number (1) NOT NULL,
"name" varchar2 (25) NOT NULL,
phonenumber number (10) NOT NULL,
dateOfPublication date NOT NULL,
costOfadvertising decimal(5,2),
CONSTRAINT fk_ouletId FOREIGN KEY(ouletId) 
REFERENCES  typeofads(outletId#)
);

CREATE TABLE advertisement_typeofads(
adTypeId# NUMBER(5) PRIMARY KEY,
outletId NUMBER(1),
adId NUMBER(10),
CONSTRAINT fk_outlet_id
FOREIGN KEY (outletId)
REFERENCES typeofads(outletId#),
CONSTRAINT fk_ad_id
FOREIGN KEY (adId)
REFERENCES advertisement(adId#)
);

CREATE TABLE sales (
    invoiceID#      NUMBER(5)       PRIMARY KEY,
    propertyID NUMBER(10),
    sellPrice   DECIMAL(10,2)    NOT NULL,       
    yearOfSale  NUMBER(4)       NULL,
    CONSTRAINT fk_propertyID_sale
    FOREIGN KEY (propertyID)
    REFERENCES property(propertyID#));

CREATE TABLE property_sales (
    propertySalesID#  NUMBER(5)      PRIMARY KEY,
    propertyID      NUMBER(10),
    invoiceID       NUMBER(5),
    sold             CHAR(1) CHECK(UPPER(sold) = 'Y' OR UPPER(sold) ='N'),
    CONSTRAINT fk_propertyID_jn
    FOREIGN KEY (propertyID)
    REFERENCES property(propertyID#),
    CONSTRAINT fk_invoiceID_jn
    FOREIGN KEY (invoiceID)
    REFERENCES sales(invoiceID#)
    );

INSERT ALL
    INTO property VALUES (01,101, 2, 2, 600, 'condo', 150.00,'', 500000)
    INTO property VALUES (02,102,3,3, 1300, 'house', null, 1700, 650000)
    INTO property VALUES (03,103, 2,2, 600, 'condo', 200.00, '', 600000)
    INTO property VALUES (04, 104, 4, 4,1500, 'house', null, 2000, 675000)
    INTO property VALUES (05, 105, 2, 2, 700, 'condo', 200.00, '', 550000)
    INTO property VALUES (06, 106, 4, 4, 1700, 'house', null, 2000, 700000)
    INTO property VALUES (07, 107, 2, 2, 600, 'condo', 150.00, '', 500000)
    INTO property VALUES (08, 108, 5, 5, 2000, 'house', null, 2200, 750000)
    INTO property VALUES (09, 109, 2,2, 700, 'condo', 200.00, '', 550000)
    INTO property VALUES (10, 101, 3, 3, 1300, 'house', null, 1700, 650000)
SELECT * FROM DUAL;

INSERT ALL
  
  INTO agency (agencyName,phoneNumber,propertyId,agencyId#) VALUES ('agencyA','4165215211',01,01)
  INTO agency (agencyName,phoneNumber,propertyId,agencyId#) VALUES ('agencyB','4165215212',02,02)
  INTO agency (agencyName,phoneNumber,propertyId,agencyId#) VALUES ('agencyC','4165215213',03,03)
  INTO agency (agencyName,phoneNumber,propertyId,agencyId#) VALUES ('agencyD','6475215214',04,04)
  INTO agency (agencyName,phoneNumber,propertyId,agencyId#) VALUES ('agencyE','4165215215',05,05)
  INTO agency (agencyName,phoneNumber,propertyId,agencyId#) VALUES ('agencyF','6475215216',06,06)
  INTO agency (agencyName,phoneNumber,propertyId,agencyId#) VALUES ('agencyG','4165215217',07,07)
  INTO agency (agencyName,phoneNumber,propertyId,agencyId#) VALUES ('agencyH','6475215218',08,08)
  INTO agency (agencyName,phoneNumber,propertyId,agencyId#) VALUES ('agencyI','4165215219',09,09)
  INTO agency (agencyName,phoneNumber,propertyId,agencyId#) VALUES ('agencyJ','6475215210',10,10)
    
SELECT *  FROM DUAL;

INSERT ALL
    INTO ownershipinfo VALUES(0001,50,01)
    INTO ownershipinfo VALUES(0002,34,02)
    INTO ownershipinfo VALUES(0003,20,03)
    INTO ownershipinfo VALUES(0004,50,04)
    INTO ownershipinfo VALUES(0005,25,05)
    INTO ownershipinfo VALUES(0006,40,06)
    INTO ownershipinfo VALUES(0007,70,07)
    INTO ownershipinfo VALUES(0008,100,08)
    INTO ownershipinfo VALUES(0009,60,09)
    INTO ownershipinfo VALUES(0010,100,10)
    SELECT * FROM dual;

INSERT ALL 
    INTO clientinfo VALUES (10,'Precious','Waterbury',6471234567,'pwaterbury@gmail.com','buyer',0001)
    INTO clientinfo VALUES (11,'Kathi', 'Severe',6471234568,'ksevere@gmail.com','seller',0002)
    INTO clientinfo VALUES (12,'Margaretta', 'Mcnellis',6471234569,'mmcnellis@gmail.com','seller',0002)
    INTO clientinfo VALUES (13,'Lizabeth', 'Thompkins',6471234560,'lthompkins@gmail.com','buyer',0010)
    INTO clientinfo VALUES (14,'Maryland', 'Brisker',6471234561,'mbrisker@gmail.com','seller',0002)
    INTO clientinfo VALUES (15,'Judith', 'Cevallos',6471234562,'jcevallos@gmail.com','buyer',0008)
    INTO clientinfo VALUES (16,'Darryl', 'Barnhart',6471234563,'dbarnhart@gmail.com','buyer',0008)
    INTO clientinfo VALUES (17,'Claudette', 'Lavallie',6471234564,'clavallie@gmail.com','buyer',0010)
    INTO clientinfo VALUES (18,'Jorge', 'Shellman',6471234565,'jshellman@gmail.com','buyer',0005)
    INTO clientinfo VALUES (19,'Marco', 'Bundrick',6471234566,'mbundrick@gmail.com','seller',0001)
    SELECT * FROM dual;

INSERT ALL
  
  INTO referal (referalId# ,clientId,amtPaid ) VALUES (121,10,500.00)
  INTO referal (referalId# ,clientId,amtPaid) VALUES (122,11,897.00)
  INTO referal (referalId# ,clientId,amtPaid) VALUES (123,12,492.00)
  INTO referal (referalId# ,clientId,amtPaid) VALUES (124,13,573.00)
  INTO referal (referalId# ,clientId,amtPaid) VALUES (125,14,513.00)
  INTO referal (referalId# ,clientId,amtPaid) VALUES (126,15,500.00)
  INTO referal (referalId# ,clientId,amtPaid) VALUES (127,16,600.00)
  INTO referal (referalId# ,clientId,amtPaid) VALUES (128,17,700.00)
  INTO referal (referalId# ,clientId,amtPaid) VALUES (129,18,800.00)
  INTO referal (referalId# ,clientId,amtPaid) VALUES (120,19,900.00)
    
SELECT * FROM DUAL;
    
INSERT ALL 
    INTO residential VALUES (10000, 'North York','A elementary School')
    INTO residential VALUES (20000,'Mississauga','B High School')
    INTO residential VALUES (30000,'East York','C elementary School')
    INTO residential VALUES (40000,'York','D High School')
    INTO residential VALUES (50000,'Etobocoke','F elementary School')
    INTO residential VALUES (60000,'Downtown Toronto','B junior High school')
    INTO residential VALUES (70000, 'Scarborough','G elementary' )
    INTO residential VALUES (80000,'Annex','K elementary school')
    INTO residential VALUES (90000,'The beach','P High School')
    INTO residential VALUES (10001,'Little Itally','J Elemetary')
SELECT * FROM DUAL;

INSERT ALL
    INTO address VALUES(101,'500 Kingston Rd','ON','M4L 1V3',10000,'Toronto')
    INTO address VALUES(102,'315 St Germain Ave','ON','M5M 1W4',10000,'Toronto')
    INTO address VALUES(103,'234 Willow Ave','ON','M4E 3K7',30000,'Toronto')
    INTO address VALUES(104,'26 Goodwood Park','ON','M4C 2G5',40000,'Toronto')
    INTO address VALUES(105,'48 St Clair Ave W','ON','M4V 2Z2',50000,'Toronto')
    INTO address VALUES(106,'1974 Queen St E','ON','M4L 1H8',60000,'Toronto')
    INTO address VALUES(107,'42 Balsam Ave','ON','M4E 3B4',70000,'Toronto')
    INTO address VALUES(108,'258 Waverley Rd','ON','M4L 3T6',80000,'Toronto')
    INTO address VALUES(109,'2441  Halsey Avenue','ON','M3B 2W6',90000,'Toronto')
    INTO address VALUES(110,'101 Hillingdon Ave','ON','M4C 3H9',10000,'Toronto')
    SELECT * FROM dual;
    
INSERT ALL
    INTO typeofads VALUES(01,'magazine',99)
    INTO typeofads VALUES(02,'web',150)
    INTO typeofads VALUES(03,'newspaper',598)
    SELECT * FROM dual;
    
INSERT ALL
  
  INTO advertisement (adId# ,ouletId,"name",phonenumber,dateOfPublication, costOfadvertising ) VALUES (111,01,'addComA',4161112222,to_date('19-01-02','yy-mm-dd'),100.00)
  INTO advertisement (adId# ,ouletId,"name",phonenumber,dateOfPublication, costOfadvertising) VALUES (112,02,'addComB',4161113333,to_date('19-03-22','yy-mm-dd'),101.00)
  INTO advertisement(adId# ,ouletId,"name",phonenumber,dateOfPublication, costOfadvertising) VALUES (113,03,'addComC',4161114444,to_date('19-04-12','yy-mm-dd'),102.00)
  INTO advertisement (adId# ,ouletId,"name",phonenumber,dateOfPublication, costOfadvertising) VALUES (114,01,'addComD',4161115555,to_date('19-01-23','yy-mm-dd'),103.00)
  INTO advertisement (adId# ,ouletId,"name",phonenumber,dateOfPublication, costOfadvertising) VALUES (115,02,'addComE',4161116666,to_date('19-02-02','yy-mm-dd'),104.00)
  INTO advertisement (adId# ,ouletId,"name",phonenumber,dateOfPublication, costOfadvertising) VALUES (116,03,'addComF',4161117777,to_date('19-04-02','yy-mm-dd'),105.00)
  INTO advertisement (adId# ,ouletId,"name",phonenumber,dateOfPublication, costOfadvertising) VALUES (117,01,'addComG',4161118888,to_date('19-02-13','yy-mm-dd'),106.00)
  INTO advertisement (adId# ,ouletId,"name",phonenumber,dateOfPublication, costOfadvertising) VALUES (118,02,'addComH',4161119999,to_date('19-01-20','yy-mm-dd'),107.00)
  INTO advertisement (adId# ,ouletId,"name",phonenumber,dateOfPublication, costOfadvertising) VALUES (119,03,'addComI',4162221111,to_date('19-01-30','yy-mm-dd'),108.00 )
  INTO advertisement (adId# ,ouletId,"name",phonenumber,dateOfPublication, costOfadvertising) VALUES (110,01,'addComJ',4163331111,to_date('19-04-05','yy-mm-dd'),109.00)
    
SELECT * FROM DUAL;

INSERT ALL 
    INTO sales VALUES(1001,01,450000,2018)
    INTO sales VALUES(1002,01,500000,2016)
    INTO sales VALUES(1003,05,550000,2018)
    INTO sales VALUES(1004,06,750000,2018)
    INTO sales VALUES(1005,01,350000,2015)
    INTO sales VALUES(1006,05,450000,2015)
    INTO sales VALUES(1007,08,700000,2019)
    INTO sales VALUES(1008,09,550100,2019)
    INTO sales VALUES(1009,09,450000,2017)
    INTO sales VALUES(1010,01,250000,2012)
    SELECT * FROM dual;
    
INSERT ALL
    INTO property_sales VALUES(0001,09,1009,'Y')
    INTO property_sales VALUES(0002,02,'','N')
    INTO property_sales VALUES(0003,03,'','N')
    INTO property_sales VALUES(0004,04,'','N')
    INTO property_sales VALUES(0005,05,1003,'Y')
    INTO property_sales VALUES(0006,06,1004,'Y')
    INTO property_sales VALUES(0007,07,'','N')
    INTO property_sales VALUES(0008,08,1007,'Y')
    INTO property_sales VALUES(0009,01,1010,'Y')
    INTO property_sales VALUES(0010,10,'','N')
    SELECT * FROM dual;

 ALTER TABLE property
		ADD CONSTRAINT address_id_fk FOREIGN KEY (addressID) REFERENCES address(addressID#);

drop table agency;
drop table client_ownership;
drop table referal;
drop table clientinfo;
drop table ownershipinfo;
drop table advertisement_typeofads;
drop table advertisement;
drop table typeofads;
drop table property;
drop table address;
drop table residential;
drop table sales;
drop table property_sales;


CREATE VIEW stateOfBusiness AS(
SELECT propertyId#,propertytype,area,listprice FROM property
);

CREATE VIEW salesOfYear AS (
SELECT sum(sellPrice) AS total_sale
FROM sales
WHERE yearOfSale=&enterYear
);

CREATE VIEW clients AS (
SELECT clientid#, firstname, lastname, typeofclient
FROM clientinfo
);

CREATE VIEW notSoldProperties AS(
SELECT propertyId#, propertytype,listprice,lotsize, maintenanceFee, sold
FROM property FULL JOIN property_sales
ON property.propertyid#=property_sales.propertyid
WHERE upper(sold)='N'
);

drop view salesOfYear;
select * from notSoldProperties;