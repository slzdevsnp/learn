If you are using Oracle 11g, unzip the Oracle 11g file and follow the directions in that README.txt

The database tables were exported using the Oracle data pump utility.  A good reference for this tool is located at: http://www.oracle-base.com/articles/10g/oracle-data-pump-10g.php

This will only work with Oracle 12c as the data was exported for 12c.  Again, if you are using 11g, look in the 11g zip file and follow those instructions.

To import the data, you need to use the impdp tool (import data pump) on the machine with Oracle installed.

1) I would strongly suggest creating a new user (schema) in in Oracle to house all of these objects.  The user I used was called student, but you can call it
anything you want.  

2) You need to create a directory that Oracle knows about.  This must be done as a SYSDBA user

	a) Create a direcoty on your file system (say C:\app\oracle-import) and place the student_data.dmp file in this directory
	b) As a SYSDBA user, run the command:  CREATE OR REPLACE DIRECTORY import_dir AS 'C:\app\oracle-import';  (use your direcotry path in this statement)
    c) GRANT READ, WRITE ON DIRECTORY import_dir TO <<your user name>>;  
	

3) Now, you can use the impdp command to import the data.  You run this command from a Powershell prompt, Command prompt or Unix Command line.

impdp <<your target user>> schemas=student remap_schema=student:<<your user name>> directory=import_dir dumpfile=student_data.dmp logfile=import.log

impdp  schemas=student  directory=import_dir  dumpfile=student_data.dmp logfile=import.log


<<your target user>> is the name of the user (schema) in your database that you want these tables created in.  These tables were originally created in
a schema called 'student'.  If you use a schema called 'student', you can omit the remap_user option.  Otherwise, you must include this option so Oracle
will create the tables in your schema name and not try to create them in student (which would fail)

When the process is successful, you will see something like this:

Connected to: Oracle Database 12c Release 12.1.0.1.0 - 64bit Production
Master table "STUDENT2"."SYS_IMPORT_SCHEMA_01" successfully loaded/unloaded
Starting "STUDENT2"."SYS_IMPORT_SCHEMA_01":  student2/******** schemas=student directory=export_dir dumpfile=student_sch
ema.dmp remap_schema=student:student2
Processing object type SCHEMA_EXPORT/PRE_SCHEMA/PROCACT_SCHEMA
Processing object type SCHEMA_EXPORT/SEQUENCE/SEQUENCE
Processing object type SCHEMA_EXPORT/TABLE/TABLE
Processing object type SCHEMA_EXPORT/TABLE/TABLE_DATA
. . imported "STUDENT2"."APPLICATIONS"                   12.10 MB   90000 rows
. . imported "STUDENT2"."STUDENTS"                       1.217 MB   10135 rows
. . imported "STUDENT2"."COURSE_ENROLLMENTS"             5.100 MB  243167 rows
. . imported "STUDENT2"."COURSE_OFFERINGS"               185.3 KB    6257 rows
. . imported "STUDENT2"."COURSE_ENROLLMENTS_SMALL"       103.9 KB    4544 rows
. . imported "STUDENT2"."COURSES"                        43.65 KB     144 rows
. . imported "STUDENT2"."CLASS_STANDINGS"                6.546 KB       6 rows
. . imported "STUDENT2"."DEGREES"                        7.171 KB      15 rows
. . imported "STUDENT2"."DEGREE_LEVELS"                  5.523 KB       2 rows
. . imported "STUDENT2"."DEGREE_REQUIREMENTS"            15.24 KB     280 rows
. . imported "STUDENT2"."DEGREE_TYPES"                   5.992 KB       3 rows
. . imported "STUDENT2"."DEPARTMENTS"                    5.703 KB      10 rows
. . imported "STUDENT2"."GRADES"                         6.046 KB       6 rows
. . imported "STUDENT2"."PERF_STATS"                     6.703 KB       9 rows
. . imported "STUDENT2"."SESSIONS"                       5.507 KB       3 rows
. . imported "STUDENT2"."STUDENTS_SMALL"                 35.93 KB     200 rows
. . imported "STUDENT2"."STUDENT_CLASS_TERMS"             8.25 KB      56 rows
. . imported "STUDENT2"."TERMS"                          6.312 KB      22 rows
. . imported "STUDENT2"."PERFORMANCE_CAPTURE_STATS"          0 KB       0 rows
Processing object type SCHEMA_EXPORT/TABLE/IDENTITY_COLUMN
Processing object type SCHEMA_EXPORT/TABLE/INDEX/INDEX
Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/CONSTRAINT
Processing object type SCHEMA_EXPORT/TABLE/INDEX/STATISTICS/INDEX_STATISTICS
Processing object type SCHEMA_EXPORT/VIEW/VIEW
Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/REF_CONSTRAINT
Processing object type SCHEMA_EXPORT/TABLE/STATISTICS/TABLE_STATISTICS
Processing object type SCHEMA_EXPORT/STATISTICS/MARKER
Job "STUDENT2"."SYS_IMPORT_SCHEMA_01" completed with 1 error(s) at Thu Mar 13 22:16:24 2014 elapsed 0 00:00:54


That should do it.  Now login to Oracle as that user and you should have all the tables there




************************************** Note ********************************************
The names in this database were generated using http://www.fakenamegenerator.com/.  
Any similarity to any person is purely a coincidence