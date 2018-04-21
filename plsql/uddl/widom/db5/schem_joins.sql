drop table T1;
drop table  T2;
create table T1 (A int, B int);
create table T2 (B int, C int);
create table T3 (A int, C int);

insert into T1 values(1,2);
insert into T2 values(2,3);
insert into T3 values(4,5); 

---
select * from T1;
select * from T2;

/* outer joins are not associative */
select A,B,C
from (T1 natural full outer join T2) natural full outer join T3;
/* results are different */
select A,B,C
from T1 natural full outer join (T2 natural full outer join T3);
