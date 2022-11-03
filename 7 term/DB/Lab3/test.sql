DROP DATABASE testdb;
CREATE DATABASE TestDB;
\c testdb
CREATE TABLE IF NOT EXISTS Supplier(
	ID INT,
	NAME VARCHAR(50) NOT NULL,
	ADDRESS VARCHAR(250) NOT NULL,
	PHONE_NUMBER VARCHAR(20) NOT NULL,
	PRIMARY KEY(ID)
);
CREATE TABLE IF NOT EXISTS Shipper(
        ID INT,
        NAME VARCHAR(50) NOT NULL,
        ADDRESS VARCHAR(250) NOT NULL,
        POSTAL_CODE VARCHAR(20) NOT NULL,
        PRIMARY KEY(ID)
);
CREATE TABLE IF NOT EXISTS Customer(
        ID INT,
        NAME VARCHAR(50) NOT NULL,
        ADDRESS VARCHAR(250) NOT NULL,
        PHONE_NUMBER VARCHAR(20) NOT NULL,
        PRIMARY KEY(ID)
);
CREATE TABLE IF NOT EXISTS Warehouse(
	ID INT,
	ADDRESS VARCHAR(250) NOT NULL,
	PHONE_NUMBER VARCHAR(20) NOT NULL,
	SUPPLIER_ID INT,
	PRIMARY KEY(ID),
	CONSTRAINT FK_SUPPLIER
		FOREIGN KEY(SUPPLIER_ID)
			REFERENCES SUPPLIER(ID)
);
CREATE TABLE IF NOT EXISTS Product(
	ID INT,
	NAME VARCHAR(50) NOT NULL,
	PRICE INT NOT NULL,
	NUMBER INT NOT NULL,
	PRIMARY KEY(ID)
);
CREATE TABLE IF NOT EXISTS Freight(
	ID INT,
	START_DATE DATE NOT NULL,
	END_DATE DATE NOT NULL,
	DESTINATION VARCHAR(250) NOT NULL,
	CUSTOMER_ID INT,
	PRIMARY KEY(ID),
	CONSTRAINT FK_CUSTOMER
		FOREIGN KEY(CUSTOMER_ID)
			REFERENCES CUSTOMER(ID)
);
CREATE TABLE IF NOT EXISTS Driver(
	ID INT,
	NAME VARCHAR(50) NOT NULL,
	PASSPORT_NUMBER VARCHAR(20) NOT NULL,
	FREIGHT_ID INT,
	SHIPPER_ID INT,
	PRIMARY KEY(ID),
	CONSTRAINT FK_FREIGHT
		FOREIGN KEY(FREIGHT_ID)
			REFERENCES FREIGHT(ID),
	CONSTRAINT FK_SHIPPER
		FOREIGN KEY(SHIPPER_ID)
			REFERENCES SHIPPER(ID)
);
CREATE TABLE IF NOT EXISTS Truck(
	ID INT,
	REGISTRATION_NUMBER VARCHAR(10) NOT NULL,
	MAX_LOAD INTEGER NOT NULL,
	DRIVER_ID INT,
	PRIMARY KEY(ID),
	CONSTRAINT FK_DRIVER
		FOREIGN KEY(DRIVER_ID)
			REFERENCES DRIVER(ID)
);
