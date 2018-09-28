
ora_ess-views-synonyms-triggers


VIEWS
SYNONYMES
SEQUENCES
TRIGGERS

oracle resources

https://docs.oracle.com/database/121/index.htm

http://buildingbettersoftware.blogspot.com


CHAP
VIEWS
    what is a view,  when would i use it, how to create a view

    a view acts as a virtual table with data from 1 or more tables
    view can contain a select with a join with a filter in where and an aggregate function

    reasons for a view:
        complex queries can be encapsulated into a view
        tables and columns can be given more meaningful names in a view
        security:  create view on a subset of columns 


    to create a vew you need  CREATE VIEW privilege


    syntax: 
    CREAT or REPLACEVIEW  <<viewname >> as 
    Select  <col1>,...
    FROM <<tbl1>>, <tbl..>
    where <<join condition >> AND <<filter condition>> [aggregate condition]


    /* example of creating a view on multiple joins on student schema */
    CREATE OR REPLACE VIEW degree_course_requirements AS 
    SELECT
      d.department_code as degree_department_code,
      dd.department_name as degree_department_name,
      d.degree_type_code, d.degree_name,
      cs.class_standing_code , cs.class_standing_name,
      s.session_code, s.session_name,
      d.department_code, c.course_number,
      c.course_title, c.course_description, c.credits
    FROM  degrees d
    INNER JOIN degree_requirements r 
        ON d.degree_id = r.degree_id
    INNER JOIN courses c
        on  r.department_code = c.department_code
        AND r.course_number = c.course_number
    INNER JOIN sessions s 
        on r.session_code = s.session_code
    INNER JOIN departments dd   
        ON d.department_code = dd.department_code
    INNER JOIN class_standings cs 
        on r.class_standing_code = cs.class_standing_code
    ;

    ---query the view to get all courses to obtain a cs degree
    select  class_standing_name, session_name, department_code, course_number, course_title, credits
    from degree_course_requirements
    where degree_department_code = 'CS'
    and degree_type_code = 'BS'
    ORDER BY class_standing_code, department_code, course_number;


    /*view on a subset of columns   */

    CREATE OR REPLACE VIEW current_compsci_students AS
    SELECT student_id, first_name, middle_name, last_name, gender, email, d.degree_name 
    FROM students s 
    INNER JOIN degrees d 
        ON d.degree_id = s.degree_pursued
    WHERE  
        d.department_code = 'CS'
        AND s.student_status = 'E';

   /* common use of views, grant them to less privileged users */
   GRANT SELECT on current_compsci_students TO student_web;

   ! Read only view 
   CREATE VIEW <<viewname>> AS 
   SELECT ...
   WITH READ ONLY;
   
   == DML against views 
        allowed in some situations  
        DML cannot be used against view if:
            view contains: distinct,  GROUP BY, ORDER BY, STATRTS WITH , a subquery as a column 
        DML allowed on a simple view  on 1 table   (insert, update, delete) (all table constraints hold)
       
        views with simple joins, still can do DML in limited scenarios
            only 1 table will be modified  (key preserve table : unique key of table is unique key of view)

    example of a view with join  


    /* == view with a join for DML  */
    CREATE or REPLACE VIEW department_degrees AS 
    SELECT d.degree_id, d.department_code, dd.department_name,
        d.degree_type_code, d.degree_name
    FROM degrees d 
    INNER JOIN departments dd 
        ON dd.department_code = d.department_code;

    -- insert into this view 
    INSERT INTO department_degrees (department_code, degree_type_code, degree_name)
        VALUES ('CS', 'MS', 'Master of Science in Software Engineering');

    -- update  works because modifying data in key preserved table)
    UPDATE department_degrees
        SET degree_name = 'Masters of Science in Systems Engineering'
        WHERE degree = 16 ;


    -- a help to see which columns are updatable in the view
    SELECT * FROM USER_UPDATABLE_COLUMNS WHERE TABLE_NAME = 'DEPARTMENT_DEGREES';


    NB! try to avoid  execute DML on a view with multiple joins 

     
     !! With check option (useful if doing DML on views) 

CREATE OR REPLACE VIEW computer_science_courses AS 
SELECT 
    c.department_code, c.course_number,
    c.course_title, c.course_description, c.credits
FROM courses c 
WHERE c.department_code = 'CS'
WITH CHECK OPTION;

--- cannot insert data for non 'CS' course


View  is like a virtual table 
    views is for people who want simple query 
    view create a logica view of your data 
    view is a logic object i.e.  underlying table constraints hold
    oracle translates a select on a view into a select on underlying tables 

    NB! avoid encapsulating complex business logic , subqueries , complex functions into  a view 

    the DB design that is simple, expressive and easy to understand almost always is more maintainable in the long run.

    Materialized view, or snapshot as they were previously known, is a table segment whose contents are periodically refreshed based on a query, either against a local or remote table.
    
    Use-case  : replication of data between two databases


CHAP TRIGGERS (36 m)
    trigger is a block of code firing at an event in DB  i.e. DML, system event
    

    common uses of triggers 
        update admin columns i.e. created, modified columns 
        audit changes to a table. copy a record in archive table 
        enforce complex business constraints (i.e. check if new value within the range,
                                             which is stored in another table) 

    triggers do not play well when:
        you put application logic in triggers    
            not evident to debug the program as trigger is an independent construct 

    type of triggers:
        * statement level trigger 
        * row level trigger 
        * system trigger (create table) reserved to dbas

    trigger base syntax:
        CREATE [OR REPLACE] TRIGGER <<trigger_name>>
        [BEOFRE | AFTER ] [INSERT | UPDATE | DELETE]
        [OF <<col_name>>]
        ON  <<table_name>>
        [FOR EACH ROW]
    DECLARE --plsql block from here
        --variable , procs declarations 
    BEGIN 
        --trigger code 

    EXCEPTION
        WHEN ...
            -- exception handling 
    END;

    -- triggers can have conditional predicates 
    CREATE [OR REPLACE] TRIGGER <<trigger_name>>
    ....
    BEGIN 
        CASE 
            WHEN INSERTING THEN
                -- insert logic 
            WHEN UPDATING(<<col_name>>) THEN
                -- column spec logic 
            WHEN UPDATING THEN 
                --update spec logic 
            WHEN DELETING  THEN 
                -- delete specific logic    
        END CASE ;
    END;

    Enabling disabling triggers (for ex for admin, bulk operations)
        ALTER TRIGGER  <<trigger name>> DISABLE ;
        ALTER TRIGGER <<table_name >>  DISABLE ALL TRIGGERS; 

        ALTER TRIGGER  <<trigger name>> ENABLE ;
        ALTER TRIGGER <<table_name >>  ENABLE ALL TRIGGERS; 


    triggers cannot have commit or rollback statements in their body
    they are part of the transaction for which they fire 

    firing order of triggers 
    before statemenet -> before each row -> statement ex -> after each row ->after statement


    demo update admin colum (modified stamp)


    demo archive a row
        in overview plsql file

    demo  trigger for autoincriment a primary key
        in overview plsql file

    COMPOUND trigger   
        a trggger  than can fire at multiple points in the statement life-cycle
            useful in bulk row operations 


    CREATE [OR REPLACE] TRIGGER <<trigger_name>>
        FOR [INSERT | UPDATE | DELETE]
        ON  <<table_name>>
    COMPOUND TRIGGER
        --variable , procs declarations 
    BEFORE STATEMENT IS
        BEGIN 
        --logic to fire before statement
        END BEFORE STATEMENT;
    BEFORE EACH ROW IS
        BEGIN 
        --logic to fire before each row
        END BEFORE EACH ROW;
    AFTER EACH ROW IS
        BEGIN 
        --logic to fire after each row
        END AFTER EACH ROW;
    AFER STATEMENT IS
        BEGIN 
        --logic after  statement
        END AFTER STATEMENT;
    END;

    demo in the plsql file


chap Synonyms
--------------
    create a synonym to a db object (table, view, proc, func, package, sequence)

    private and public synonyms

    private synonym has a scope of current user (common)

    public synonym has a scope of all users
        need a privilege to create public synonyms


    CREATE OR REPLACE SYNONYM <syn_name>> 
    for <<target_obj_name>>;

    most often used to create aliases for tables in another schema

    e.g.  CREATE SYNOYM rooms for facilities.rooms;
    




