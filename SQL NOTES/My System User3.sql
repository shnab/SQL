CREATE TABLE workers4
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5),
    CONSTRAINT id6_pk PRIMARY KEY(id)
);

INSERT INTO workers4 VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers4 VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers4 VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers4 VALUES(10004, 'Angie Ocean', 8500);
INSERT INTO workers4 VALUES(10005, 'Tom Hanks', 17000);
INSERT INTO workers4 VALUES(10006, 'Eddie Murphy', 9200);
INSERT INTO workers4 VALUES(10007, 'Mark J', 5000);
INSERT INTO workers4 VALUES(10008, 'Walker Tom', 7200);

SELECT * FROM workers4;

--third highest salary
SELECT MAX(salary) AS third_highest_salary
FROM workers4
WHERE salary< (SELECT MAX(salary)
                FROM workers4
                WHERE salary<(SELECT MAX(salary)
                                FROM workers4));
--third highest salary                                
SELECT *
FROM workers4
WHERE salary= (SELECT MAX(salary) 
              FROM workers4
                WHERE salary< (SELECT MAX(salary)
                                FROM workers4
                                WHERE salary<(SELECT MAX(salary)
                                            FROM workers4)));
                                            
 --IN CONDITION                                            
 --instead of                                            
  --Select the names and salaries of the workers whose ids are 10001, 10002, 10004
  --1. way
  SELECT name, salary
  FROM workers4
  WHERE id =10001 OR id= 10002 OR id = 10004;
  
  --2. WAY
 SELECT name, salary
  FROM workers4
  WHERE id IN (10001, 10002, 10004);
  
  --between condition
  --WHEN YOU USE BETWEEN condition boundaries are inclusive
  --Select the names and salaries of the workers4 whose ids are greater than or equal to 10002 or less than or equal to 10005
  --1. way
  SELECT name, salary
  FROM workers4
  WHERE id>=10002 AND id <=10005;
  
  --2. way
  SELECT name, salary
  FROM workers4
  WHERE id BETWEEN 10002 AND 10005;
  
  --NOT BETWEEEN CONDITION
   --WHEN YOU USE BETWEEN condition boundaries are inclusive
  --Select the names and salaries of the workers4 whose ids are less than 10002 or gretater than 10005
  --1. way
  SELECT name, salary
  FROM workers4
  WHERE id<10002 OR id > 10005;
  --2. way
  SELECT name, salary
  FROM workers4
  WHERE id NOT BETWEEN 10002 AND 10005;
  
  --PRACTICE
  --select the sdalary whose names are between 'Tom Hanks', 'Eddie Murphy',
  SELECT salary
  FROM workers4
  WHERE name BETWEEN 'Eddie Murphy'  AND 'Tom Hanks';
  
  --EXISTS CONDITION 
  --When you use exists condition you need to type a subquery after WHERE clause
  --If the subquery has any result  it will return data otherwise it will not.
  
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
  
  CREATE TABLE customers_likes
( 
  product_id number(10),
  customer_name varchar2(50),
  liked_product varchar2(50)
);

INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary', 'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Eddie', 'Apple');
  
  SELECT * FROM customers_likes;
  
  --select CUSTOMER NAMEs who have same product ids in the tables
  
  SELECT customer_name
  FROM customers_products
  WHERE EXISTS(SELECT product_id 
              FROM customers_likes
              WHERE customers_products.product_id = customers_likes.product_id );
              
--How to use SubQueries after select BEFORE from
--Select name,salary,  average salary from wrokers4 table.
--Display average salary for every workers

SELECT name, salary, (SELECT AVG(salary) FROM workers4 ) average_salary
FROM workers4;

--cREATE a report to display name, salary, max salary, min salary for every record.
SELECT name, salary, (SELECT MAX(salary) FROM workers4 ) max_salary, (SELECT MIN(salary) FROM workers4 ) min_salary
FROM workers4;
  
-- Create a rapoort which displays product names and the number of liked products
--GROUP BY 
  
                                        --LIKE condition 
                                -- HOW TO USE WILDCARDS(%, _)
SELECT * FROM workers4;

--Select records which have workers whose names are starting with 'A'
--% ==> means all characters. Works for 0 or more characters
SELECT *
FROM workers4
WHERE name LIKE 'A%';

--Select records whose names are ending with 'n'
SELECT *
FROM workers4
WHERE name LIKE '%n';
  

--Select records whose names have 'an'
SELECT *
FROM workers4
WHERE name LIKE '%an%';

--Select records whose names start with any character followed by 'li'
-- '_' ==> underscore is used for single character
SELECT *
FROM workers4 
WHERE  name LIKE '_li%';

--Select records whose names 2nd character is 'a', 4th character is 'y'
SELECT *
FROM workers4 
WHERE  name LIKE '_a_y%';

--Select records whose names 2nd character is 'r' and have 6 character in total
SELECT *
FROM workers4 
WHERE  name LIKE '__r___';--Mark J
--Select records whose names 2nd character is 'r' and have at least 6 character in total
SELECT *
FROM workers4 
WHERE  name LIKE '__r___%';

--Select records whose names are starting with  'a' and endong with 'n' and have at least 4 characters
SELECT *
FROM workers4 
WHERE  name LIKE 'A__%n';
  
                         --how to USE regex (REGULAR EXPRESSIONS)

CREATE TABLE words
(
    word_id char(3),
    word varCHAR2(15),
    word_length NUMBER(2)

);
  INSERT INTO words VALUES ('101', 'hat', 3);
  INSERT INTO words VALUES ('102', 'hot', 3);
  INSERT INTO words VALUES ('103', 'hit', 3);
  INSERT INTO words VALUES ('104', 'hut', 3);
  INSERT INTO words VALUES ('104', 'selena', 6);
  INSERT INTO words VALUES ('104', 'yusuf', 5);
  INSERT INTO words VALUES ('104', 'adem', 4);
  INSERT INTO words VALUES ('104', 'hct', 3);
  
  SELECT * FROM words;
  
 --SELECT THE WORDS starring with 'h', ending with 't' and 2nd is 'a' or 'o' and 3 characters in total
  --REGEXP
  --1 way==>Recommemned
SELECT *
FROM words
WHERE REGEXP_LIKE (word,'h[aio]t');
--2. way
SELECT *
FROM words
WHERE REGEXP_LIKE (word,'h(a|i|o)t');

--Select the words starting with 'h', ending 't' and 2nd  characters is from a to i ij alphabet
SELECT *
FROM words
WHERE REGEXP_LIKE (word,'h[a-i]t');

--Select the words contains 'a' or 'e' in any position
SELECT *
FROM words
WHERE REGEXP_LIKE (word,'[ae](*)');--'[ae](*)') and [ae]  are same but 1st is beter
--'*' all
--select starts with 's' or 'y' or 'a'  
SELECT *
FROM words
WHERE REGEXP_LIKE (word,'^[sya](*)'); --'^' ==>stands for 'starts with' isareti

--select ends with 'a' or 'f' or 'm' 
SELECT *
FROM words
WHERE REGEXP_LIKE (word,'(*)[afm]$'); --$==> 'ends with'


                                            