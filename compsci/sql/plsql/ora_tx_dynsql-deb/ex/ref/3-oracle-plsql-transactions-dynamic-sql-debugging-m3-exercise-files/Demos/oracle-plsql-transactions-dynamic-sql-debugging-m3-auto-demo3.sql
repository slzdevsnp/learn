SELECT * FROM orders_queue;

delete from orders;
delete from log_table;
commit;
CREATE OR REPLACE PROCEDURE 
                 process_order (p_act_id accounts.act_id%TYPE,
                                p_item_id items.item_id%TYPE,
                                p_item_value items.item_value%TYPE) IS
   PRAGMA AUTONOMOUS_TRANSACTION;
 BEGIN
   -- Debit Account
   UPDATE accounts 
    SET act_bal = act_bal - p_item_value WHERE act_id = p_act_id;
  -- Place Order
    INSERT INTO orders(order_id,
                       order_item_id,
                       order_act_id)
                             VALUES( order_seq.NEXTVAL,
                                               p_item_id,
                                              p_act_id);
   -- Log Message
   log_msg(p_act_id, 'Order Successful');
    COMMIT;
 EXCEPTION
 WHEN OTHERS THEN
   -- Log Message
   log_msg(p_act_id, 'Failed '||SQLERRM);  
   ROLLBACK;
END process_order;
/
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
     process_order(cur_info.queue_act_id,
                   cur_info.queue_item_id,
                   cur_info.item_value);
   END LOOP;
END;
/
SELECT * FROM ORDERS;
SELECT * FROM log_table order by log_id;

