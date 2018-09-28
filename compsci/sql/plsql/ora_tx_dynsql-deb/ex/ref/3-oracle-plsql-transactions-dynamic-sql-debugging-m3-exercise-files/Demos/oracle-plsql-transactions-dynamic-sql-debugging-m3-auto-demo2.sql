delete from orders;
delete from log_table;
update accounts set act_bal = 1000;
commit;
SELECT * FROM accounts;


CREATE OR REPLACE PROCEDURE   
   log_msg (p_act_id accounts.act_id%TYPE, 
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
 END log_msg;
 /
 BEGIN
   SAVEPOINT first;
   INSERT INTO ACCOUNTS(act_id,act_cust_id,act_bal) VALUES (10,3,1000);
   log_msg(10,'Created');
   ROLLBACK TO first;
 END;
 /
 SELECT * FROM accounts;
 SELECT * FROM log_table;
