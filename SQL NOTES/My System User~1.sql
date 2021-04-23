CREATE TABLE words
(
    word_id CHAR(3),
    word VARCHAR2(15),
    word_length NUMBER(2)
);

INSERT INTO words VALUES('101', 'hat', 3);
INSERT INTO words VALUES('102', 'hot', 3);
INSERT INTO words VALUES('103', 'hit', 3);
INSERT INTO words VALUES('104', 'hut', 3);
INSERT INTO words VALUES('104', 'selena', 6);
INSERT INTO words VALUES('104', 'yusuf', 5);
INSERT INTO words VALUES('104', 'adem', 4);
INSERT INTO words VALUES('104', 'hct', 3);
?
--Select the words start with 's' end with 'a'

SELECT *
FROM words
WHERE REGEXP_LIKE(word, '^[s].*[a]$(*)');
?
                                        --NOT LIKE Condition
--1)NOT LIKE with Wildcards
?
--Select the words not start with 'h'
SELECT *
FROM words
WHERE word NOT LIKE 'h%';
?
--Select the words not end with 't'
SELECT *
FROM words
WHERE word NOT LIKE '%t';
?
--Select the words do not contain 'a' in any position
SELECT *
FROM words
WHERE word NOT LIKE '%a%';
?
--Select the words start with any character, not followed by 'at'
SELECT *
FROM words
WHERE word NOT LIKE '_at%';
?
--1)NOT LIKE with Regex
?
--Select the words starting with any character, not followed by 'a' or 'o' or 'i'
SELECT *
FROM words
WHERE NOT REGEXP_LIKE(word, '[_aoi](*)');
?
--Select the words whose initial is not 'y' or 's' or 'a' and last character is not 'f' or 'a' or 'm'
SELECT *
FROM words
WHERE NOT REGEXP_LIKE(word, '^[ysa].*[fam]$(*)');
?
--ORDER BY Clause
CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5),
    CONSTRAINT id4_pk PRIMARY KEY(id)
);
?
INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);
INSERT INTO workers VALUES(10005, 'Tam Hanks', 17000);
INSERT INTO workers VALUES(10006, 'Eddie Murphy', 9200);
INSERT INTO workers VALUES(10007, 'Mark J', 5000);
INSERT INTO workers VALUES(10008, 'Walker Tom', 7200);
INSERT INTO workers VALUES(10009, 'Adem Star', 7000);
INSERT INTO workers VALUES(10010, 'Bob Tom', 7000);
?
--Display all records sorted in natural order by using worker names
--ORDER BY puts the records in natural order as default
--To put records in ascending order if you want put ASC after the column name it works as well 
--but it is not must
SELECT *
FROM workers
ORDER BY name ASC;
?
--Display all records sorted in reverse order by using worker salaries
--To put the records in revrese order use DESC after the column name
SELECT *
FROM workers
ORDER BY salary DESC;
?
--Select records of the workers whose salary is less than the average salary and put them in descending order.
SELECT *
FROM workers
WHERE salary < (SELECT AVG(salary) FROM workers)
ORDER BY salary DESC;
?
--Select records of the workers whose names length is less than 8 and put them in descending order by using names.
SELECT *
FROM workers
WHERE LENGTH(name) < 8
ORDER BY name DESC;
?
--Select records of the workers put them in descending order by using salary and put them in ascending order by using names.
SELECT *
FROM workers
ORDER BY salary DESC, name ASC;
?
                                                    --ALIASES for table names
?
SELECT w.name, w.salary
FROM workers w
WHERE salary > 5000;
?
CREATE TABLE employees1 
(  
  employee_id number(9), 
  employee_first_name varchar2(20),
  employee_last_name varchar2(20)
);
?
INSERT INTO employees1 VALUES(14, 'Chris', 'Tae');
INSERT INTO employees1 VALUES(11, 'John', 'Walker');
INSERT INTO employees1 VALUES(12, 'Amy', 'Star');
INSERT INTO employees1 VALUES(13, 'Brad', 'Pitt');
INSERT INTO employees1 VALUES(15, 'Chris', 'Way');
?
CREATE TABLE addresses 
(  
  employee_id number(9), 
  street varchar2(20),
  city varchar2(20),
  state char(2),
  zipcode char(5)
);
?
INSERT INTO addresses VALUES(11, '32nd Star 1234', 'Miami', 'FL', '33018');
INSERT INTO addresses VALUES(12, '23rd Rain 567', 'Jacksonville', 'FL', '32256');
INSERT INTO addresses VALUES(13, '5th Snow 765', 'Hialeah', 'VA', '20121');
INSERT INTO addresses VALUES(14, '3rd Man 12', 'Weston', 'MI', '12345');
INSERT INTO addresses VALUES(15, '11th Chris 12', 'St. Johns', 'FL', '32259');
?
--If the employee_ids are same in 2 tables, display first name, last name and the city on the report by using aliase for table names.
--Put the records in natural order by using last names.
SELECT e.employee_first_name, e.employee_last_name, a.city
FROM employees1 e, addresses a
WHERE e.employee_id = a.employee_id
ORDER BY e.employee_last_name;
?
--GROUP BY Clause
CREATE TABLE employees2 
(  
  id number(9), 
  name varchar2(50), 
  state varchar2(50), 
  salary number(20),
  company varchar2(20)
);
?
INSERT INTO employees2 VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employees2 VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employees2 VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO employees2 VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employees2 VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO employees2 VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO employees2 VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
?
--Display total income of all employees name by name
SELECT name, SUM(salary) AS total_income
FROM employees2
GROUP BY name;
?
--Create a report which displays the total number of employees for every state
SELECT state, COUNT(name) AS num_of_employee
FROM employees2
GROUP BY state;
?
--Create a report which displays the number of employees whose salary is greater than 2000 for every company
SELECT company, COUNT(name) AS num_ofemployees
FROM employees2
WHERE salary > 2000
GROUP BY company;
?
--Create a report which displays the max and min salaries for every company
SELECT company, MAX(salary) AS max_salary, MIN(salary) AS min_salary
FROM employees2
GROUP BY company;
?
--HAVING Clause
--Having is used after Group By Clause to filter the result
--Having is used with Aggregate Functions(SUM(), AVG(), COUNT(), MIN(), MAX())
--After GROUP BY we cannot use WHERE Clause to filter the result. You need to use HAVING after GROUP BY to filter.
?
--Create a report displays the employee names whose total incomes are greater than 2500 
SELECT name, SUM(salary) AS total_income
FROM employees2
GROUP BY name
HAVING SUM(salary) > 2500;
?
--Find the number of employees if it is more than 1 per state
SELECT state, COUNT(name) AS num_of_employees
FROM employees2
GROUP BY state
HAVING COUNT(name) > 1;
?
--Find the minimum salary if it is more than 2000 for every company
SELECT company, MIN(salary) AS min_salary
FROM employees2
GROUP BY company
HAVING MIN(salary) > 2000;
?
--Find the maximum salary if it is less than 3000 for every state
SELECT state, MAX(salary) AS max_salary
FROM employees2
GROUP BY state
HAVING MAX(salary)<3000;
?
--UNION Operator
--Union Operator combines the result of two SELECT Queries, it displays the repeated records just once
SELECT *
FROM employees2
WHERE salary > 3000
?
UNION
?
SELECT *
FROM employees2
WHERE salary < 2000;
?
--Use UNION to display records whose salary is less than 2600 and greater than 2400
SELECT *
FROM employees2
WHERE salary > 2400
?
UNION
?
SELECT *
FROM employees2
WHERE salary < 2600;
?
--UNION ALL Operator
--UNION ALL is used to combine 2 SELECT Queries, it displays repeated records multiple times
SELECT *
FROM employees2
WHERE salary > 2400
?
UNION ALL
?
SELECT *
FROM employees2
WHERE salary < 2600;
?
--INTERSECT Operator
--INTERSECT Operator displays just the common records from the SELECT Queries
SELECT *
FROM employees2
WHERE salary > 2400
?
INTERSECT
?
SELECT *
FROM employees2
WHERE salary < 2600;
?
--Find all common employee names whose salary is greater than 2000 and company name is IBM, APPLE or GOOGLE
SELECT *
FROM employees2
WHERE salary > 2000
?
INTERSECT
?
SELECT *
FROM employees2
WHERE company IN('IBM', 'APPLE', 'GOOGLE');
?
--MINUS Operator
--Minus Operator returns the different records. 
--When you use MINUS Operator, it means you do not want to see common records on the console.
--In MINUS Operator, the order of queries is important
?
--Find the employee names whose salary is less than 3000 and not working in GOOGLE
SELECT *
FROM employees2
WHERE salary < 3000
?
MINUS
?
SELECT *
FROM employees2
WHERE company = 'GOOGLE';
?
--JOINS 
--We have 4 JOINS 1)Inner Join    2)Left Join    3)Right Join     4)Full Join   5)Self Join
?
--INNER Join
--When I tell JOIN, it means INNER Join
?
CREATE TABLE companies1 
(  
  company_id number(9), 
  company_name varchar2(20)
);
?
INSERT INTO companies1 VALUES(100, 'IBM');
INSERT INTO companies1 VALUES(101, 'GOOGLE');
INSERT INTO companies1 VALUES(102, 'MICROSOFT');
INSERT INTO companies1 VALUES(103, 'APPLE');
?
CREATE TABLE orders1 
(  
  order_id number(9),
  company_id number(9), 
  order_date date
);
?
INSERT INTO orders1 VALUES(11, 101, '17-Apr-2020');
INSERT INTO orders1 VALUES(22, 102, '18-Apr-2020');
INSERT INTO orders1 VALUES(33, 103, '19-Apr-2020');
INSERT INTO orders1 VALUES(44, 104, '20-Apr-2020');
INSERT INTO orders1 VALUES(55, 105, '21-Apr-2020');
?
--If the company ids are same display, company name, order id, order date by using Join(Inner Join)
SELECT c.company_name, o.order_id, o.order_date
FROM orders1 o INNER JOIN companies1 c 
ON c.company_id = o.company_id;