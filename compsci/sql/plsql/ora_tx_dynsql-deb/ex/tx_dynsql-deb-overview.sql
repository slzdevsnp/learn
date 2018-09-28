-- script to run under user learn

-- before ddl 
DROP TABLE ORDERS;
DROP TABLE ACCOUNTS;
DROP TABLE ITEMS;
DROP TABLE CUSTOMERS;
DROP TABLE TEMP_TABLE;
DROP TABLE ORDERS_QUEUE;
DROP TABLE LOG_TABLE;

DROP PACKAGE act_magmt;
DROP PROCEDURE process_order;
DROP PROCEDURE batch_processing;

DROP SEQUENCE orders_seq;
DROP SEQUENCE log_seq;
DROP SEQUENCE queue_seq;

/*==================
prere popuulate data
=====================*/
CREATE TABLE CUSTOMERS (cust_id  NUMBER  NOT NULL PRIMARY KEY,
                        cust_name  VARCHAR2(100) NOT NULL,
                        cust_location VARCHAR2(2) NOT NULL  );
                        
CREATE TABLE ACCOUNTS (act_id NUMBER NOT NULL PRIMARY KEY,
                       act_cust_id NUMBER NOT NULL,
                       act_bal NUMBER(10,2),
                       CONSTRAINT act_cust_fk FOREIGN KEY (act_cust_id) REFERENCES  
                       customers(cust_id));

CREATE TABLE ITEMS    (item_id  NUMBER  NOT NULL PRIMARY KEY,
                       item_name  VARCHAR2(100) NOT NULL,
                       item_value number(5,2) NOT NULL  );
                       
CREATE TABLE ORDERS  ( order_id  NUMBER  NOT NULL PRIMARY KEY,
                       order_item_id   NUMBER NOT NULL,
                       order_act_id    NUMBER NOT NULL ,
                       CONSTRAINT order_item_fk FOREIGN KEY (order_item_id) REFERENCES  
                       items(item_id),
                       CONSTRAINT  order_act_fk FOREIGN KEY (order_act_id) REFERENCES  
                       accounts(act_id) );

CREATE TABLE TEMP_TABLE(dummy number);

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
COMMIT;



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
exec pretty_chapter('Transaction Management'); 

/************************
demo  1.1.1 commit & rollback 
*************************/

CREATE OR REPLACE PACKAGE act_mgmt IS
  g_debit VARCHAR2(1):='N';
END act_mgmt;
/

--proc to process an order
CREATE OR REPLACE PROCEDURE process_order (p_act_id accounts.act_id%TYPE,
                                           p_item_id items.item_id%TYPE,   --item id should exist
                                           p_item_value items.item_value%TYPE) IS
  l_new_bal       accounts.act_bal%TYPE;
  l_balance_again accounts.act_bal%TYPE;
  BEGIN
  SELECT act_bal INTO l_balance_again FROM accounts where act_id = p_act_id; -- save ini acc balance
    SET TRANSACTION NAME 'place_order';	
    -- Debit Account
    UPDATE accounts 
     SET act_bal = act_bal - p_item_value
     WHERE act_id = p_act_id   
     RETURNING act_bal INTO l_new_bal; --put value of act_bal column into a variable l_new_bal
     DBMS_OUTPUT.PUT_LINE('Account id '||p_act_id||' debited for '|| p_item_value
                         ||' new balance is '||l_new_bal);
     act_mgmt.g_debit :='Y';  --change var in package
     DBMS_OUTPUT.PUT_LINE('Debug Package variable act_mgmt.g_debit assigned a value of Y.'
                         ||' Now trying to insert');
   -- Place Order
     INSERT INTO orders(order_id,           
                        order_item_id,     -- orders references items
                        order_act_id)      -- orders referrences accounts
                VALUES( orders_seq.nextval,
                        p_item_id,
                        p_act_id);
    DBMS_OUTPUT.PUT_LINE('Successful insertion in the orders table');
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN

   DBMS_OUTPUT.PUT_LINE('In Exception Section. Balance for account id '|| p_act_id 
                        || ' before rollback '||l_balance_again);
   DBMS_OUTPUT.PUT_LINE('Error: '||DBMS_UTILITY.FORMAT_ERROR_STACK||' Rolling back');
   DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
   ROLLBACK;
   DBMS_OUTPUT.PUT_LINE('Value of package variable act_mgmt.g_debit after rollback '
                        ||act_mgmt.g_debit);
   RAISE;
END process_order;
/


--item_id = 3 does not exist  Expect a rollback from the transaction 
-- nothing insertedin orders,  account balances are unchanged
EXEC process_order(p_act_id=>1, p_item_id=>3, p_item_value=>700); 


/*
select * from accounts;
select * from items;
select * from orders;
*/

/************************
demo  1.1.2 implicit commit 
*************************/
-- now lets insert a ddl statement in the procedure. and we should see a partial commit
update accounts set act_bal = 1000;
-- redefine the proc 
CREATE OR REPLACE PROCEDURE process_order_bis(  p_act_id accounts.act_id%TYPE,
                                                p_item_id items.item_id%TYPE,   --item id should exist
                                                p_item_value items.item_value%TYPE) IS
  l_new_bal       accounts.act_bal%TYPE;
  l_balance_again accounts.act_bal%TYPE;
  BEGIN
  SELECT act_bal INTO l_balance_again FROM accounts where act_id = p_act_id; -- save ini acc balance
    SET TRANSACTION NAME 'place_order';	
    -- Debit Account
    UPDATE accounts 
        SET act_bal = act_bal - p_item_value
    WHERE act_id = p_act_id   
        RETURNING act_bal INTO l_new_bal; --put value of act_bal column into a variable l_new_bal
     DBMS_OUTPUT.PUT_LINE('Account id '||p_act_id||' debited for '|| p_item_value
                         ||' new balance is '||l_new_bal);
     act_mgmt.g_debit :='Y';  --change var in package
     --=======================================
     EXECUTE IMMEDIATE 'DROP TABLE TEMP_TABLE';  -- DDL statemement (tx 'place_order' will commit')
     --=======================================     
     DBMS_OUTPUT.PUT_LINE('Debug Package variable act_mgmt.g_debit assigned a value of Y.'
                         ||' Now trying to insert');
   -- Place Order
     INSERT INTO orders(order_id,           
                        order_item_id,     -- orders references items
                        order_act_id)      -- orders referrences accounts
                VALUES( orders_seq.nextval,
                        p_item_id,
                        p_act_id);
    DBMS_OUTPUT.PUT_LINE('Successful insertion in the orders table');
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN

   DBMS_OUTPUT.PUT_LINE('In Exception Section. Balance for account id '|| p_act_id 
                        || ' before rollback '||l_balance_again);
   DBMS_OUTPUT.PUT_LINE('Error: '||DBMS_UTILITY.FORMAT_ERROR_STACK||' Rolling back');
   DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
   ROLLBACK;
   DBMS_OUTPUT.PUT_LINE('Value of package variable act_mgmt.g_debit after rollback '
                        ||act_mgmt.g_debit);
   RAISE;
END process_order_bis;
/

--item_id = 3 does not exist  Expect a rollback from the transaction 
-- nothing insertedin orders,  but account balances is  changed !! because DDL commited transaction
-- implicit commit!
-- package variable not rolled back
clear screen;
EXEC process_order_bis(p_act_id=>1, p_item_id=>3, p_item_value=>700); 

-- normal proc run
--acc 2 debited, oders has a new line inserted
clear screen;
EXEC process_order(p_act_id=>2, p_item_id=>2, p_item_value=>600); 


/*
select * from accounts;
select * from items;
select * from orders;
*/


/************************
demo 1.2.1 transaction savepoint
*************************/

UPDATE accounts   SET act_bal = 1000;
delete from orders;
commit;
--define  pro without params 
-- is is expected to create first order and rollback to savepoint after first order inserted
CREATE OR REPLACE PROCEDURE demo_savepoint_dml_explicit IS
  l_act_id1_bal NUMBER;
  l_act_id2_bal NUMBER;
BEGIN

   -- Debit Account 1
    UPDATE accounts
        SET act_bal = act_bal - 600 
    WHERE act_id = 1
        RETURNING act_bal INTO l_act_id1_bal;
    DBMS_OUTPUT.PUT_LINE('Debited act_id 1 for 600 dollars new balance is '||l_act_id1_bal);
  -- Place Order
    DBMS_OUTPUT.PUT_LINE('Inserting order ');
    INSERT INTO orders( order_id,
                        order_item_id,
                        order_act_id)
        VALUES( 1, 2, 1);    -- order int act_id = 1
    DBMS_OUTPUT.PUT_LINE('Establishing savepoint_after_first_order ');
    
    SAVEPOINT savepoint_after_first_order; 

    -- Debit Account 2
     UPDATE accounts
        SET act_bal = act_bal - 600
    WHERE act_id = 2
        RETURNING act_bal INTO l_act_id2_bal;
    DBMS_OUTPUT.PUT_LINE('Debited act_id 2 for 600 dollars new balance is '||l_act_id2_bal);
  -- Place Order
    DBMS_OUTPUT.PUT_LINE('Inserting order ');
    INSERT INTO orders( order_id,
                        order_item_id,
                        order_act_id)
        VALUES( 2, 10, 2);        -- act_id = 2, item_id = 10 does not exist, expect exception
 COMMIT;
 EXCEPTION
 WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inserting order for second transaction '
                        ||DBMS_UTILITY.FORMAT_ERROR_STACK);
    DBMS_OUTPUT.PUT_LINE('Rolling back to savepoint_after_first_order');
    DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
    ROLLBACK to savepoint_after_first_order;  -- rollback to a specified savepoitn
    DBMS_OUTPUT.PUT_LINE('Committing');
    COMMIT; -- do not forget to put commit
    RAISE;
END demo_savepoint_dml_explicit;
/

-- proc run  is expected to create first order and rollback to savepoint after first order inserted
clear screen;
EXEC demo_savepoint_dml_explicit;

/*
select * from accounts where act_id in (1,2);
select * from orders;
*/

/************************
demo 1.2.2 savepoint redefined in loop
*************************/

CREATE TABLE orders_queue (QUEUE_ID NUMBER NOT NULL PRIMARY KEY,
                           queue_act_id NUMBER,
                           queue_item_id NUMBER ); 

INSERT INTO orders_queue(queue_id,queue_act_id,queue_item_id) VALUES(1,1,2);
INSERT INTO orders_queue(queue_id,queue_act_id,queue_item_id) VALUES(2,20,2);
INSERT INTO orders_queue(queue_id,queue_act_id,queue_item_id) VALUES(3,3,2);

delete from orders;

insert INTO items(item_id, item_name, item_value) VALUES(3, 'Bike', 600);
commit;


update accounts
    set act_bal = 1000;


--proc to process orders readied in orrders_queue table
 CREATE OR REPLACE PROCEDURE orders_in_queue_batch_processing IS
  
  CURSOR cur_get_orders IS
    SELECT oq.queue_act_id,
           oq.queue_item_id,
           it.item_value
      FROM orders_queue oq
           INNER JOIN items it
      ON oq.queue_item_id  = it.item_id
      ORDER BY queue_id;
BEGIN
   -- Process orders in a loop
    FOR order_var IN cur_get_orders LOOP
      SAVEPOINT savepoint_before_order; --savepoint redefined at each loop iteration
                                        --if exceptin, rollback only the current iteration
      BEGIN
         -- Debit Account
         UPDATE accounts
            SET act_bal = act_bal - order_var.item_value
         WHERE act_id = order_var.queue_act_id;
         -- Place Order
         INSERT INTO orders(order_id, order_item_id, order_act_id)
                VALUES( orders_seq.NEXTVAL,
                        order_var.queue_item_id,
                        order_var.queue_act_id);
         COMMIT;
         DBMS_OUTPUT.PUT_LINE('Processed order for act id '||order_var.queue_act_id);
       EXCEPTION
           WHEN OTHERS THEN
            ROLLBACK TO savepoint_before_order;
            DBMS_OUTPUT.PUT_LINE('Account id: '||order_var.queue_act_id||' Item id: '||order_var.queue_item_id||' Error '|| SQLERRM);
            -- we are not excpected to RAISE as this would excit the loop  
       END; --block inside the loop
  END LOOP; 
END  orders_in_queue_batch_processing;
/

clear screen;
--executing proc will gracefully on row 2 from orders_queue
-- 2 rows will be inserted into orders
exec orders_in_queue_batch_processing;
select * from accounts;
select * from orders;

/*
select * from accounts where act_id in (1,2);
select * from orders_queue;
select * from orders;
select * from items;
select orders_seq.currval from dual;
*/

-------
-------------------
exec pretty_chapter('Autonomous transactions'); 


/************************
demo 2.1.1 use of autonomous transaction in logging
*************************/
delete from orders;
delete from items where item_id = 3;
update accounts set ACT_BAL = 1000;
commit;
drop table log_table;
create table log_table(log_id           NUMBER PRIMARY KEY,
                       log_act_id       NUMBER,
                       log_msg          VARCHAR2(400),
                       log_insert_time  TIMESTAMP);

create sequence log_seq START WITH 1 INCREMENT BY 1;

--  logging proc with autonomus transaction 
CREATE OR REPLACE PROCEDURE   
   log_msg (p_act_id accounts.act_id%TYPE, 
            p_msg  VARCHAR2)   IS
  PRAGMA AUTONOMOUS_TRANSACTION; --!!
 BEGIN
   INSERT INTO log_table(log_id,
                         log_act_id,
                         log_msg,
                         log_insert_time)
                VALUES( log_seq.NEXTVAL,
                        p_act_id,
                        p_msg,
                        SYSTIMESTAMP);
    COMMIT;
 END log_msg;
/
--proc to debig account, process order and log this info
CREATE OR REPLACE PROCEDURE 
                 process_order_logged (p_act_id accounts.act_id%TYPE,
                                p_item_id items.item_id%TYPE,
                                p_item_value items.item_value%TYPE) IS
 BEGIN
   -- Debit Account
   UPDATE accounts 
    SET act_bal = act_bal - p_item_value WHERE act_id = p_act_id;
   -- Log Message
   log_msg(p_act_id, 'Debited');
  -- Place Order
    INSERT INTO orders(order_id,
                       order_item_id,
                       order_act_id)
               VALUES( orders_seq.NEXTVAL,
                       p_item_id,
                       p_act_id);
   -- Log Message
   log_msg(p_act_id, 'Order Placed');
    COMMIT;
 EXCEPTION
 WHEN OTHERS THEN
   -- Log Message
   log_msg(p_act_id, SQLERRM);  
   ROLLBACK;
   RAISE;
END process_order_logged;
/

clear screen;
-- item 3 does not exist
exec process_order_logged(p_act_id=>1,p_item_id=>3,p_item_value=>200);

--accounts are not affected
select * from accounts;
select * from orders;
select * from items;
--info, failed attempt IS in th elog table
select * from log_table;

-- valid proc execution
exec process_order_logged(p_act_id=>1,p_item_id=>2,p_item_value=>200);
select * from accounts;
select * from orders;
select * from log_table;

/************************
demo 2.2.1 tx context i autonomous transactions
*************************/
delete from orders;
delete from log_table;
update accounts set ACT_BAL = 1000;
commit;

--  logging proc with autonomou swith savepoint 
CREATE OR REPLACE PROCEDURE   
   log_msg_savep (p_act_id accounts.act_id%TYPE, 
            p_msg  VARCHAR2)   IS
  PRAGMA AUTONOMOUS_TRANSACTION;
 BEGIN
   SAVEPOINT first;
   INSERT INTO log_table(log_id,
                         log_act_id,
                         log_msg,
                         log_insert_time)
                VALUES( log_seq.NEXTVAL,
                        p_act_id,
                        p_msg,
                        SYSTIMESTAMP);
    COMMIT;
 END log_msg_savep;
/
-- anonymous block with savepiont having the same name
DECLARE
 BEGIN
   SAVEPOINT first;
   INSERT INTO ACCOUNTS(act_id,act_cust_id,act_bal) VALUES (10,3,1000); --expect fail
   log_msg_savep(10,'Created');
   ROLLBACK TO first;
 END;
 /
-- accounts are unchanged as expecgted
select * from accounts;
--- log_table has a line. i.e. savepoint first in anonymous block
-- is not shared with savepoint first in autonomous transaction inside log_msg_savep
select * from  log_table;

/************************
demo 2.3.1 nested autonomous transactions
*************************/
update accounts set act_bal = 1000;
delete from orders;
delete from log_table;
commit;
select * from accounts;
select * from orders_queue;
--proc to debig account, process order and log this info
CREATE OR REPLACE PROCEDURE 
                 process_order_autonom (p_act_id accounts.act_id%TYPE,
                                        p_item_id items.item_id%TYPE,
                                        p_item_value items.item_value%TYPE) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
 BEGIN
   -- Debit Account
   UPDATE accounts 
        SET act_bal = act_bal - p_item_value
    WHERE act_id = p_act_id;
  -- Place Order
    INSERT INTO orders(order_id,
                       order_item_id,
                       order_act_id)
               VALUES( orders_seq.NEXTVAL,
                       p_item_id,
                       p_act_id);
   -- Log Message
   log_msg(p_act_id, 'Order Placed, acc debited');  -- autonom tx insided log_msg nested
    COMMIT;
 EXCEPTION
 WHEN OTHERS THEN
   -- Log Message
   log_msg(p_act_id, 'Failed '|| SQLERRM);  -- autonom tx insided log_msg nested
   ROLLBACK;
   RAISE;
END process_order_autonom;
/

-- execute in anonymous block  orders in the order_gueue
DECLARE
  CURSOR cur_get_order_queue IS
    SELECT queue_act_id,
           queue_item_id,
           item_value
      FROM orders_queue,
           items
     WHERE queue_item_id = item_id;
BEGIN
   FOR cur_info IN cur_get_order_queue LOOP
     process_order_autonom(cur_info.queue_act_id,
                   cur_info.queue_item_id,
                   cur_info.item_value);
   END LOOP;
END;
/

clear screen;
--  accts 1,3 debited
select * from accounts;
-- 2 orders created
select * from orders;
select * from orders_queue;
--- logging every operation
select * from log_table;


-------------------
exec pretty_chapter('Native Dynamic SQL'); 

/************************
demo 3.2.1 single row and multile row select
*************************/
update accounts set act_bal = 1000;
truncate table orders;
truncate table log_table;
commit;

update orders_queue 
    set queue_act_id = 2,
        queue_item_id =1
where queue_id = 2;
commit;

/*
select * from accounts;
select * from orders_queue;
*/

--proc which uses dyn sql to chose all or specific rows from orders_queue 
CREATE OR REPLACE PROCEDURE initiate_order(p_where VARCHAR2)  IS 

    TYPE cur_ref IS REF CURSOR;  --pointer
    cur_order cur_ref;
    -- plsql record type
    TYPE order_rec IS RECORD( act_id       orders_queue.queue_act_id%TYPE,
                              item_id       orders_queue.queue_item_id%TYPE);
    l_order_rec  order_rec;
    l_item_rec   items%ROWTYPE;
    l_query VARCHAR2(400);
 BEGIN
    l_query := 'SELECT queue_act_id,queue_item_id FROM  orders_queue ' ||  p_where ;
    dbms_output.put_line(l_query);
    OPEN    cur_order FOR l_query;  --open cursor and associate it with dyn query
    LOOP                            --infinte loop   
        FETCH cur_order INTO l_order_rec;   --get current row from cursor
        EXIT WHEN cur_order%NOTFOUND;  --get out of loop
        
        -- :item_id is variable placeholder, bound with l_order_rec.item_id
        EXECUTE IMMEDIATE  'SELECT * FROM items WHERE item_id = :item_id ' 
            INTO l_item_rec  USING l_order_rec.item_id ; -- to get item_value

        process_order_logged(p_act_id=>l_order_rec.act_id,
                             p_item_id=>l_order_rec.item_id,
                             p_item_value=>l_item_rec.item_value   );
   END LOOP;

END initiate_order;
/
--process orders from queue for act 1
clear screen;
exec initiate_order(p_where=>'where queue_act_id = 1');

--only 1 order processed
select * from orders;

/*
select * from orders_queue;
select * from accounts;
select * from orders;
select * from items;
select * from log_table;
*/

--now lets process orders for all rows in orders_queue
update accounts set act_bal = 1000;
truncate table orders;
truncate table log_table;
commit;

clear screen;
--we do not specify the where close
exec initiate_order(p_where=>NULL); 

--all 3 ordesr processed, all accounts debited
select * from orders;
select * from accounts;
select * from log_table;

/************************
demo 3.2.1 execution procedures
*************************/
update accounts set act_bal = 1000;
truncate table orders;
truncate table log_table;
commit;

--sequence for orders_queue
--drop sequence queue_seq;

CREATE SEQUENCE queue_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE FUNCTION generate_order(p_loc VARCHAR2, p_act_id NUMBER, p_item_id NUMBER)
   RETURN NUMBER IS
  l_count    NUMBER;
  l_id       NUMBER;
  l_item_val NUMBER;
  no_table_exists EXCEPTION;
  PRAGMA EXCEPTION_INIT(no_table_exists,-942);
  CURSOR get_item_val IS
    SELECT item_value
     FROM  items
    WHERE  item_id = p_item_id;
BEGIN
  BEGIN
    --First check if table exists. If not create it for that location
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM orders_queue_'||p_loc INTO l_count;
  EXCEPTION 
    WHEN no_table_exists THEN
      EXECUTE IMMEDIATE 'CREATE TABLE orders_queue_'||p_loc||'( queue_id NUMBER,queue_act_id NUMBER,queue_item_id NUMBER)';
  END;
  EXECUTE IMMEDIATE 'INSERT INTO orders_queue_'||p_loc||'(queue_id ,queue_act_id ,queue_item_id) VALUES '||
                    '(:p_id,:p_act,:p_item) RETURNING queue_id INTO :l_id' 
                     USING queue_seq.NEXTVAL,p_act_id,p_item_id RETURNING INTO l_id;
  DBMS_OUTPUT.PUT_LINE('queue_id is '||l_id);
  OPEN get_item_val;
  FETCH get_item_val INTO l_item_val;
  CLOSE get_item_val;
  EXECUTE IMMEDIATE 'CALL process_order_logged(:p_act_id,:p_item_id,:p_item_value) ' USING p_act_id,p_item_id,l_item_val;
  RETURN l_id;
END generate_order;
/  

delete  from orders;
commit;
clear screen;
--this creates table orders_queues_ca;
DECLARE
  l_id NUMBER;
BEGIN 
  l_id := generate_order('CA',1,1);
END;
/

select * from  orders_queue_ca;

/************************
demo 3.3.1 sql injection
*************************/

CREATE OR REPLACE PROCEDURE delete_order(p_column VARCHAR2,
                                         p_value  VARCHAR2 )  IS     
 l_query VARCHAR2(200);
 BEGIN
    l_query := 'DELETE FROM orders WHERE ' ||
                          p_column ||' = '||p_value ;
    DBMS_OUTPUT.PUT_LINE(l_query);

    EXECUTE IMMEDIATE l_query;
    DBMS_OUTPUT.PUT_LINE('Rows Deleted: '||SQL%ROWCOUNT);
END delete_order;
/


insert into orders(order_id, order_item_id, order_act_id)
    values(orders_seq.nextval, 2, 2);
insert into orders(order_id, order_item_id, order_act_id)
    values(orders_seq.nextval, 2, 3);
commit;

--legit use 1 row deleted
exec delete_order('order_act_id','1');
ROLLBACK;
--rogue use  all rows deleted
exec delete_order('order_act_id','1 OR 1=1');
ROLLBACK;


/*

select * from orders;

*/
--proc with some protection from sql injection  (variable binding)

CREATE OR REPLACE PROCEDURE delete_order_vb(p_column VARCHAR2,
                                         p_value  VARCHAR2 )  IS     
 l_query VARCHAR2(200);
 BEGIN
    l_query := 'DELETE FROM orders WHERE ' ||
                          p_column ||' = :p_value' ;
    DBMS_OUTPUT.PUT_LINE(l_query);

    EXECUTE IMMEDIATE l_query USING p_value;
    DBMS_OUTPUT.PUT_LINE('Rows Deleted: '||SQL%ROWCOUNT);
END delete_order_vb;
/

--this execution does not pass
exec delete_order_vb('order_act_id','1 OR 1=1');

--legitmate usage
exec delete_order_vb('order_act_id','1');

-- expect two rows for act_id != 1
select * from orders;


-------------------
exec pretty_chapter('Debugging SQL code'); 
