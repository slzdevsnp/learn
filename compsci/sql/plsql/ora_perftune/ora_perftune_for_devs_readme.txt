oracle peformance tuning for developers

-------------------------------------
chap  why performance tuning matters
chap oracle architecture and performance basics
chap connections and connection pools
chap Bind variables
chap Statement Level performance tuning
chap Execution plans in depth
chap Indexing Essentials
chap Advanced Indexing Techniques
chap Application Indexing Practices
chap Monitoring Oracle Application
chap Pitfalls and Practices
-------------------------------------



1 chap  why performance tuning matters
-------------------------------------

    perf tuning is not a blackbox magic
    can have analytica approach to performance tuning 
    who is responsible for perf tuning? dbas or developers -> developers

    design performance from the start

    first principle in performance
        * focus on processing less data
        * take analytical approach, let data drive your decision
            your decisions should be based on Measured metrics


    the course uses the same database student enrollments as in course oracle tables and indexes

2 chap oracle architecture and performance basics
----------------------------------------------
    oracle loves memory
        puts lots of data in a cache
        have special memory zones to do sql operations
    memory
        SGA (system global area shared among users, processes)
        PGA (server process area) private area not shared among users 

        dev need understanding, PGA,  Shared Pol Buffer Cache   

    data organized in blocks sized 2kb to 32 kb, 8 kb typical 
        block header, directory of rows
        a list of rows.  gray area: free space
    PCT param to control free space. (some free space is useful)
        i.e. insert new rows into a block

    Buffer Cache (in SGA)
        a large collection of blocks dynamically stored in memory cache for reuse
    Shared Pool (in SGA)
        data dictionary cache (on db objects, columns, indexes)
        shared sql area cache sql statements and execution plans
    Reserved Pool
        used to borrow memory for short term operations

    PGA (program global area)
        individual session memory
            sql work area  (sorting data, creating hash tables)
            private sql area
                values of bind variables

    Performance Metrics
        * elapsed time (for the sql statement operation)
            what your user feels
            is a product of underneath multiple factors
        * logical io operations (number of blocks reads from cache and disk)
            this is a consistent metric (standard metric across RDBMS)
        autrace in sqlplus and sql developer    
        v$qlstats

    cpu usage in oracle
        1. statement parsing and creating exec plan (cpu intensive operation)
        2. statement processing (filtering, joining, sorting data)

    testing consideration
        tested on small dbsize on test, problems in prod where dbsize is big

        imperative programming used in oo langaueges, we specify which algo the code uses 
        declarative programming specify the result wanted. how this is executed
        is done by the system. oracle can choose different algorithms to execute
    => need to create a test environment which represents well the prod environment.  (size and data distribution )    

    building test environment 
        1. replicate data from prod to test (can use tools like data pump)
            * known to match your distribution
            * be sure to mask sensitive data
        2. data generation tools (commercially available tools)
            * eliminate issue of sensitive data
            * generate any amount of data
            * need to invest time into data generation process to ensure distribution data
    using test environment
        analyze individual sql statements
            determine execution plans, develop performance baseline
    performance tuning process  is iterative
        
    component level performance testing 
        evaluate a performance of the whole component
        identify performance issues early on component level
    Formal Performance testing : automatic deployment of performance engines
    Testers -> testing application 
        identify intensive operations, make sure testers test them

    Proactive vs Reactive performance  tuning
        reduce reactive tuning as much as you can by investing in proactive testing
        reactive tuning: troubleshooting a production performance issue (can be urgent)
        test all changes in a test environment!!!! 
            minimize impact on production users
            some indexes can be time consuming/resource intensive to build

    Integrate performance testing into the development process

chap Bind variables
-------------------
    using bind varibles easy step to improve performance

    shared sql area keeps a hash map of recent sql statements
        at every requestion oracle makes a search on hash in the shared sql area

     statenents have to match exactly char by char to get pulled from cache  even upper case/lower case in object names
    
    with 2 bind variables : USE bind variables
    SELECT
        department_code, course_number, course_title,
        credits, grade_code, points
    FROM v_student_grades
    WHERE student_id = :student_id
        AND term_code = :term_code 

     add params in the same order as bind variables
     

     demo sample application in .net to compare approach   

chap Statement Level performance tuning
------------------------------------
    Explain plan (F10)
    query does not run

    Autotrace capability (F6)
    query runs (prepare to roll back)
    autortrace returns stats : numbe of physical or logical IOs

    if data read from cache -> logical io
    if data on disk -> physical io + logical io

    We want to reduce the number of physical ios and of logical ios

    in sqlplus:

    sql>set linesize 120
    sql>set autotrace traceonly

    sql>-- run the query, get stats

    data size in execution:  make the same data size between prod and test

    execution plan most common operations

chap Execution plans in depth
-----------------------------
    table operations 
        table scan full
        table access by index row ID

    index operations
        index range scan
        index unique scan
        index fast full scan
        index full scan

    join operations
        nested loops join
        merge join
        hash join

    Table operations 
        table scan full (high physical IOs most expensive)
            for a large table avoid full scan!
            (for small tables full scan is OK)

        table access by index row id (much more efficient)
            (ora has row ids from index lookup operation)
        reads a right block right away

        filter predicates are  applied AFTER the data is read
    
    Index lookup operations (more efficient)

        Index range scan (usually matches multiple rows)     

        Index Unique scan (if 1 value specified in where clause)
            -> 1 rowid returned

        predicates
            access predicate
                applied while reading the index
                limits amount of data read
            filter predicate
                applied After index blocks have been read
                do not reduce the amount of data read


    Index full scan operations
        index fast full scan
            reads all index in an unsorted manner
                (index has fewer columns than table -> light version of table)
    Index full scan
        index data is read in order
        single block reads are used
            -> relatively slow operation
    
    Join operations
        Nested loops join  (2 level loop)
            ( ! have indexes on joined coluns)            

        Hash join
            (if there ar no indexes on joined columns)
            builds a hashtable on a driving table
            checks rows in internal table for a matching hash key
            cost to build a hashtable
            !! works best on large tables

        Merge Join
            1 sort tables
            2  merge sorted tables

        join operations
            which table does oracle use as a driving table
            are the joined columns indexed in both tables ? 
            doi need to perform this join ? 


        Guidelines for performance tuning 
            interactive applications
                many users
                high volume, short duration queries .

            batch applications
                few long running queries
                must finish in specified window

            business intelligence applications
                fixed and ad-hoc queries
                queries process large volumes of data

            Identify key tables for performance
                -> almost often the most large, dynamic tables with high business value


            try to use more selective where  clause (to return less rows)   
            
            !!! poorly performing sql statements can bring down the whole database server Affecting the whole system   

chap Indexing Essentials
-------------------------

    consider indexes like an investment

    B-tree (balanced tree)
        data (index key, rowid) on leaf nodes is in sorted order

    tree traversal O(log n)


    bitmap index  is suitable for low cardinality columns (factor variables)
        targeted for data warehouse applications
    do not use in OLTP databases, only in Data warehouse

     
    Bitmap index 

    column order matters!!
        if index's leading edge column is not included in where clause this index will not be used.
        put in a leading edge the column which most frequently used in a where clause


    index skip scan
           ix_some_index  col1, col2, col3
            if col1 has low cardinality, it can be skipped

    Index selectivity
        measure of how discerning the index is
        most selective index is PK (distinct value for every row)

        Gender column has only 2 values , not selective (factor variables)
        in
        most columns in the middle : zip_code, last_name

    If an index returns > ~ 5% of rows of table in a query, it will not be used

    Formula for index selectivity: 
         selectivity = # unique values of column/ # rows in table

    --see distinct values for all columns in a table
    SELECT column_name, num_distinct
        FROM all_tab_columns
        WHERE table_name = upper('applications')
        ORDER BY num_distinct DESC;


    --selectivity on multiple columns
    --/////////////////////////////////
    select count(1) from
        (select 
            distinct last_name, first_name
        from applications)


    how to determine index column order
        1. frequent used columns need to be at the front

        2. pay attention to index selectivity, add columns to improve selectivity



chap Advanced Indexing Techniques
---------------------------------
    Covering indexes
        it makes sense to create a covering index for 1 query which is very frequently used 

    Function based indexes (oracle specific)
        index is built over a derived value
        indexing a subset of rows  with function based index


    Index compression
        repeated values at the front of the index are compressed into a single prefix value (smaller storage, less IOs)
        less disk storage, less ios -> gain in performance

    Invisible indexes
    ability to mark index invisible
    index exists but is not used by the oracle optimizer
        usage to test query without using the index

        create index <<name>> on <<table>> (<<col1>>,..) INVISIBLE;
        alter  index <<name> INVISIBLE;
        alter index <<name>  VISIBLE;
