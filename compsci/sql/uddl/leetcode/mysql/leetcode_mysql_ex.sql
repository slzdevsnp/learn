USE learn;

--pb 595 e Big Countries

DROP TABLE IF EXISTS World;
CREATE TABLE IF NOT EXISTS World (NAME VARCHAR(255), continent VARCHAR(255), AREA INT, population INT, gdp BIGINT);
INSERT INTO World (NAME, continent, AREA, population, gdp) VALUES ('Afghanistan', 'Asia', '652230', '25500100', '20343000000');
INSERT INTO World (NAME, continent, AREA, population, gdp) VALUES ('Albania', 'Europe', '28748', '2831741', '12960000000');
INSERT INTO World (NAME, continent, AREA, population, gdp) VALUES ('Algeria', 'Africa', '2381741', '37100000', '188681000000');
INSERT INTO World (NAME, continent, AREA, population, gdp) VALUES ('Andorra', 'Europe', '468', '78115', '3712000000');
INSERT INTO World (NAME, continent, AREA, population, gdp) VALUES ('Angola', 'Africa', '1246700', '20609294', '100990000000');

SELECT * FROM world;


-works
SELECT NAME, population, AREA  FROM world  WHERE AREA > 3000000 OR population > 25000000;



--pb 175 e combine two tables; 
/*
Write a SQL query for a report that provides the following information for
 each person in the Person table, regardless if there is an address for
  each of those people:
*/

DROP TABLE Person;
DROP TABLE Address;
CREATE TABLE Person (PersonId INT, FirstName VARCHAR(255), LastName VARCHAR(255));
CREATE TABLE Address (AddressId INT, PersonId INT, City VARCHAR(255), State VARCHAR(255));

INSERT INTO Person (PersonId, LastName, FirstName) VALUES ('1', 'Wang', 'Allen');
INSERT INTO Address (AddressId, PersonId, City, State) VALUES ('1', '2', 'New York City', 'New York')

--works
SELECT FirstName, LastName, City, State  FROM Person p LEFT JOIN Address a ON p.Personid = a.PersonId ;

-- pb 620 e 
/*
write a SQL query to output movies with an odd numbered ID and a description that is not 'boring'. Order the result by rating.
*/

DROP TABLE cinema;
CREATE TABLE  cinema (id INT, movie VARCHAR(255), description VARCHAR(255), rating FLOAT(2, 1));

INSERT INTO cinema (id, movie, description, rating) VALUES ('1', 'War', 'great 3D', '8.9');
INSERT INTO cinema (id, movie, description, rating) VALUES ('2', 'Science', 'fiction', '8.5');
INSERT INTO cinema (id, movie, description, rating) VALUES ('3', 'irish', 'boring', '6.2');
INSERT INTO cinema (id, movie, description, rating) VALUES ('4', 'Ice song', 'Fantacy', '8.6');
INSERT INTO cinema (id, movie, description, rating) VALUES ('5', 'House card', 'Interesting', '9.1');

--works 

SELECT id,  movie, description, rating FROM cinema
 WHERE id % 2 != 0 AND description != 'boring'  ORDER BY rating DESC;

--570 easy
/*
Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. For the above table, your SQL query should return:
*/

DROP TABLE Employee;
CREATE TABLE Employee (Id INT, NAME VARCHAR(25), Department VARCHAR(25), ManagerId INT);
INSERT INTO Employee (Id, NAME, Department, ManagerId) VALUES ('101', 'John', 'A', NULL);
INSERT INTO Employee (Id, NAME, Department, ManagerId) VALUES ('102', 'Dan', 'A', '101');
INSERT INTO Employee (Id, NAME, Department, ManagerId) VALUES ('103', 'James', 'A', '101');
INSERT INTO Employee (Id, NAME, Department, ManagerId) VALUES ('104', 'Amy', 'A', '101');
INSERT INTO Employee (Id, NAME, Department, ManagerId) VALUES ('105', 'Anne', 'A', '101');
INSERT INTO Employee (Id, NAME, Department, ManagerId) VALUES ('106', 'Ron', 'B', '101');

--works
SELECT e.name FROM employee e JOIN
 (SELECT managerId, COUNT(managerId) AS cnt FROM employee GROUP BY managerId) eg
 ON e.id = eg.managerId
WHERE eg.cnt > 4;


--p 608  med
/*
Write a query to print the node id and the type of the node. Sort your output by the node id. The result for the above sample is:
*/
DROP TABLE tree;
CREATE TABLE  tree (id INT, p_id INT);
INSERT INTO tree (id, p_id) VALUES ('1', NULL);
INSERT INTO tree (id, p_id) VALUES ('2', '1');
INSERT INTO tree (id, p_id) VALUES ('3', '1');
INSERT INTO tree (id, p_id) VALUES ('4', '2');
INSERT INTO tree (id, p_id) VALUES ('5', '2');

SELECT * FROM tree;


SELECT id , 
CASE WHEN p_id IS NULL
        THEN 'Root'
     WHEN id IN (SELECT p_id FROM tree) AND p_id IS NOT NULL
        THEN 'Inner'
     ELSE 'Leaf'  
     END AS TYPE
FROM tree;


--p 612  minimum distance in plane . med 
/*
Write a query to find the shortest distance between these points rounded to 2 decimals.
*/

DROP TABLE point_2d;
CREATE TABLE point_2d (X INT NOT NULL, Y INT NOT NULL);
INSERT INTO point_2d (X, Y) VALUES ('-1', '-1');
INSERT INTO point_2d (X, Y) VALUES ('0', '0');
INSERT INTO point_2d (X, Y) VALUES ('-1', '-2');

SELECT * FROM point_2d;

SELECT  min(sqrt(POWER(a.x - b.x, 2) + POWER(a.y - b.y,2))) AS shortest
FROM point_2d a JOIN point_2d b
ON a.x != b.x  OR  a.y != b.y;


--p 585  investments  2016  med
DROP TABLE  insurance;
CREATE TABLE insurance (PID INTEGER(11), TIV_2015 NUMERIC(15,2), TIV_2016 NUMERIC(15,2), LAT NUMERIC(5,2), LON NUMERIC(5,2) );
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('1', '10', '5', '10', '10');
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('2', '20', '20', '20', '20');
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('3', '10', '30', '20', '20');
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('4', '10', '40', '40', '40');

SELECT * FROM insurance;

--works
SELECT sum(TIV_2016) AS TIV_2016 
FROM insurance
WHERE pid IN
( SELECT pid FROM insurance i JOIN
 (SELECT TIV_2015, COUNT(TIV_2015) AS cnt FROM insurance GROUP BY TIV_2015) ig
 ON i.TIV_2015 = ig.TIV_2015
 JOIN (SELECT LAT+LON AS ll, COUNT(LAT+LON) AS cnt FROM insurance GROUP BY (LAT+LON) ) cl
 ON i.LAT+i.LON = cl.ll
WHERE ig.cnt > 1 AND cl.cnt = 1 ) ;


-- p 580 count student number in departments
/*
Write a query to print the respective department name and number of students majoring in each department
for all departmentsin the department table (even ones with no current students).
Sort your results by descending number of students; if two or more departments have
the same number of students, then sort those departments alphabetically by department name.
*/

DROP TABLE student;
CREATE TABLE student (student_id INT,student_name VARCHAR(15), gender VARCHAR(6), dept_id INT);

DROP TABLE department;
CREATE TABLE  department (dept_id INT, dept_name VARCHAR(15));

INSERT INTO student (student_id, student_name, gender, dept_id) VALUES ('1', 'Jack', 'M', '1');
INSERT INTO student (student_id, student_name, gender, dept_id) VALUES ('2', 'Jane', 'F', '1');
INSERT INTO student (student_id, student_name, gender, dept_id) VALUES ('3', 'Mark', 'M', '2');

INSERT INTO department (dept_id, dept_name) VALUES ('1', 'Engineering');
INSERT INTO department (dept_id, dept_name) VALUES ('2', 'Science');
INSERT INTO department (dept_id, dept_name) VALUES ('3', 'Law');



-- solution query
SELECT
    dept_name, COUNT(student_id) AS student_number
FROM
    department
        LEFT OUTER JOIN
    student ON department.dept_id = student.dept_id
GROUP BY department.dept_name
ORDER BY student_number DESC , department.dept_name
;


