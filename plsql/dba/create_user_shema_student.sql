/*
script to create a user with schema  
script runs under system user
*/

CREATE USER student IDENTIFIED BY "study";

GRANT CONNECT, RESOURCE to student;

GRANT CREATE SESSION to student;
GRANT CREATE TABLE to student;
GRANT CREATE VIEW to student;
GRANT CREATE ANY TRIGGER to student;
GRANT CREATE ANY PROCEDURE to student;
GRANT CREATE SEQUENCE to student;
GRANT CREATE SYNONYM to student;


GRANT UNLIMITED TABLESPACE to study;

