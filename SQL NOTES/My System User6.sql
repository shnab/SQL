
--FUNCTIONS are cretated mainly for 2 reasons
--1)To do some calculations like tax calculations etc.
--2) To fetch data from database like student name and average scores from students table

--Creating functions is very useful for reusability

--1) Functions must return a value for every condition
--2) IN SQL there are 3 types of parameters a)IN ( used to send data into the function)
--                                          b) OUT (used to get data from the function)
--                                          c)IN/OUT parameter ( used to send data into the function and used to get data from the function operations )
--In the functions we use IN parameter
--Functions use "iN" parameter eveytime. Because of that we do not declare parameters as "IN" "OR" or  "IN/OUT" in the functions
--3) We can use functions in SQL statements like SELECT, INSERT, UPDATE, DELETE etc
--4) We cannot call procedures from inside the functions

--DUAL TABLE==> IS A SPecifiek table
--1)DUAL table is created by ORACLE DBMS, no need to create it.
--if you create DUAL table, you cannor use ORACLE's DUAL table anymore
--2) DUAL TABLE has 1 row 1 column
--3)ROW default value IS "X", data type of the "X" is VARCHAR2(1)
--Column name is "DUMMY" as default
--4) DUAL TABLE has 1 row 1 column so it has just a single data in it

SELECT * FROM DUAL;

--Usage Examples of DUAL Table
SELECT sysdate FROM DUAL; --sysytem date
SELECT user FROM DUAL; --user name

SELECT (3+5)/2 AS AVG FROM DUAL;



--Cerate a students table whose cloumn are name, average scorre NUMBER(4), modify_date DATE, modifier
--INSERT 3 reccords into the students table by getting modify_date and modifier_name from the DUAL table]

CREATE TABLE students

(
        name VARCHAR2(50),
        avg_score NUMBER(4,2),
        modify_date DATE,
        modifier VARCHAR2(50)
);

SELECT * FROM students;

DECLARE --
    cur_date students.modify_date%TYPE; --cur_date DATE:
    modifier_name students.modifier%TYPE;

BEGIN 
    SELECT sysdate, user 
    INTO cur_date, modifier_name
    FROM DUAL;

    INSERT INTO students VALUES('Ali Can', 87.54, cur_date, modifier_name);
    INSERT INTO students VALUES('Veli Han', 63.54, cur_date, modifier_name);
    INSERT INTO students VALUES('Ayse Can',97.54, cur_date, modifier_name);
    
END;
    
    
-- HOW TO CRETAE FUNCTIONS

--1) cRETAE a function which add 2 mnumbers

CREATE OR REPLACE FUNCTION addf(a NUMBER, b NUMBER)
RETURN NUMBER IS
BEGIN

RETURN a+b;

END;
    
-- HOW TO CALL A FUNCTION
    --1. way
    SELECT addf(10, 20) FROM DUAL;
    
    --2. way
    EXECUTE DBMS_OUTPUT.PUT_LINE('sum of the numbers is ' ||addf(10,20));
    
    --3. WAY 
    --in java we were using "=" to make assigment , in SQL we use ":="
    VARIABLE result NUMBER 
    EXECUTE :result := addf(10,20);
    PRINT result;
    

--HOW TO CREATE FUNCTIONS
    --2) Cretae a function which can do 4 mathematical operations with 2 numbers
CREATE OR REPLACE FUNCTION calcf(a NUMBER, b NUMBER, operator CHAR)

RETURN NUMBER IS
BEGIN 
    IF operator = '+' THEN
    RETURN a+b;
     ELSIF operator ='-' THEN
    RETURN a+b;
     ELSIF operator ='*' THEN
    RETURN a*b;
     ELSIF operator ='/' THEN
    RETURN a/b;
    
    ELSE 
        dbms_output.put_line('You should select one of the +, -, *, /');
        RETURN 0;
    END IF;
    
    EXCEPTION
    WHEN ZERO_DIVIDE THEN 
    dbms_output.put_line('You should not divide by zero');
    RETURN 0;
END;

--HOW TO CALL FUNCTION
--1. WAY
SELECT calcf(10,0, '/') FROM DUAL;

--2. WAY: RECOMMENDED
EXECUTE dbms_output.put_line (calcf(10,0, '/'));

--3. way
VARIABLE result NUMBER;
EXECUTE :result := calcf(10,0,'/');
PRINT result;

--Create A function which returns the greater number of 2 numbers(numbers entered manually)


CREATE OR REPLACE FUNCTION findMax(a NUMBER, b NUMBER)

RETURN NUMBER IS

BEGIN 
    IF a>b THEN
    RETURN a;
    ELSE
    RETURN b;  
    
      END IF;
   
END;

--1. way
SELECT findMax(11,23) FROM DUAL;
--2. way
EXECUTE dbms_output.put_line (findMax(11,23));
--3. way
VARIABLE result NUMBER;
EXECUTE :result := findMax(11,23);
PRINT result;



----Create A function which returns the greater number of 2 numbers(numbers entered by user)
--When you get data from the user , wHEN YO UUSE DECLARE, dont use CREATE OR REPLACE, type just FUNCTION
--To c all the method you need to type "BEGIN dbms_output.put_line ('Maximum one is ' || findGreaterf(a,b)); END;"
DECLARE 
a NUMBER := '&firstNumber';
b NUMBER := '&secondNumber';

FUNCTION findGreaterf(x NUMBER, y NUMBER)
RETURN NUMBER IS
BEGIN 

    IF x>y THEN
    RETURN x;
    ELSE 
    RETURN y;
    END IF;

END;

BEGIN
    dbms_output.put_line ('Maximum one is ' || findGreaterf(a,b));
END;

--How to drop function
DROP FUNCTION findMax;

--Create a function to calculate factorial, get the number from user
DECLARE 
a NUMBER := '&numberToCalculateFactorial';

 FUNCTION factorialf(x NUMBER)
RETURN NUMBER IS
BEGIN 
    IF x<0 THEN
    DBMS_OUTPUT.PUT_LINE('DO NOT USE NAGATIVE NUMBER');
    RETURN 0;
   ELSIF x=0 THEN
   RETURN 1;
   ELSE 
   RETURN x* factorialf(x-1); --recorsif method call
   
   END IF;
END;

BEGIN
    dbms_output.put_line (a||'! = '|| factorialf(a));
END;
