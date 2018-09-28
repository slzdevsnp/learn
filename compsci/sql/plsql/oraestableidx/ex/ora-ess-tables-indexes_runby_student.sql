

-- indexes 

select * from applications
where last_name = 'Morris' and first_name = 'Anthony';
-- run the selct with xtrace (f10)  explain plan

select * from applications
where last_name = 'BAKER' and first_name = 'JOHN';


select * from applications
where UPPER(last_name) = UPPER('BAKER')
and UPPER(first_name) = UPPER('JOHN');

select * from user_indexes where table_name = upper('applications');

CREATE INDEX fx_applicatiosn_fullname_ci
on applications
(UPPER(last_name), UPPER(first_name));

drop index fx_applicatiosn_fullname_ci;


