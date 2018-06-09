-- run under  user learn 
/*
urls
1.
https://blogs.oracle.com/oraclemagazine/having-sums,-averages,-and-other-grouped-data
2.
https://blogs.oracle.com/oraclemagazine/a-window-into-the-world-of-analytic-functions
3.
https://blogs.oracle.com/oraclemagazine/leading-ranks-and-lagging-percentages%3a-analytic-functions%2c-continued
4.
https://blogs.oracle.com/oraclemagazine/pivotal-access-to-your-data%3a-analytic-functions%2c-concluded

SUM, AVG, RANK(), DENSE_RANK(), 
FIRST_VALUE(col), LAST_VALUE(col), LAG(col), LEAD(col)
RATIO_TO_REPORT,
LISTAGG(col) WITHIN GROUP ...
PIVOT
*/

--initial ddl 

drop table employee cascade constraints;
drop table department  cascade constraints;

drop sequence employee_seq;
drop sequence department_seq;

CREATE TABLE employee (
employee_id   NUMBER,
first_name    VARCHAR2(16),
last_name     VARCHAR2(16),
hire_date     DATE,
salary        NUMBER(9,2),
manager       NUMBER,
department_id NUMBER
);

CREATE TABLE department (
department_id NUMBER,
name          VARCHAR2(16),
location      VARCHAR2(16)
);

CREATE SEQUENCE employee_seq; 

CREATE SEQUENCE department_seq;


INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (28, 'Emily', 'Eckhardt', to_date('07-JUL-2004', 'DD-MON-YYYY'), 100000, NULL, 10);
INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (37, 'Frances', 'Newton', to_date('14-SEP-2005', 'DD-MON-YYYY'), 75000, NULL, NULL);
INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (1234, 'Donald', 'Newton', to_date('24-SEP-2006', 'DD-MON-YYYY'), 80000, 28, 10);
INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (7895, 'Matthew', 'Michaels', to_date('16-MAY-2007', 'DD-MON-YYYY'), 70000, 28, 10);
INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (6567, 'Roger', 'Friedli', to_date('16-MAY-2007', 'DD-MON-YYYY'), 60000, 28, 10);
INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (6568, 'Betsy', 'James', to_date('16-MAY-2007', 'DD-MON-YYYY'), 60000, 28, 10);
INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (6569, 'michael', 'peterson', to_date('03-NOV-2008', 'DD-MON-YYYY'), 90000, NULL, 20);
INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (6570, 'mark', 'leblanc', to_date('06-MAR-2009', 'DD-MON-YYYY'), 65000, 6569, 20);
INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (6571, 'Thomas', 'Jeffrey', to_date('27-FEB-2010', 'DD-MON-YYYY'), 300000, null, 30);
INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (6572, 'Theresa', 'Wong', to_date('27-FEB-2010 9:02:45', 'DD-MON-YYYY HH24:MI:SS'), 70000, 6571, 30);
INSERT INTO employee (employee_id, first_name, last_name, hire_date, salary, manager, department_id) VALUES (6573, 'Lori', 'Dovichi', to_date('07-JUL-2011 8:31:57', 'DD-MON-YYYY HH24:MI:SS'), null, 28, 10);


INSERT INTO department (department_id, name, location) VALUES (10, 'Accounting', 'LOS ANGELES');
INSERT INTO department (department_id, name, location) VALUES (20, 'Payroll', 'NEW YORK');
INSERT INTO department (department_id, name, location) VALUES (30, 'IT', 'WASHINGTON DC');
commit;

set serveroutput on;
set feedback on;
set lines 32000;


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

select * from employee;
select * from department;

exec PRETTY_CHAPTER('part 9 Having Sums, Averages, and Other Grouped Data');

select * from employee;

-- sum and avg
select sum(salary) from employee;
select avg(salary) from employee;  --avg does not apply to null values
select avg(salary) from employee where salary is not null;
select avg(nvl(salary,0)) avg_salary from employee;  --replace a null col with 0 expect lower result

--count
select count(manager) from employee; -- count on a colun also dows not count nuls 
select count(*) from employee; --count(*) does not iengore null values

--count distinct
select count(distinct manager) from employee;

--count grouped by department id 
select department_id, count(employee_id) cnt
from employee
group by department_id
order by department_id;

-- cannot put non_aggregated column absent  in group by statement
-- but can put aggregated column 
select 
    department_id, count(employee_id) cnt
--    ,hire_date --will fail
     ,max(hire_date)  -- will work
from employee
group by department_id
order by department_id;


select * from employee order by department_id, hire_date ;

--group by  with having 
select count(employee_id) , department_id
from employee 
group by department_id
having count(employee_id) > 1;  --having normally used with aggregate functions

select count(employee_id) , department_id
from employee
where department_id in (10,20) -- where clause is used for filtering of buckets
group by department_id
 
--having can combine operators
select count(employee_id) , department_id, salary
from employee 
group by department_id, salary
having  count(employee_id) > 1 OR salary < 100000 
order by department_id, salary desc;

--queries with group by can include literals in select
select
    count(employee_id),department_id, salary,
    sysdate, 'string literal', 42*37 expression
from employee 
group by department_id, salary
having  count(employee_id) > 1 OR salary < 100000 
order by department_id, salary desc;


--nested aggregated funcs

select min(sum(salary)) min_dept_salary, max(sum(salary))  max_dept_salary
from employee
where department_id is not null
group by department_id;
-- to check summed salary by department
select sum(salary), department_id
from employee where department_id is not null 
group by department_id;



select employee_id, department_id, salary from employee;

exec PRETTY_CHAPTER('par 10 A window into the world of analytic functions');
-------------

--obtain a cumulative salary for all employees
select last_name, first_name, salary,
sum(salary) over (order by last_name, first_name) cumul_salary
from employee 
order by last_name, first_name;


--obrain a cumulative salary by department
select last_name, first_name, department_id,
      salary, sum(salary) 
over (partition by department_id
        order by last_name, first_name) dept_total
from employee 
order by department_id, last_name, first_name;

-- sort by salary insided partitioned buckets (within department ids)
-- check the wrong  dept_total for Friendli Roger  and James Betsy
select last_name, first_name, department_id, salary,
sum(salary) 
over (partition by department_id
        order by salary) dept_total
from employee 
order by department_id, last_name, first_name;

-- applying analytic function on a sliding window
--adding a window  ROWS 2 PRECEEDINg means apply sum(salary) 
-- on a window of the row + preceeding 2 rows 
select last_name, first_name, department_id,
      salary, sum(salary) 
over (partition by department_id       --partition clause
        order by last_name, first_name --order by clause
        ROWS 2 PRECEDING) dept_total   -- windowing clause
from employee 
order by department_id, last_name, first_name;


-- RANGE 90 PRECEDING means 
/*
Provide a summary of the current row’s salary value together with the salary
values of all previous rows whose HIRE_DATE value falls within 90 days 

this is reflected on 3 rows of dept_id = 10  with the same hire date 16-may-07
*/
select last_name, first_name, department_id, hire_date,salary,
    sum(salary) 
over (partition by department_id       --partition clause
        order by hire_date --order by clause
        RANGE 90 PRECEDING) dept_total   -- windowing clause
from employee 
order by department_id, hire_date;


-- IF RANGE is specified than order by can contain only numeric data types number, date
select last_name, first_name, department_id, hire_date,salary,
    sum(salary) 
over (partition by department_id       --partition clause
        order by last_name -- 
        RANGE 90 PRECEDING) dept_total   -- windowing clause
from employee 
order by department_id, hire_date;



select last_name, first_name, department_id,
      salary,
      sum(salary) 
over (partition by department_id
        order by last_name, first_name
        ROWS UNBOUNDED PRECEDING  --use all rows in a partioned bucket
     ) dept_total
from employee 
order by department_id, last_name, first_name;



select last_name, first_name, department_id,
      salary, sum(salary) 
over (partition by department_id
        order by last_name, first_name
        ROWS current row  --use only current row in a partioned bucket
     ) dept_total
from employee 
order by department_id, last_name, first_name;

-- expression for a  a range cumulate over a hire date 1 year before , 1 year after
select last_name, first_name, department_id, hire_date,salary,
    sum(salary) 
over (partition by department_id       --partition clause
        order by hire_date --order by clause
        RANGE BETWEEN 365 PRECEDING and 365 FOLLOWING) dept_total   -- windowing clause
from employee 
order by department_id, hire_date;

---------------
exec PRETTY_CHAPTER('part 11 Leading Ranks and Lagging Percentages');
-------------

--rank
--list employees ranked by department and by salary with salary decreasing
select department_id, last_name, first_name, salary,
    DENSE_RANK() OVER (partition by department_id
                        order by salary desc) d_ranking
from employee
--where salary is not null -- elimininate salary nulls (makes sense)
order by department_id, salary desc, last_name, first_name;


--same rank with null last extensions to put null salary at the end of ranking
select department_id, last_name, first_name, salary,
    DENSE_RANK() OVER (partition by department_id order
                        by salary desc NULLS LAST) d_ranking
from employee
order by department_id, salary desc, last_name, first_name;

--rank() instead of dense_rank()
-- if same value the same rank is assigned but next value will have a rank gap
-- see skipping  from rank 4 to 6 int dept_id = 10
select department_id, last_name, first_name, salary,
    RANK() OVER (partition by department_id 
                order by salary desc NULLS LAST) d_ranking
from employee
order by department_id, salary desc, last_name, first_name;

--first_value(), last_value()
select department_id, last_name, first_name, salary, hire_date,
    FIRST_VALUE(salary) OVER (partition by department_id 
                            order by hire_date ) fst_sal, --last value on a window before smallest hire_date 
    LAST_VALUE(salary) OVER (partition by department_id   -- and current row hire _date 
                            order by hire_date
                            ) lst_sal -- default value for window here ROWS UNBOUNDED PRECEDING
from employee
where salary is not null
order by department_id, hire_date, last_name, first_name;

--last_value constant by bin
select department_id, last_name, first_name, salary, hire_date,
    LAST_VALUE(last_name) OVER (partition by department_id   -- and current row hire _date 
                                order by hire_date
                                ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) lst_emp,
                             
    LAST_VALUE(salary) OVER (partition by department_id   -- and current row hire _date 
                            order by hire_date
                            ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) lst_sal
from employee
where salary is not null
order by department_id, hire_date, last_name, first_name;

---LAG !! function
select last_name, first_name, department_id, hire_date,
    LAG(hire_date ) OVER (partition by department_id 
                        order by hire_date ) prev_hire
from employee
order by department_id, hire_date, last_name, first_name;

---LAG and LEAD
select last_name, first_name, department_id, hire_date,
    LAG(hire_date,1,null ) OVER (partition by department_id 
                        order by hire_date ) prev_hire,
    LEAD(hire_date,1,null ) OVER (partition by department_id 
                        order by hire_date ) nxt_hire
from employee
order by department_id, hire_date, last_name, first_name;


--ratio to report
-- show a percentage of each salary related to a a total salary of all employees
select last_name, first_name, department_id, hire_date, salary,
    round(RATIO_to_REPORT(salary) over ()*100,2) sal_pct --over() :partion is full list of salaries
from employee
--where department_id is not null  -- if this condition is enabled, pct numbers different
order by department_id, salary desc, last_name, first_name;

--this is the same result wihout use of analytic function, but at cost of n subqueries
select last_name, first_name, department_id, hire_date, salary,
     round(salary / (select sum(salary) from employee) * 100, 2) sal_pctt
from employee
order by department_id, salary desc, last_name, first_name;
     
--salary percentages within each department
select last_name, first_name, department_id, hire_date, salary,
    round(RATIO_to_REPORT(salary) OVER (partition by department_id)*100,2) sal_dpt_pct
from employee
order by department_id, salary desc, last_name, first_name;


--///////////////////////
exec PRETTY_CHAPTER('part 12 Pivotal Access to Your Data: Analytic Functions, Concluded');
-------------
select department_id, last_name, first_name
from employee 
order by department_id, last_name, first_name;

--lets concatenate folk names  by departmen id

--LISTAGG  since ora11g
select department_id,
    LISTAGG( first_name||' '||last_name ||', ') WITHIN GROUP (order by last_name) dpt_employees
from employee 
group by department_id 
order by department_id;

--invoke listagg as analytic function
select department_id, salary, last_name||' '||first_name earned_by,
    LISTAGG( first_name||' '||last_name ||', ')
    WITHIN GROUP (order by salary desc nulls last, last_name, first_name)
    OVER (partition by department_id) dpt_emps
from employee
order by department_id, salary desc nulls last, last_name;

--PIVOT clause 
select * 
from  
    (select department_id, salary 
     from employee) total_dpt_sals
PIVOT (SUM(salary)
    FOR department_id in (10 as Accounting, 20 as Payroll, NULL as Unassigned_dpt));

--display sum of total salaries pert dep in a particular year 
select * 
    from (select department_id,
             to_char(trunc(hire_date, 'YYYY'),'YYYY') hire_date,
             salary
             from employee )
                 
    PIVOT (SUM(salary)
        FOR (department_id, hire_date)  IN
        ( (10, '2007') as act_2007,
          (20, '2008') as payroll_2008,
          (30, '2010') as IT_2010
        )
   );
   
--pivot and display multiple aggregate columns 
select * 
from (select department_id, hire_date, salary
              from employee)
       PIVOT (SUM(salary) AS sals,
              MAX(hire_date) AS latest_hire
       FOR department_id IN (10 as act, 20 as payrl, 30 as IT, NULL as mystery));
 

--unpivot
--first create a pivot table,  then unpivot it
with pivoted_emp_data AS
(
select *
      from (select department_id, hire_date, salary
              from employee)
      PIVOT (SUM(salary) sum_sals,
             MAX(hire_date) latest_hire
      FOR department_id IN (10 AS Acc, 20 AS Pay, 30 AS IT, NULL))
)
select hire_date, salary
      from pivoted_emp_data
         UNPIVOT INCLUDE NULLS
          ((hire_date, salary)
             FOR department_id IN (
             (acc_latest_hire, acc_sum_sals) AS 'Accounting',
             (pay_latest_hire, pay_sum_sals) AS 'Payroll',
             (it_latest_hire, it_sum_sals) AS 'IT',
             (null_latest_hire, null_sum_sals) AS 'Unassigned'
        ))
order by hire_date, salary;

--using  analytics function as a predicate (in wher clause)
--top 2 salaries per department
select * 
from (
    select department_id, last_name, first_name, salary,
        DENSE_RANK() OVER (partition by department_id
                        order by salary desc nulls last) d_ranking
    from employee
    order by department_id, salary desc, last_name, first_name) sr 
   where sr.d_ranking < 3;
   
 

--cpu intensive query --check sortering on concatenated string (avoid)
select first_name||' '||last_name, department_id, hire_date,
     sum(salary) over (order by department_id, 
      first_name||' '||last_name) sum_dept_emp,
      avg(salary) over (order by hire_date, department_id) avg_dept_hire_dt
      from employee
     order by department_id, hire_date, first_name||' '||last_name;
   