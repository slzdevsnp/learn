select * from student;
select * from college;
select * from apply;


select * from Student;

select sID, sName, GPA from Student
where sID in ( select distinct sID from Apply where major = 'CS');

select avg(GPA) from Student
where sID in ( select distinct sID from Apply where major = 'CS');


