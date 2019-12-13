bobased on book  postgresql-11-quick-start guide

used a database testdb

chapter01 statement tricks
===========
-- to redefine and populate tables run
psql -U postgres -d testdb -a -f 00-table-structure.sql


INSERT on conflict do update

chapter02_listing07   inserting and return the inserted rows


--CTEs

with get_files_by_hash as (
select pk , f_name from files where f_hash like 'abc%')
select f_name from get_files_by_hash;


ch2-listing14.sql  -- pipelining

--ch2-listing 15.sql  --writable cte
WITH
 deleting_files AS ( DELETE FROM files RETURNING * )
INSERT INTO archive_files
SELECT * FROM deleting_files;


## ch3-- listing18.sql  recursive cte
listing 18 - 24  loops
listing 25 -  arrays
listing 26 - 28 exception
listing 29 raise statement  debug, info
listing 30 fully parametrized example of RAISE
listing 31 dynamic query with execute
listing 35, 36 PERFORM instead of SELECT
listing

## ch4-- stored procs and funcs
funcs and procs in postgres.pg_proc table
\df to list compile functions

#### return types
* scalar type
* tuple  (complex) type
* void
listing 4  f_args which returns a record
listing 6 a func with variable number of args VARIADIC
listing 8 returns a setof rows from table   OR a new table
listing 10 generate a tuple from a table row type  on the fly
listing 12 return next or return query
listing 13 returns table
listing 14  list files from a fs directory
listing 18 function immutable
listing 19  function in another schema
listing 20  temp function (exists over a session)
listing 21 show contents of  a function
    SELECT prosrc FROM pg_proc
    WHERE proname = 'f_files_from_directory' AND   prokind = 'f';
listing 23  a func  to dump function contents
listing 24   f_insert_tags function
listing 28 procedures. can commit transactions, returns nothing. introduced in psg11