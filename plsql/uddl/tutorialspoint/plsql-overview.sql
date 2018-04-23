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


----------------
-- Strings
----------------
DECLARE 
   message  varchar2(100):= 'Strings'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/

/*
fixed lenght strings
varible lenght strings  up to 32767 bytes
character large objects (clobs)  variable up to 128 TB

*/
DECLARE 
   name varchar2(20); 
   company varchar2(30); 
   introduction clob; 
   choice char(1); 
BEGIN 
   name := 'John Smith'; 
   company := 'Infotech'; 
   introduction := ' Hello! I''m John Smith from Infotech.'; 
   choice := 'y'; 
   IF choice = 'y' THEN 
      dbms_output.put_line(name); 
      dbms_output.put_line(company); 
      dbms_output.put_line(introduction); 
   END IF; 
END; 
/

/*
string functions
ascii(x);
chr(x);
concat(x,y);
initcap(x); -- convert intial letter of each word in uppercase
instr(x, find_string [,star], [,occcurence] );  -- search a substring in find_string
length(x) ;  -- lenght of string
lengthb(x) ;  -- lenght of string in bytes
lower(x);
lpad(x, width [,pad_string]); 
ltrim(x, [,trim_string]);
NANVL(x, value);  -- Returns value if x matches the NaN special value (not a number),
                  -- otherwise x is returned.

NLS_INITCAP(x);   -- same as initcap but uses differnt sort method as specified in NLSSORT
NLSSORT(x);
NVL(x,value); returns value if x is null, othervise x is return
replace(x, search_ptrn, replace_ptrn);
rpad(x);
rtrim(x);
soundex(x); 
SUBSTR(x, start[,length]);
TRIM([trim_char FROM x);  trim char from both sides
UPPER(x);
*/

DECLARE
    sstr_posit int;
    mynum int := NULL;
    greeting varchar2(20); 
BEGIN
    greeting := 'aprivet mama i papa';
    sstr_posit := INSTR('ma', 'privet papa i mama');
    dbms_output.put_line('nvl output: '|| NVL(mynum, -1)); 
    dbms_output.put_line('trim output: '|| TRIM('a' FROM greeting) ); 
    
END;
/

DECLARE 
   greetings varchar2(11) := 'hello world'; 
BEGIN 
   dbms_output.put_line(UPPER(greetings)); 
   dbms_output.put_line(LOWER(greetings)); 
   dbms_output.put_line(INITCAP(greetings)); 
   /* retrieve the first character in the string */ 
   dbms_output.put_line ( SUBSTR (greetings, 1, 1)); 
   /* retrieve the last character in the string */ 
   dbms_output.put_line ( SUBSTR (greetings, -1, 1)); 
   /* retrieve five characters,  
      starting from the seventh position. */ 
   dbms_output.put_line ( SUBSTR (greetings, 7, 5)); 
   /* retrieve the remainder of the string,
      starting from the second position. */ 
   dbms_output.put_line ( SUBSTR (greetings, 2));    
   /* find the location of the first "e" */ 
   dbms_output.put_line ( INSTR (greetings, 'e')); 
END; 
/ 
/* trim examples */
DECLARE 
   greetings varchar2(30) := '......Hello World.....'; 
BEGIN 
   dbms_output.put_line(RTRIM(greetings,'.')); 
   dbms_output.put_line(LTRIM(greetings, '.')); 
   dbms_output.put_line(TRIM( '.' from greetings)); 
END; 
/

----------------
-- Arrays
----------------
DECLARE 
   message  varchar2(100):= 'Arrays'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/

/*
VARRAY type  fixe-size  collectio of items of the same type , continious in memory

def in block:
TYPE varray_type_name IS VARRAY(n) of <element_type>
e.g.
TYPE namearray IS VARRAY(5) OF VARCHAR2(10); 
Type grades IS VARRAY(5) OF INTEGER;
*/
/*  varray example 1  */
DECLARE 
   type namesarray IS VARRAY(5) OF VARCHAR2(10); 
   type grades IS VARRAY(5) OF INTEGER; 
   names namesarray; 
   marks grades; 
   total integer; 
BEGIN 
   names := namesarray('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz'); 
   marks:= grades(98, 97, 78, 87, 92); -- if add another element, compile error
   total := names.count; 
   dbms_output.put_line('Total '|| total || ' Students'); 
   FOR i in 1 .. total LOOP   -- array index starts from 1
      dbms_output.put_line('Student: ' || names(i) || ' 
      Marks: ' || marks(i)); 
   END LOOP; 
END; 
/
/*  varray example 2  */
DECLARE 
   CURSOR c_customers is   
   SELECT  name FROM customers; 
   type c_list is varray (6) of customers.name%type; 
   name_list c_list := c_list(); -- memory allocated for empty error of fixed length
   counter integer :=0; --initilize loop index
BEGIN 
   FOR n IN c_customers LOOP 
      counter := counter + 1; 
      name_list.extend; 
      name_list(counter)  := n.name; -- n is an element from the cursor
      dbms_output.put_line('Customer('||counter ||'):'||name_list(counter)); 
   END LOOP; 
END; 
/ 
----------------
-- Procedures
----------------
DECLARE 
   message  varchar2(100):= 'Procedures'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/

/*
procs calling other procs ==  modular design

create procedure
drop procedure
create function
drop function

these  are db objects
a subprogram created inside a package is a apackaged subprogram

a proc has  { declarative part (optional), executable part (mandatory), exception handling (mandatory) }
gen syntax:

CREATE [OR REPLACE] PROCEDURE procedure_name 
[(parameter_name [IN | OUT | IN OUT] type [, ...])] 
{IS | AS} 
BEGIN 
  < procedure_body > 
END procedure_name; 

or replace  allows the modif of an existing procedure
param IN  will be passed inside  (read-only param) this is a adefault mode for params
parm OUT will e passed out used to return a value ouside the proc. param should be variable

*/
/*  dummy  example */
CREATE OR REPLACE PROCEDURE greetings 
AS 
BEGIN 
   dbms_output.put_line('Hello World!'); 
END; 
/
-- call in the script
--exec greetings;
-- call in the block

BEGIN
    greetings;
END;

-- drop procedure greetings;

/* IN & OUT Mode Example   */

DECLARE 
   a number; 
   b number; 
   c number;
PROCEDURE findMin(x IN number, y IN number, z OUT number) IS 
BEGIN 
   IF x < y THEN 
      z:= x; 
   ELSE 
      z:= y; 
   END IF; 
END; 
BEGIN 
   a:= 23; 
   b:= 45; 
   findMin(a, b, c); -- positional notation
   findMin(x => a, y => b, z => c);  -- named notation
   dbms_output.put_line(' Minimum of (23, 45) : ' || c); 
END; 
/


/*  in out example 2 */
DECLARE 
   a number; 
   b number;
PROCEDURE squareNum(x IN OUT number) IS 
BEGIN 
  x := x * x; 
END;  
BEGIN 
   a:= 23; 
   squareNum(a); 
   dbms_output.put_line(' Square of (23): ' || a); 
END; 
/

----------------
-- Functions
----------------
DECLARE 
   message  varchar2(100):= 'Functions'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/

/*
general syn
CREATE [OR REPLACE] FUNCTION function_name 
[(parameter_name [IN | OUT | IN OUT] type [, ...])] 
RETURN return_datatype 
{IS | AS} 
BEGIN 
   < function_body > 
END [function_name];

a function reuturns a computed value rather than modifies data in tables

*/

/*  simple example  define func with no params */
CREATE OR REPLACE FUNCTION totalCustomers 
RETURN number IS 
   total number(2) := 0; 
BEGIN 
   SELECT count(*) into total 
   FROM customers; 
    
   RETURN total; 
END; 
/ 
-- call the func in the block
DECLARE 
   c number(2); 
BEGIN 
   c := totalCustomers(); 
   dbms_output.put_line('Total no. of Customers: ' || c); 
END; 
/
/* definein  the block a func to find a max of two numbers */
DECLARE 
   a number; 
   b number; 
   c number; 
FUNCTION findMax(x IN number, y IN number)  
RETURN number 
IS 
    z number; 
BEGIN 
   IF x > y THEN 
      z:= x; 
   ELSE 
      Z:= y; 
   END IF;  
   RETURN z; 
END;
BEGIN 
   a:= 49; 
   b:= 48;  
   c := findMax(a, b); 
   dbms_output.put_line(' Maximum of ' || a || ' and ' || b || ' : ' || c); 
END;
/

/*
recursive functions

*/

/* example with canonical factorial recursive function defined in the block */
DECLARE 
   num number; 
   factorial number;  
   
FUNCTION fact(x number) 
RETURN number  
IS 
   f number; 
BEGIN 
   IF x=0 THEN 
      f := 1; 
   ELSE 
      f := x * fact(x-1); 
   END IF; 
RETURN f; 
END;  

BEGIN 
   num:= 6; 
   factorial := fact(num); 
   dbms_output.put_line(' Factorial '|| num || ' is ' || factorial); 
END; 
/

----------------
-- Cursors
----------------
DECLARE 
   message  varchar2(100):= 'Cursors'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/

/*
a cursor is a pointer  in the memory area called context area
a set of rows the cursor holds is aclled active set

implicit cursors
    automatically created in oracle whenever a sql statement is executed
    programer has no control on implicit cursor
    
    implicit cursor has also attributes such as %FOUND, %ISOPEN  %NOTFOUND %ROWCOUNT
    sql%attribute_name  the way to access attributes    
*/

/*  the followin will update every row in customers sql%rowcount shows num of affected roes */
DECLARE  
   total_rows number(2); 
BEGIN 
   UPDATE customers 
   SET salary = salary + 500; 
   IF sql%notfound THEN 
      dbms_output.put_line('no customers selected'); 
   ELSIF sql%found THEN 
      total_rows := sql%rowcount;
      dbms_output.put_line( total_rows || ' customers affected '); 
   END IF;  
END; 
/   

/*
explicit cursors   
    programmer defined cursors

gen syntax
CURSOR cursor_name IS select_statement; 

steps:
declar a cursor to initialize the memory
open cursor  to allocate memory 
fetch the cursor to ge data
close curser to release allocated memory

*/

/*  example of explicit cursor  on customers  */

DECLARE 
   c_id customers.id%type; 
   c_name customers.name%type; 
   c_addr customers.address%type; 
   CURSOR c_customers is 
      SELECT id, name, address FROM customers; 
BEGIN 
   OPEN c_customers;  -- memory allocated
   LOOP 
   FETCH c_customers into c_id, c_name, c_addr; -- put data from a cursor row into vars 
      EXIT WHEN c_customers%notfound;   -- exit condition with cursor attribute
      dbms_output.put_line(c_id || ' ' || c_name || ' ' || c_addr); 
   END LOOP; 
   CLOSE c_customers; 
END; 
/

----------------
-- Records
----------------
DECLARE 
   message  varchar2(100):= 'Records'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/

/*
a recod is a data structure holding data items of different knid
equivalent of  c struct ? 

types of records:
    table-based
    cursor-based
    user-defined records

create table-based or cursor-based records with %ROWTYPE

*/

/*  basic table-based record example  */


DECLARE 
   customer_rec customers%rowtype; 
BEGIN 
   SELECT * into customer_rec 
   FROM customers 
   WHERE id = 5;  
   dbms_output.put_line('Customer ID: ' || customer_rec.id); 
   dbms_output.put_line('Customer Name: ' || customer_rec.name); 
   dbms_output.put_line('Customer Address: ' || customer_rec.address); 
   dbms_output.put_line('Customer Salary: ' || customer_rec.salary); 
END; 
/

/* cursor based record example */
DECLARE 
   CURSOR customer_cur is 
      SELECT id, name, address  
      FROM customers; 
   customer_rec customer_cur%rowtype; 
BEGIN 
   OPEN customer_cur; 
   LOOP 
      FETCH customer_cur into customer_rec; -- customer_rec is a record
      EXIT WHEN customer_cur%notfound; 
      DBMS_OUTPUT.put_line(customer_rec.id || ' ' || customer_rec.name ||
                        ' lives in ' || customer_rec.address); 
   END LOOP; 
END; 
/

/* user defined records */
DECLARE 
   type books is record 
      (title varchar(50), 
      author varchar(50), 
      subject varchar(100), 
      book_id number); 
   book1 books; 
   book2 books; 
BEGIN 
   -- Book 1 specification 
   book1.title  := 'C Programming'; 
   book1.author := 'Nuha Ali ';  
   book1.subject := 'C Programming Tutorial'; 
   book1.book_id := 6495407;  
   -- Book 2 specification 
   book2.title := 'Telecom Billing'; 
   book2.author := 'Zara Ali'; 
   book2.subject := 'Telecom Billing Tutorial'; 
   book2.book_id := 6495700;  
  
  -- Print book 1 record 
   dbms_output.put_line('Book 1 title : '|| book1.title); 
   dbms_output.put_line('Book 1 author : '|| book1.author); 
   dbms_output.put_line('Book 1 subject : '|| book1.subject); 
   dbms_output.put_line('Book 1 book_id : ' || book1.book_id); 
   
   -- Print book 2 record 
   dbms_output.put_line('Book 2 title : '|| book2.title); 
   dbms_output.put_line('Book 2 author : '|| book2.author); 
   dbms_output.put_line('Book 2 subject : '|| book2.subject); 
   dbms_output.put_line('Book 2 book_id : '|| book2.book_id); 
END; 
/

/* records as a param for proc
   you can pass a record as a subprogram param 
*/
DECLARE 
   type books is record 
      (title  varchar(50), 
      author  varchar(50), 
      subject varchar(100), 
      book_id   number); 
   book1 books; 
   book2 books;  
PROCEDURE printbook (book books) IS 
BEGIN 
   dbms_output.put_line ('*** pretty book printing ***');    
   dbms_output.put_line ('Book  title :  ' || book.title); 
   dbms_output.put_line('Book  author : ' || book.author); 
   dbms_output.put_line( 'Book  subject : ' || book.subject); 
   dbms_output.put_line( 'Book book_id : ' || book.book_id); 
END; 
   
BEGIN 
   -- Book 1 specification 
   book1.title  := 'C Programming'; 
   book1.author := 'Nuha Ali ';  
   book1.subject := 'C Programming Tutorial'; 
   book1.book_id := 6495407;
   
   -- Book 2 specification 
   book2.title := 'Telecom Billing'; 
   book2.author := 'Zara Ali'; 
   book2.subject := 'Telecom Billing Tutorial'; 
   book2.book_id := 6495700;  
   
   -- Use procedure to print book info 
   printbook(book1); 
   printbook(book2); 
END; 
/     
 
 
----------------
-- Exceptinos
----------------
DECLARE 
   message  varchar2(100):= 'Exceptions'; 
BEGIN 
   dbms_output.put_line('#################');
   dbms_output.put_line(message);
    dbms_output.put_line('#################');
END; 
/   
   

