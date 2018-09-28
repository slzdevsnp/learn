-- this plsql file runs under schema : slava
-- imported database model is under student

drop table courses;
drop table departements;



set serveroutput on;


CREATE OR REPLACE PROCEDURE pretty_chapter(message varchar2,
                                            lc char default '*' ) 
 AS
 lc_str varchar2(256)  := '';
 msg_str varchar2(256);
BEGIN
  msg_str := 'CHAPTER :' || message;
  FOR i in 1 .. length(msg_str) LOOP
    lc_str  := lc_str || lc;
  END LOOP;
  dbms_output.put_line(lc_str);
  dbms_output.put_line(msg_str);
  dbms_output.put_line(lc_str);
END pretty_chapter;
/


-------
DECLARE 
   message  varchar2(100):= 'Introduction'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/


/* documentation */

/*
root of ora 12 doc
https://docs.oracle.com/database/121/index.htm

on left appliction development
book : Concepts

book : SQL Language Reference
    -> Create Synonym  -> Create Table
            -> snake diagram
*/

/*
oracle vm images

http://www.oracle.com/technetwork/community/developer-vm/index.html

Database application developer vm

*/

/*
http://buildingbettersoftware.blogspot.ch/2014/05/e-r-diagram-for-sample-university.html
university enrolment schema
imported under student

*/

-------
DECLARE 
   message  varchar2(100):= 'Table Basics'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/

/*
virtual columns in tables
from 11g
not stored on disk
computed from physical columns

*/

-------
DECLARE 
   message  varchar2(100):= 'Table Constraints'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/

/* constraints are:
    primary keys
    foreign keys
    check constraints

constraints help to enforce data integrity
*/

/*
Primary keys

any column that's part of a primary key CANNOT contain null values

pkeys 
    natural key  (combination of naturally occuring columns that form unique key
    surrogate key ( a unique value generated for each row)
            using oracle sequence or identity column
            
careful naming in the DB is important  as it is easier to work in the long run

recommendations

every table in db should have a primary key defined
values of primary key should be immutable!!

ORACLE ROWID
------------

every row, any table contains a pseudo-column called ROWID, 
 ROWID represents address of the row in the table
 ROWID is unique  but you should NOT use it as PK
    -> ROWID can change over sessions
select t.rowid, t.* from terms t;

 
*/


/* Foreign Keys 

put the relational in relational databases

FK column can cantain ONLY a set of values fom a referenced table

*/
--- 2 related tables defined


--- this example is to be run in slava schema 
drop table DEPARTMENTS;
drop table COURSES;

CREATE TABLE DEPARTMENTS 
(   "DEPARTMENT_CODE" VARCHAR2(2 BYTE) NOT NULL ENABLE, 
	"DEPARTMENT_NAME" VARCHAR2(25 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "PK_DEPARTMENTS" PRIMARY KEY ("DEPARTMENT_CODE")
);



CREATE TABLE COURSES(
    department_code     VARCHAR2(2)     NOT NULL,
    course_number       NUMBER(3,0)     NOT NULL,
    course_title        VARCHAR(64)     NOT NULL,
    course_description  VARCHAR2(512)   NOT NULL,
    credits             NUMBER(3,1)     NOT NULL,
    CONSTRAINT pk_courses
        PRIMARY KEY (department_code, course_number),
    CONSTRAINT fk_courses_department_code
        FOREIGN KEY (department_code)
        REFERENCES DEPARTMENTS (department_code)

);

INSERT INTO departments VALUES ('MA', 'Math');
INSERT INTO departments VALUES ('CS', 'Computer Science');
INSERT INTO departments VALUES ('PH', 'Physics');
INSERT INTO departments VALUES ('MG', 'Management'); -- put 'MA' and you have PK error

insert into courses values('MA', '101', 'Calculus 1', 'math foundation', 4.0);
insert into courses values('CS', '111', 'Algorithms 1', 'algos foundation', 5.0); -- put code HH and error
insert into courses values('PH', '31', 'Electrodynamics', 'maxwel et al', 4.0); -- put code HH and error


select * from courses;
select * from departments;

/* on delete cascade 
..
    CONSTRAINT fk_courses_department_code
        FOREIGN KEY (department_code)
        REFERENCES DEPARTMENTS (department_code)
        ON DELETE CASCADE
);

/*
to delete a primary key value, no child records in referenced tables should exist

*/

/* Deferred constraints  
- do not enforce constraints until transaction is commited

..
    CONSTRAINT fk_courses_department_code
        FOREIGN KEY (department_code)
        REFERENCES DEPARTMENTS (department_code)
        DEFERRABLE
            INITIALLY IMMEDIDATE   --enforce constraint on statement level
            --INITIALLY DEFERRABLE  -- always deferr until transaction commited
);


/* deferrable demo */

drop table COURSES;
drop table DEPARTMENTS;

CREATE TABLE DEPARTMENTS 
(   "DEPARTMENT_CODE" VARCHAR2(2 BYTE) NOT NULL ENABLE, 
	"DEPARTMENT_NAME" VARCHAR2(25 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "PK_DEPARTMENTS" PRIMARY KEY ("DEPARTMENT_CODE")
);

CREATE TABLE courses(
    department_code     VARCHAR2(2)     NOT NULL,
    course_number       NUMBER(3,0)     NOT NULL,
    course_title        VARCHAR(64)     NOT NULL,
    course_description  VARCHAR2(512)   NOT NULL,
    credits             NUMBER(3,1)     NOT NULL,
    CONSTRAINT pk_courses
        PRIMARY KEY (department_code, course_number),
    CONSTRAINT fk_courses_department_code
        FOREIGN KEY (department_code)
        REFERENCES DEPARTMENTS (department_code)
        DEFERRABLE  --- NB!!
        INITIALLY IMMEDIATE
);

INSERT INTO departments VALUES ('MA', 'Math');
INSERT INTO departments VALUES ('CS', 'Computer Science');
INSERT INTO departments VALUES ('PH', 'Physics');
INSERT INTO departments VALUES ('MG', 'Management'); -- put 'MA' and you have PK error


insert into courses values('MA', '101', 'Calculus 1', 'math foundation', 4.0);
insert into courses values('CS', '111', 'Algorithms 1', 'algos foundation', 5.0); -- put code HH and error
insert into courses values('PH', '311', 'Electrodynamics', 'maxwel et al', 4);

-- make a defferrable constraint deferred 
set constraint fk_courses_department_code deferred;

-- update parent key first
UPDATE departments
    set department_code = 'CO'
where department_code = 'CS';
-- update child keys later
UPDATE courses
    set department_code = 'CO'
where department_code = 'CS';
commit;


select * from departments;
select * from courses;

/*
 !! NB your db desing should imply that primary key is never changed.
 so that you never has to do any cascading  deletes, updates
 
 rather put a status column in a table 'inactive' and avoid deleting data
 
 
 if you have to update child records due to primary key changes -> consider
surrogate keys. -> potential to simplify system design
 
*/


/* check constraints   (chcks between columns from the sam table)*/

/*

create table states (
    region      varchar(2) NOT NULL,
    CONSTRAINT ch_state_egions
    CHECK (region IN ('NE', 'SE', 'MW', 'SC'))
    
    -- or
    CONSTRAINT ck_order_ship_date
    CHECK ( ship_date > order_date)
    
    
);

*/

/* #### disabling constraints*/

ALTER TABLE courses DISABLE CONSTRAINT fk_courses_department_code;

-- at enabling referential data integrity check is passed 
-- sometimes it is difficult to find reason why referential integirity is not satisifed after updates
ALTER TABLE courses ENABLE CONSTRAINT fk_courses_department_code;
-- i.e. avoid doing it. 

/* =================

make use of DB constraints because they help make 
business data clean!

 ================= */
 
 
 
/* ======Constraints strategy ===========

- database constraints
    one set of tools on DB level, make use of all tools available
    
- validate both in database and applications
    applications: provide immediate user feedback
    database: consistently enforce rules across all applications

- performance impact
    constraints can be checked in milliseconds
    bad data takes a long time to clean up.

 ============================ */
 
-------
DECLARE 
   message  varchar2(100):= 'Table storage (skipped)'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/


-------
DECLARE 
   message  varchar2(100):= 'Managing Tables'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/
/*  adding columns , changing data types, renaming objects */

/* oracle data dictionary, database statistics */

/*  === oracle data dictionary

Series of views containing metadata about all
database objects in Oracle

3 sets of views
    dba_*   :  info about all objects in db
    user_*  : info about objectgs owned by the current user
    all_*   | all of db objects the current user has permission to
*/

/* user_objects view  */

--all available views
select * from dictionary;


select * from user_objects;
select * from user_tables;
select * from user_tab_cols;  -- all columns from user created tables
select * from user_constraints; -- all user constraints

select * from user_indexes; -- all user created indexes
select * from user_ind_columns; -- all coluns in user index with their positions in indexes
select * from user_ind_columns
where table_name in ('STUDENT', 'COLLEGE');


/*  gathering statistics on objects

life of sql statment:
    parse phase (chck sql syntax, chk permissions)
    query optimization (evaluation statistics, create execution plan) 
    execution phase  (read blocks, filter rows, sort data0

    oracle optimizer computes how how most efficiently execute your statment  e.g.
        read entire tables, 
        using an index to look up rows
        how to join tables together
    => comes with the execution plan which will be most efficient to your statement
    
    opimizer uses database statistics stored on every table, column, index, etc.. 

   statstics gather as:
    -- periodically as scheduled by oracle
    
    -- manually by calling DBMS stats package
        after a large load operation for instance
*/

-- gather status on 1 table
exec dbms_stats.gather_table_stats('slava','student');
exec dbms_stats.gather_table_stats('slava','college');
                                    
--gather stats on whole schema (can take long time)
exec dbms_stats.gather_schema_stats('slava');


-------
DECLARE 
   message  varchar2(100):= 'Indexes'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/

/* demo create unique index */

select * from courses;

CREATE UNIQUE INDEX fx_courses_departmentnumbertitle_ui
on courses
(department_code, course_number,course_title)
TABLESPACE indexes;
select * from user_indexes where table_name = upper('courses');

--drop index fx_courses_departmentnumbertitle_ui;
--select * from v$tablespace;

-- run xtrace (f6 on query )
select * from courses where COURSE_NUMBER = '101'; -- this query is a table scane

select * from courses c
where c.DEPARTMENT_CODE = 'MA' and c.course_number = '101'; -- uses our index

select * from courses c
where c.department_code = 'MA' 
and c.course_number = '101'
and c.course_title like 'Calculus%' ; -- uses our index

/*
recomennendations on index creation

-- column order in index matters. your db query  must use the first column to use index
-- use as many columns as possible from the front of the index in your sql queries
-- index selectivity more columns = better. i.e. more distinct values in the index.
-- do not overindex your database 
   *- every index takes up space on disk
   *- oracle must sync the index during dml operations
-- make indexes your are creating to actually correspond to your db queries  
*/

select * from scott.emp;



