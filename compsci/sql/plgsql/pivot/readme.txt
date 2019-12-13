
turorial on pivoting table  from 

https://postgresql.verite.pro/blog/2018/06/19/crosstab-pivot.html


on osx 

psql -U postgres -h localhost
#> create database if not exists tutorial;
#> create extension tablefunc;

psql -U postgres -h localhost -d tutorial -a -f rainfall-example.sql

#this creates a table tutorial.rainfall 

#follow postgres_pivot_queries.sql 

 
