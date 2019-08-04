--unnest  and array 

drop table if exists contacts;

--- see the phones column definition

CREATE TABLE contacts (
   id serial PRIMARY KEY,
   name VARCHAR (100),
   phones TEXT []
);


INSERT INTO contacts (name, phones) VALUES('John Doe',ARRAY [ '(408)-589-5846','(408)-589-5555' ]);
-- using curly braces 

INSERT INTO contacts (name, phones)
VALUES
   (
      'Lily Bush',
      '{"(408)-589-5841"}'
   ),
   (
      'William Gate',
      '{"(408)-589-5842","(408)-589-58423"}'
   );
   
 ------- querying ------
 
  select name, phones from contacts; 
  
 --get first element from phones index starts from 1
  select name, phones[1] from contacts; 
 
 --using array in where clause 
 

select name, phones
from contacts
where phones [2] = '(408)-589-58423';

--expanding arrays
---unnesting (unpivot  array elements into rows)
select name, unnest(phones) from contacts


--update using a row numeric index 

UPDATE contacts
SET phones [2] = '(408)-589-5843'
where ID = 3;


--this statement updates array as a whole 

UPDATE contacts
SET phones = '{"(408)-589-5843"}'
where ID = 3;

--search in postgres array 
SELECT
   name,
   phones
FROM
   contacts
WHERE
   '(408)-589-5555' = ANY (phones);
  

  
