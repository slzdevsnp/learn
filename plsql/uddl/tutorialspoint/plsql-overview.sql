-- oracle version
/*
select * from V$VERSION;
*/
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


----------------
-- Environment
----------------

/*
after launching sqlplus command prompt  type @filename to execute your prog
*/

----------------
-- Basic syntax
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

----------------
-- data types
----------------

