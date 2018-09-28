-------set serveroutput on;

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


exec pretty_chapter('q 0 oracle functions');
--------------------

--padding strin from the left
select lpad('hello world', 25, '*') from dual;

--take off leading space
select trim(trailing 'x' from 'mama x') from dual;

--truncate
select trunc(123.375, 1) from dual;

--vs round
select round(123.375, 1) from dual;

--get position of 'v'
select instr('privet mama', 'v') from dual;

exec pretty_chapter('q 1 merge operator');
--------------------
/*
MERGE conditionaly updates or inserts data 
*/

drop table employee;
drop table hr_record;

create table  employee(
    Id int not null primary key,
    Name varchar(16),
    Salary int,
    ManagerId int,
    address  varchar2(128) );

insert into Employee (Id, Name, Salary, ManagerId,address) values ('1', 'Joe', '70000', '3', '10 place du Feu');
insert into Employee (Id, Name, Salary, ManagerId,address) values ('2', 'Henry', '80000', '4', NULL);
insert into Employee (Id, Name, Salary, ManagerId,address) values ('3', 'Sam', '60000', NULL, NULL);
insert into Employee (Id, Name, Salary, ManagerId,address) values ('4', 'Max', '90000', NULL,NULL);


create table hr_record(
    emp_id int not null primary key,
    Name varchar(16),
    address  varchar2(128) );
    
insert into hr_record (emp_id, Name,address) values ('1', 'Joe', '1 av. de la Gare');
insert into hr_record (emp_id, Name,address) values ('3', 'Sam', '10 rue de Roses');
insert into hr_record (emp_id, Name,address) values ('5', 'Joe', '11 place Centrale');

select * from employee;
select * from hr_record;

MERGE into employee e 
    USING  hr_record h
    ON (e.id = h.emp_id)
    WHEN MATCHED THEN 
        UPDATE set e.address = h.address
    WHEN NOT MATCHED THEN 
        insert (id, address)
            VALUES (h.emp_id, h.address);

--after the merge
select * from employee;



exec pretty_chapter('q 1 multiple table insert');
--------------------
/*
insert in 1 statement data into several tables
https://www.red-gate.com/simple-talk/sql/oracle/multi-table-insert-statements-in-oracle/
*/

drop table e1;
drop table s1;

TRUNCATE TABLE e1;

create table  e1(Id int,  Name varchar(16));
create table  s1(Id int,  Salary int );

INSERT ALL
INTO e1(id,name) values (id, name)
INTO s1(id,salary) values (id, salary )
select * from employee e;

select * from e1;
select * from s1;

select * from employee;

select  id, name, managerid, LEVEL
from employee 
connect by prior id = managerid;


exec pretty_chapter('q 199 sequence hitting max value');

drop sequence tseq;

create SEQUENCE tseq start with 10 increment by 1 maxvalue 13;

create SEQUENCE tseq start with 10 increment by 1 maxvalue 13 cycle cache 2;
create SEQUENCE tseq minvalue 10 increment by 1 maxvalue 13 cycle nocache;


drop table a;
create table a(id int);
alter table a add price number(8,2) not null;


drop  table order_item; 
create table order_item(o_id int, unit_price number, qty number);

insert into order_item(o_id, unit_price, qty) values (10, 2.0, 2);
insert into order_item(o_id, unit_price, qty) values (11, 3.0, 1);
insert into order_item(o_id, unit_price, qty) values (12, 4.0, 3);
insert into order_item(o_id, unit_price, qty) values (12, 5.0, 1);
insert into order_item(o_id, unit_price, qty) values (13, NULL, 1);
insert into order_item(o_id, unit_price, qty) values (14, NULL, 1);


select * from order_item;

select o_id, max(unit_price * qty) as max_or from order_item group by o_id; 

select count(nvl(unit_price,0)) from order_item where unit_price is null; 

select o_id, qty as qq
from order_item order by qq desc;



exec pretty_chapter('q 1 multiple table insert');
--------------------

select * from order_item;

select o_id
from order_item
group by o_id
having sum(unit_price * qty) = (
select max(sum(unit_price * qty)) 
from order_item
group by o_id);


--- default value
drop table item_date;
create table item_date(i_id int not null,
                       i_dt timestamp(6) default to_timestamp('1900-01-01 00:00:00.0', 'YYYY-MM-DD HH24:MI:SS.FF') );


insert into item_date(i_id, i_dt) values (1, to_timestamp('2015-01-01 00:00:00.0', 'YYYY-MM-DD HH24:MI:SS.FF') );   
insert into item_date(i_id, i_dt) values (2, to_timestamp('2016-01-01 00:00:00.0', 'YYYY-MM-DD HH24:MI:SS.FF') );   
insert into item_date(i_id, i_dt) values (3, to_timestamp('2017-01-01 00:00:00.0', 'YYYY-MM-DD HH24:MI:SS.FF') );   


select * from item_date;

update item_date
    set i_dt  = DEFAULT;
    
 
 select 2 col1, 'y' col2 from dual
 union
 select 1, 'x' from dual
 union
 select 3, null from dual
 order by 2;
 
  
select id,name 
from employee
where id = 2
union
select id,name 
from employee
where id = 1
order by id;


select add_months(sysdate, -1) from dual;
select sysdate from dual;

select * from employee
where id between 1 and 2;

select name "NAM", salary sal,  'b'
from employee where id= 1
union
select name, salary s,  'a'
from employee where id= 2
order by sal;

select e1.* , e2.* from employee e1 , employee e2
where e1.id = e2.id;

insert into employee values (5, NULL, 10000, NULL, 3);

select * from employee;

select e1.* , e2.* from employee e1  left join employee e2
on e1.id = e2.id;

------
select * from employee;

select name, salary, salary * 2  saldbl from employee;

select 
    name,
    salary,
    (select salary * 2
    from employee es 
    where es.id = em.id) dblsal
from employee em;

with es(id,dblsal) 
as (select id ,salary * 2 from employee)
select
    name,
    salary,
    (select dblsal from es where es.id = e.id) dblsal
from employee e;

