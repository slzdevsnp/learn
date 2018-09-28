-- script to run under user learn
-- clean schema learn with drop_all_objects_user.sql

--pre course DML

DROP TABLE ORDERS;
DROP TABLE ITEMS;
DROP TABLE ACCOUNTS;
DROP TABLE CUSTOMERS;
DROP SEQUENCE orders_seq;

CREATE TABLE CUSTOMERS (cust_id  NUMBER  NOT NULL PRIMARY KEY,
                        cust_name  VARCHAR2(100) NOT NULL,
                        cust_location VARCHAR2(2) NOT NULL  );
                        
CREATE TABLE ACCOUNTS (act_id NUMBER NOT NULL PRIMARY KEY,
                       act_cust_id NUMBER NOT NULL,
                       act_bal NUMBER(10,2),
                       CONSTRAINT act_cust_fk FOREIGN KEY (act_cust_id) REFERENCES  
                       customers(cust_id));

CREATE TABLE ITEMS    (item_id  NUMBER  NOT NULL PRIMARY KEY,
                       item_name  VARCHAR2(60) NOT NULL,
                       item_value number(5,2) NOT NULL  );
                       
CREATE TABLE ORDERS  ( order_id  NUMBER  NOT NULL PRIMARY KEY,
                       order_item_id   NUMBER NOT NULL,
                       order_act_id    NUMBER NOT NULL ,
                       CONSTRAINT order_item_fk FOREIGN KEY (order_item_id) REFERENCES  
                       items(item_id),
                       CONSTRAINT  order_act_fk FOREIGN KEY (order_act_id) REFERENCES  
                       accounts(act_id) );

CREATE SEQUENCE orders_seq START WITH 1 INCREMENT BY 1;


-- Insert into customers table
INSERT INTO customers(cust_id,cust_name,cust_location) VALUES (1,'John','WA');
INSERT INTO customers(cust_id,cust_name,cust_location) VALUES (2,'Jack','CA');
INSERT INTO customers(cust_id,cust_name,cust_location) VALUES (3,'Jill','CA');

-- Insert into accounts table
INSERT INTO accounts(act_id,act_cust_id,act_bal) VALUES (1,1,1000);
INSERT INTO accounts(act_id,act_cust_id,act_bal) VALUES (2,2,1000);
INSERT INTO accounts(act_id,act_cust_id,act_bal) VALUES (3,3,1000);

-- Insert into items table
INSERT INTO items(item_id,item_name,item_value) VALUES (1,'Treadmill', 600);
INSERT INTO items(item_id,item_name,item_value) VALUES (2,'Elliptical',600);
INSERT INTO items(item_id,item_name,item_value) VALUES (3,'Bike',600);
INSERT INTO orders(order_id,order_item_id,order_act_id) VALUES (orders_seq.NEXTVAL, 1,1);
INSERT INTO orders(order_id,order_item_id,order_act_id) VALUES (orders_seq.NEXTVAL, 2,1);
INSERT INTO orders(order_id,order_item_id,order_act_id) VALUES (orders_seq.NEXTVAL, 2,2);
INSERT INTO orders(order_id,order_item_id,order_act_id) VALUES (orders_seq.NEXTVAL, 3,1);
INSERT INTO orders(order_id,order_item_id,order_act_id) VALUES (orders_seq.NEXTVAL, 3,2);
INSERT INTO orders(order_id,order_item_id,order_act_id) VALUES (orders_seq.NEXTVAL, 3,3);
COMMIT;
--- end of initial  ddl-dml for this course

drop type items_nt;
drop type orders_ot;
drop table account_orders;

drop type mytype_va;

drop type items_va;
drop type orders_va;
drop table act_orders;


set serveroutput on;
--- func to print chapter names
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

-------------------
exec pretty_chapter('ASSOCIATIVE Arrays'); 

/************************
chap assoc array demo 1 defintion and iteration of AA
*************************/
-- basic definition and assignment of AA
DECLARE
    TYPE items_aa is table of varchar2(60) INDEX BY BINARY_INTEGER;
    l_items_aa  items_aa;
    l_itemscopy_aa items_aa; 
    l_empty_aa items_aa;
BEGIN
   --assigment do not need to initialize
  l_Items_aa(1) := 'Treadmill';
  l_Items_aa(2) := 'Bike';
  l_items_aa(3) := 'Elliptical';
  
  DBMS_OUTPUT.PUT_LINE(' Value at index counter 2 in l_items_aa array '||l_items_aa(2));
  DBMS_OUTPUT.PUT_LINE(' Copying l_items_aa array to l_itemscopy_aa array');
  l_itemscopy_aa := l_items_aa;
  DBMS_OUTPUT.PUT_LINE(' Value at index counter 2 in l_itemscopy_aa array '||l_itemscopy_aa(2));
  DBMS_OUTPUT.PUT_LINE(' Initializing l_items_aa array to an empty array by assigning l_empty_aa to it');
  l_items_aa := l_empty_aa;
  --accessing a non-existing element produces excepiton
  --DBMS_OUTPUT.PUT_LINE(' Value at index counter 2 in l_items_aa array '||l_items_aa(2));
  DBMS_OUTPUT.PUT_LINE('count of empty AA '||l_items_aa.count);

END;
/

select * from items  order by item_id;


--definition of AA of type  %ROWTYPE of items table
DECLARE
  TYPE items_aa is table of items%ROWTYPE INDEX BY BINARY_INTEGER;
  l_items_aa  items_aa;
  count_idx NUMBER:=0;
 -- classic definition of cursor
  CURSOR get_items_cur IS
    SELECT *
      FROM items
      ORDER BY item_id;
BEGIN
    --iteration on the cursor
    FOR iterable IN get_items_cur LOOP
      count_idx := count_idx + 1;
      --attributes in l_items_aa should correspond to attributes in cursor
      l_items_aa(count_idx).item_id := iterable.item_id;
      l_items_aa(count_idx).item_name := iterable.item_name;
      l_items_aa(count_idx).item_value := iterable.item_value;
    END LOOP;
    -- lets now iterate over AA 
    FOR j IN l_items_aa.first .. l_items_aa.last LOOP
        DBMS_OUTPUT.PUT_LINE('At Counter '|| j||': Item id is '||l_items_aa(j).item_id
                            ||' Item Name is '||l_items_aa(j).item_name);
    END LOOP;
END;
/


/************************
chap assoc array demo 2 sparse index of AA
*************************/

DECLARE
TYPE items_aa is table of varchar2(60) INDEX BY BINARY_INTEGER;
  l_items_aa  items_aa;
  l_key BINARY_INTEGER;
BEGIN
  l_Items_aa(-10) := 'Treadmill';
  l_Items_aa(20) := 'Bike';
  DBMS_OUTPUT.PUT_LINE(' Value at index counter 20 in l_items_aa array initially '||l_items_aa(20));
  l_items_aa(3) := 'Elliptical';
  l_items_aa(20) := 'Elliptical';
  DBMS_OUTPUT.PUT_LINE(' New Value at index counter 20 in l_items_aa array is '||l_items_aa(20));
 
    -- lets now iterate over AA with  the sparse index
    -- NB! elements are stored SORTED!! with index keys  -10,3,20
    dbms_output.put_line('== iterating over sparse AA');
    l_key := l_items_aa.first;
    LOOP 
        EXIT WHEN l_key  is NULL;
        dbms_output.put_line('At key '|| l_key||': Item value '|| l_items_aa(l_key) );
        l_key := l_items_aa.next(l_key);  -- fetch next available index
    END LOOP;
    
    -- if AA is sparce this syntax will produce an exception
    /*
    FOR j IN l_items_aa.first .. l_items_aa.last LOOP
        dbms_output.put_line(': Item value '|| l_items_aa(j) );
    END LOOP;
    */
END;
/

/************************
chap assoc array demo 3 common exceptins
*************************/

-- assigning null will not even compile
DECLARE
  TYPE items_aa IS TABLE of VARCHAR2(4) NOT NULL INDEX BY BINARY_INTEGER;
  l_items_aa       items_aa;
BEGIN
  l_Items_aa(1) := NULL;
EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE(' Error '|| SQLERRM);
   RAISE;
END;
/

-- bad value type
DECLARE
  TYPE items_aa IS TABLE of VARCHAR2(4) NOT NULL INDEX BY BINARY_INTEGER;
  l_items_aa       items_aa;
BEGIN
  l_Items_aa(1) := 'Treadmill';
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error '|| SQLERRM);
    RAISE;    
END;
/


--acessing bad element
DECLARE
  TYPE items_aa IS TABLE of VARCHAR2(10) NOT NULL INDEX BY BINARY_INTEGER;
  l_items_aa       items_aa;
BEGIN
  l_items_aa(1) := 'Treadmill';  -- ok
  --l_items_aa(2)  := 'ellipse'; ---supposed we did not define element 2
 dbms_output.put_line(l_items_aa(2));  -- accessing non existig element
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Error '|| SQLERRM);
    RAISE;
END;
/

/************************
chap assoc array demo 4 persistence of collections in sessions
*************************/

-- crete a package with AA
CREATE OR REPLACE PACKAGE globals IS
   -- all this variables and type are globaly visible in package globals
  TYPE items_aa IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
     g_items_aa  items_aa;
     TYPE order_count_rec IS RECORD(item_id NUMBER, order_count NUMBER);
     TYPE order_count_aa IS TABLE OF order_count_rec INDEX BY PLS_INTEGER;
END globals;
/
-- define a proc which mutates a global variable globasl.g_items_aa
CREATE OR REPLACE PROCEDURE set_items IS
   --classic cursor
  CURSOR items_cur IS
  SELECT item_id
    FROM items;
  l_counter NuMBER:=0;
BEGIN
  FOR items_var IN items_cur LOOP
    l_counter := l_counter + 1;
    --mutating a variable defined in gloals
    globals.g_items_aa(l_counter) := items_var.item_id;
  END LOOP;
  dbms_output.put_line('Items Set count '||l_counter);
END set_items;
/
--define a function which mutates a global variable
CREATE OR REPLACE FUNCTION get_order_count 
    RETURN globals.order_count_aa
IS
  CURSOR order_count_cur(p_item_id items.item_id%TYPE) IS
    SELECT count(*)
      FROM orders
     WHERE order_item_id = p_item_id;
  l_order_count_aa globals.order_count_aa; -- access  order_count_aa
  l_index NUMBER;
  l_item_id NUMBER;
  l_counter NUMBER:=0;
BEGIN
  l_index := globals.g_items_aa.FIRST;
  WHILE l_index IS NOT NULL LOOP
    l_item_id := globals.g_items_aa(l_index);  --accessing globals.g_items_aa
    l_counter := l_counter + 1;
    l_order_count_aa(l_counter).item_id := l_item_id;
    OPEN order_count_cur(l_item_id);
    FETCH order_count_cur INTO l_order_count_aa(l_counter).order_count;
    CLOSE order_count_cur;
    l_index := globals.g_items_aa.NEXT(l_index);
  END LOOP;
  RETURN l_order_count_aa;
END get_order_count;
/
--executing
DECLARE
  l_order_aa globals.order_count_aa;
  l_index NUMBER:= 0;
BEGIN
  -- Populate globals.g_items_aa
  set_items;  --calling this proc  fills up  globals.g_items_aa
  l_order_aa := get_order_count; -- calling this function uses a filled globals.g_items_aa
  -- i.e.  globals.g_items_aa is shared between objects !! CAUTION !!
  l_index := l_order_aa.FIRST;
  DBMS_OUTPUT.PUT_LINE('COUNT '|| l_order_aa.count);
  WHILE l_index IS NOT NULL LOOP
    DBMS_OUTPUT.PUT_LINE('Item Id: '||l_order_aa(l_index).item_id||' Order Count '||l_order_aa(l_index).order_count);
    l_index := l_order_aa.NEXT(l_index);
  END LOOP;
END;
/

-------------------
exec pretty_chapter('Collection Methods'); 

/************************
chap collection methods demo1  last exists, delete, prior
*************************/

DECLARE
  TYPE items_aa IS TABLE of VARCHAR2(60) INDEX BY BINARY_INTEGER;
  l_items_aa                     items_aa;
BEGIN
  l_Items_aa(-10) := 'Treadmill';
  l_Items_aa(10)  := 'Treadmill';
  l_Items_aa(20)  := 'Bike';
  l_items_aa(25)  := 'Elliptical';
  l_items_aa(27)  := 'Weights';
  
  DBMS_OUTPUT.PUT_LINE('Initial count '||l_items_aa.COUNT||' Intial last index counter '
                       ||l_items_aa.LAST ||' its element: ' ||l_items_aa(l_items_aa.LAST) );
  DBMS_OUTPUT.PUT_LINE('Index counter prior to the last one is  '
                    ||l_items_aa.PRIOR(l_items_aa.LAST) ||'its element: '
                    || l_items_aa(l_items_aa.PRIOR(l_items_aa.LAST)) );
  --deleting elements with indexes BETWEEN 20 and 27
  l_items_aa.DELETE(20,27);
  DBMS_OUTPUT.PUT_LINE('After deleting index counters from 20 to 27 new count is '
                        ||l_items_aa.COUNT||' new last index counter is '||l_items_aa.LAST);
  
  IF NOT l_items_aa.EXISTS(25) THEN
    DBMS_OUTPUT.PUT_LINE('Index 25 does not exist');
  END IF;
  l_items_aa.DELETE; --delete all elements
  DBMS_OUTPUT.PUT_LINE('After issuing delete with no argument new count '||l_items_aa.COUNT||' new last index counter '||l_items_aa.LAST);
END;
/

/************************
chap collection methods demo2  iterating over collections
*************************/
--
DECLARE
 TYPE items_aa IS TABLE of VARCHAR2(60) INDEX BY BINARY_INTEGER;
  l_items_aa                     items_aa;
BEGIN
 --sparce AA
  l_Items_aa(4) := 'Treadmill';
  l_items_aa(6) := 'Bike';
  l_items_aa(8) := 'Elliptical';
  --   aa.first .. aa.last  is a dense looping
  FOR i IN  reverse l_Items_aa.FIRST .. l_Items_aa.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('Index counter is '||i);
    IF l_items_aa.EXISTS(i) THEN
      DBMS_OUTPUT.put_line ('Counter '||i||' exists.Value is  '||l_Items_aa (i));
    END IF;
  END LOOP;
END;
/

-- expected way to iterate over a sparce collecton  aa.next()
DECLARE
   TYPE items_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
   l_items_aa      items_aa;
   l_index         BINARY_INTEGER;
   l_value         VARCHAR2(60);
BEGIN
   l_Items_aa(4) := 'Treadmill';
   l_items_aa(6) := 'Bike';
   l_items_aa(8) := 'Elliptical';
   l_index := l_items_aa.FIRST;
   WHILE  l_index IS NOT NULL LOOP
      l_value := l_items_aa(l_index);
      DBMS_OUTPUT.PUT('Current Index is '||l_index||' Value is '||l_value);
      l_index := l_items_aa.NEXT(l_index);
      DBMS_OUTPUT.PUT_LINE(' Next Index is '||l_index);
   END LOOP;
END;
/
--how to iterate over a sparce collecton  from last to first  aa.prior()
DECLARE
   TYPE items_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
   l_items_aa      items_aa;
   l_index         BINARY_INTEGER;
   l_value         VARCHAR2(60);
BEGIN
   l_Items_aa(4) := 'Treadmill';
   l_items_aa(6) := 'Bike';
   l_items_aa(8) := 'Elliptical';
   l_index := l_items_aa.LAST;  --last element
   WHILE  l_index IS NOT NULL LOOP
      l_value := l_items_aa(l_index);
      DBMS_OUTPUT.PUT('Current Index is '||l_index||' Value is '||l_value);
      l_index := l_items_aa.PRIOR(l_index);
      DBMS_OUTPUT.PUT_LINE(' Next Index is '||l_index);
   END LOOP;
END;
/

-----------------------
exec pretty_chapter('NESTED Tables'); 

/**********************************
chap NESTED TABLES demo1  initialization
***********************************/
DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(60) ;
  l_items_nt      items_nt;
BEGIN
  -- NT should be initialized , not only declared
  DBMS_OUTPUT.PUT_LINE( l_items_nt.COUNT);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('*Exception '|| SQLERRM);
    RAISE;
END;
/


DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(60) ;
  l_items_nt      items_nt := items_nt();  --initialized, size must not be specified
BEGIN
  DBMS_OUTPUT.PUT_LINE( l_items_nt.COUNT);
END;
/

DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(60) ;
  l_items_nt      items_nt := items_nt('Bike', 'Treadmill');
BEGIN
  DBMS_OUTPUT.PUT_LINE( l_items_nt.COUNT);
END;
/

/**********************************
chap NESTED TABLES demo2  assignment
***********************************/
DECLARE
  TYPE items_rec IS RECORD( item_name  items.item_name%TYPE,
                            count      NUMBER);
  TYPE items_nt IS TABLE of items_rec ;
  l_items_nt   items_nt := items_nt();  --initialize (no lenght specified)
 
BEGIN
  l_items_nt.EXTEND; --allocate memory for next element of NT type
  l_items_nt(l_items_nt.LAST).item_name := 'Bike';
  l_items_nt(l_items_nt.LAST).count := 1;

  l_items_nt.EXTEND; 
  l_items_nt(l_items_nt.LAST).item_name := 'Treadmill';
  l_items_nt(l_items_nt.LAST).count := 2;

  DBMS_OUTPUT.PUT_LINE( 'number of elements: ' || l_items_nt.COUNT);
  DBMS_OUTPUT.PUT_LINE( l_items_nt(1).item_name);
END;
/


DECLARE
  TYPE items_rec IS RECORD( item_name  items.item_name%TYPE,
                            count      NUMBER);
  TYPE items_nt IS TABLE of items_rec ;
  l_items_nt   items_nt := items_nt();
 
BEGIN
  l_items_nt.EXTEND(2);   --allocate memmory to 2 next elements
  l_items_nt(1).item_name := 'Bike';
  l_items_nt(1).count := 1;
 
  l_items_nt(2).item_name := 'Treadmill';
  l_items_nt(2).count := 2;

  DBMS_OUTPUT.PUT_LINE( l_items_nt.COUNT);
  DBMS_OUTPUT.PUT_LINE( l_items_nt(1).item_name);
END;
/

DECLARE
  TYPE items_rec IS RECORD( item_name  items.item_name%TYPE,
                            count      NUMBER);
  TYPE items_nt IS TABLE of items_rec ;
  l_items_nt   items_nt := items_nt();
 
BEGIN
  l_items_nt.EXTEND(2); 
  l_items_nt(1).item_name := 'Bike';
  l_items_nt(1).count := 1;
 
  l_items_nt(2).item_name := 'Treadmill';
  l_items_nt(2).count := 2;
  l_items_nt.EXTEND(2,1);  -- assign next two elements  and copy to them element 1

  DBMS_OUTPUT.PUT_LINE('number of elements: '|| l_items_nt.COUNT);
  DBMS_OUTPUT.PUT_LINE( l_items_nt(3).item_name);
  --loop on NT
  FOR j in l_items_nt.first .. l_items_nt.last LOOP
     dbms_output.put_line('element: ' || l_items_nt(j).item_name
                        || ' cnt: ' || l_items_nt(j).count );
  END LOOP;
END;
/

DECLARE
  TYPE items_rec IS RECORD( item_name  items.item_name%TYPE,
                            count      NUMBER);
  TYPE items_nt IS TABLE of items_rec ;
  l_items_nt   items_nt := items_nt();
 
BEGIN
  l_items_nt.EXTEND(2); 
  l_items_nt(1).item_name := 'Bike';
  l_items_nt(1).count := 1;
 
  l_items_nt(2).item_name := 'Treadmill';
  l_items_nt(2).count := 2;
  
  l_items_nt.EXTEND(2,1);  --assign 2 more elements copy in them element 1  bike, bike
   
  l_items_nt.delete(2); --delete element an index 2 so NT becomes sparse
  
  
  dbms_output.put_line('after applying .delete(2)');
  --- we expect only Bikes elemen  at index 1, 3, 4
  FOR j in l_items_nt.first .. l_items_nt.last LOOP
     IF l_items_NT.EXISTS(j) THEN
        dbms_output.put_line('item_name: ' || l_items_nt(j).item_name
                        || ' item_count: ' || l_items_nt(j).count );
     END IF;                   
  END LOOP;
  
END;
/
-- usual fill NT from cursor
SELECT * FROM items;
DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(60) ;
  l_items_nt      items_nt := items_nt();

  CURSOR get_items IS
    SELECT *
         FROM items;
BEGIN
  FOR iterable IN get_items LOOP
    l_items_nt.EXTEND; 
    l_items_nt(l_items_nt.LAST) := iterable.item_name;
  END LOOP;
  --loop over a filled NT
  FOR i IN l_items_nt.FIRST..l_items_nt.LAST LOOP
   DBMS_OUTPUT.PUT_LINE(l_items_nt(i));
  END LOOP;
END;
/

/**********************************
chap NESTED TABLES demo3  NT common exceptions
***********************************/

--exception uninitialized NT  with element assignements
DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(60) NOT NULL;
  l_items_nt      items_nt;
 
BEGIN
   l_items_nt(1) := 'Bike';
END;
/

-- memory not allocated before element assignment
DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(60) NOT NULL;
  l_items_nt      items_nt := items_nt();
 
BEGIN
    -- need here l_items_nt.EXTEND;
   l_items_nt(1) := 'Bike';
END;
/

-- cannot assign NULL to elements
DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(60) NOT NULL;
  l_items_nt      items_nt := items_nt();
 
BEGIN
   l_items_nt.EXTEND; 
   l_items_nt(1) := NULL;
END;
/

-- try to access an element  after deletion
DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(60) NOT NULL;
  l_items_nt      items_nt := items_nt();
 
BEGIN
   l_items_nt.EXTEND; 
   l_items_nt(1) := 'Bike';
   l_items_nt.delete(1);
   -- or l_items_nt.trim;
   dbms_output.put_line(l_items_nt(1));
END;
/



--assignment of a value of a bad type  'Bike' and varchar2(2)
DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(2) NOT NULL;
  l_items_nt      items_nt := items_nt();
 
BEGIN
   l_items_nt.EXTEND; 
   l_items_nt(1) := 'Bike';
   dbms_output.put_line(l_items_nt(1));
END;
/

--using a bad type for an index
DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(20) NOT NULL;
  l_items_nt      items_nt := items_nt();
 
BEGIN
   l_items_nt.EXTEND; 
   l_items_nt('a') := 'Bike';
   dbms_output.put_line(l_items_nt(1));
END;
/

--index out of bounds. also cannot use negative integers unlike with AA
DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(20) NOT NULL;
  l_items_nt      items_nt := items_nt();
 
BEGIN
   l_items_nt.EXTEND; 
   l_items_nt(0) := 'Bike';
   dbms_output.put_line(l_items_nt(1));
END;
/

-- demo of trim
DECLARE
  TYPE items_nt IS TABLE of VARCHAR2(20) NOT NULL;
  l_items_nt      items_nt := items_nt();
 
BEGIN
   l_items_nt.EXTEND(3); 
   l_items_nt(1) := 'Bike';
   l_items_nt(2) := 'Treadmill';
   l_items_nt(2) := 'Weights'; --reassignment

   dbms_output.put_line('Item at index 1 '||l_items_nt(1));
   dbms_output.put_line('Count before trim '||l_items_nt.count);

   l_items_nt.trim;  -- cut last element
   dbms_output.put_line('Count after trim '||l_items_nt.count);
   l_items_nt.trim(2); -- cut other 2 elments, execpting element count = 0
   dbms_output.put_line('Count after trim with an argument of 2 is  '||l_items_nt.count);
END;
/


/**********************************
chap NESTED TABLES demo4  DML on nested table columns
***********************************/
-- ddl schema objects types and a nested table
-- do not forget  to add / 
CREATE TYPE items_nt AS TABLE OF VARCHAR2(60);
/
CREATE TYPE orders_ot AS OBJECT (order_id NUMBER, order_item_id NUMBER);
/
CREATE OR REPLACE TYPE  orders_nt IS TABLE OF orders_ot;
/
CREATE TABLE account_orders (
   act_id NUMBER,
   act_month VARCHAR2(8),
   itemslist      items_nt    DEFAULT items_nt(),
   orderslist    orders_nt  DEFAULT orders_nt())
   NESTED TABLE  itemslist   STORE AS itemlist_store
   NESTED TABLE  orderslist  STORE AS orderslist_store;
/

-- this is how to insert a row in  a nested table inside a block
DECLARE
  l_items_nt      items_nt := items_nt();
  l_orders_nt    orders_nt:= orders_nt();
  l_orders_ot    orders_ot := orders_ot(1,1);
 
BEGIN
  l_items_nt.EXTEND(2); 
  l_items_nt(1) := 'Bike'; 
  l_items_nt(2) := 'Treadmill';


  l_orders_nt.EXTEND(2);
  l_orders_nt(1) := l_orders_ot;
  l_orders_nt(2) := orders_ot(2,2);
  INSERT INTO  account_orders (act_id, act_month, itemslist,  orderslist)  
                       VALUES (  1,    'JANUARY', l_items_nt, l_orders_nt);
   COMMIT;
END;
/
--this is how to insert a row in a nested table in a sql
SELECT * FROM account_orders;
INSERT INTO  
     account_orders (act_id, 
                     act_month,
                     itemslist,     
                     orderslist)  
            VALUES ( 2, 
                     'MARCH',     
                     items_nt('Weights'), 
                     orders_nt(orders_ot(5,5),orders_ot(6,6)));
COMMIT;
/

select * from account_orders;

-- this is how to update a row  of a nested table inside a block
DECLARE
  l_items_nt      items_nt := items_nt();
  l_orders_nt    orders_nt:= orders_nt();
  l_orders_ot    orders_ot := orders_ot(1,1);
 
BEGIN
  l_items_nt.EXTEND(1); 
  l_items_nt(1) := 'Elliptical';

  l_orders_nt.EXTEND(2);
  l_orders_nt(1) := l_orders_ot;
  l_orders_nt(2) := orders_ot(3,3);
  UPDATE account_orders SET  itemslist  = l_items_nt,
                             orderslist = l_orders_nt
                       WHERE     act_id = 1
                         AND  act_month = 'JANUARY';
  COMMIT;
END;
/

select * from account_orders;

--this is how to delete a row of nested table
BEGIN
 DELETE FROM account_orders
        WHERE  act_id = 1
        AND        act_month =  'JANUARY';
   COMMIT;
END;
/
select * from account_orders;
          
--clear screen;

-------------------
exec pretty_chapter('VArrays'); 

/************************
chap Varrays demo 1 defintion of VA
*************************/

CREATE OR REPLACE TYPE mytype_va IS VARRAY(5) OF VARCHAR2(60) ;
/
DECLARE
  TYPE items_va IS VARRAY(5) of VARCHAR2(60) ; --specify lenght
  l_items_va  items_va := items_va();
  l_mytype_va mytype_va := mytype_va('Bike','Treadmill');
  
BEGIN
  DBMS_OUTPUT.PUT_LINE( 'l_items_va count is '||l_items_va.COUNT);
  DBMS_OUTPUT.PUT_LINE( 'l_mytype_va count is '||l_mytype_va.COUNT);
END;
/


/************************
chap Varrays demo 2 extending reducing VA
*************************/

-- initialization and assigment is similar to NT
-- BUT you need to set the length of the VARRAY
DECLARE
  TYPE items_rec IS RECORD( item_name  items.item_name%TYPE, --type of a table column
                                count  NUMBER);
  VSIZE CONSTANT NUMBER  := 5;                          
  TYPE items_va IS VARRAY(VSIZE) of items_rec ;
  l_items_va  items_va := items_va();
 
BEGIN
  l_items_va.EXTEND; 
  l_items_va(l_items_va.LAST).item_name := 'Bike';
  l_items_va(l_items_va.LAST).count := 1;

  l_items_va.EXTEND; 	
  l_items_va(l_items_va.LAST).item_name := 'Treadmill';
  l_items_va(l_items_va.LAST).count := 2;

  DBMS_OUTPUT.PUT_LINE( l_items_va(1).item_name);
  DBMS_OUTPUT.PUT_LINE( l_items_va.COUNT);
   
END;
/


DECLARE
  TYPE items_rec IS RECORD( item_name  items.item_name%TYPE,
                                count  NUMBER);
  TYPE items_va IS VARRAY(5) of items_rec ;
  l_items_va  items_va := items_va();
 
BEGIN
  l_items_va.EXTEND(2); 
  l_items_va(1).item_name := 'Bike';
  l_items_va(1).count := 1;
  l_items_va(2).item_name := 'Treadmill';
  l_items_va(2).count := 2;
  l_items_va.EXTEND(2,2); -- allocate 2 more elements copy into them element 2
  DBMS_OUTPUT.PUT_LINE( l_items_va(4).item_name);
  DBMS_OUTPUT.PUT_LINE( l_items_va.COUNT);
   
END;
/

--define a VA of records
DECLARE
  TYPE items_rec IS RECORD( item_name  items.item_name%TYPE,
                                count  NUMBER);
  TYPE items_va IS VARRAY(5) of items_rec ;
  l_items_va  items_va := items_va();
  l_copy_va   items_va := items_va();
 
BEGIN
  l_items_va.EXTEND(2); 
  l_items_va(1).item_name := 'Bike';
  l_items_va(1).count := 1;
  l_items_va(2).item_name := 'Treadmill';
  l_items_va(2).count := 2;
  l_items_va.EXTEND(2,2);
  l_copy_va := l_items_va;
  DBMS_OUTPUT.PUT_LINE( l_copy_va(3).item_name);
  DBMS_OUTPUT.PUT_LINE( l_copy_va.COUNT);
   
END;
/
--applying trim and delete
DECLARE
  TYPE items_rec IS RECORD( item_name  items.item_name%TYPE,
                                count  NUMBER);
  TYPE items_va IS VARRAY(5) of items_rec ;
  l_items_va  items_va := items_va();
 
BEGIN
  l_items_va.EXTEND(2); 
  l_items_va(1).item_name := 'Bike';
  l_items_va(1).count := 1;
  l_items_va(2).item_name := 'Treadmill';
  l_items_va(2).count := 2;
  l_items_va.EXTEND(2,2);  -- 4 elements
  l_items_va.TRIM;   -- 3 elements
  DBMS_OUTPUT.PUT_LINE( l_items_va.COUNT);
  l_items_va.DELETE;  -- 0 elements
  DBMS_OUTPUT.PUT_LINE( l_items_va.COUNT);
   
END;
/

select * from items;
-- fill VA from a cursor
DECLARE
  TYPE items_va IS VARRAY(5) of VARCHAR2(60) ;
  l_items_va      items_va := items_va();
  CURSOR cur_get_items IS
     SELECT *
         FROM items
     WHERE ROWNUM < 6;
BEGIN 
   FOR iterable IN cur_get_items LOOP
     l_items_va.EXTEND; 
     l_items_va(l_items_va.LAST) := iterable.item_name;
   END LOOP;
   --loop over a filled VA
   FOR i IN l_items_va.FIRST .. l_items_va.LAST LOOP
     DBMS_OUTPUT.PUT_LINE(l_items_va(i));
   END LOOP;
END;
/

clear screen;

/************************
chap Varrays demo 3 exceptions
*************************/

DECLARE
  TYPE items_va IS VARRAY(2) of VARCHAR2(4);
  l_items_va      items_va ;
 
BEGIN
  l_items_va.EXTEND(3);
END;
/


DECLARE
  TYPE items_va IS VARRAY(2) of VARCHAR2(4);
  l_items_va      items_va  := items_va();
 
BEGIN
  l_items_va.EXTEND(3);
   
EXCEPTION
  WHEN SUBSCRIPT_OUTSIDE_LIMIT THEN
    DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
    RAISE;
END;
/

DECLARE
  TYPE items_va IS TABLE of VARCHAR2(4);
  l_items_va      items_va  := items_va();
 
BEGIN
  l_items_va.EXTEND;
  l_items_va(0) := 'Treadmill'; -- bad index value = 0
EXCEPTION
  WHEN SUBSCRIPT_OUTSIDE_LIMIT THEN
    DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
    RAISE;
END;
/

DECLARE
  TYPE items_va IS VARRAY(5) of VARCHAR2(4);
  l_items_va      items_va  := items_va();
 
BEGIN
  l_items_va.EXTEND;
  l_items_va(1) := 'Treadmill';
EXCEPTION
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
    RAISE;
END;
/

--finally no exeptions
DECLARE
  TYPE items_va IS VARRAY(5) of VARCHAR2(4);
  l_items_va      items_va  := items_va();
 
BEGIN
  l_items_va.EXTEND;
  l_items_va(1) := 'Bike';
EXCEPTION
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
    RAISE;
END;
/

DECLARE
  TYPE items_va IS VARRAY(5) of VARCHAR2(4);
  l_items_va      items_va  := items_va();
 
BEGIN
  l_items_va.EXTEND;
  l_items_va(1) := 'Bike';
  l_items_va.TRIM(2);  -- trimmed 2 elemnts whilst VA contained 1 element
EXCEPTION
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
    RAISE;
END;
/

/************************
chap Varrays demo 4 DML agains Varray columns in testes tables
*************************/
-- haven't looked on it yet
CREATE OR REPLACE TYPE items_va AS VARRAY(5) OF VARCHAR2(60);
/
CREATE TYPE orders_ot AS OBJECT (order_id NUMBER, order_item_id NUMBER);
/
CREATE OR REPLACE TYPE  orders_va IS VARRAY(5) OF orders_ot;
/

CREATE TABLE act_orders (
   act_id NUMBER,
   act_month VARCHAR2(8),
   itemslist      items_va    DEFAULT items_va(),
   orderslist    orders_va  DEFAULT orders_va());
/
--ddl done
DECLARE
   l_items_va      items_va := items_va();
   l_orders_va     orders_va:= orders_va();
   l_orders_ot     orders_ot := orders_ot(1,1);
 
BEGIN
   l_items_va.EXTEND(2); 
   l_items_va(1) := 'Bike'; 
   l_items_va(2) := 'Treadmill';

   l_orders_va.EXTEND(2);
   l_orders_va(1) := l_orders_ot;
   l_orders_va(2) := orders_ot(2,2);
   INSERT INTO  act_orders  (act_id, act_month,  itemslist,   orderslist)  
                    VALUES  (  1,    'JANUARY',  l_items_va,  l_orders_va);
   COMMIT;
END;
/
select * from act_orders;
/

DECLARE
   l_items_va      items_va := items_va();
   l_orders_va    orders_va:= orders_va();
   l_orders_ot    orders_ot := orders_ot(1,1);
 
BEGIN
   l_items_va.EXTEND(1); 
   l_items_va(1) := 'Elliptical';

   l_orders_va.EXTEND(2);
   l_orders_va(1) := l_orders_ot;
   l_orders_va(2) := orders_ot(3,3);
   UPDATE act_orders SET itemslist = l_items_va,
                         orderslist = l_orders_va
                  WHERE  act_id = 1
                    AND  act_month =  'JANUARY';
   COMMIT;
END;
/
select * from act_orders;
/
BEGIN
   DELETE FROM act_orders ;
   COMMIT;
END;
/
select * from act_orders;
-- and now in sql
INSERT INTO  
   act_orders (act_id, 
               act_month,
               itemslist,     
               orderslist)  
      VALUES ( 1, 
               'JANUARY',     
               items_va('Bike', 'Treadmill'),  
               orders_va(orders_ot(1,1),orders_ot(2,2)));
COMMIT;

select * from act_orders;
SELECT  order_id, 
        order_item_id 
  FROM  TABLE(SELECT orderslist FROM  act_orders
                               WHERE  act_id = 1  
                                 AND  act_month =  'JANUARY'); 
SELECT  b.COLUMN_VALUE 
  FROM  act_orders a, 
        TABLE(itemslist) b
 WHERE  act_id = 1  
   AND  act_month =  'JANUARY'; 



-------------------
exec pretty_chapter('BULK ops Bulk Collect'); 


--fill with 10K elemnts items
begin
 FOR i in 4..10000 LOOP
   INSERT into items values(i,'Weight-'||i, 500);
 END LOOP;
 commit;
end;
/
/************************
chap Bulk Ops Bulk Collect  demo 1   bulk collect from a direct seelct
*************************/

-- bulk fill a column in a nested table and a column in AA
DECLARE
  TYPE itemid_nt  IS TABLE OF PLS_INTEGER;  --NT
  l_itemid_nt      itemid_nt;
  TYPE item_name_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER; --AA
  l_item_name_aa   item_name_aa;

BEGIN
   SELECT   item_id,
            item_name 
    BULK COLLECT INTO l_itemid_nt,
                      l_item_name_aa
     FROM items;
   DBMS_OUTPUT.PUT_LINE( l_itemid_nt.COUNT);
   DBMS_OUTPUT.PUT_LINE( l_item_name_aa.COUNT);
END;
/


DECLARE
  TYPE itemid_nt  IS TABLE OF PLS_INTEGER;  --NT
  l_itemid_nt      itemid_nt;
  TYPE item_name_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
  l_item_name_aa   item_name_aa;  --AA

BEGIN
   SELECT   item_id,
            item_name 
    BULK COLLECT INTO l_itemid_nt,
                      l_item_name_aa
     FROM items
     WHERE item_value = -1;  -- this query does not return anything
    -- expect counts at 0
   DBMS_OUTPUT.PUT_LINE( l_itemid_nt.COUNT);
   DBMS_OUTPUT.PUT_LINE( l_item_name_aa.COUNT);
END;
/

select * from items where item_value = -1;


/************************
chap Bulk Ops Bulk Collect  demo 2   bulk collect from cursor 
*************************/

-- add another 90000 elements
begin
 FOR i in 10001 ..100000 LOOP
   INSERT into items values(i,'Weight-'||i, 500);
 END LOOP;
 commit;
end;
/

-- paginating by 100 elemnents with timer stop start counting
DECLARE
   TYPE itemid_aa  IS TABLE OF NUMBER INDEX BY PLS_INTEGER; --AA
   l_itemid_aa      itemid_aa;

   CURSOR get_item_info_cur IS
       SELECT item_id
        FROM  items;
   l_start_time     NUMBER;
   l_end_time       NUMBER;
BEGIN
   l_start_time := dbms_utility.get_time;
   OPEN   get_item_info_cur;
      LOOP
        FETCH get_item_info_cur BULK COLLECT INTO l_itemid_aa LIMIT  500;     
        EXIT WHEN l_itemid_aa.COUNT = 0; 
      END LOOP;
   CLOSE   get_item_info_cur; 
   l_end_time := dbms_utility.get_time;
   DBMS_OUTPUT.PUT_LINE('Time elapsed in seconds with bulk collect: '
                        ||(l_end_time - l_start_time)/100);  
END;
/

-- run the same query without bulk 10x times slower
DECLARE
   TYPE itemid_aa  IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
   l_itemid_aa      itemid_aa;
   CURSOR get_item_info_cur IS
       SELECT item_id
        FROM  items;
   l_start_time     NUMBER;
   l_end_time       NUMBER;
BEGIN
   l_start_time := dbms_utility.get_time;
   OPEN   get_item_info_cur;
      LOOP
        FETCH get_item_info_cur INTO l_itemid_aa(l_itemid_aa.COUNT+1);     
        EXIT WHEN get_item_info_cur%NOTFOUND; 
      END LOOP;
   CLOSE   get_item_info_cur; 
   l_end_time := dbms_utility.get_time;
   DBMS_OUTPUT.PUT_LINE('Time elapsed in seconds with normal fetch: '||(l_end_time - l_start_time)/100);  
END;
/


/************************
chap Bulk Ops Bulk Collect  demo 3  with dynamic sql statment
*************************/
DECLARE
   TYPE itemid_nt  IS TABLE OF PLS_INTEGER;  --NT
   l_itemid_nt      itemid_nt;
BEGIN
  UPDATE items 
     SET item_value = item_value * 1.10
   WHERE item_value > 400
   RETURNING item_id  BULK COLLECT INTO l_itemid_nt;                  
   DBMS_OUTPUT.PUT_LINE( l_itemid_nt.COUNT);
END;
/



CREATE OR REPLACE FUNCTION get_item_ids(p_where VARCHAR2)   
    RETURN  items_nt   -- NT of varchar2(60) defined in schema
IS     
    l_items_nt      items_nt;
BEGIN
   EXECUTE IMMEDIATE
       'SELECT   item_name
          FROM    items '
          || p_where      --p_where is a func param
       BULK COLLECT INTO l_items_nt;
     DBMS_OUTPUT.PUT_LINE( l_items_nt.COUNT);
      RETURN l_items_nt;
END;
/

-- call the function  with a defined param
DECLARE     
    l_items_nt      items_nt;
BEGIN
   --expect 100'000 - 3
   l_items_nt :=  get_item_ids('WHERE item_value < 600');
END;
/

-------------------
exec pretty_chapter('BULK Ops FORALL'); 

/************************
chap Bulk Ops FORALL demo 1 basic use
*************************/

-- update  in BULK just 2 first rows of items  table
SELECT count(*) FROM items; 

DECLARE
  TYPE item_rec IS RECORD(item_id NUMBER, inc_factor NUMBER); 
  TYPE items_aa IS TABLE OF item_rec INDEX BY BINARY_INTEGER;
  l_items_aa      items_aa;
BEGIN
   l_items_aa(1).item_id := 1;
   l_items_aa(1).inc_factor := 1.10;
   l_items_aa(2).item_id := 2;
   l_items_aa(2).inc_factor := 1.15;

   FORALL i IN l_items_aa.FIRST .. l_items_aa.LAST  
     UPDATE items
        SET item_value = item_value  * l_items_aa(i).inc_factor
      WHERE item_id IN       l_items_aa(i).item_id;
   DBMS_OUTPUT.PUT_LINE('Rows updated  '||SQL%ROWCOUNT);
END;
/

select * from items where  rownum < 100;

rollback;

/************************
chap Bulk Ops FORALL demo 2 values of and indices of clause
*************************/
select * from items where item_id between 1 and 4;
select * from items where item_id in (5,6,7,8);

--- this block updates elements  in items  5,6,7,8
DECLARE
   TYPE itemid_aa  IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
   l_itemid_aa      itemid_aa ;
BEGIN
   l_itemid_aa(1) := 5;
   l_itemid_aa(5) := 6;
   l_itemid_aa(7) := 7;
   l_itemid_aa(9) := 8;
   FORALL i IN INDICES OF l_itemid_aa    
      UPDATE items
        SET  item_value = item_value * 1.13
       WHERE item_id = l_itemid_aa(i);
   DBMS_OUTPUT.PUT_LINE('Rows updated  '||SQL%ROWCOUNT);
END;
/
rollback;
select * from items where item_id between 1 and 10;

DECLARE
   TYPE itemid_aa  IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
   l_itemid_aa      itemid_aa ;
   l_second_aa      itemid_aa;
BEGIN
   l_itemid_aa(1) := 1;
   l_itemid_aa(2) := 2;
   l_itemid_aa(3) := 3;

   l_second_aa(1) := 3;
   l_second_aa(2) := 3;
   l_second_aa(3) := 2;
   l_second_aa(4) := 1;
   FORALL i IN VALUES OF l_second_aa    
      UPDATE items
        SET  item_value = item_value * 1.13  -- element 3 will be affected twice
       WHERE item_id = l_itemid_aa(i);
   DBMS_OUTPUT.PUT_LINE('Rows updated  '||SQL%ROWCOUNT);
END;
/
select * from items where item_id between 1 and 10;
rollback;


/************************
chap Bulk Ops bulk exceptions
*************************/

SELECT * FROM items d where rownum < 10 order by item_id; --10 items 1-10
SELECT * FROM orders; --order item id 1..2..3

--- block shows we cannot delete item_id 2 and 3 because of referential integrigyt
DECLARE
   TYPE id_aa  IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
   l_id_aa       id_aa ;
   l_error_count NUMBER;
   l_index NUMBER;
   l_item_id NUMBER;
   
   array_dml_exception EXCEPTION;
   PRAGMA EXCEPTION_INIT (array_dml_exception, -24381);

BEGIN
   l_id_aa(1) := 21;
   l_id_aa(2) := 3;
   l_id_aa(3) := 25;
   l_id_aa(4) := 2;

   FORALL i IN l_id_aa.FIRST..l_id_aa.LAST SAVE EXCEPTIONS  --we are saving exceptions
      DELETE FROM items
      WHERE item_id = l_id_aa(i); 
EXCEPTION
   WHEN array_dml_exception THEN
     l_error_count := SQL%BULK_EXCEPTIONS.COUNT;
     FOR i in 1..l_error_count LOOP
           l_item_id := l_id_aa(SQL%BULK_EXCEPTIONS(i).ERROR_INDEX );
           DBMS_OUTPUT.PUT_LINE('Error occured at index '||SQL%BULK_EXCEPTIONS(i).ERROR_INDEX||' for item id '||
                                 l_item_id ||' for error message '||
                                 SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));     
    END LOOP;
END;
/
rollback;

--this block deletes all rows from orders
DECLARE
   TYPE id_aa  IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
   l_id_aa       id_aa ;
   l_error_count NUMBER;
   l_index NUMBER;
   l_item_id NUMBER;
   
   array_dml_exception EXCEPTION;
   PRAGMA EXCEPTION_INIT (array_dml_exception, -24381);

BEGIN
   l_id_aa(1) := 1;
   l_id_aa(2) := 2;
   l_id_aa(3) := 3;

   FORALL i IN l_id_aa.FIRST..l_id_aa.LAST SAVE EXCEPTIONS --we are saving exceptions
      DELETE FROM orders
      WHERE order_item_id = l_id_aa(i); 
   FOR  i IN l_id_aa.FIRST..l_id_aa.LAST LOOP
     DBMS_OUTPUT.PUT_LINE('Row counts affected for index '||i||' are '||SQL%BULK_ROWCOUNT(I));
   END LOOP;
EXCEPTION
   WHEN array_dml_exception THEN
     l_error_count := SQL%BULK_EXCEPTIONS.COUNT;
     FOR i in 1..l_error_count LOOP
           l_item_id := l_id_aa(SQL%BULK_EXCEPTIONS(i).ERROR_INDEX );
           DBMS_OUTPUT.PUT_LINE('Error occured at index '||SQL%BULK_EXCEPTIONS(i).ERROR_INDEX||' for item id '||
                                 l_item_id ||' for error message '||
                                 SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));     
    END LOOP;
END;
/

ROLLBACK;


/************************
chap performance for all
*************************/
delete from items;
delete from  orders;
COMMIT;
/

/*
select * from orders;
select * from items;
*/

--first half of 100'000 is inserted usually send half by bulk forall 
-- check time difference
DECLARE
   TYPE  number_aa IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
   TYPE  varchar_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
   l_itemid_aa number_aa;
   l_itemname_aa varchar_aa;
   l_itemvalue_aa number_aa;
   l_start_time NUMBER;
   l_end_time NUMBER;
   l_time_normal NUMBER;
   l_time_forall NUMBER;
BEGIN
  -- First let us fill the associative arrays  
   FOR i IN 1..100000 LOOP
     l_itemid_aa(i):= i;
     l_itemname_aa(i) := 'Item'||i;
     l_itemvalue_aa(i):= 600;
   END LOOP;
   
  -- First let us insert using a normal for loop
  --Start Timing
  l_start_time := DBMS_UTILITY.GET_TIME;
   FOR i IN 1..50000  LOOP
     INSERT INTO items(item_id, item_name, item_value)
                VALUES(l_itemid_aa(i),l_itemname_aa(i),l_itemvalue_aa(i));
   END LOOP;
   --End Timing
  l_end_time := DBMS_UTILITY.GET_TIME;
  l_time_normal := (l_end_time-l_start_time)/100;
  DBMS_OUTPUT.PUT_LINE('Elapsed time for normal loop insert '||l_time_normal);
   COMMIT;
   
  -- Nxt let us insert using a forall loop
  --Start Timing
  l_start_time := DBMS_UTILITY.GET_TIME;
   FORALL i IN 50001..100000 
     INSERT INTO items(item_id, item_name, item_value)
                VALUES(l_itemid_aa(i),l_itemname_aa(i),l_itemvalue_aa(i));
   --End Timing
  l_end_time := DBMS_UTILITY.GET_TIME;
  l_time_forall :=  (l_end_time-l_start_time)/100;
  DBMS_OUTPUT.PUT_LINE('Elapsed time for a forall loop insert '||l_time_forall);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Normal for loop insert took '||trunc(l_time_normal/l_time_forall) ||' times more time then forall insert');
END;
/

