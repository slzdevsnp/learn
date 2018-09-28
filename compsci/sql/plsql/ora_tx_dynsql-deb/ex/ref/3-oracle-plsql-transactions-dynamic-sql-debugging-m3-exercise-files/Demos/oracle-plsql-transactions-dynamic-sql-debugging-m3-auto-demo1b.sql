CREATE OR REPLACE PROCEDURE   
   log_msg (p_act_id accounts.act_id%TYPE, 
            p_msg  VARCHAR2)   IS
  PRAGMA AUTONOMOUS_TRANSACTION;
 BEGIN
   INSERT INTO log_table(log_id,
                         log_act_id,
                         log_msg,
                         log_insert_time)
                VALUES( log_seq.NEXTVAL,
                        p_act_id,
                        p_msg,
                        SYSTIMESTAMP);
 END log_msg;
/
SELECT * FROM log_table;
exec process_order(1,3,200);
