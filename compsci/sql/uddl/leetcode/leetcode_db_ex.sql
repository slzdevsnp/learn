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
/*
Write a SQL query for a report that provides the following information for each person
in the Person table, regardless if there is an address for each of those people:
*/


drop table Person;
drop table  Address;
/
Create table Person (PersonId int not null primary key,
                    FirstName varchar(20),
                    LastName varchar(20));
Create table Address (AddressId int not null primary key,
                    PersonId int,
                    City varchar(25),
                    State varchar(25));

Truncate table Person;
insert into Person (PersonId, LastName, FirstName) values ('1', 'Wang', 'Allen');

Truncate table Address;
insert into Address (AddressId, PersonId, City, State) values ('1', '2', 'New York City', 'New York');
/

delete from Address where AddressId = 2;

select * from Person;
select * from Address;

--works
select 
    p.FirstName, p.LastName, a.city, a.State
from Person p 
left outer join Address a 
on p.PersonId = a.PersonId;





--------------------
exec pretty_chapter('p 620  ');
--------------------
/*
write a SQL query to output movies with an odd numbered ID and a description
that is not 'boring'. Order the result by rating.
*/

drop table cinema;
Create table  cinema (id int, movie varchar(25), description varchar(20), rating number(2, 1));

insert into cinema (id, movie, description, rating) values ('1', 'War', 'great 3D', '8.9');
insert into cinema (id, movie, description, rating) values ('2', 'Science', 'fiction', '8.5');
insert into cinema (id, movie, description, rating) values ('3', 'Irish', 'boring', '6.2');
insert into cinema (id, movie, description, rating) values ('4', 'Ice song', 'Fantasy', '8.6');
insert into cinema (id, movie, description, rating) values ('5', 'House card', 'Interesting', '9.1');

select * from cinema;

--works

select id,  movie, description, rating 
from cinema 
where MOD(id, 2) != 0 AND description != 'boring'  order by rating desc;

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

Create table  courses (student varchar(10), class varchar(15));

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

-- also works
select class from 
(select class, count(distinct student) as cnt from courses group by class) cg -- count(distinct student) important
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


--########################################################################
--########################################################################

--------------------
exec pretty_chapter('p 570 managers with at least 5 direct reports. m ');
--------------------
/*
Given the Employee table, write a SQL query that finds out managers with at least 5
direct report. For the above table, your SQL query should return:  i.e. only john
*/

Drop table Employee;
Create table Employee (Id int, Name varchar(25), Department varchar(25), ManagerId int);
insert into Employee (Id, Name, Department, ManagerId) values ('101', 'John', 'A', NULL);
insert into Employee (Id, Name, Department, ManagerId) values ('102', 'Dan', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('103', 'James', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('104', 'Amy', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('105', 'Anne', 'A', '101');
insert into Employee (Id, Name, Department, ManagerId) values ('106', 'Ron', 'B', '101');

select * from employee;

--works
select e.name from employee e join 
(select managerId, count(managerId) as cnt from employee group by managerid) eg 
on e.id = eg.managerId  where eg.cnt > 4;


---------------------
exec pretty_chapter('p 608 tree node. m ');
-------------------
/*
Write a query to print the node id and the type of the node. Sort your output by the node
id. The result for the above sample is:
*/

drop table tree;
Create table  tree (id int, p_id int);
insert into tree (id, p_id) values ('1', NULL);
insert into tree (id, p_id) values ('2', '1');
insert into tree (id, p_id) values ('3', '1');
insert into tree (id, p_id) values ('4', '2');
insert into tree (id, p_id) values ('5', '2');

select * from tree;

--works
select id , 
case when p_id is null
        then 'Root'
     when id in (select p_id from tree) and p_id is not null
        then 'Inner'
     else 'Leaf'  
     end as Type
from tree;


---------------------
exec pretty_chapter('p 612 shortest distance in plane. m ');
-------------------
/*
Write a query to find the shortest distance between these points rounded to 2 decimals.
*/

drop table point_2d;
CREATE TABLE point_2d (x INT NOT NULL, y INT NOT NULL);
insert into point_2d (x, y) values ('-1', '-1');
insert into point_2d (x, y) values ('0', '0');
insert into point_2d (x, y) values ('-1', '-2');

select * from point_2d;

-- works
select  
    min(round( sqrt(power(a.x - b.x, 2) + power(a.y - b.y,2)),2 ))  as shortest
from point_2d a join point_2d b
on a.x != b.x or  a.y != b.y;  --  or important in joining


---------------------
exec pretty_chapter('p 626 exchange seats');
-------------------
/*
Mary wants to change seats for the adjacent students.
Can you write a SQL query to output the result for Mary?
*/

drop table seat;
Create table  seat(id int, student varchar(25));
insert into seat (id, student) values ('1', 'Abbot');
insert into seat (id, student) values ('2', 'Doris');
insert into seat (id, student) values ('3', 'Emerson');
insert into seat (id, student) values ('4', 'Green');
insert into seat (id, student) values ('5', 'Jeames');


select * from seat, (select count(*) as cnt from seat) cs ;


--works
select  
    case
        when mod(id,2) = 1 and id != cs.cnt then id+1
        when mod(id,2) = 1 and id = cs.cnt then id
        else id -1
    end as id,
    student
from seat,
    (select count(*) as cnt from seat) cs
order by id ;


--------------------
exec pretty_chapter('p 178 Rank scores  ');
--------------------
/*
Write a SQL query to rank scores. If there is a tie between two scores,
both should have the same ranking. Note that after a tie, the next ranking
number should be the next consecutive integer value. In other words, there
should be no "holes" between ranks.
*/
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

--using analytic func much more natural
select 
    score,
    dense_rank() over ( order by score desc )  rnk
from scores
order by score desc;


--------------------
exec pretty_chapter('p 585 investements in 2016  ');
--------------------
/*
query for:
Have the same TIV_2015 value as one or more other policyholders.
Are not located in the same city as any other policyholder
(i.e.: the (latitude, longitude) attribute pairs must be unique).
*/

drop table  insurance;
CREATE TABLE insurance (PID INT, TIV_2015 NUMBER(15,2), TIV_2016 NUMBER(15,2), LAT NUMBER(5,2), LON NUMBER(5,2) );
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('1', '10', '5', '10', '10');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('2', '20', '20', '20', '20');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('3', '10', '30', '20', '20');
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('4', '10', '40', '40', '40');

select * from insurance;

--works
select sum(TIV_2016) as TIV_2016 
from insurance
where pid in
( select pid from insurance i join
 (select TIV_2015, count(TIV_2015) as cnt from insurance group by TIV_2015) ig   --cond to check count of TIV2015 > 1
 on i.TIV_2015 = ig.TIV_2015     
 join (select LAT+LON as ll, count(LAT+LON) as cnt from insurance group by (LAT+LON) ) cl -- cond to check uniqueness of LAT,LON
 on i.LAT+i.LON = cl.ll
where ig.cnt > 1 and cl.cnt = 1 ) ;


--------------------
exec pretty_chapter('p 602 who has most friends ');
--------------------
/*
Write a query to find the the people who has most friends and the most friends number.
For the sample data above, the result is: id = 3
*/

drop table request_accepted;
Create table request_accepted ( requester_id INT NOT NULL, accepter_id INT NULL, accept_date DATE NULL);
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '2', to_date('2016/06/03', 'YYYY/MM/DD'));
insert into request_accepted (requester_id, accepter_id, accept_date) values ('1', '3', to_date('2016/06/08', 'YYYY/MM/DD'));
insert into request_accepted (requester_id, accepter_id, accept_date) values ('2', '3', to_date('2016/06/08', 'YYYY/MM/DD'));
insert into request_accepted (requester_id, accepter_id, accept_date) values ('3', '4', to_date('2016/06/09', 'YYYY/MM/DD'));


select * from request_accepted;


--works
with prep as 
(
select id, sum(cnt) as num from
    (select accepter_id as id, count(accepter_id) as cnt from request_accepted group by accepter_id
      union all
    (select requester_id as id, count(requester_id) as cnt from request_accepted group by requester_id)) comb
group by id
)
select id, num from prep
where num = (select max(num) from prep) ;


--------------------
exec pretty_chapter('p 580 count student number in departments ');
--------------------
/*
Write a query to print the respective department name and number of students majoring in each department
for all departmentsin the department table (even ones with no current students).
Sort your results by descending number of students; if two or more departments have
the same number of students, then sort those departments alphabetically by department name.
*/

drop table student;
CREATE TABLE student (student_id INT,student_name VARCHAR(15), gender VARCHAR(6), dept_id INT);

drop table department;
CREATE TABLE  department (dept_id INT, dept_name VARCHAR(15));

insert into student (student_id, student_name, gender, dept_id) values ('1', 'Jack', 'M', '1');
insert into student (student_id, student_name, gender, dept_id) values ('2', 'Jane', 'F', '1');
insert into student (student_id, student_name, gender, dept_id) values ('3', 'Mark', 'M', '2');

insert into department (dept_id, dept_name) values ('1', 'Engineering');
insert into department (dept_id, dept_name) values ('2', 'Science');
insert into department (dept_id, dept_name) values ('3', 'Law');


select * from student;
select * from department;

--q works 
select dept_name, count(student_id) as student_number
from (select d.dept_id, d.dept_name , s.student_id
       from department d left join student s
       on d.dept_id = s.dept_id ) sd
group by dept_name  order by count(student_id) desc,  dept_name desc;


-- solution query
SELECT
    dept_name, COUNT(student_id) AS student_number
FROM
    department
        LEFT OUTER JOIN
    student ON department.dept_id = student.dept_id
GROUP BY department.dept_name
ORDER BY student_number DESC , department.dept_name
;


--------------------
exec pretty_chapter('p 574. Winning Candidate');
--------------------
/*
Write a sql to find the name of the winning candidate, the above example will return the winner B.
*/
drop table Candidate;
Drop table Vote;
Create table Candidate (id int, Name varchar(15));
Create table  Vote (id int, CandidateId int);
insert into Candidate (id, Name) values ('1', 'A');
insert into Candidate (id, Name) values ('2', 'B');
insert into Candidate (id, Name) values ('3', 'C');
insert into Candidate (id, Name) values ('4', 'D');
insert into Candidate (id, Name) values ('5', 'E');
insert into Vote (id, CandidateId) values ('1', '2');
insert into Vote (id, CandidateId) values ('2', '4');
insert into Vote (id, CandidateId) values ('3', '3');
insert into Vote (id, CandidateId) values ('4', '2');
insert into Vote (id, CandidateId) values ('5', '5');

--works
select Name 
from Candidate join 
     (select Candidateid, count(CandidateId) as cnt from Vote group by Candidateid) cg
on candidate.id = cg.candidateId
where cg.cnt = (select max(cnt) from (select Candidateid, count(CandidateId) as cnt
                                      from Vote group by Candidateid) cg1)  ;


-- using with tlbname as 
with cg as 
(select Candidateid, count(CandidateId) as cnt
from Vote group by Candidateid)
select Name 
from Candidate c join cg
on  c.id  = cg.candidateId
where cg.cnt = (select max(cnt) from cg )
;

--------------------
exec pretty_chapter('p 578. Get Highest Answer Rate Question');
--------------------
/*
Write a sql query to identify the question which has the highest answer rate. (285) for this input)
*/

drop table survey_log;
Create table survey_log (id int, action varchar(10), question_id int, answer_id int, q_num int, timestamp int);
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'show', '285', NULL, '1', '123');
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'answer', '285', '124124', '1', '124');
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'show', '369', NULL, '2', '125');
insert into survey_log (id, action, question_id, answer_id, q_num, timestamp) values ('5', 'skip', '369', NULL, '2', '126');

select * from survey_log;

select * from survey_log where rownum < 2 order by answer_id;

-- query that works
with rtio as
(
select u.question_id, u.numer, d.denom , u.numer / d.denom as ratio  from
(select question_id, count(answer_id) as numer  from survey_log  group by question_id) u  join 
(select question_id, count(question_id) as denom  from survey_log where action='show' group by question_id ) d 
on u.question_id = d.question_id
)
select  question_id as survey_log from  rtio
where ratio = (select max(ratio) from rtio)
;

--also works by sorting and using rownum (more efficient
with rtio as
(
select u.question_id, u.numer, d.denom , u.numer / d.denom as ratio  from
(select question_id, count(answer_id) as numer  from survey_log  group by question_id) u  join 
(select question_id, count(question_id) as denom  from survey_log where action='show' group by question_id ) d 
on u.question_id = d.question_id
)
select survey_log from 
(select  question_id as survey_log from  rtio  order by ratio desc) wr
where rownum < 2 
;

---from leetcode solution, check elegant use of sum() with a group 
SELECT question_id as survey_log
FROM
(
    SELECT question_id,
        SUM(case when action='answer' THEN 1 ELSE 0 END) as num_answer,
        SUM(case when action='show' THEN 1 ELSE 0 END) as num_show    
    FROM survey_log
    GROUP BY question_id
) tbl
ORDER BY (num_answer / num_show) DESC
fetch next 1 rows only
;

--------------------
exec pretty_chapter('p 184. Department Highest Salary');
--------------------

drop table Employee;
drop table Department;
Create table  Employee (Id int, Name varchar(15), Salary int, DepartmentId int);
Create table  Department (Id int, Name varchar(15));
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '70000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Henry', '80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Sam', '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Max', '90000', '1');
insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'Sales');


select * from department;
select * from employee order by departmentid;


--my query works 
select d.name as Department, e.Name as Employee, ms.Salary 
from department d join
(select departmentid, max(salary) as salary from employee group by departmentid) ms
 on d.id = ms.departmentid
join Employee e 
on  ms.Salary = e.Salary ;


-- from leetcode solution  see usage of ( departmentid, salary) in ( select department_id, max(salary) .. )
SELECT
    Department.name AS Department,
    Employee.name AS Employee,
    Salary
FROM
    Employee
        JOIN
    Department ON Employee.DepartmentId = Department.Id
WHERE
    (Employee.DepartmentId , Salary) IN
    (   SELECT
            DepartmentId, MAX(Salary)
        FROM
            Employee
        GROUP BY DepartmentId
    )
;


--------------------
exec pretty_chapter('p 177. Nth Highest Salary');
--------------------
/*
Write a SQL query to get the nth highest salary from the Employee table.
*/
drop table employee;
create table employee(id int, salary int);
insert into employee(id,salary) values ('1','100');
insert into employee(id,salary) values ('2','200');
insert into employee(id,salary) values ('3','300');

--working
with  rn as
(
select  salary,
    dense_rank() over( order by salary desc) as rnk
from employee
) 
select salary from rn where rnk  = 2;



CREATE OR REPLACE FUNCTION getNthHighestSalary(N IN NUMBER)
RETURN NUMBER IS
result NUMBER;
BEGIN

with  rn as
(
select  salary,
    dense_rank() over( order by salary desc) as rnk
from employee
) 
select salary into result from rn where rnk  = n;
return result;
END;
/

DECLARE
    nth_sal number; 
BEGIN 
   nth_sal := getNthHighestSalary(2); 
   dbms_output.put_line('nth salary ' || nth_sal); 
END; 
/


--------------------
exec pretty_chapter('p 614, Second Degree Follower ');
--------------------
/*
In facebook, there is a follow table with two columns: followee, follower.
Please write a sql query to get the amount of each follower’s follower if he/she has one.
*/

drop table follow;
Create  table follow (followee varchar(10), follower varchar(10));
insert into follow (followee, follower) values ('A', 'B');
insert into follow (followee, follower) values ('B', 'C');
insert into follow (followee, follower) values ('B', 'D');
insert into follow (followee, follower) values ('D', 'E');

--select * from follow;

-- q works
select distinct f.follower, fg.num 
from follow f 
 join (select followee as follower, count(followee) as num
       from follow group by followee) fg
on f.follower = fg.follower 
order by f.follower asc ;


--------------------
exec pretty_chapter('185. Department Top Three Salaries  H ');
--------------------
/*
The Employee table holds all employees. Every employee has an Id,
and there is also a column for the department Id.
Write a SQL query to find employees who earn the top three salaries in each of the department.
For the above tables, your SQL query should return the following rows.
*/


drop table Employee;
drop table Department;
Create table Employee (Id int, Name varchar(10), Salary int, DepartmentId int);
Create table  Department (Id int, Name varchar(10));
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '70000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Henry','80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Sam', '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentIfd) values ('4', 'Max', '90000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Janet', '69000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('6', 'Randy', '85000', '1');   

insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'Sales');


select * from employee;

-- q works
select  d.name as Department, e.name as Employee, e.Salary
from employee e inner join  department d
on e.departmentid = d.id
inner join (select id,
            dense_rank() over( partition by departmentid
                               order by salary desc) as rnk
           from employee) er  on
er.id = e.id
where er.rnk < 4
order by d.name asc, e.Salary desc;

--------------------
exec pretty_chapter('601. Human Traffic of Stadium  H ');
--------------------
/*
X city built a new stadium, each day many people visit it
and the stats are saved as these columns: id, date, people
Please write a query to display the records which have 3 or
more consecutive rows and the amount of people more than 100(inclusive).
*/

drop table stadium;
Create table  stadium (id int, rdate DATE NULL, people int);
insert into stadium (id, rdate, people) values ('1', to_date('2017-01-01', 'YYYY-MM-DD') , '10');
insert into stadium (id, rdate, people) values ('2', to_date('2017-01-02','YYYY-MM-DD') , '109');
insert into stadium (id, rdate, people) values ('3', to_date('2017-01-03','YYYY-MM-DD') , '150');
insert into stadium (id, rdate, people) values ('4', to_date('2017-01-04','YYYY-MM-DD') , '99');
insert into stadium (id, rdate, people) values ('5', to_date('2017-01-05','YYYY-MM-DD') , '145');
insert into stadium (id, rdate, people) values ('6', to_date('2017-01-06','YYYY-MM-DD') , '1455');
insert into stadium (id, rdate, people) values ('7', to_date('2017-01-07','YYYY-MM-DD') , '199');
insert into stadium (id, rdate, people) values ('8', to_date('2017-01-08','YYYY-MM-DD') , '188');
insert into stadium (id, rdate, people) values ('9', to_date('2017-01-09','YYYY-MM-DD') , '101');
insert into stadium (id, rdate, people) values ('10', to_date('2017-01-10','YYYY-MM-DD') , '99');

select * from stadium;


-- analytic solution does not work correctly
with c as
(select id,
rdate,
people,
nvl(lead(people,1) over(order by rdate), lag(people,1) over(order by rdate)) lead1,
nvl(lead(people, 2) over(order by rdate),lag(people,2) over(order by rdate)) lead2
from stadium
)
select id,
rdate,
people,
lead1,
lead2
from c
where people >= 100
and lead1 >= 100
and lead2 >= 100;


--- solution  published 
select distinct t1.*
from stadium t1, stadium t2, stadium t3
where t1.people >= 100 and t2.people >= 100 and t3.people >= 100
and
-- 3 permutations
(
    (t1.id - t2.id = 1 and t1.id - t3.id = 2 and t2.id - t3.id =1)  -- t1, t2, t3
    or
    (t2.id - t1.id = 1 and t2.id - t3.id = 2 and t1.id - t3.id =1) -- t2, t1, t3
    or
    (t3.id - t2.id = 1 and t2.id - t1.id =1 and t3.id - t1.id = 2) -- t3, t2, t1
)
order by t1.id
;



