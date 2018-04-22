/*
script to create a user with schema  
script runs under system user
*/

CREATE USER slava IDENTIFIED BY "mypwd";

GRANT CONNECT, RESOURCE to slava;

GRANT CREATE SESSION to slava;
GRANT CREATE TABLE to slava;
GRANT CREATE VIEW to slava;
GRANT CREATE ANY TRIGGER to slava;
GRANT CREATE ANY PROCEDURE to slava;
GRANT CREATE SEQUENCE to slava;
GRANT CREATE SYNONYM to slava;




GRANT UNLIMITED TABLESPACE to slava;

