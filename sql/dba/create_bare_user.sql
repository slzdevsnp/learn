/*
script to create a user with  
with only connect initial privilege
*/

CREATE USER bare IDENTIFIED BY "bare";

GRANT CONNECT to bare;

GRANT SELECT_CATALOG_ROLE to bare;
GRANT SELECT ANY DICTIONARY to bare;

