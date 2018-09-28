-- run under student user 
/*
this course uses the same database students enrollment as in oracle tables and indexes
imported under student schema
*/
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

--how to see all tables created by current user

select table_name from user_tables order by table_name;


exec pretty_chapter('chap 5 Statement level performance');
------------------------------
 /*
 study query plan
 */
 SELECT cs.department_code, cs.course_number,
    cs.course_title, cs.credits, g.grade_code, g.points
    FROM course_enrollments_small c
    INNER JOIN grades g
        ON c.grade_code = g.grade_code
    INNER JOIN course_offerings co
        ON c.course_offering_id = co.course_offering_id
    INNER JOIN courses cs
        ON co.department_code = cs.department_code
        AND co.course_number = cs.course_number
    WHERE student_id = '206960'
        AND co.term_code = 'FA2012';

/*
alter index IX_COURSE_ENROLL_STUDENT_ID unusable;
--- see difference in the plan

alter index IX_COURSE_ENROLL_STUDENT_ID rebuild;

create index IX_COURSE_ENROLL_STUDENT_ID on course_enrollments (student_id);
*/

/*
 select * from COURSE_ENROLLMENTS
where student_id = '206960';

select * from course_offerings co 
where co.term_code = 'FA2012';
*/
-- mark index unsuable then rebuild it



exec pretty_chapter('chap 6 execution plans in depths');
------------------------------
--check all indexes on a user table
select * from user_ind_columns
where table_name = 'APPLICATIONS';


select * from applications
where zip_code = '11201'
and last_name = 'Rivera';

alter index IX_APPLICATIONS_FULLNAME unusable; 
alter index IX_APPLICATIONS_STATE unusable; 

alter index IX_APPLICATIONS_FULLNAME rebuild; 
alter index IX_APPLICATIONS_STATE rebuild; 

drop index ix_applications_zipcode
create index ix_applications_zipcode on Applications (zip_code);



 SELECT cs.department_code, cs.course_number,
    cs.course_title, cs.credits, g.grade_code, g.points
    FROM course_enrollments c
    INNER JOIN grades g
        ON c.grade_code = g.grade_code
    INNER JOIN course_offerings co
        ON c.course_offering_id = co.course_offering_id
    INNER JOIN courses cs
        ON co.department_code = cs.department_code
        AND co.course_number = cs.course_number
    WHERE student_id = '206960'
        AND co.term_code = 'FA2012';


--index unique scan operation
select * from students where email = 'LindaTMann@fleckens.hu';



select * 
from applications
where zip_code = '11201'
and last_name = 'Rivera';


drop index ix_applications_name_zip;
create index ix_applications_name_zip on Applications (last_name, first_name,zip_code);


exec pretty_chapter('chap 7 indexing essentials');
------------------------------

--select * from dictionary where table_name like 'USER_%' order by table_name;

--select all indexes  with all columns poistions on a tanle
select ic.*
from user_indexes ix
inner join user_ind_columns ic
on ix.index_name = ic.index_name
where ix.table_name = upper('applications')
order by ic.index_name, ic.column_position;

create index ix_applications_zip_name on applications(zip_code, last_name, first_name);
drop index ix_applications_zip_name;

select * from applications
where last_name = 'Harris'
and zip_code = '98951';

desc applications

-- how to compute a selectivity of the column
select (select count(distinct gpa) from applications ) / 
(select count(1) from applications)
from dual;

--ensure statistics up to date
SELECT to_char(last_analyzed, 'YYYY-MM-DD hh24:mm')
FROM all_tables
WHERE owner = upper('student')
AND table_name = upper('applications');

--force refresh stats
exec DBMS_STATS.GATHER_TABLE_STATS('student', 'applications');
-- sample 25 % of the rows
exec DBMS_STATS.GATHER_TABLE_STATS('student', 'applications', estimate_percent => 25);

--getting number of distinct values !! useful
SELECT column_name, num_distinct
    FROM all_tab_columns
    WHERE table_name = upper('applications')
    ORDER BY num_distinct DESC;
    
    
    
  --- selectivity demo
--/////////////////////////////////
--selectivity on multiple columns
--/////////////////////////////////
select count(1) from
    (select 
        distinct last_name, first_name, zip_code
    from applications);



  --select all indexes  with all columns poistions on a tanle
select ic.*
from user_indexes ix
inner join user_ind_columns ic
on ix.index_name = ic.index_name
where ix.table_name = upper('applications')
order by ic.index_name, ic.column_position;


-- disable all indexes on applications 

alter index IX_APPLICATIONS_FULLNAME unusable;
alter index IX_APPLICATIONS_NAME_ZIP unusable;
alter index IX_APPLICATIONS_STATE unusable;
alter index IX_APPLICATIONS_ZIPCODE unusable;


-- demo temp indexes
create index ix_applications_lname on applications (last_name);
drop index ix_applications_lname;



--cost of 341 (not very selective index)
select * from applications
where last_name = 'Harris'
and first_name = 'Sam';

alter index IX_APPLICATIONS_FULLNAME rebuild;
--cost of 2
select * from applications
where last_name = 'Harris'
and first_name = 'Sam';

-- enable all indexes on applications 

alter index IX_APPLICATIONS_FULLNAME rebuild;
alter index IX_APPLICATIONS_NAME_ZIP rebuild;
alter index IX_APPLICATIONS_STATE rebuild;
alter index IX_APPLICATIONS_ZIPCODE rebuild;



exec pretty_chapter('chap 8 advanced indexing techniques');
------------------------------

select ic.*
from user_indexes ix
inner join user_ind_columns ic
on ix.index_name = ic.index_name
where ix.table_name = upper('students')
order by ic.index_name, ic.column_position;


--query
select s.student_id, s.first_name, s.last_name,
    d.degree_name, cs.class_standing_name
from students s
inner join degrees d 
    on s.degree_pursued = d.degree_id
inner join class_standings cs 
    on cs.class_standing_code = s.class_standing_code 
where s.last_name = 'Jones';


drop index ix_students_name_search;
--covering index has all columns in a query 
create index ix_students_name_search on students (last_name, first_name, degree_pursued, class_standing_code, student_id);

--function based index
-- ex. case insensitive search

-- run autotrace f6
select * from students
where upper(last_name) =  upper('mcneil');

drop index fx_students_name;

--function based index
create index fx_students_name on students (UPPER(last_name));

exec DBMS_STATS.GATHER_TABLE_STATS('student', 'students');


select ic.*
from user_indexes ix
inner join user_ind_columns ic
on ix.index_name = ic.index_name
where ix.table_name = upper('applications')
order by ic.index_name, ic.column_position;



select  * 
from applications
where  application_status in ('N', 'P');


drop index fx_applications_app_status;

create index fx_applications_app_status
on applications
(
    case application_status
        when 'N' then 'N'
        when 'P' then 'P'
        else null
    end
);

-- corresponding sql statment for an index on a subset of rows
-- check autotrace
select  * 
from applications
where (
        case application_status
            when 'N' then 'N'
            when 'P' then 'P'
            else NULL
        end
      )
in ('N', 'P');

-- lets encapsulate this selective row logic ina UDF
create or replace FUNCTION map_application_status_value(application_status IN VARCHAR) 
   RETURN VARCHAR
   DETERMINISTIC
   IS 
   mapped_value VARCHAR2(1);
   BEGIN
       mapped_value :=
          CASE application_status
               WHEN 'N' THEN application_status
               WHEN 'P' THEN application_status
               ELSE NULL
           END;
        RETURN (mapped_value);   
END;
/
--now lets redefine index using this function and a corresponding sql statment
drop index fx_applications_app_status;

create index fx_applications_app_status on applications (map_application_status_value(application_status));

--use the select statment which is much cleaner (check F6)
select * from applications
where  map_application_status_value(application_status) IN ('N', 'P');

 --check size of index on subset of values (it is smaller than the index on all rows)
 select ix.index_name, ix.distinct_keys, ix.leaf_blocks, ix.avg_leaf_blocks_per_key, s.blocks, s.bytes
 from  all_indexes ix
 inner join dba_segments s 
 on ix.owner = s.owner 
 and ix.index_name  = s.segment_name
where  ix.index_name = upper('fx_applications_app_status'); 


--invisible index

select * from students
where zip_code = '97205';

drop index ix_students_zip_code;

create index ix_students_zip_code on students( zip_code)
invisible;

alter index ix_students_zip_code visible;

alter index ix_students_zip_code invisible;

alter session set optimizer_use_invisible_indexes=true;
--only this session will use an invisible index
select * from students
where zip_code = '97205';

alter session set optimizer_use_invisible_indexes=false;