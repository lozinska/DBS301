----------------------------------------------------------------------
-- Name: Jonathan Mani, Portia Siddiqua, Krystyna Lopez
-- Student: 123280182, 146736178,107741179
-- DBS301 Assignment2
-- April 9, 2019
-- Purpose: Create database for John Wick. Revoking and Granting permission
----------------------------------------------------------------------

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