-- oracle version
--select * from V$VERSION;

-----
-- ddl for this tutorial
-------
DROP TABLE CUSTOMERS;

----------------
-- Overview
----------------

/*
pl/sql is totally portable, 
high-performance transaction-processing language


-  extensive error checking , 
-  numerous data types
-  variety of programming strutures
-  programming through functions and procedures
- supports object oriented programming
- supports dev of web applications and server pages

== advantages
- sql is a standard db language, pl/sql is strongly integrated with sql
- plsql  supports static and dynamic sql  (dynamicsql: sql allows mbedding DDL
  statements in PL/SQL blocks)
-  PL/SQL allows sending an entire block of statements to the database
   at one time.  
- pl/sql offers desing, debugging, exception handling, encapsulation,
data hiding, object oriented data types
- apps written in plsql  are fully portable
-  provides high security level
-  gives access to predefined sql packages
-  support for OOProgramming
*/

DECLARE 
   message  varchar2(20):= 'Environment'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 

----------------
-- Environment
----------------

/*
after launching sqlplus command prompt  type @filename to execute your prog
*/

DECLARE 
   message  varchar2(20):= 'Basic Syntax'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 
----------------
--Basic syntax
----------------
/*
general block structure
DECLARE 
   <declarations section> 
BEGIN 
   <executable command(s)>
EXCEPTION 
   <exception handling> 
END;

*/
-- hello world
DECLARE 
   message  varchar2(20):= 'Hello, World!'; 
BEGIN 
   dbms_output.put_line(message);
   dbms_output.put_line(2**5);
   
END; 
/ 


/*
pl/sql delimiteers
+ - * /  -- arithmetic
%  attribute operator
'  char string delimiter
. component selector
(,)  list delimiter
: host variable indicator
,  item seprator
"  quoted  identifier delimiter
= relalational op
@ remote access indicator
; statement terminator
:=  assignement op
=> association op
|| concatenation op
** exponention op
<<,>>  label delimiter
-- single line comment
.. range op
<,>,<=,>= relational op
<>, '=, ~=, ^=   differnt versions of not equal
*/

/*
pl/sql program units
pl/sql block
function
package
package body 
procedure
trigger
type
type body
*/

DECLARE 
   message  varchar2(20):= 'Data types'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 
----------------
-- data types
----------------
/* 
- Scalar and Lob data types  : traditional db
-  LOB  large objects, pointers to large objects  e.g. images, video : traditional db
- Composite   i.e. collections and records : plsql
- reference   pointers to other data items  : plsql
*/

/* 
scalar types
- numeric  family
- character family
- boolean type
- datetime family
*/

/* numeric family

PLS_INTEGER   : signed int (32 bit)  -/+  2'147'483'648

BINARY_INTEGER : signed int (32 bit) same range

BINARY_FLOAT  : single-preisions  floating point number

NUMBER(prec,scale) :  fixed point or floating point number  range 1E-130 - 1.0E126
                   :  precision is a number of digits in a number, scale is the number of difits to the right of the decimal
                   :  point  e.g.  123.45 has prec = 5, scale = 2
DEC(prec,scale)  : ainsi specific fixed point type with max precision of 38 decimal digits

DECIMAL(prec,scale) : ibm specific fixed-point type max precision 38 decimal digits . fixed point numbers stored in db

NUMERIC(pre,scale)  : floating type with max decimal prec = 38

DOUBLE PRECISION   : ainsi spec  floating-point with maximum precision of 126 binary digits (approx 38 decimal digits)

FLOAT               : ainsi  floating-point with max precision of 126 binary digits (128 bits)
INTEGER             : ainsi   integer with max 38 decimal digits
INT                 : ainsi   integer with max 38 decimal digits
SMALLINT            : ainsi integer type with amx of 38 decimal digitls
REAL                : floating-point with max prcision of 63 binary digits

topic
precision, scale:
    Precision 4, scale 2: 99.99
    Precision 10, scale 0: 9999999999
    Precision 8, scale 3: 99999.999
    Precision 5, scale -1: 54320
    Precision 5, scale -3: 54000

fixed point vs floating:     
    number(p,s)  both p,s are specified => fixed point
    number() no p nor s, specfied => floating
*/

DECLARE 
   num0 BINARY_INTEGER; -- 32 bit storage
   num1 INTEGER;   -- 128 bit
   num2 REAL;   -- 64 bit
   num3 DOUBLE PRECISION; --128 bit
   num4 NUMBER(10,5); --128 bit
   num5 NUMBER;      -- 128 bit
   num6 DECIMAL(10,3);  --128 bit
BEGIN 
   null; 
END; 
/ 
 
/* CHAR family

*/

DECLARE 
   s0 CHAR;  
   s1 CHAR(5);
   s2 RAW(1) ;  -- binary or byte string must specify lenght
   s3 NCHAR(2); -- fixed-lenght national char, non-lating chars do not pass
   s4 NVARCHAR2(5); -- variable lenght national char string max size 32767 bytes
   s5 LONG ;   --variable lenght string with max size 32760 bytes
   s6 LONG RAW ; -- variable lenght binary or byte string
   s7 ROWID;  -- physical row identify, the address of a row in an ordinary table
   s8 UROWID; -- universal row identifier (physical, logical, or foreign row identifier)
BEGIN 
   --s0 := 'aa'; -- error. expects single char
   s1 := 'aa';
   s3 := 'aa';
   s4 := 'a';
   s4 := 'abvgd'; 
   s5 := 'aaaaaaaaaaaaa';  -- do not need to specify lenght
   
   null; 
END; 
/ 
/*
Boolean data types
*/
DECLARE
    b0 BOOLEAN;
BEGIN
    b0  := TRUE;
    b0 := FALSE;
    null;
END;
/
/*
date time & interval types

DATE  type to store datetimes
       each date has YEAR,MONTH, DAY,HOUR, MINUTE, SECOND, TIMEZONE_HOUR, TIMEZONE_MINUTE, TIMEZONE_REGION, TIMEZONE_ABBR
       ORA initizaliation parameter NLS_DATE_FORMAT
*/
DECLARE
    d0 Date;
    d1 Date;
    d2 Date;
    d3 Date;
BEGIN
    d0 := SYSDATE;

    d1 := TO_DATE('24-APR-1997');
    d2 := TO_DATE('14-02-2015', 'DD-MM-YYYY');
    d3 := to_date('27-SEP-2011 23:59:13', 'dd-mon-yyyy hh24:mi:ss');
    dbms_output.put_line(d0);
    dbms_output.put_line(d1);
    dbms_output.put_line(TO_CHAR(d3, 'hh24:mi:ss') );  -- extracts hours minutes seconds
    
    
END;
/
/*
LOB family

BFILE  - use to store large binary objects in OS FS outside the db
BlOB    -store larege bin objects    size 8 to 128 TB
CLOB   - store large blocks of char dat    8 to 128 TB
NCLOB  - large block of NCHAR data    8 to  128 TB
*/

/* !! pl sql user-defined subtypes
SUBTYPE CHARACTER IS CHAR; 
SUBTYPE INTEGER IS NUMBER(38,0);
*/

DECLARE 
   SUBTYPE person_name IS char(20); 
   SUBTYPE message IS varchar2(100); 
   salutation person_name; 
   greetings message; 
BEGIN 
   salutation := 'Reader'; 
   greetings := 'Welcome to the World of PL/SQL'; 
   dbms_output.put_line('Hello ' || salutation || greetings); 
END; 
/ 

DECLARE 
   message  varchar2(20):= 'Variables'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 
----------------
-- Variables
----------------
/*
general syntax
variable_name [CONSTANT] datatype [NOT NULL] [:= | DEFAULT initial_value]
*/
DECLARE
    gen_digits number := 1234565789.0123456789;
    sales number(10, 2); 
    pi CONSTANT double precision := 3.1415; 
    name varchar2(25); 
    customer varchar2(30) DEFAULT 'Average Joe';
    address varchar2(100);
BEGIN
    sales := 999.15;
    sales := sales + 0.70;
    dbms_output.put_line('incremeented sales: ' || sales); 
    null;
END;
/
/*
variable scope
    local variables  - scope = innner block
    global variables  declared in outermost block or a package (accessble in all nested blocks )
*/
DECLARE 
   -- Global variables  
   num1 number := 95;  
   num2 number := 85;  
BEGIN  
   dbms_output.put_line('Outer Variable num1: ' || num1); 
   dbms_output.put_line('Outer Variable num2: ' || num2); 
   --nested block
   DECLARE  
      -- Local variables 
      num1 number := 195;  
      num2 number := 185;  
   BEGIN  
      dbms_output.put_line('Inner Variable num1: ' || num1); 
      dbms_output.put_line('Inner Variable num2: ' || num2); 
   END;  
END; 
/ 

/*
Assigning SQL Query Results to PL/SQL Variables
*/
CREATE TABLE CUSTOMERS( 
   ID   INT NOT NULL, 
   NAME VARCHAR (20) NOT NULL, 
   AGE INT NOT NULL, 
   ADDRESS CHAR (25), 
   SALARY   DECIMAL (18, 2),        
   PRIMARY KEY (ID) 
);  
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 );  
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 );  
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) VALUES (3, 'kaushik', 23, 'Kota', 2000.00 );
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) VALUES (4, 'Chaitali', 25, 'Mumbai', 6500.00 ); 
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) VALUES (5, 'Hardik', 27, 'Bhopal', 8500.00 );  
INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) VALUES (6, 'Komal', 22, 'MP', 4500.00 ); 

select * from CUSTOMERS;
/*  the block assignes values from the table to variables  */
DECLARE 
   c_id customers.id%type := 1; 
   c_name  customers.name%type; 
   c_addr customers.address%type; 
   c_sal  customers.salary%type; 
BEGIN 
   SELECT name, address, salary INTO c_name, c_addr, c_sal 
   FROM customers 
   WHERE id = c_id;  
   dbms_output.put_line 
   ('Customer ' ||c_name || ' from ' || c_addr || ' earns ' || c_sal); 
END; 
/  

----------------
-- Constants and Literals
----------------
DECLARE 
   message  varchar2(100):= 'Constants and Literals'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 

DECLARE 
   -- constant declaration 
   pi constant number := 3.141592654; 
   -- other declarations 
   radius number(5,2);  
   dia number(5,2);  
   circumference number(7, 2); 
   area number (10, 2); 
BEGIN  
   -- processing 
   radius := 9.5;  
   dia := radius * 2;  
   circumference := 2.0 * pi * radius; 
   --area := pi * radius * radius; 
   area := pi * radius **2; 
   -- output 
   dbms_output.put_line('Radius: ' || radius); 
   dbms_output.put_line('Diameter: ' || dia); 
   dbms_output.put_line('Circumference: ' || circumference); 
   dbms_output.put_line('Area: ' || area); 
   dbms_output.put_line('we used in calculations pi declared as a constant'); 
   
END; 
/ 

/*  Literals
a literal is an explicit numerc character, string, or boolean not represented bya an identifier 
i.e. in  bms_output.put_line('Helo World');  -- 'Hello World'  is a literal
SELECT TO_DATE('2015/04/30', 'yyyy/mm/dd') FROM dual; -- '2015/04/30' is a literal
*/
DECLARE 
   message  varchar2(30):= 'That''s tutorialspoint.com!'; 
BEGIN 
   dbms_output.put_line(message); 
   dbms_output.put_line(message || ' string is a literal');
END; 
/  

----------------
-- Operators
----------------
DECLARE 
   message  varchar2(100):= 'Operators'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 


/*
Arithmetic family

+, -, *, /, **  (power)

Relational family

=  check for equality
!=, <> ~=  : check for non equality
<,>,<=, >=


Comparison  family

LIKE  : Zara Ali' like 'Z% A_i'  -> true
BETWEEN   : f x = 10 then, x between 5 and 20 returns true
IN   : If x = 'm' then, x in ('a', 'b', 'c') returns false but x in ('m', 'n', 'o') returns true.
IS NULL  : If x = 'm', then 'x is null' returns false

Logical family

AND
OR
NOT
*/

/* operators PRECEDENCE 

**
*,/
+,-

comparison
not
and 
or
*/

----------------
-- Condition
----------------
DECLARE 
   message  varchar2(100):= 'Condition'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 

/*
if then

if then else

if then elsif 

case

searched case statement

*/
DECLARE 
   c_id customers.id%type := 1; 
   c_name  customers.name%type; 
   c_addr customers.address%type; 
   c_sal  customers.salary%type; 
   u_comment varchar2(32);
BEGIN 
   SELECT name, address, salary INTO c_name, c_addr, c_sal 
   FROM customers 
   WHERE id = c_id;
   
   if  c_sal <= 2000 THEN
        u_comment := 'not such bad salary'; 
   else 
        u_comment := 'really high salary';
   END IF; 
   dbms_output.put_line('Customer ' ||c_name || ' has ' || u_comment); 
END; 
/ 

/*  case examples */
select ID, NAME, AGE,
CASE  
    when AGE  > 26 THEN 'older guy'
    ELSE 'the younger guy'
END as Youth   
from CUSTOMERS;


SELECT  table_name,
CASE owner
  WHEN 'SYS' THEN 'The owner is SYS'
  WHEN 'SYSTEM' THEN 'The owner is SYSTEM'
  ELSE 'The owner is another value'
END
FROM all_tables 
FETCH NeXT 20 ROWS ONLY;


----------------
-- Loops
----------------
DECLARE 
   message  varchar2(100):= 'Loops'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/ 
/*
pl/sql basic loop

pl/sql while loop

pl/sql for loop

nested loops
*/

/*
loops can have statments
EXIT  : get out of the loop
CONTINUE : go  to next iteration

*/


/* basic loop */ 
DECLARE 
   i number(2);
BEGIN 
 FOR i in 1..3 LOOP
   dbms_output.put_line('i is: '|| i);
 END LOOP; 
END; 
/
/* nested declared loops */
DECLARE 
   i number(1); 
   j number(1); 
   outer_border int := 2;
   inner_border int := 4;
BEGIN 
   << outer_loop >> 
   FOR i IN 1..outer_border LOOP 
      << inner_loop >> 
      FOR j IN 1..inner_border LOOP 
         dbms_output.put_line('i is: '|| i || ' and j is: ' || j); 
      END loop inner_loop; 
   END loop outer_loop; 
END; 
/