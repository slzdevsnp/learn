-- run under learn  user 
/*
leetcode p.175  Combine Two Tables
*/

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
    Name varchar(255),
    Salary int,
    ManagerId int);
    
Truncate table Employee;

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


select distinct Score from Scores order by Score desc;

SELECT
  Score,
  (SELECT count( distinct score) FROM Scores WHERE Score >= s.Score) Rank
FROM Scores s
ORDER BY s.Score desc;

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
select email, count(*) as occur 
from Person group by email )  pp
where pp.occur > 1;

