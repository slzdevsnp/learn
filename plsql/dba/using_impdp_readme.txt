

importing schema  data in oracle using impdp utility


1. create a new user with schema e.g. user = user . 

2. create a script to define the import_dir variable for oracle
   and run this script in sqlplus  as  sysdba
$ cat def_import-dir-student.sql 
CREATE OR REPLACE DIRECTORY import_dir AS '/home/oracle/oradata-import';
GRANT READ, WRITE ON DIRECTORY import_dir TO student;

3. ensure you copied our dmp data file under that folder

4. from cmd under oracle user run:

$>impdp  schemas=student  directory=import_dir  dumpfile=student_data.dmp logfile=import.log

when connected to oracle, type student user credentials

5. you may need to create an additional tablespace like or indexes 

i.e. 
[oracle@localhost dba]$ cat create_index_tablespace.sql

CREATE TABLESPACE INDEXES
 DATAFILE 'tbs_indexes.dat'
 size 50M
 REUSE
 AUTOEXTEND ON;



