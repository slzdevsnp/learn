-- run under learn schema
--- create a schema 

drop table employee;
drop table departments;



CREATE TABLE departments
(dept_id NUMBER NOT NULL PRIMARY KEY,
dept_name VARCHAR2(60));




INSERT INTO departments (dept_id,dept_name)
                      VALUES(1,'IT');
INSERT INTO departments (dept_id,dept_name)
                      VALUES(2,'Accounting');
COMMIT;




CREATE TABLE employee
(emp_id NUMBER NOT NULL PRIMARY KEY,
emp_name VARCHAR2(60),
emp_dept_id  NUMBER ,
emp_loc VARCHAR2(60),
emp_sal  NUMBER,
emp_status VARCHAR2(1),
CONSTRAINT emp_dept_fk FOREIGN KEY(emp_dept_id) 
REFERENCES departments(dept_id));




insert into employee(emp_id,emp_name,emp_dept_id,emp_loc,emp_sal,emp_status) VALUES(10,'Tom',1,'CA',50000,'A');
insert into employee(emp_id,emp_name,emp_dept_id,emp_loc,emp_sal,emp_status) VALUES(20,'John',1,'CA',40000,'A');
insert into employee(emp_id,emp_name,emp_dept_id,emp_loc,emp_sal,emp_status) VALUES(50,'Tim',2,'WA',40000,'A');
insert into employee(emp_id,emp_name,emp_dept_id,emp_loc,emp_sal,emp_status) VALUES(60,'Jack',2,'WA',70000,'A');
COMMIT;


----------------
-- ch Procedures
----------------
DECLARE 
   message  varchar2(64):= 'Procedures'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 

CREATE OR REPLACE PROCEDURE update_dept  AS
  l_emp_id employee.emp_id%TYPE := 10;
  BEGIN
    UPDATE employee
        SET emp_dept_id = '2'
    WHERE emp_id = l_emp_id;
    DBMS_OUTPUT.PUT_LINE('Rows Updated '||SQL%ROWCOUNT);
    COMMIT;
  EXCEPTION
      WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE(SQLERRM);
       DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
       rollback;
       raise;
  END update_dept;
/
/* call the proc in anonymous block */
BEGIN
  update_dept;
END;
/
/* call the proc as a squl statement */
exec update_dept;

--select * from employee;


----------------
-- ch functions
----------------
DECLARE 
   message  varchar2(64):= 'Functions'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 

create or replace  FUNCTION get_tier  RETURN NUMBER  AS
    l_salary NUMBER := 50000;
    l_return NUMBER;
BEGIN
      IF l_salary < 40000 THEN
         l_return := 1;
      ELSIF l_salary < 60000 THEN
         l_return := 2;
      ELSE
         l_return := 3;
       END IF;
     DBMS_OUTPUT.PUT_LINE('salary tier: '||l_return);
     RETURN l_return;
EXCEPTION
      WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
       DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_backtrace);
END get_tier;
/

/*call the func */
DECLARE 
    salary_tier number;
BEGIN
    salary_tier := get_tier();
END;
/

----------------
-- parameters in procedures & funcs
----------------
DECLARE 
   message  varchar2(64):= 'Parameters in procs and funcs'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 


CREATE OR REPLACE 
     PROCEDURE update_emp(  p_emp_id          IN  NUMBER,
                            p_dept_id             NUMBER,
                            p_location       OUT  NOCOPY VARCHAR2,  --3NOCOPY VARCHAR2
                            p_status      IN OUT  NOCOPY NUMBER) AS --3NOCOPY NUMBER
       l_number  NUMBER;
   BEGIN
       DBMS_OUTPUT.PUT_LINE('Out parameter p_location initially '||p_location);
       DBMS_OUTPUT.PUT_LINE('In Out parameter p_status initially '||p_status);
       --p_emp_id := 30;  --- compile error  p_emp_id = IN (RO) param
       UPDATE           employee
         SET           emp_dept_id = p_dept_id
         WHERE            emp_id = p_emp_id
       RETURNING    emp_loc INTO p_location;
       p_status := 1;
       --l_number := 'CHAR'; -- raises the execption of wrong type conversion
       COMMIT; 
 EXCEPTION
      WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE(SQLERRM);
       DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
       ROLLBACK;
       RAISE;
  END update_emp;
/

/* use this proc */
DECLARE
    emp_id number;
    dept_id number;
    location varchar2(20);
    status number;
BEGIN
    emp_id := 10;
    dept_id := 1;
    location := 'NA';
    status := 0;
    
    update_emp(p_emp_id => emp_id, p_dept_id => dept_id,
            p_location => location, p_status=>status);   
    DBMS_OUTPUT.PUT_LINE('extracted location; '|| location);
    DBMS_OUTPUT.PUT_LINE('proc execution status; '|| status);
    
END;
/

/* constraints on formatl parameters */

DECLARE
 SUBTYPE charsubtype IS VARCHAR2(2) NOT NULL;
  PROCEDURE testsubtype ( p_char IN charsubtype ) AS BEGIN
    DBMS_OUTPUT.PUT_LINE(p_char); 
  END testsubtype;
BEGIN
    testsubtype('TEST');
    --testsubtype(NULL);
END;
/

----------------
-- local subprograms
----------------
DECLARE 
   message  varchar2(64):= 'local subprograms'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 

DECLARE
    l_emp_id number := 10;
    
    l_dept_id departments.dept_id%TYPE := 2;
    -- this is a local proc.  not visible outside this block
    PROCEDURE display_message(p_location IN VARCHAR2, p_msg VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('***'||p_location||'***');
        DBMS_OUTPUT.PUT_LINE(p_msg);
    END display_message;
BEGIN
    display_message('Before Updating', 'Input Employee ID:'|| l_emp_id);
    UPDATE employee
    SET emp_dept_id = l_dept_id
    WHERE emp_id = l_emp_id;
    display_message('After Updating', 'Rows Updated:' ||SQL%ROWCOUNT);
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM); DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE); RAISE;
END ;
/

select * from employee;

