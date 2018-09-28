CREATE OR REPLACE PROCEDURE 
                 process_order (p_act_id accounts.act_id%TYPE,
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
               VALUES( order_seq.NEXTVAL,
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
END process_order;
/
select * from log_table;
exec process_order(1,3,200);

