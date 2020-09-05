----------------------------------------------------------------------
-- Name: Jonathan Mani, Portia Siddiqua, Krystyna Lopez
-- Student: 123280182, 146736178,107741179
-- DBS301 Assignment2
-- April 9, 2019
-- Purpose: Create database for John Wick. Creation Script
-- dbs301_191a39 contains all the tables with data
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

		agencyName VARCHAR2(25) NOT NULL,
		phoneNumber NUMBER(10) NOT NULL,
		propertyId  NUMBER (10) NOT NULL,
		agencyId# NUMBER (10) PRIMARY KEY,
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

CREATE TABLE referal(
referalId# NUMBER (10) PRIMARY KEY,
clientId NUMBER(6)  NOT NULL,
amtPaid DECIMAL (6,2) NOT NULL,
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
adId# NUMBER (10) PRIMARY KEY,
ouletId NUMBER (1) NOT NULL,
propertyId NUMBER(10) NOT NULL,
"name" VARCHAR2 (25) NOT NULL,
phonenumber NUMBER (10) NOT NULL,
dateOfPublication DATE NOT NULL,
costOfadvertising DECIMAL(5,2),
CONSTRAINT fk_ouletId FOREIGN KEY(ouletId) 
REFERENCES  typeofads(outletId#),
CONSTRAINT fk_propertyId_ad FOREIGN KEY(propertyId) 
REFERENCES  property(propertyId#)
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
 ALTER TABLE property
		ADD CONSTRAINT address_id_fk FOREIGN KEY (addressID) REFERENCES address(addressID#);   
        
-- Revoking ALL permissions from public on all tables that been created for this assignment

REVOKE ALL ON property FROM public;
REVOKE ALL ON agency FROM public;
REVOKE ALL ON ownershipinfo FROM public;
REVOKE ALL ON clientinfo FROM public;
REVOKE ALL ON client_ownership FROM public;
REVOKE ALL ON referal FROM public;
REVOKE ALL ON residential FROM public;
REVOKE ALL ON address FROM public;
REVOKE ALL ON typeofads FROM public;
REVOKE ALL ON advertisement FROM public;
REVOKE ALL ON advertisement_typeofads FROM public;
REVOKE ALL ON sales FROM public;
REVOKE ALL ON property_sales FROM public;
REVOKE ALL ON stateOfBusiness FROM public;
REVOKE ALL ON salesOfYear FROM public;
REVOKE ALL ON clients FROM public;
REVOKE ALL ON notSoldProperties FROM public;

--Granting ALL permissions to the group members and Clint on the tables that been created for this assignment

GRANT ALL ON property TO dbs301_191a43;
GRANT ALL ON property TO dbs301_191b18;
GRANT ALL ON property TO DBS301_191B45;
GRANT ALL ON property TO dbs301_191a39;
GRANT ALL ON address TO dbs301_191a43;
GRANT ALL ON address TO dbs301_191b18;
GRANT ALL ON address TO DBS301_191B45;
GRANT ALL ON address TO dbs301_191a39;
GRANT ALL ON sales TO dbs301_191a43;
GRANT ALL ON sales TO dbs301_191b18;
GRANT ALL ON sales TO DBS301_191B45;
GRANT ALL ON sales TO dbs301_191a39;
GRANT ALL ON agency TO dbs301_191a43;
GRANT ALL ON agency TO dbs301_191b18;
GRANT ALL ON agency TO DBS301_191B45;
GRANT ALL ON agency TO dbs301_191a39;
GRANT ALL ON residential TO dbs301_191a43;
GRANT ALL ON residential TO dbs301_191b18;
GRANT ALL ON residential TO DBS301_191B45;
GRANT ALL ON residential TO dbs301_191a39;
GRANT ALL ON property_sales TO dbs301_191a43;
GRANT ALL ON property_sales TO dbs301_191b18;
GRANT ALL ON property_sales TO DBS301_191B45;
GRANT ALL ON property_sales TO dbs301_191a39;
GRANT ALL ON ownershipinfo TO dbs301_191a43;
GRANT ALL ON ownershipinfo TO dbs301_191b18;
GRANT ALL ON ownershipinfo TO DBS301_191B45;
GRANT ALL ON ownershipinfo TO dbs301_191a39;
GRANT ALL ON clientinfo TO dbs301_191a43;
GRANT ALL ON clientinfo TO dbs301_191b18;
GRANT ALL ON clientinfo TO DBS301_191B45;
GRANT ALL ON clientinfo TO dbs301_191a39;
GRANT ALL ON client_ownership TO dbs301_191a43;
GRANT ALL ON client_ownership TO dbs301_191b18;
GRANT ALL ON client_ownership TO DBS301_191B45;
GRANT ALL ON client_ownership TO dbs301_191a39;
GRANT ALL ON referal TO dbs301_191a43;
GRANT ALL ON referal TO dbs301_191b18;
GRANT ALL ON referal TO DBS301_191B45;
GRANT ALL ON referal TO dbs301_191a39;
GRANT ALL ON advertisement TO dbs301_191a43;
GRANT ALL ON advertisement TO dbs301_191b18;
GRANT ALL ON advertisement TO DBS301_191B45;
GRANT ALL ON advertisement TO dbs301_191a39;
GRANT ALL ON typeofads TO dbs301_191a43;
GRANT ALL ON typeofads TO dbs301_191b18;
GRANT ALL ON typeofads TO DBS301_191B45;
GRANT ALL ON typeofads TO dbs301_191a39;
GRANT ALL ON advertisement_typeofads TO dbs301_191a43;
GRANT ALL ON advertisement_typeofads TO dbs301_191b18;
GRANT ALL ON advertisement_typeofads TO DBS301_191B45;
GRANT ALL ON advertisement_typeofads TO dbs301_191a39;
     