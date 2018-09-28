/*
script to create a perm and temp tablespaces
*/


--DROP TABLESPACE tbs_perm_01;
--DROP TABLESPACE tbs_temp_01;
-- DROP TALESPACE tbs_undo_01;

-- 1. permanent tablespace 
CREATE TABLESPACE tbs_perm_01
 DATAFILE 'tbs_perm_01.dat'
 size 50M
 REUSE
 AUTOEXTEND ON;
 
 --2. temporary tablespace
 CREATE TEMPORARY TABLESPACE tbs_temp_01
 TEMPFILE 'tbs_temp_01.dbf'
 size 10M
 AUTOEXTEND ON;
 
 
 --3. undo table space
 -- undo tablespaces is created to sore undo datga if the oracle databses is being run in automatic undo mgmt mode
 CREATE UNDO TABLESPACE tbs_undo_01
 DATAFILE 'tbs_undo_01.f'
 size 5M
 AUTOEXTEND ON
 RETENTION GUARANTEE;
 
 

-----
ALTER USER slava 
DEFAULT TABLESPACE tbs_perm_01
TEMPORARY TABLESPACE tbs_temp_01;

 
 
