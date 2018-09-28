
stanford databases

xml
    dtd (documeent type descriptor)
    xsd (xml schema) more powerful
    xml parser consumes an xml document + dtd or xsd


sqlite  db  
>brew install sqlite
>brew list sqlite

>sqlite3 -init  schema_ddl.sql ~/Documents/dbsqlite/schema.db
>sqlite3 ~/Documents/dbsqlite/schema.db
sqlite>.databases
sqlite>.tables
sqlite>select * from tablename;
sqlite>.exit

 https://lagunita.stanford.edu/c4x/DB/SQL/asset/CollegeData.sql


Relational ALGEBRA
python interpreter
https://users.cs.duke.edu/~junyang/radb/start.html

pip3 install radb
/usr/local/bin/pip3 show radb
radb -i beers.ra beers.db
radb -i pizza.ra pizza.db

radb beers.db
radb pizza.db

ra>\list;  /* list db tables and user defined views */
ra>\quit; 
ra>\clear! v; /* clear definition for view v and all views that depend on v */
ra>\source 'ra_file';  /* execute ra statements from ra_file
ra>\sqlexec_{sql statement} ;  /* execute a single sql statement in the undelying database */

operators
Selection
\select_{condition} relation ;  eg: \select_{name='Amy' or name='Ben'} Drinker;

projection
\project{attr_list} relation; 
\project_{name} Bar;
\project_{bar, 'Special Edition '||beer, price+1} Serves;  /* concatenates special edition to attribute beer, returns a price+1 value */

Theta-join
Drinker \join_{name=drinker} Frequents; 
or
Drinker \join_{Drinker.name=Frequents.drinker} Frequents;

Natural join (join on the columns with the same name)
Drinker \join \rename_{name, bar, times_a_week} Frequents;
(Frequents.drinker is renamed to Frequents.name  which matches Drinker.name)


Cross product (multiply rows from relation1 by rows of relation2)
Drinker \cross Frequents;


##Operations on sets
input_relation_1 \union input_relation_2

input_relation_1 \diff input_relation_2

input_relation_1 \intersect input_relation_2

Drinker \union Drinker ;  // the same Drinker set
Drinker \diff Drinker ; //empty set
Drinker \intersect Drinker; // the same Drinker set

/*#######################################################
DB5 SQL course
#######################################################*/
-- using sqlite3
sqlite3 ~/Documents/dbsqlite/college.db

#############################################
####vid 1. basic select statement
#############################################

/* basic select */
select sID, sName, GPA
from Student
where GPA > 3.6 ;

/* basic join  + remove duplicates*/
select distinct sName, major
from Student, Apply
where Student.sID = Apply.sID ;


/* basic join  + bigger filter*/
select sName, GPA, decision
from Student, Apply
where Student.sID = Apply.sID 
and sizeHS < 1000 and major = 'CS' and cname = 'Stanford' ;

/* join with specified selected column*/
select distinct College.cName
from College, Apply
where College.cName= Apply.cName 
and College.enrollment > 20000 and Apply.major = 'CS';


/* 3-way join* + order by */
select Student.sID,  sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where  Apply.sID = Student.sID and  Apply.cName  = College.cName
order by GPA desc, enrollment;

/* like operator*/
select *
from Apply 
where major like '%bio%' ;

/* cross product*/
select *
from Student, College ;

/* arithmetic on columns*/
select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0) as scaled_GPA
from Student;

#############################################
####vid 2. Table variables and set operators
#############################################

/* query with table variables */
select s.sID,  s.sName, s.GPA, a.cName, c.enrollment
from Student s, College c, Apply a
where  a.sID = S.sID and  a.cName  = c.cName


/*  find pairs of student with same gpa  */
select  s1.sID, s1.sName, s1.GPA,
s2.sID, s2.sName, s2.GPA
from Student s1, Student s2 
where s1.GPA = s2.GPA
and s1.sID < s2.sID
order by s1.GPA desc ;

/*union operator */
select cName from Colledge
union
select cName from Student;

/* if you need to keep duplicates */
 select cName as name from College union all select sName as name from Student order by name;

/* intersect operator  */
select sID from Apply where major = 'CS' intersect select sID from Apply where major = 'EE' ;

/* some dbs do not have intersect operator, so here how to do it */
select distinct a1.sID  from Apply a1, Apply a2 where a1.sID = a2.sID and a1.major='CS' and a2.major = 'EE' ;

/* except (difference) operator */
/* find all who applied to CS but did not apply to EE */
select sID from Apply where major = 'CS' except select sID from Apply where major = 'EE' ;

#############################################
####vid 3. subqueries in WHERE clause
#############################################

/* basic subquery */
select sID, sName from Student where sID in (select sID from Apply where major = 'CS');

/* it is equivalent to */
select distinct s.sID, s.sName from Student s, Apply a where s.sID  = a.sID and a.major = 'CS';

select sName from Student where sID in (select sID from Apply where major = 'CS');

/* duplicates may be very important */
select s.GPA from Student s where s.SID in (select a.SID from Apply a where a.major = 'CS');  -- correct

select s.GPA  from Student s, Apply a where s.sID = a.sID and a.major='CS'; --duplicates 

select distinct s.GPA  from Student s, Apply a where s.sID = a.sID and a.major='CS'; --removes 2 distinct students with the same GPA, so average gap will be wrong

/* query  for difference operator  */
select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS')
and sID  not in (select sID from Apply where major = 'EE');

/*  external reference c1 in c2, find different colleges from the same state  */
select cName, state  from College c1  where exists (select * from College c2 where c2.state = c1.state and c1.cName != c2.cName) ;

/* find college which enrolement is higher than of other colleges, finding max enrollment */
select cName, state  from College c1  where not exists (select * from College c2 where c2.enrollment > c1.enrollment ) ;

/* find a student with highest GPA */
select sName, GPA  from Student s1  where not exists (select * from Student s2 where s2.GPA > s1.GPA ) ;
/* cannot make a query with joins to find a max of gpa ! */
select s1.sName, s1.GPA  from Student s1, Student s2  where s1.GPA > s2.GPA;

/* all operator sqlite seems not to have it,  t-sql has it */
select sName, GPA from Student s1 where GPA >= all (select GPA from Student);


select cName  from College c1 where not enrollment <= any (select enrollment from College c2 where c2.cName <> c1.cName) ;

/* any operator is a companion of all  */
select cName  from College c1 where not enrollment <= any (select enrollment from College c2 where c2.cName <> c1.cName) ;

select sID, sName, sizeHS from Student where sizeHS > any (select sizeHS from Student);

/* equivalent  query */
select sID, sName, sizeHS from Student where sizeHS >  (select min(sizeHS) from Student);

/* equivalent query using exists  -- find students from all schools with school size  bigger than minimum */
select sID, sName, sizeHS from Student s1 where exists (select * from Student s2 where s2.sizeHS < s1.sizeHS);

/* find students from 1 schoold with a mininum sizeHS */
select sID, sName, sizeHS from Student s1 where not exists (select * from Student s2 where s2.sizeHS < s1.sizeHS);


#############################################
####vid 4. subqueries in FROM and SELECT 
#############################################
/* operations on attributes can be present in select, where clauses */ 
select sID, sName, GPA, GPA*(sizeHS/1000.0) as scledGPA , sizeHS from Student where abs(GPA*(sizeHS/1000.0)) - GPA > 1.0;  

/* how to put computed column in a table attribute variable */
select * from (select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA  from Student) g where abs(g.scaledGPA - GPA) > 1.0; 

/* how to get highest GPA per uni */
/* group by and having would be seen later */
select a.cName, s.GPA from Apply a, Student s where  a.sID = s.sID
group by  a.cname having s.GPA = max(s.GPA);

!NB queries with all, any NOT tested in sqlite3



#############################################
####vid 5. the join family of operators
#############################################
from table 1, table 2 where cond1, cond2,..  #classic syntax, implicit cross product
join syntax follows a relational algebra  
inner join  = algebra theta join with conditions
natural join 
left, right, full outer join  

#join syntaxis do not add expressive power  but is handy for expressions 

/*  basic join */
select distinct sName, major from Student s, Apply a where s.sID = a.sID;
/* is the same */
select distinct sName, major 
from Student s join  Apply a
 on s.sID = a.sID;

/* and add the condition to the join for query processor /*
select  sName, GPA 
from Student s join  Apply a
on s.sID = a.sID
and sizeHS < 1000 and major = 'CS' and cName = 'Stanford'; 
                                                        

/* inner join how to find pairs of students with the same GPA */
select s1.sID, s1.sName, s1.GPA, s2.sID, s2.sName, s2.GPA
from Student s1 join Student S2 using(GPA)
where s1.sID < s2.sID ;

/** outer joins **/
/* find all students who applied to colleges with inner join */
select sName, sID, cName, major
from Student inner join Apply using(sID);

/* find students who applid or did not apply to colleges w outer join */
select sName, sID, cName, major
from Student left join Apply using(sID);

/* how to do the same outer join without using join */
select sName, Student.sID, cName, major
from Student, Apply
where Student.sID = Apply.sID
union
select sName, sID, NULL, NULL
from Student
where sID not in (select sID from Apply);

/* right join find students from Apply who may not in the Student list*/
insert into Apply values(321, 'MIT', 'history', 'N');
insert into Apply values(321, 'MIT', 'psychology', 'N');

/* right join not supported in sqlite3 so we swap tables */
select sName, sID, cName, major
from Apply natural left join Student;

select sName, sID, cName, major
from Apply full join Student using(sID);

/* full outer join  = combo left and right outer join */
select sName, sID, cName, major
from Student left join Apply using(sID)
union
select sName, sID, cName, major
from Apply left join Student using(sID);


/* full outer join without join operator */

select sName, Student.sID, cName, major
from Student, Apply
where Student.sID = Apply.sID
union
select sName, sID, NULL, NULL
from Student
where sID not in (select sID from Apply)
union
select NULL, NULL, cName, major
from Apply
where sID not in (select sID from Student);


## commutativity  (A op B) = (B op A)
## associativity (A op B) op C = A op (B op C)

Outer join is NOT associative !!
## NB
drop table if exists T1;
drop table if exists T2;
create table T1 (A int, B int);
create table T2 (B int, C int);
create table T3 (A int, C int);
insert into T1 values(1,2);
insert into T2 values(2,3);
insert into T3 values(4,5); 



/* works in oracle */
/* results are not the same.
/* outer joins are not associative!!  */
select A,B,C
from (T1 natural full outer join T2) natural full outer join T3;

select A,B,C
from T1 natural full outer join (T2 natural full outer join T3);


#############################################
####vid 6. aggregation
#############################################
/* new keywords group by  , having */
select avg(GPA) from Student;

select min(GPA), max(GPA) from Student join Apply
using(sID) where major = 'CS';


/* for avg gpa applied to cs, we need to count each sudent only once */
/* lets do it with subquery */
select avg(GPA) from Student
where sID in ( select  sID from Apply where major = 'CS')
;

select count(*) from College where enrollment > 15000;

/*  the below counts some students twice */
selct count(*) from Apply where cName = 'Cornell';
/* the fix  count(distinct sID) */
select count( distinct sID) from Apply where cName = 'Cornell';

/* amout by which averg gpa of cs guys is higher than average gpa of non cs students /*

/* by ho much cs student have higher average gpa */

select CS.avgGPA - NonCS.avgGPA
from  (select avg(GPA) as avgGPA from Student
       where sID in ( select  sID from Apply where major = 'CS')) as CS, (select avg(GPA) as avgGPA from Student
       where sID not in ( select  sID from Apply where major = 'CS')) as NonCS ;

/* same result with a complex subquery in select  */
select distinct (
select avg(GPA) as avgGPA from Student
 where sID in ( select  sID from Apply where major = 'CS')) - (select avg(GPA) as avgGPA from Student
       where sID not in ( select  sID from Apply where major = 'CS')) as d
from Student;



/* group by  */
select  cName, count(*) from Apply group by cName;

/*12.10  enrollments by state */        
select state, sum(enrollment) from College
group by state;





/*13.05  see min,max gpa  for groups of college name and major */
select cName, major, min(GPA), max(GPA), avg(GPA)
from Student s join Apply a on s.sID = a.sID
group by cname, major;

--- as usual you can check data before grouping 
select cName, major, GPA
from Student s join Apply a on s.sID = a.sID
order by cname, major;


/*14:20  see max spread of gpa grouped by college and major */
select max(mx-mn) as max_spread, min(mx-mn) as min_spread
from ( select cName, major, min(GPA) as mn, max(GPA) as mx
from Student s join Apply a on s.sID = a.sID
group by cname, major ) M;


/*15:00 see how in how many colleges each student applied */
select s.sID, s.sName, count(distinct cName) --!! count(distinct feat)
from Student s join Apply a on s.sID = a.sID
group by s.sID;

-- check data
select s.sID, a.cName
from Student s join Apply a on s.sID = a.sID
order by s.sID;


/*18:20 chooses a random value of college, in group by sID */

/* supported in sqlite,  oracle throws an error */
select s.SID, cName
from Student s   join Apply a
on s.sID = a.sID
group by s.sID;


/* 19:40  add to the query students who did not applied */
select s.sID, count(distinct cName) 
from Student s join Apply a on s.sID = a.sID
group by s.sID
union
select sID, 0
from Student
where sID not in (select sID from Apply);

/* 21:00  group by + having   query */

/* 22:00  colleges with fewer than 5 applications */
select cName
from Apply
group by cName
having count(*) < 5;

/* 23,19 group by , having query can be written without them */
select distinct cName
from Apply A1
where 5  > ( select count(*) from Apply A2 where A2.cName = A1.cName);


/* 23:40  colleges with less than 5 distinct students ! applied */
select cName
from Apply
group by cName
having count( distinct sID) < 5;


/* 24:30  majors whose applicant's maximum GPA is below average*/
select major
from Student s join Apply a on  s.sID = a.sID
group by major
having max(GPA) < ( select avg(GPA) from Student);



#############################################
####vid 7. null values
#############################################
/* insert statements with null gpa for this video */
insert into Student values(432, 'Kevin', null, 1500); -- null gpa
insert into Student values(321, 'Lori', null, 2500); -- null gpa

/* this query does not return null */
select sID, sName, GPA from student 
where GPA <= 3.5 or GPA > 2.5 ;

/* this query returns all including null */
select sID, sName, GPA from student §where GPA <= 3.5 or GPA > 2.5  or GPA is null ;

/* this returns kevin and lori becuse their sizeHS is  not null
select sID, sName, GPA, sizeHS from student 
where GPA > 3.5  or sizeHS < 1600 or sizeHS >= 1600;

select count(*)
from Student 
where GPA is not null;

/* !!!! pay great attention to queries which have NULL values */


#############################################
####vid 8.  data modification statements
#############################################

insert into table  values(a1,a2,..,a_n )

insert into table
 select-statement

delete from table where condition (cond can be complex)

update table 
set attr = expression  -- expression can be complicated
where condition    -- condition can be complicated


insert into College values('Carnegie Mellon', 'PA', 11500);

insert into Apply
select sID, 'Carnegie Mellon', 'CS', null
from Student  
where sID not in (select sID from Apply);

/*  accept students to carnegie in ee who were rejected elswhere */
insert into Apply
select sID, 'Carnegie Mellon', 'EE', 'Y'
from Student  
where sID in (select sID from Apply where major = 'EE' and decision = 'N');

/* 6.40 delete all students who  applied to more than two different majors */
delete from Student
where sID in
(select sID from Apply
group by SID  having count(distinct major)>2);

/* not all dbs allow the query below  Apply in both plaes */
/* solution put subquery results in a temp table */
delete from Apply
where sID in
(select sID from Apply
group by SID  having count(distinct major)>2);

delete from College
where cName not in (select cName from Apply where major = 'CS');

/* udpdate relation  move students to economics major */
select * from Apply
where cName = 'Carnegie Mellon'
and sID in (select sID from Student where GPA < 3.6);

update Apply
set decision = 'Y', major = 'economics'
where cName = 'Carnegie Mellon'
and sID in (select sID from Student where GPA < 3.6);


/* turn the highest-GPA ee application into CSE applicant */

update Apply
set major = 'CSE'
where major = 'EE'
and sID in 
    (select sID from Student where GPA  >= all
        (select GPA from Student where sID in (select sID from apply where major = 'EE')));

/* no condition for update */
update Apply
set decision = 'Y';

#############################################
ex 1 sql move query exercies
#############################################

#############################################
ex 2 sql social-network query exercices
#############################################

#############################################
ex 3. sql movie-rating modification exercices
#############################################

#############################################
ex 4. sql social network modification exercices. 
#############################################



sudo ln "/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" PDFconcat

