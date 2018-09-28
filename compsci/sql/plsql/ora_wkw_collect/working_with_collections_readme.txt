oracle working with collections

chap overview


chap module overview
chap Associative arrays
chap Collection Methods
chap Nested Tables
chap Nested Tables Comparison TABLE & Multiset operators
chap Varrays
chap multilevel collections & converting collections
chap bulk operations bulk collect
chap bul operations: Forall 

=====================
chap overview


Module Overview

    collections big gain for performance

    collection : composite datatype
        associative array
        varray
        nested table
     
     other language    plsql
     hash Table         associative array
     norder Table       associative array
     set                nested table
     bag                nested table
     array              varray

=============================
chap Associative arrays


        associative array  is for key-value pair
            key string or pls_integer type
            value pl/sql datatype    
    
    it is in-memory table
    
    index starts at 1 
    syn: TYPE <<type_name>> IS TABLE OF <element_type> [NOT NULL]
        INDEX BY [BINARY_INTEGER| PLS_INTEGER| VARCHAR2(size)];
        var  type_name ;
    
    the INDEX of associative array can be a number or a varchar2(size)
    associative array can have negative values in numeric index.
    
    Array's elements indexed by numeric index will be sorted !!

    the index can be sparce        

    collection methods 
        coll_obj.first
        coll_obj.next

    can't directly compare associative array
    only count1 = count2  then  compare element by element

=============================
chap Collection Methods

    LAST, EXISTS, COUNT, TRIM, EXTEND


    EXISTS(n) used to iterate through sparse array

    COUNT,
    LAST,  -- returns an index not element

    DELETE,
    l_items_aa.DELETE ; -- deletes all elements
    l_items_aa.DELETE(1) -- deletes 1st element
    l_items_aa.DELETE(1,3) -- deletes 1  2nd  and 3rd elements

    PRIOR

    TRIM  removes 1 element from the end,  TRIM(n) - removes n elements from n
    EXTEND adds 1 null element to end of collection
    TRIM, EXTEND apply only to nested tables
    iterations
        FOR loop , WHILE loop
        while 
            first,  next
        while
            last , prior

=============================
chap Nested Tables

    syn: TYPE <<type_name>> IS TABLE OF <element_type> [NOT NULL]; 

    no index in declaration

    e.g.
    TYPE mytype_nt is TABLE of <<tablname>>%ROWTYPE;
    TYPE mytype_nt is TABLE of NUMBER; 


=============================
chap Nested Tables Comparison TABLE & Multiset operators

=============================
chap Varrays

gen syn:
    TYPE mytype_va IS VARRAY(5) OF NUMBER;
    TYPE mytype_va IS VARRAY(5) OF VARCHAR2(60) NOT NULL;
    TYPE mytype_va IS VARRAY(5) OF customers%ROWTYPE; 
    TYPE mytype_va IS VARRAY(5) OF customers.column%TYPE; 


varray exceptions
    subscript_outside_limit
    value_error
    unininitialized collection
    subscript_beond_count




=============================
chap multilevel collections & converting collections

    trees
    
    AA - AA
    NT - NT 
    VA <-> NT


    cast function  to convert collectios between types

=============================
chap bulk operations bulk collect

    Limit clause ( to limit memory usage)
    returning into clause

=============================
chap bul operations: Forall 

    to speed up DML
    SQL%BULK_ROWCOUNT
    gen syn: 
    FORALL index_counter IN <bounds> [SAVE EXCEPTIONS] sql_statement

    by default work for dense collections
    for sparse collections use INDICES OF Clause
      e.g. FORALL i IN INDICES OF l_itemid_aa

    iterating over specific index values
          FORALL i IN VALUES OF l_second_aa

    Unhandled exception rolls back all previous changes

    SAVE EXCEPTIONS  clause     

    excdeptions
    array_dml_exception 

    SQL%BULK_EXCEPTIONS.COUNT
        for loop in exception  block 
