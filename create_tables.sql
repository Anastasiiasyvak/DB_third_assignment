CREATE DATABASE ASSIGNMENT3;

USE ASSIGNMENT3;

--DROP TABLE IF EXISTS TOURS;

CREATE TABLE IF NOT EXISTS TOURS (
    ID VARCHAR(36) PRIMARY KEY,
    NAME VARCHAR(200) NOT NULL,
    START_DATE DATE NOT NULL,
    FINISH_DATE DATE NOT NULL,
    PRICE DECIMAL(10, 2) CHECK (PRICE > 0),
    AVAILABILITY ENUM('available', 'not available') NOT NULL,
    DESCRIPTION VARCHAR(500),
    MAX_PARTICIPANTS INT,
    MIN_PARTICIPANTS INT,
    CHECK (START_DATE < FINISH_DATE),
    CHECK (MIN_PARTICIPANTS <= MAX_PARTICIPANTS)
);

ALTER TABLE TOURS COMMENT = 'Table to store tour information';

ALTER TABLE TOURS
MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each tour',
MODIFY COLUMN NAME VARCHAR(200) COMMENT 'Tour name',
MODIFY COLUMN START_DATE DATE COMMENT 'Tour start date',
MODIFY COLUMN FINISH_DATE DATE COMMENT 'Tour finish date',
MODIFY COLUMN PRICE DECIMAL(10, 2) COMMENT 'Tour price',
MODIFY COLUMN AVAILABILITY ENUM('available', 'not available') COMMENT 'Indicates whether the tour is available',
MODIFY COLUMN DESCRIPTION VARCHAR(500) COMMENT 'Tour description',
MODIFY COLUMN MAX_PARTICIPANTS INT COMMENT 'Maximum number of participants for the tour',
MODIFY COLUMN MIN_PARTICIPANTS INT COMMENT 'Minimum number of participants required for the tour';



--DROP TABLE IF EXISTS CLIENTS;

CREATE TABLE IF NOT EXISTS CLIENTS (
    ID VARCHAR(36) PRIMARY KEY,
    NAME VARCHAR(200) NOT NULL,
    SURNAME VARCHAR(200) NOT NULL,
    EMAIL VARCHAR(200) NOT NULL,
    PHONE VARCHAR(50) NOT NULL
);

ALTER TABLE CLIENTS COMMENT = 'Table to store client information';

ALTER TABLE CLIENTS
MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each client',
MODIFY COLUMN NAME VARCHAR(200) COMMENT 'Client first name',
MODIFY COLUMN SURNAME VARCHAR(200) COMMENT 'Client surname',
MODIFY COLUMN EMAIL VARCHAR(200) COMMENT 'Client email address',
MODIFY COLUMN PHONE VARCHAR(50) COMMENT 'Client phone number';



--DROP TABLE IF EXISTS ORDERS;

CREATE TABLE IF NOT EXISTS ORDERS (
    ID VARCHAR(36) PRIMARY KEY,
    TOUR_ID VARCHAR(36),
    CLIENT_ID VARCHAR(36),
    ORDER_DATE DATE NOT NULL,
    TOTAL_PRICE DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (TOUR_ID) REFERENCES TOURS(ID) ON DELETE CASCADE,
    FOREIGN KEY (CLIENT_ID) REFERENCES CLIENTS(ID) ON DELETE CASCADE
);

ALTER TABLE ORDERS COMMENT = 'Table to store orders';

ALTER TABLE ORDERS
MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each order',
MODIFY COLUMN TOUR_ID VARCHAR(36) COMMENT 'Identifier for the tour',
MODIFY COLUMN CLIENT_ID VARCHAR(36) COMMENT 'Identifier for the client',
MODIFY COLUMN ORDER_DATE DATE COMMENT 'Date when the order was placed',
MODIFY COLUMN TOTAL_PRICE DECIMAL(10, 2) COMMENT 'Total price for the order';



--DROP TABLE IF EXISTS HOTELS;

CREATE TABLE IF NOT EXISTS HOTELS (
    ID VARCHAR(36) PRIMARY KEY,
    NAME VARCHAR(200) NOT NULL,
    COUNTRY VARCHAR(100) NOT NULL,
    ADDRESS VARCHAR(200) NOT NULL,
    RATING DECIMAL(2, 1) CHECK (RATING BETWEEN 3 AND 5)
);

ALTER TABLE HOTELS COMMENT = 'Table to store hotel information';

ALTER TABLE HOTELS
MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each hotel',
MODIFY COLUMN NAME VARCHAR(200) COMMENT 'Hotel name',
MODIFY COLUMN COUNTRY VARCHAR(100) COMMENT 'Country where the hotel is located',
MODIFY COLUMN ADDRESS VARCHAR(200) COMMENT 'Hotel address',
MODIFY COLUMN RATING DECIMAL(2, 1) COMMENT 'Hotel rating';



CREATE TABLE IF NOT EXISTS GUIDES (
    ID VARCHAR(36) PRIMARY KEY,
    NAME VARCHAR(200),
    SURNAME VARCHAR(200),
    PHONE VARCHAR(50),
    EMAIL VARCHAR(200)
);

ALTER TABLE GUIDES COMMENT = 'Table to store guide information';

ALTER TABLE GUIDES
MODIFY COLUMN ID VARCHAR(36) COMMENT 'Unique identifier for each guide',
MODIFY COLUMN NAME VARCHAR(200) COMMENT 'Guide first name',
MODIFY COLUMN SURNAME VARCHAR(200) COMMENT 'Guide surname',
MODIFY COLUMN PHONE VARCHAR(50) COMMENT 'Guide phone number',
MODIFY COLUMN EMAIL VARCHAR(200) COMMENT 'Guide email address';



CREATE TABLE IF NOT EXISTS TOUR_HOTELS (
    TOUR_ID VARCHAR(36),
    HOTEL_ID VARCHAR(36),
    FOREIGN KEY (TOUR_ID) REFERENCES TOURS(ID) ON DELETE CASCADE,
    FOREIGN KEY (HOTEL_ID) REFERENCES HOTELS(ID) ON DELETE CASCADE
);

ALTER TABLE TOUR_HOTELS COMMENT = 'Table to store relationship between tours and hotels';



CREATE TABLE IF NOT EXISTS TOUR_GUIDES (
    TOUR_ID VARCHAR(36),
    GUIDE_ID VARCHAR(36),
    FOREIGN KEY (TOUR_ID) REFERENCES TOURS(ID) ON DELETE CASCADE,
    FOREIGN KEY (GUIDE_ID) REFERENCES GUIDES(ID) ON DELETE CASCADE
);

ALTER TABLE TOUR_GUIDES COMMENT = 'Table to store relationship between tours and guides';



CREATE TABLE IF NOT EXISTS CLIENT_DETAILS (
    CLIENT_ID VARCHAR(36) PRIMARY KEY,
    ADDITIONAL_INFO VARCHAR(500),
    FOREIGN KEY (CLIENT_ID) REFERENCES CLIENTS(ID) ON DELETE CASCADE
);

ALTER TABLE CLIENT_DETAILS COMMENT = 'Table to store additional client details';

--(1:1 CLIENTS and CLIENT_DETAILS)
--(1:many TOURS and ORDERS)
--(many:many TOUR_GUIDES)
--(many:many TOUR_HOTELS)


 CREATE INDEX INDEX_TOURS_PRICE ON TOURS(PRICE);
 CREATE INDEX INDEX_TOURS_START_DATE ON TOURS(START_DATE);
 CREATE INDEX INDEX_TOURS_AVAILABILITY ON TOURS(AVAILABILITY);
 CREATE INDEX INDEX_HOTELS_RATING ON HOTELS(RATING);
