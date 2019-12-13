
--1

drop table if exists emp;
create table emp(id serial, name text,salary int);

insert into emp(name, salary) values
('sam', 90000),
('john', 100000);

select * from emp;

drop function if exists clean_emp;
create function clean_emp()
return void AS