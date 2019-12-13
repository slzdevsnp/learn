-- pivot queries based table rainfall (amount of rainy days for french cities on monthly basis ) 
--pivot means rows to columns 
--unpivot means columns to rows  

SELECT count(*) FROM rainfall;

select * from rainfall limit 100;


select distinct city from rainfall;

select distinct year from  rainfall;


---- query to subset few months over 2 years for 2 cities
select * from rainfall
where city in ('Paris', 'Dijon')
and month between 1 and 3
and year between 2016 and 2017
order by city asc, year asc, month asc;

-- the pivoted version of the same query 
select
city, 
(case when year=2016 and month = 1 then raindays end) as "2016_1_rdays",
(case when year=2016 and month = 2 then raindays end) as "2016_2_rdays",
(case when year=2016 and month = 3 then raindays end) as "2016_3_rdays",
(case when year=2017 and month = 1 then raindays end) as "2017_1_rdays"
from  rainfall   
where year between 2016 and 2017 and month between 1 and 3
and city in ('Paris', 'Dijon')
order by city asc 


--often pivots  have aggregated functions  eg. 
-- nb look how FILTER WHERE is used
SELECT
  city,
  SUM(raindays) FILTER (WHERE year=2012) AS "2012",
  SUM(raindays) FILTER (WHERE year=2013) AS "2013",
  SUM(raindays) FILTER (WHERE year=2014) AS "2014",
  SUM(raindays) FILTER (WHERE year=2015) AS "2015",
  SUM(raindays) FILTER (WHERE year=2016) AS "2016",
  SUM(raindays) FILTER (WHERE year=2017) AS "2017"
FROM rainfall 
GROUP BY city
ORDER BY city;


-- execute in database if not done yet CREATE EXTENSION tablefunc;
select * from crosstab(
-- central query
'select city,year,sum(raindays) 
from rainfall group by city,year order by city',
--query to generate the horizontal header
'select distinct year from rainfall order by year' )
as ("City" text, "2012" int, "2013" int, "2014" int, "2015" int, "2016" int, "2017" int);


--test_crosstab
select * from test_crosstab ;

select * from crosstab( 
'select product_name, product_category, product_count
 from test_crosstab where product_name = order by 1,2')
 as  T (Product_name text, IT INT, ELE INT)


 --unpivoting with unnest 
 drop table foo; 
 CREATE TEMP TABLE if not exists foo
 (id int,
  a text,
  b text,
  c text);
 
 INSERT INTO foo VALUES (1, 'ant', 'cat', 'chimp');
 insert into foo values (2, 'grape', 'mint', 'basil');

select * from foo;
 
select id, 
	unnest(array['x1','x2','x3']) as colname, 
	unnest(array[a,b,c])  as thing 
from foo 
order by id; 


--=======================
select * from mdummy;

select 
symbol, lp, 
avg(y0) as a_y0, 
avg(y100) as a_y100,
avg(y1000) as a_y1000
from mdummy 
group by symbol, lp;

--=======================
--unpivog query appears to work for preceeding query  
select 
symbol, lp,
unnest(array[0,100,1000]) as x, 
unnest(array[avg(y0),avg(y100), avg(y1000)]) as y 
from mdummy 
where lp='009'
group by symbol, lp 
--=======================




