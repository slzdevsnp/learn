/*
script to create a user with schema  
script runs under system user
*/

CREATE USER learn IDENTIFIED BY "lrn";

GRANT CONNECT, RESOURCE to learn;

GRANT CREATE SESSION to learn;
GRANT CREATE TABLE to learn;
GRANT CREATE VIEW to learn;
GRANT CREATE ANY TRIGGER to learn;
GRANT CREATE ANY PROCEDURE to learn;
GRANT CREATE SEQUENCE to learn;
GRANT CREATE SYNONYM to learn;

GRANT UNLIMITED TABLESPACE to learn;

GRANT SELECT_CATALOG_ROLE to learn;
GRANT SELECT ANY DICTIONARY to learn;

