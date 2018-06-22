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
select salary from rn where rnk  = 3;



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


DECLARE
    nth_sal number; 
BEGIN 
   nth_sal := getNthHighestSalary(2); 
   dbms_output.put_line('nth salary ' || nth_sal); 
END; 
/

