ora essentials  tables and indexes.

code  Dropbox/cs/gcs/plural/plsql/oraestableidx/ex


indexes done 

privileges and roles 

example  enrollment databases 

apps : student web portal  , faculty web portal,  staff mgmt app, analytics ETL process

each app: to be ran under different users. can't be ran under studen login(has full control)

grant privileges on object to user|role; anki

revoke privileges on object to user|role; anki

 list of privileges on a table 
   alter, debug, delete, index,insert,read,references, select, update

 list of privileges on a view

pessimistic locking

! column level privileges  (insert, update, references privileges)
grant update (street_adddress, city, state, telephone,email) on students to students_web;

if you don't want a user to see some columns in the table solution: create a specific view,  grant select access to the view

CREATE VIEW v_employee_contact_info AS
select employee_id, first_naem, last_name, title, phone,email
FROm employees;

GRANT select on v_employee_contact_info TO web_user;

demo assigning object privileges 


--privileges on stored procedures on oracle

execute, debug privilege

execute privilege on stored proc  -> user does not need privielges on underlying tables

Procedures execute with the permissions of the owner of the procedure


stored procs offer some advantages to secure the data
example login process have execution grant on function check_password('user', 'password')

database roles

    a container of predefined set of privileges
    -> simplify management of permissions
    add new table to schema,  add this table to the roles 

--dba does it
CREATE ROLE  role_name;
GRANT select on departments to role_name;
GRANT select on courses to role_name;

--assign role to the user
GRANT role_name  to  <<user_name>>;

--security recommendations

    -- principle of least privilege  .give minimum privilege to get job done
    -- defense in depth. use multiple mechanisms to secure access to your data.

good practices 
    separate application users from the schema owner 
        Schema owner has full access to all objects
        Schema owner can perform DDL statements

    use separate oracle user for each application
    take time to assign appropriate access permissions


chap Table storage options 
---------------------------
    how table data is stored on disk

    tablespace  : logical structure
        needs to know tablespace block size
        (between 2kb and 32 kb)
    
        need to know to avoid row chaining (1 row in > 1 block)
    segment space management
        automatic
        manual

    oracle contains multiple tablespaces
        system table space
        temp  (for temporary tables (large sorts))
        user tablespaces 

    every user has a default tablespace
    create table ( .... ) TABLESPACE <<tblspace_name>>;

    high water mark: a block with highest id that ever contained data

    truncate <<tblename>> resets high-water mark to zero (does not work on tables with foreign keys)

    PCTFREE in pourcentage is a free space in a block for data updates, default value = 10 %  you can specify it in CREATE TABLE  statement

    PCTUSED (only in manual segment space mgmt)

    row migration process
        copying a row to a new data block
        creates  a poiner from old block to new block           
    
    freelists
    CREATE TABLE ..... STORAGE (FREELISTS 12);  
                    -- estimate 12 concurent dmls for this table
                    --- ignored with automatic segment management

    Row Chaining 
        when a row is too big to fit in a data block, so needs
        to store row data in a next block
        avoid for performance issues 


    admin/utlchain.sql


    make sure to use a sufficiently large block size
    for OLTP  block size of 4  KB ok 
    for Data warehouse block size of 16 or 32 KB are often used


    vertically partion table
        columns frequently used in table A (primary), columns less used in a table B secondary table, PK column on both
        sides 


chap Specialized table types
----------------------------

    global temporary tables (retain data for transaction or a session)


    global temp table  created and kept
        data is private to the session

    CREATE GLOBAL TEMPORARY TABLE <<tblname>> ... 
    ON COMMIT DELETE ROWS   -- transaction scope  (default)
    --ON COMMIT PRESERVE ROWS;

    cannot have FK to temp table 
    you can create indexes on temp table


    external tables  (data in flat files)

    define external structure in a database to match the file with data

    for loading data into oracle

    CREATE TABLE <<tabname>> ( columns... )
    ORANIZATION EXTERNAL
    (
        TYPE ORACLE LOADER
        ...
        ....
        FIELDS
        (
        ...
        )
        LOCATION ('filename_in_ora_import_dir')
    )

    also possible to link csv files

    external table resources
    Oracle loader access driver


