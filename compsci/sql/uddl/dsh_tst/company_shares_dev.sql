


drop table Company;

create table  Company(
    id int not null primary key,
    name varchar(20) not null,
    parent_share number,
    parent_id int,
    Constraint chk_share CHECK (parent_share between 0 and 100 )
);
    
insert into Company (Id, Name, parent_share, parent_id) values (1, 'mother', 100, NULL);

insert into Company (Id, Name, parent_share, parent_id) values (2, 'A', 75, 1);
insert into Company (Id, Name, parent_share, parent_id) values (3, 'B', 51, 1);
insert into Company (Id, Name, parent_share, parent_id) values (4, 'C',  30, 1);

insert into Company (Id, Name, parent_share, parent_id) values (5, 'CA', 90, 4);
insert into Company (Id, Name, parent_share, parent_id) values (6, 'CAA', 30, 5);

insert into Company (Id, Name, parent_share, parent_id) values (7, 'BA', 80, 3);
insert into Company (Id, Name, parent_share, parent_id) values (8, 'BB', 25, 3);
insert into Company (Id, Name, parent_share, parent_id) values (9, 'BBA', 100, 8);


insert into Company (Id, Name, parent_share, parent_id) values (10, 'AA', 40, 2);
insert into Company (Id, Name, parent_share, parent_id) values (11, 'AAA', 99, 10);
insert into Company (Id, Name, parent_share, parent_id) values (12, 'AAB', 30, 10);
commit;


/*********************************************************************************************
f_get_underlying_ownership()

prints a list of companies and their cumulative shares of the root holding 
company 'mother'  with shares above  '>'  or below '<'  a threshold

parameters:
p_id  numeric, an id of the parent company 
                            default value 1 for the id of the root 'mother' company
p_cumulativeShare numeric,  a value of the cumulative share of a current company,
                            default value 100 used for the 'mother'     
p_shareThreshold  numeric, a threshold value to for cumulative share ownership
p_operator  char,  supported values '>'   and '<'
**********************************************************************************************/
CREATE OR REPLACE FUNCTION f_get_underlying_ownership(  p_id IN NUMBER default 1,
                                                        p_cumulativeShare IN NUMBER default 100,
                                                        p_shareThreshold IN NUMBER,
                                                        p_operator IN CHAR) RETURN VARCHAR2
AS
  l_result VARCHAR2(32000);
  l_result_tmp VARCHAR2(32000);
  l_compName company.name%TYPE;
  l_currentShare company.parent_share%TYPE;
BEGIN
  SELECT name, parent_share INTO l_compName, l_currentShare FROM company WHERE ID = p_id;
  
  IF ( (p_operator = '>' AND p_cumulativeShare * l_currentShare / 100 > p_shareThreshold)
    OR (p_operator = '<' AND p_cumulativeShare * l_currentShare / 100 < p_shareThreshold) )
    AND  l_compName != 'mother' THEN
    l_result := l_compName || ' - ' || p_cumulativeShare * l_currentShare / 100 || '%';
  ELSE
    l_result := null; -- not a nessary assignment, put for code readability purpose
  END IF;
  
  FOR chld IN (SELECT ID FROM company WHERE parent_id = p_id) LOOP  --select will return null  on a leaf node
    l_result_tmp := f_get_underlying_ownership( chld.id,
                                                p_cumulativeShare * l_currentShare / 100,
                                                p_shareThreshold,
                                                p_operator);
    IF l_result_tmp IS NOT NULL THEN
      IF l_result IS NOT NULL THEN
        l_result := l_result || ', ';
      END IF;
      l_result := l_result || l_result_tmp;
    END IF;    
  END LOOP;
  
  RETURN l_result;
END;

--- print company ownership tree
select
    lpad(' ', level*2, ' ')||name ||' '||to_char(parent_share) company,
    LEVEL,
    SYS_CONNECT_BY_PATH(parent_share/100, '*') holding_share
from company 
start with parent_id is null
connect by prior id = parent_id;

--test func
select f_get_underlying_ownership(p_shareThreshold=>40, p_operator=>'>') company_list from dual;
select f_get_underlying_ownership(p_shareThreshold=>40, p_operator=>'<') company_list from dual;


