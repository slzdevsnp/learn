--test_crosstab 

DROP TABLE IF EXISTS test_crosstab;

CREATE TABLE test_crosstab
(
    Product_Name TEXT
    ,Product_Category TEXT
    ,Product_Count INT
);
 
INSERT INTO test_crosstab
VALUES
('Mobile','IT',20)
,('Mobile','ELE',40)
,('Desktop','IT',50)
,('Desktop','ELE',60)
,('Laptop','IT',30)
,('Laptop','ELE',70);


