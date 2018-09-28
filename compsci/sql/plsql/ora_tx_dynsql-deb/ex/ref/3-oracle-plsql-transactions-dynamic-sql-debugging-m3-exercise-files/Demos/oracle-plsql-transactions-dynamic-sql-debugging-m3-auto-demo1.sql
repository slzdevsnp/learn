delete from orders;
delete from items where item_id = 3;
commit;
create table log_table(log_id           NUMBER PRIMARY KEY,
                       log_act_id       NUMBER,
                       log_msg          VARCHAR2(400),
                       log_insert_time  TIMESTAMP);
create sequence log_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE   
   log_msg (p_act_id accounts.act_id%TYPE, 
            p_msg  VARCHAR2)   IS
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
