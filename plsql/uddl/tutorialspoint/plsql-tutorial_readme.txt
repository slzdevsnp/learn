plsql tutorial readme / questions

Questions

subject: data types

numerical types

1. difference between   PLS_INTEGER and BINARY_INTEGER (some size in memory, same range)

2. fixed-point  vs  floating type  i.e. number(p,s)  vs number  ? 

3. DEC(prec,scale)  : ainsi specific fixed point type with max precision of 38 decimal digits   i.e. max  scale = 38  but max precision is also 38 ? 

4. DOUBLE PRECISION   : ainsi spec  floating-point with maximum precision of 126 binary digits (approx 38 decimal digits)  i.e. 128 bits storage  max precision = 38, max scale=38 ? 

5. Q: Am I correct about types storage values? 
DECLARE
   --valid types declarations 
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

CHAR types

1.  ROWID;  -- physical row identify, the address of a row in an ordinary table Q: What is this type ? 
2.  CHAR vs NCHAR data type?  what is the difference ? 


Arrays

line: 751
what does the line  name_list.extend;  ? 


Procedures topic

1.  procedure definition  IS  vs AS    ? 
    AS creates a proc as a persistd db object
    IS creates a  proc visible only inside its block ? 

2.
/* in out example 1 */
line 814
when executed as  a group of statements OK

when full script is ran  - compilation error.
PLS-00103: Encountered the symbol "DECLARE" 
 why? 

Cursors 

often used in  pl/sql  programs behind screens ?


Exceptions

line: 1219
DECLARE 
   c_id customers.id%type := &cc_id;  -- the &cc_id opens gui
   c_name customers.name%type; 
   c_addr customers.address%type;  
   ex_invalid_id  EXCEPTION;  -- user defined exception 
BEGIN 
....

Q: what is this syntax &cc_id ? 



Dates and times 

EXTRACT(HOUR from x)  vs EXTRACT(TIMEZONE_HOUR from x) ? 


Object orented pl/sql  

1.   are objects  often used in  pl/sql programming ? 





