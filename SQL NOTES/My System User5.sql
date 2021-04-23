
CREATE TABLE employees3 
(  
  id number(9), 
  name varchar2(50), 
  state varchar2(50), 
  salary number(20),
  company varchar2(20)
);

INSERT INTO employees3 VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employees3 VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employees3 VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO employees3 VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employees3 VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO employees3 VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO employees3 VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');


--NOTE: When you use 'UNION', UNION ALL, INTERSECT, MINUS you need to be careful about
--1) The number of colunms of both queries should be same, otherwise SQL gives error like  "query block has incorrect number of result columns"

SELECT name, state
FROM employees3

UNION

SELECT name, state, salary
FROM employees3;

--2) Data types of corresponding columns should match, otherwise SQL gives error like "expression must have same datatype as corresponding expression"
SELECT name, state
FROM employees3

UNION

SELECT name, salary
FROM employees3;

--Trick : Following code works but given rules above is fine
SELECT name, state
FROM employees3

UNION

SELECT state, name
FROM employees3;

SELECT * FROM orders1;
SELECT * FROM companies1;

--2)LEFT JOIN : returns all data from  the first table
--When you use  LEFT JOIN orders of the tables are important, IT AFFECTS the result
SELECT c.company_name, o.order_id, o.order_date
FROM companies1 c LEFT JOIN orders1 o
ON c.company_id = o.company_id;

--3)RIGHT JOIN : returns all data from  the second table
--When you use RIGHY JOIN orders of the tables are important 
SELECT c.company_name, o.order_id, o.order_date
FROM companies1 c RIGHT JOIN orders1 o
ON c.company_id = o.company_id;

--NOTE: SET operation are used to join the result of SELECT QUERIES
--JOINS are used to join tables


--4) FULL JOIN  : It will return all data from both tables
--               REPEATED DATA will be displayed just once

SELECT c.company_name, o.order_id, o.order_date
FROM companies1 c FULL JOIN orders1 o
ON c.company_id = o.company_id;

--5) SELFf JOIN: we use just a single table
CREATE TABLE employees2 
(  
  id number(2), 
  name varchar2(20),
  title varchar2(60),
  manager_id number(2) 
);

INSERT INTO employees2 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO employees2 VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO employees2 VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO employees2 VALUES(4, 'Amy Sky', 'CEO', 5);

SELECT t1.name AS emp_name, t2.name AS mng_name
FROM employees2 t1 INNER JOIN employees2 t2
ON t1.manager_id= t2.id;


--PIVOT CLAUSE: IT IS USED to make records data cloumn name
DROP TABLE customers_products;

CREATE TABLE customers_products
( 
  product_id number(10),
  customer_name varchar2(50),
  product_name varchar2(50)
);

INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (20, 'John', 'Apple');
INSERT INTO customers_products VALUES (30, 'Amy', 'Palm');
INSERT INTO customers_products VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_products VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_products VALUES (40, 'John', 'Apricot');
INSERT INTO customers_products VALUES (20, 'Eddie', 'Apple');


SELECT * FROM customers_products;
 
--display which customer bought how many orange , how many apple etc ==> () subquery
SELECT *
FROM (SELECT customer_name, product_name FROM customers_products)

PIVOT 
(COUNT(product_name) FOR product_name IN ('Orange', 'Apple', 'Palm', 'Apricot'));

--Display which product is bought how many times from which customer
SELECT *
FROM (SELECT product_name, customer_name FROM customers_products)
PIVOT 
(COUNT (customer_name ) FOR customer_name IN ('Mark', 'Any', 'John'));

--HOW TO ALTER TABLES
SELECT * FROM customers_products;
--We will update the scructure of table
--1) How to add column into a table

ALTER TABLE customers_products
ADD lastname varchar2(25);

ALTER TABLE customers_products
ADD address varchar2(50);


--How to add multiple columns

ALTER TABLE  customers_products
ADD (county varchar2(15), city varchar2(15));

--How to add columns with  a default value?
ALTER TABLE  customers_products
ADD country varchar2(15) DEFAULT 'The USA';

--how to drop a single  column
ALTER TABLE  customers_products
DROP COLUMN lastname;

--how to drop multiple  columns
ALTER TABLE  customers_products
DROP (address, county);

ALTER TABLE  customers_products
DROP (city, country);


--3) how to rename a column
ALTER TABLE customers_products
RENAME column product_name TO fruit;

ALTER TABLE cust_pro
RENAME column fruit to fruit_name;

--how to rename table
ALTER TABLE customers_products
RENAME TO cust_pro;


SELECT * FROM cust_pro;


--5) HOW TO MODIFY A COLUMN STRUCTURE

ALTER TABLE cust_pro
MODIFY fruit_name varchar2(20) NOT NULL;


--add price column to table with default value 0.00
ALTER TABLE cust_pro
ADD price number(4,2);

--modify the price column by using UNIQUE Constraint, make the precision 5 and scale 2
ALTER TABLE cust_pro
MODIFY price number(5,2) UNIQUE;

--DROP PRICE
ALTER TABLE cust_pro
DROP COLUMN price;

--6) How to MODIFY multiple columns
--To modify data type of a column, the column should not any data in it, all data should be null
--You get error like "column to be modified must be empty to change datatype"
--To modify data size of a column you can just increase, if you want to decrease all data in the column must be null othetwise you get error like
----"column to be modified must be empty to decrease precision or scale"
ALTER TABLE cust_pro
MODIFY (customer_name VARCHAR2(151), product_id number(20,2));








