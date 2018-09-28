oracle pl/sql transactions dynamic sql & debugging 

==============================
chap transaction management

chap autonomous transaction 

chap native dynamic sql

chap dynamic sql usig dbms_sql 

chap debugging pl/sql code 


==============================
chap transaction management
    in course-overview.sql 
    demo  1.1 commit & rollback 
    demo  1.2 implicit commit 
    demo 2.1 transaction savepoint
    demo 2.2 savepoint redefined in loop



    ACID
        atomicity (all or nothing)
        consistency (transition from one valid state to another)
        isolation (thread safe)
        durability (comits make perm changes)

    What is transaction?  An atomic unit of work
        begins with
            * starts with DML,DDL, set transaction statement

        ends with:
            * commit
            * rollback
            * ddl statement
            * normal use exit, abnormal termination

    Transaction names
        SET TRANSACTION NAME <<tx_name>>
            is a first statement of a transaction before a first dml 
            useful for monitoring long running transactiosn
            redo logs
            V$TRANSACTION
    Read-ONLY transactions 
        SET TRANSACTION READ ONLY NAME <<tx_name>>   
        select A;
        Select B;
        COMMIT;
            before commit you see the data at the state when ro tx started. 
            i.e. you see a fixated snap-shot of the data

    Commit
        data changes written on disk
        system change number (SCN) is generated 
            it is oracle clock for db data change
        tx locks are released
        savepoints deleted
        tx ends

    DDL statements in the middle of transaction issue implicit commit
        because ddl opens its own transaction, 
            after a ddl statement this new tx commits

    Rollback
        changes undone
        tx locks released.
        savepoints erased

        if db system stops/ craches  all open txs rollback

        rollback does not revert any variables changed inside tx body

        tx ends

    Save Points
        user defined markets
        logically break long transaction into steps
        allow to do a partial rollback
    SAVEPOINT <<savepoint_name>>;

        ROLLBACK to <<savepoint_name>>;

    savepoint overriding    
        if you redefine a savepoint with the same name
        the market moves to this new location
        this happens if savepoint is defined inside a loop
                i.e. a rollback touches only a current iteration

    Explicit locks
        normally locks are managed by oracle
        locks should be minimized

    ex. cursor for update
        when cursor is opened it makes a snapshot of data in its 
        query but does not lock this data before the actual update.
        sometimes you need exclusive lock from the moment you open your cursor.
        DECLARE
            CURSOR update_accounts(p_balance accounts.act_balance%TYPE)  IS
                SELECt act_id, act_balance FROM accounts 
                WHERE act_balance < p_balance
                FOR UPDATE OF act_balance;  -- FOR UPDATE makes a cursor FOR UPDATE
                                            -- orcl will make an explicit  lock for this cursor
        BEGIN
        FOR cur_upd_acts_var IN cur_upd_acts(500) LOOP  -- 500 is a cursor parameter value
            ....
            .....
            UPDATE accounts
            SET act_bal = act_bal - 10
            WHERE CURRENT OF cur_upd_acts;
        END LOOP;
        COMMIT;
        END; 

    Lock Table
        locks never prevent quering the data
        shared lock  --many sessions can have a shared lock on a table
        exculive lock  -- one user per detail
        When a tx1 tries to DML a row it obtains a ROW exclusive lock on those rows
            if another session tries to change the same row it should wait tx1 to finish
    LOCK TABLE accounts  IN ROW SHARE MODE NOWAIT; --prevent other sessions to obtain an exclusive lock
    LOCK TABLE accounts  in ROW EXCLUSIVE MODE; 

        tx commit, rollback  makes  locks released                                                   

==============================
chap Autonomous transcations 
    demos  in overview.sql 

    demo 2.1.1 use of autonomous transaction in logging
    demo 2.2.1 tx context in autonomous transactions
    demo 2.3.1 nested autonomous transactions 

    Autonomous transaction make independent transactions with a separate context
        from within another transaction 
    very used for logging, monitoring, usage counters (login attempts)
    has PRAGMA directive  (used in  compile time)

==============================
chap Native dynamic sql
    demos  in overview.sql 
      3 demos  done 

 
    l_query := l_select || l_from || p_where;
    EXECUTE IMMEDATE  l_query 
    [USING  bind_var1,..]
    [RETURNING INTO bind_varA];

    Binding variable is  important for speed and to reduce SQL-injection risk

    Dyn native sql  supports sql types and plsql types including user-defined types
    
    Dyn sql can be used for DDL  (will skip the demo) 
                            for DML  

