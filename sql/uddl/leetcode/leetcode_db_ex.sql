-- run under learn  user 
/*
*/
set serveroutput on;


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

--------------------
exec pretty_chapter('p 175 combine two tables  ');
--------------------
drop table Person;
drop table  Address;
/
Create table Person (PersonId int not null primary key,
                    FirstName varchar(255),
                    LastName varchar(255));
Create table Address (AddressId int not null primary key,
                    PersonId int,
                    City varchar(255),
                    State varchar(255));

Truncate table Person;
insert into Person (PersonId, LastName, FirstName) values ('1', 'Wang', 'Allen');

Truncate table Address;
insert into Address (AddressId, PersonId, City, State) values ('1', '2', 'New York City', 'New York');
/

delete from Address where AddressId = 2;

select * from Person;
select * from Address;

select 
    p.FirstName, p.LastName, a.city, a.State
from Person p 
left outer join Address a 
on p.PersonId = a.PersonId;



--------------------
exec pretty_chapter('p 176 2nd max salary  ');
--------------------
drop table  Employee;

Create table Employee (Id int, Salary int);
Truncate table Employee;
insert into Employee (Id, Salary) values ('1', '100');
insert into Employee (Id, Salary) values ('2', '200');
insert into Employee (Id, Salary) values ('3', '300');

select * from employee;

--works
select  max(salary) as SecondHighestSalary  from Employee e1 
where e1.salary < (select max(salary) from Employee e2);

--works
select max(e1.Salary) as SecondHighestSalary
from Employee e1 join Employee e2 
on  e1.id < e2.id;


--------------------
exec pretty_chapter('p 181 Employees Earning More Than Their Managers  ');
--------------------

drop table employee;
create table  Employee(
    Id int not null primary key,
    Name varchar(20),
    Salary int,
    ManagerId int);
    

insert into Employee (Id, Name, Salary, ManagerId) values ('1', 'Joe', '70000', '3');
insert into Employee (Id, Name, Salary, ManagerId) values ('2', 'Henry', '80000', '4');
insert into Employee (Id, Name, Salary, ManagerId) values ('3', 'Sam', '60000', NULL);
insert into Employee (Id, Name, Salary, ManagerId) values ('4', 'Max', '90000', NULL);


select * from employee;

--select e.id, e.name, e.Salary, m.id, m.name, m.Salary 
select e.name as Employee 
from employee e join employee m
on e.managerid = m.id
where e.Salary > m.Salary;


--------------------
exec pretty_chapter('p 178 Rank scores  ');
--------------------

drop table scores;

Create table Scores (Id int, Score Number(4,2));


insert into Scores (Id, Score) values ('1', '3.5');
insert into Scores (Id, Score) values ('2', '3.65');
insert into Scores (Id, Score) values ('3', '4.0');
insert into Scores (Id, Score) values ('4', '3.85');
insert into Scores (Id, Score) values ('5', '4.0');
insert into Scores (Id, Score) values ('6', '3.65');


--select distinct Score from Scores order by Score desc;

select * from scores order by score desc;

SELECT
  Score,
  (SELECT count( distinct s2.score) FROM Scores s2 WHERE s2.Score >= s1.Score) as Rank
FROM Scores s1
ORDER BY s1.Score desc;

--using analytic func
select 
    score,
    dense_rank() over ( order by score desc )  rnk
from scores
order by score desc;


--------------------
exec pretty_chapter('p 182 duplicate emails  ');
--------------------
drop table Person;

Create table Person (Id int, Email varchar(255));

insert into Person (Id, Email) values ('1', 'a@b.com');
insert into Person (Id, Email) values ('2', 'c@d.com');
insert into Person (Id, Email) values ('3', 'a@b.com');


select * from Person;


select email from (
select email, count(*)  occur 
from Person group by email )  pp
where pp.occur > 1;



--------------------
exec pretty_chapter('p 183. Customers Who Never Order');
--------------------
/*
Suppose that a website contains two tables, the Customers table and the Orders table.
Write a SQL query to find all customers who never order anything.
*/

drop table customers cascade constraints;
drop table orders cascade constraints;

Create table  Customers (Id int, Name varchar2(255));
Create table  Orders (Id int, CustomerId int);

insert into Customers (Id, Name) values ('1', 'Joe');
insert into Customers (Id, Name) values ('2', 'Henry');
insert into Customers (Id, Name) values ('3', 'Sam');
insert into Customers (Id, Name) values ('4', 'Max');

insert into Orders (Id, CustomerId) values ('1', '3');
insert into Orders (Id, CustomerId) values ('2', '1');

/*
select * from customers;
select * from orders;
*/

select name as customers from customers 
where id not in (select customerid from orders);

--------------------
exec pretty_chapter('p 197. Rising Temperature');
--------------------
/*
Given a Weather table, write a SQL query to find all dates' Ids with higher temperature
compared to its previous (yesterday's) dates.
*/

drop table weather cascade constraints;

Create table  Weather (Id int, RecordDate date, Temperature int);


insert into Weather (Id, RecordDate, Temperature) values ('1', to_date('2015-01-01', 'YYYY-MM-DD'), '10');
insert into Weather (Id, RecordDate, Temperature) values ('2', to_date('2015-01-02', 'YYYY-MM-DD'), '25');
insert into Weather (Id, RecordDate, Temperature) values ('3', to_date('2015-01-03', 'YYYY-MM-DD'), '20');
insert into Weather (Id, RecordDate, Temperature) values ('4', to_date('2015-01-04', 'YYYY-MM-DD'), '30');


--select * from weather;

-- solution more correct compare on dates
select w1.id
from Weather w1   join Weather w0 
on w1.recorddate = w0.recorddate+1
where w1.temperature > w0.temperature;


--------------------
exec pretty_chapter('p 577. Employee Bonus');
--------------------
-- Select all employee's name and bonus whose bonus is < 1000.

drop table employee cascade constraints;
drop table bonus cascade constraints;

create table Employee (EmpId int, Name varchar(20), Supervisor int, Salary int);
Create table  Bonus (EmpId int, Bonus int);
Truncate table Employee;
insert into Employee (EmpId, Name, Supervisor, Salary) values ('3', 'Brad', NULL, '4000');
insert into Employee (EmpId, Name, Supervisor, Salary) values ('1', 'John', '3', '1000');
insert into Employee (EmpId, Name, Supervisor, Salary) values ('2', 'Dan', '3', '2000');
insert into Employee (EmpId, Name, Supervisor, Salary) values ('4', 'Thomas', '3', '4000');
Truncate table Bonus;
insert into Bonus (EmpId, Bonus) values ('2', '500');
insert into Bonus (EmpId, Bonus) values ('4', '2000');

select * from employee;
select * from bonus;

--works
select e.name,b.bonus from employee e  left join bonus b 
on e.empid = b.empid
where b.bonus < 1000 or b.bonus is null;


--------------------
exec pretty_chapter('p 586. Customer Placing the Largest Number of Orders ');
--------------------
/*
Query the customer_number from the orders table for the customer who has placed the largest number of orders.

It is guaranteed that exactly one customer will have placed more orders than any other customer.
*/
drop table orders cascade constraints;

Create table orders (order_number int, customer_number int, order_date date, required_date date,
                    shipped_date date, status varchar(15), cmnt varchar(200));
Truncate table orders;

insert into orders (order_number, customer_number) values ('1', '1');
insert into orders (order_number, customer_number) values ('2', '2');
insert into orders (order_number, customer_number) values ('3', '3');
insert into orders (order_number, customer_number) values ('4', '3');

/*
select * from orders;
select max(count(customer_number)) from orders group by customer_number;
*/

--working on oracle
select customer_number from (
select customer_number, count(customer_number) as cnt from orders group by customer_number ) cg
where cg.cnt  in ( select max(count(customer_number)) from orders group by customer_number); 

--workin on oracle and mysql
select distinct o.customer_number  
from  Orders o join (select customer_number, count(*) as cnt
                     from orders group by customer_number) og
on o.customer_number = og.customer_number
where og.cnt = (select max(cnt) 
                from (select customer_number, count(*) as cnt
                      from orders group by customer_number) ogg) ;


--------------------
exec pretty_chapter('p 596. Classes with More Than 5 Students ');
--------------------


drop table courses cascade constraints;

Create table  courses (student varchar(255), class varchar(255));

insert into courses (student, class) values ('A', 'Math');
insert into courses (student, class) values ('B', 'English');
insert into courses (student, class) values ('C', 'Math');
insert into courses (student, class) values ('D', 'Biology');
insert into courses (student, class) values ('E', 'Math');
insert into courses (student, class) values ('F', 'Computer');
insert into courses (student, class) values ('G', 'Math');
insert into courses (student, class) values ('H', 'Math');
insert into courses (student, class) values ('I', 'Math');

--select * from courses;
--works
select
    distinct cu.class
from courses cu join (select class , count(class) as cnt
                        from courses group by class) cg
on cu.class = cg.class
where cg.cnt >= 5;



--------------------
exec pretty_chapter('p 597. Friend Requests I: Overall Acceptance Rate');
--------------------
/*
Write a query to find the overall acceptance rate of requests rounded to 2 decimals,
which is the number of acceptance divide the number of requests.
*/
drop table  friend_request;
drop table  request_accepted;

Create table friend_request ( sender_id INT NOT NULL, send_to_id INT NULL, request_date DATE NULL);
Create table  request_accepted ( requester_id INT NOT NULL, accepter_id INT NULL, accept_date DATE NULL);


insert into friend_request (sender_id, send_to_id, request_date) values ('1', '2', to_date('2016/06/01','YYYY/MM/DD'));
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '3', to_date('2016/06/01','YYYY/MM/DD'));
insert into friend_request (sender_id, send_to_id, request_date) values ('1', '4', to_date('2016/06/01','YYYY/MM/DD'));
insert into friend_request (sender_id, send_to_id, request_date) values ('2', '3', to_date('2016/06/02','YYYY/MM/DD'));
insert into friend_request (sender_id, send_to_id, request_date) values ('3', '4', to_date('2016/06/09','YYYY/MM/DD'));


insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '2', to_date('2016/06/03','YYYY/MM/DD'));
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '3', to_date('2016/06/08','YYYY/MM/DD'));
insert into request_accepted (requester_id, accepter_id, accept_date) values ('2', '3', to_date('2016/06/08','YYYY/MM/DD'));
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', to_date('2016/06/09','YYYY/MM/DD'));
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', to_date('2016/06/10','YYYY/MM/DD'));



select * from friend_request;
select * from request_accepted;

-- the query below works on mysql but not on oracle
select round((select count(*) 
              from (select r.sender_id
                    from friend_request r join request_accepted
                    a on r.sender_id = a.requester_id
                    and r.send_to_id = a.accepter_id
                    group by r.sender_id, r.send_to_id ) aok) / 
             (select count(*) from friend_request),
             2)  as accept_rate;



--------------------
exec pretty_chapter('p 603. Consecutive Available Seats');
--------------------
/*
Several friends at a cinema ticket office would like to reserve consecutive available seats.
Can you help to query all the consecutive available seats order by the seat_id using
the following cinema table
*/

drop table cinema;

Create table cinema (seat_id int primary key, free number);

insert into cinema (seat_id, free) values ('1', '1');
insert into cinema (seat_id, free) values ('2', '0');
insert into cinema (seat_id, free) values ('3', '1');
insert into cinema (seat_id, free) values ('4', '1');
insert into cinema (seat_id, free) values ('5', '1');
insert into cinema (seat_id, free) values ('6', '0');
insert into cinema (seat_id, free) values ('7', '1');
insert into cinema (seat_id, free) values ('8', '1');
insert into cinema (seat_id, free) values ('9', '0');
insert into cinema (seat_id, free) values ('10','1');
insert into cinema (seat_id, free) values ('11','1');
select * from cinema;

-- sequences of free seats ok
select c1.seat_id  
from cinema c1 join cinema c2 
on c1.seat_id = c2.seat_id+1
where c1.free >0 
order by c1.seat_id ;


--------------------
exec pretty_chapter('p 607. Sales Person');
--------------------
/*
Given three tables: salesperson, company, orders.
Output all the names in the table salesperson, who didn’t have sales to company 'RED'.
*/

drop table salesperson cascade constraints;
drop table  company cascade constraints ;
drop table  orders  cascade constraints;
/

Create table  company (com_id int, name varchar(255), city varchar(255));

Create table  orders (order_id int, odate varchar(255), com_id int, sales_id int, amount int);

Create table  salesperson (sales_id int, name varchar(255), salary int,
                            commission_rate int, hire_date varchar(255));


insert into company (com_id, name, city) values ('1', 'RED', 'Boston');
insert into company (com_id, name, city) values ('2', 'ORANGE', 'New York');
insert into company (com_id, name, city) values ('3', 'YELLOW', 'Boston');
insert into company (com_id, name, city) values ('4', 'GREEN', 'Austin');


insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('1', 'John', '100000', '6', '4/1/2006');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('2', 'Amy', '12000', '5', '5/1/2010');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('3', 'Mark', '65000', '12', '12/25/2008');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('4', 'Pam', '25000', '25', '1/1/2005');
insert into salesperson (sales_id, name, salary, commission_rate, hire_date) values ('5', 'Alex', '5000', '10', '2/3/2007');


insert into orders (order_id, odate, com_id, sales_id, amount) values ('1', '1/1/2014', '3', '4', '10000');
insert into orders (order_id, odate, com_id, sales_id, amount) values ('2', '2/1/2014', '4', '5', '5000');
insert into orders (order_id, odate, com_id, sales_id, amount) values ('3', '3/1/2014', '1', '1', '50000');
insert into orders (order_id, odate, com_id, sales_id, amount) values ('4', '4/1/2014', '1', '4', '25000');

select * from company;
select * from orders;
select * from salesperson;

--salespersons never making orders with company RED, works
select 
    name 
from salesperson 
where sales_id not in ( select o.sales_id
                        from orders o join company c 
                        on o.com_id  = c.com_id
                        where c.name = 'RED') ;




--------------------
exec pretty_chapter('p 610. Triangle Judgemen');
--------------------
/*
Could you help Tim by writing a query to judge whether these three sides can form a triangle,
assuming table triangle holds the length of the three sides x, y and z.
*/

-- NB! definition of triangle, sum of two smaller sides is bigger than the largest side

drop table triangle;

Create table  triangle (x int, y int, z int);

insert into triangle (x, y, z) values ('13', '15', '30');
insert into triangle (x, y, z) values ('10', '20', '15');

select * from triangle;


--works
select 
    x,y,z,
    case  when x+y > z and x+z>y and y+z>x then
        'Yes'
    else
        'No'
    end  as triangle
from triangle;


--------------------
exec pretty_chapter('p 613. Shortest Distance in a Line');
--------------------
/*
Table point holds the x coordinate of some points on x-axis in a plane, which are all integers.
Write a query to find the shortest distance between two points in these points.
*/

drop table point;

CREATE TABLE  point (x INT NOT NULL );
Truncate table point;
insert into point (x) values ('-1');
insert into point (x) values ('0');
insert into point (x) values ('2');

select * from point;


--- shortest distance
select min(dd.l1dist) as shortest
from ( select a.x, b.x, abs(a.x -  b.x) as l1dist  
       from point a join point b
       on a.x != b.x ) dd ;


--------------------
exec pretty_chapter('p 619. Biggest Single Number');
--------------------
/*
Table numbers contains many numbers in column num including duplicated ones.
Can you write a SQL query to find the biggest number, which only appears once.
*/

drop table numbers;
Create table  numbers (num int);

insert into numbers (num) values ('8');
insert into numbers (num) values ('8');
insert into numbers (num) values ('3');
insert into numbers (num) values ('3');
insert into numbers (num) values ('1');
insert into numbers (num) values ('4');
insert into numbers (num) values ('5');
insert into numbers (num) values ('6');

select * from numbers;


--biggest number occuring only once in a table. works
select max(num) as num
from (select num, count(num) as cnt
      from numbers group by num) ng
where ng.cnt = 1;


--------------------
exec pretty_chapter('p 627. Swap Salary');
--------------------
/*
Given a table salary, such as the one below, that has m=male and f=female values.
Swap all f and m values (i.e., change all f values to m and vice versa) with a single update query and no intermediate temp table.
*/

drop table  salary;
create table  salary(id int, name varchar2(16), sex char(1), salary int);
Truncate table salary;
insert into salary (id, name, sex, salary) values ('1', 'A', 'm', '2500');
insert into salary (id, name, sex, salary) values ('2', 'B', 'f', '1500');
insert into salary (id, name, sex, salary) values ('3', 'C', 'm', '5500');
insert into salary (id, name, sex, salary) values ('4', 'D', 'f', '500');

select * from salary;

--query with update works
update salary
    set sex = case when sex = 'f' then
        'm'
    else
        'f'
    end ;

update salary
    set sex = case when sex = 'f' then
        'm'
    when sex = 'm' then
        'f'
    end ;


select * from salary;





--------------------
exec pretty_chapter('p 180. Consecutive Numbers  ');
--------------------
/*
Write a SQL query to find all numbers that appear at least three times consecutively.
*/
drop table  logs;
Create table  Logs (Id int, Num int);
Truncate table Logs;
insert into Logs (Id, Num) values ('1', '1');
insert into Logs (Id, Num) values ('2', '1');
insert into Logs (Id, Num) values ('3', '1');
insert into Logs (Id, Num) values ('4', '2');
insert into Logs (Id, Num) values ('5', '1');
insert into Logs (Id, Num) values ('6', '2');
insert into Logs (Id, Num) values ('7', '2');
insert into Logs (Id, Num) values ('8', '2');
insert into Logs (Id, Num) values ('9', '2');
insert into Logs (Id, Num) values ('10','3');
insert into Logs (Id, Num) values ('11','4');
insert into Logs (Id, Num) values ('12','4');
insert into Logs (Id, Num) values ('13','4');
insert into Logs (Id, Num) values ('14','5');

select * from logs;

/*


select l1.id, l1.num as num1, l2.num as num2, l3.num as num3 
from logs l1 join logs l2 
on l1.id = l2.id+1 
join logs l3 
on l2.id = l3.id+1
where l1.num = l2.num and l2.num = l3.num ;
*/
-- q to select only at least 3 consecutive numbers 
select
    distinct l1.num as ConsecutiveNums
from logs l1 join logs l2
on l1.id = l2.id+1 
join logs l3 
on l2.id = l3.id+1
where l1.num = l2.num and l2.num = l3.num ;


--------------------
exec pretty_chapter('85. Department Top Three Salaries (hard) ');
--------------------
/*
The Employee table holds all employees. Every employee has an Id,
and there is also a column for the department Id.
Write a SQL query to find employees who earn the top three salaries in each of the department.
For the above tables, your SQL query should return the following rows.
*/


drop table  Employee;
drop table  Department;

Create table  Employee (Id int, Name varchar(12), Salary int, DepartmentId int);
Create table  Department (Id int, Name varchar(10));
;
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe',   '70000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Henry', '80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Sam',   '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Max',   '90000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Janet', '69000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('6', 'Randy', '85000', '1');


insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'Sales');


select * from department;
select * from employee;

--the idea is to use unions. 
--this query works if each employee has a unique salary value

select d.name as Department, e.name as Employee,  cq.salary
from (
select max(salary) as salary, departmentid  --top salary
from employee 
group by departmentid
union
select max(salary), departmentid from employee --2nd highest  salary
where salary not in ( select max(salary)
                     from employee group by departmentid)
group by departmentid
union
select max(salary), departmentid from employee --3rd highest salary 
where salary not in ( 
    select max(salary) 
    from employee 
    group by departmentid
    union
    select max(salary) from employee 
    where salary not in ( select max(salary)
                     from employee group by departmentid)
    group by departmentid)
group by departmentid
) cq join department d
on  cq.departmentid = d.id
join employee e 
on e.salary  = cq.salary and e.departmentid = d.id
order by cq.departmentid asc, cq.salary desc;


--- solution with rank and partition  study rank() and partition
With dataset as
(
select 
    rank() over (partition by departmentid order by salary desc) rnk,
    E.Name Employee , D.Name Department, Salary
from Employee E
join Department D on E.Departmentid=D.Id
)
select Department as "Department" ,Employee as "Employee", Salary "Salary" from dataset
where rnk <=3


select * from department;
select * from employee;


with dpt_copy as (select * from department
)
select e.*, d.name  as dpt
from employee e  join dpt_copy d on e.departmentid = d.id;

select rank() as r, e.* from employee e order by e.salary desc;



/************************************************
**************** useful queries *****************
*************************************************/

drop table employee cascade constraints;

create table  Employee(
    Id int not null primary key,
    Name varchar(12),
    Salary int,
    ManagerId int);
    
Truncate table Employee;

insert into Employee (Id, Name, Salary, ManagerId) values ('1', 'Joe', '70000', '2');
insert into Employee (Id, Name, Salary, ManagerId) values ('2', 'Henry', '80000', '3');
insert into Employee (Id, Name, Salary, ManagerId) values ('3', 'Sam', '60000', NULL);

select * from employee;


/******* full cartesian product *****/
--using cross join
select e1.id, e2.id from employee e1 cross join employee e2
order by e1.id, e2.id;

-- explicit on indexes full cartesion product
select  e1.id , e2.id  from employee e1 join employee e2
on e1.id != e2.id OR e1.id = e2.id
order by e1.id;


/******* self inner join *****/
select e1.id, e1.name  from employee e1  join employee e2 
on e1.id = e2.id;

/******* self join on different ids*****/
-- employee manager problem in the same table
select * from employee;

select e1.id, e1.name , e2.name as manager 
from employee e1  left join employee e2 
on e1.managerId = e2.id;



/*
joins, inner, outer with null values
*/

drop table a;
create table a(id int, av varchar2(10));

drop table b;
create table b(id int, bv varchar2(10));

insert into a(id,av) values(1, 'aa');
insert into a(id,av) values(2, 'bb');
insert into a(id,av) values(NULL, 'cc');


insert into b(id,bv) values(1, 'aaa');
insert into b(id,bv) values(2, 'bbbb');
insert into b(id,bv) values(3, 'ccc');


select * from a;
select * from b;

select a.* , b.*
from a  join b 
on a.id = b.id;

select a.*, b.*
from a  inner join b 
on a.id = b.id;

select a.*, b.*
from a  left outer join b 
on a.id = b.id;

select a.*, b.*
from a  right outer join b 
on a.id = b.id;

select a.*, b.*
from a full outer join b 
on a.id = b.id;


--cartesian product
select  a.id, av, b.id, bv
from a cross join b;



--left outer self join on a null key value
select a1.*, a2.*
from a a1 left outer join a a2 
on a1.id = a2.id;


select * from a;
select * from b;

---------------------
--delete duplicates
--------------------
drop table dup;
create table dup(id int, v1 varchar(12), v2 varchar(12));
insert into dup(id, v1, v2) values( 1, 'a', 'b');
insert into dup(id, v1, v2) values( 2, 'd', 'e');
insert into dup(id, v1, v2) values( 3, 'c', 'f');
insert into dup(id, v1, v2) values( 4, 'c', 'g');
insert into dup(id, v1, v2) values( 5, 'c', 'g');

select * from dup;

--working query
delete from dup d1
where  rowid < ( select max(rowid) from dup d2
    where d1.v1 = d2.v1
    and  d1.v2 = d2.v2)
;

select * from dup;
