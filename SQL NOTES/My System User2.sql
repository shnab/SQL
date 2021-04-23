CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5),
    CONSTRAINT id4_pk PRIMARY KEY(id)
);
INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);

SELECT * FROM workers;

UPDATE workers
SET salary = (SELECT MAX(salary)*0.60
              FROM workers
               )
WHERE name = 'Veli Han'; 

UPDATE workers
SET salary = (SELECT MIN(salary)*1.30
              FROM workers
               )
WHERE name = 'Mary Star'; 



--Company decided to increase the salary of Veli Han. However, instead of setting a specific price, 
--they want to make it 40% less than the highest salary.

--Create parents table whose fields are id(char size is 5 FK), num_of_kids(number size is 2, prevent to use negative numbers),
--total_income(number size is 5)

CREATE TABLE parents
(
    id char(5),
    num_of_kids number(2),
    total_income number(5),
    CONSTRAINT id4_fk FOREIGN KEY(id) REFERENCES workers(id),
    CONSTRAINT check_num_of_kids1 CHECK(num_of_kids>=0)
);
INSERT INTO parents VALUES(10001, 4, 17000);
INSERT INTO parents VALUES(10002, 2, 11000);
INSERT INTO parents VALUES(10003, 1, 9100);
INSERT INTO parents VALUES(10004, 0, 10000);

SELECT * FROM parents;


--If the salary equals to total income increase the salary 20 percent.
UPDATE workers
SET salary = (SELECT total_income*1.20
              FROM parents
              WHERE workers.salary = parents.total_income
              )
WHERE salary = (SELECT total_income
                FROM parents
                WHERE workers.salary = parents.total_income
                ); 

CREATE TABLE people
(
 ssn char(9),
 name varchar2(50),
 address varchar2(50)
);

INSERT INTO people VALUES(123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES(234567890, 'Angie Way', null);
INSERT INTO people VALUES(345678901, 'Maryy Tien', null);
INSERT INTO people(ssn, address) VALUES(456789012, null);
INSERT INTO people(ssn, address) VALUES(567890123, 'California');

SELECT * FROM people;

--Update nulls 'Not inserted yet'
UPDATE people 
SET name = 'Not inserted yet'
WHERE ssn= '456789012' OR ssn= '567890123';
WHERE name IS NULL; 
--Update all nulls to 'Not inserted yet'

UPDATE people 
SET address = 'Not inserted yet'
WHERE address IS NULL;

--2. way --Update all nulls to 'Not inserted yet'

                            --COALESCE(name of the column, data you want to insert) is used to update null values to data in multiple columns
UPDATE people
SET name = COALESCE(name, 'Name is not inserted yet'), 
    address = COALESCE(address, 'Address is not inserted yet');
    
    
    

                    --How to delete data
--DELETE Command deletes records from a table
--DELETE FROM PEOPLE;==> Deletes all records but it does not destroy the table
--If you delete data by using delete command, the data can be rolled back

DELETE FROM people;

--Delete records whose names are null
DELETE FROM people
WHERE name IS NULL;

--Delete records whose names ADRESSES are not null
DELETE FROM people
WHERE address IS NOT NULL;


----Delete records whose names or ADRESSES are null
DELETE FROM people
WHERE address IS NULL OR name IS NULL;

--Delete all records whose names Mark Star and adrress is California==> 
--If tehere is no any data ro delete, SQL gives 0 rows deleted message  on the console
--It does not give any error message
DELETE FROM people
WHERE name = 'Mark Star' AND address = 'California';

--              HOW TO TRUNCATE data
--TRUNCATE command does the same with DELETE command but when you use TRUNCATE you cannot get the data back after removing
--As you know when you use delete the data can be roled back
--TRUNCATE IS used to delete all records 

--DELETE  all recors=ds from people table make it not rolled back
TRUNCATE TABLE people;

SELECT * FROM people;

                --HOW TO DROP TABLE
 --Drop command destroyes the table  with its data and the scructure
 --If you use just DROP COMMAND, it means table can be rolled back but if you use DROP Command together with PERGE
 --it means the table dropped cannot be rolled back
 
DROP TABLE people;              
                
DROP TABLE people PURGE;--TABLE cannot be rolled back with PURGE


                    --SELECT Query
--1)To get all records from a table
SELECT * 
FROM workers;

--2)  To get specific column/columns FROM A TABLE
SELECT name
FROM workers;

SELECT name, salary
FROM workers;

--3)To get a specific data from a column 
SELECT name
FROM workers
WHERE id= 10001;

--4)To get a specific record from a column 
SELECT *
FROM workers
WHERE id =10002;

--TASK: Select all records whose names length  is gretaer than 8
SELECT *
FROM workers
WHERE LENGTH (name)>8;

--TASK: Select all rercords whose salary is the highest
SELECT *
FROM workers
WHERE salary = (SELECT MAX(salary)
                FROM workers
                );

--Select the name whose salary is the lowest

SELECT name
FROM workers
WHERE salary = (SELECT MIN(salary)
                FROM workers
                );

--task: Select the name and salary whose salary is the lowest or highest
SELECT name, salary
FROM workers
WHERE salary = (SELECT MIN(salary) FROM workers) OR salary = (SELECT MAX(salary) FROM workers);

--Slelct the second highest salary from workers table
SELECT MAX(salary) AS second_highest_salary
FROM workers
WHERE salary< (SELECT MAX(salary) 
                FROM workers
                );

                
SELECT MIN(salary) AS second_minimum_salary
FROM workers
WHERE salary> (SELECT MIN(salary) 
                FROM workers
                );               
                
        

--task: Select the third highest salary from workers table
--select all records whose salary is the second high salary
SELECT MAX(salary)
FROM workers
WHERE salary <(WHERE salary< (SELECT MAX(salary)
                FROM workers)
                 );               















