CREATE TABLE clientinfo(
clientId NUMBER(6) PRIMARY KEY,
firstName CHAR(30) NOT NULL,
lastName CHAR(30) NOT NULL,
phoneNumber NUMBER(10) NOT NULL,
email CHAR(15) NOT NULL,
typeOfClient CHAR(6) NOT NULL,
ownershipId NUMBER(4),
CONSTRAINT fk_ownershipid
FOREIGN KEY (ownership_id)
REFERENCES client_ownership(clientOwnershipId)
);

CREATE TABLE ownershipinfo(
ownershipId NUMBER(4) PRIMARY KEY,
pctOwnership NUMBER(3) NOT NULL,
propertyId NUMBER(10),
CONSTRAINT fk_property_id
FOREIGN KEY (propertyId)
REFERENCES property(propertyId)
);

CREATE TABLE client_ownership(
clientOwnershipId NUMBER(6) PRIMARY KEY,
clientId NUMBER(6),
ownershipId NUMBER(4),
CONSTRAINT fk_client_id
FOREIGN KEY (clientId)
REFERENCES clientinfo(clientId),
CONSTRAINT fk_ownership_id
FOREIGN KEY (ownershipId)
REFERENCES ownershipinfo(ownershipId)
);

CREATE TABLE typeofads(
outletId NUMBER(1) PRIMARY KEY,
typeOfOutlet CHAR(10) NOT NULL,
numberOfAds NUMBER(3)
);

CREATE TABLE advertisement_typeofads(
adTypeId NUMBER(5) PRIMARY KEY,
outletId NUMBER(1),
adId NUMBER(10),
CONSTRAINT fk_outlet_id
FOREIGN KEY (outletId)
REFERENCES typeofads(outletId),
CONSTRAINT fk_ad_id
FOREIGN KEY (adId)
REFERENCES advertisement(adId)
)




