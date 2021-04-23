
--EXCEPTIONS IN PL/SQL


--1) PRE-DEFINED  Exceptions

CREATE TABLE students
(
id char(11),
name VARCHAR2(50),
grade number(3),
address VARCHAR2(80),
update_date date
);

INSERT INTO students VALUES(123456789, 'John Walker', 11, '1234 Texas', '14-Apr-2020');
INSERT INTO students VALUES(223456789, 'Johnny Walker', 12, '1234 Florida', '14-Apr-2020');

SELECT * FROM students;

--I will declare 2 variables  like emp_id and emp_name
--FETCH ID AND NAME from the students table and assign to variables
--Error like exact fetch returns more than requested number of rows
DECLARE 
    emp_id char(11);
    emp_name varchar2(50);
BEGIN 
        SELECT id, name
        INTO emp_id, emp_name
        FROM students;
        DBMS_OUTPUT.PUT_LINE('Employee id: '||emp_id);
        DBMS_OUTPUT.PUT_LINE('Employee name: '||emp_name);
        DBMS_OUTPUT.PUT_LINE(emp_id ||'==>'|| emp_name) ;
    EXCEPTION
    WHEN TOO_MANY_ROWS THEN 
    DBMS_OUTPUT.PUT_LINE('i need 1 row but query returned multiple rows');
END;

DELETE FROM students 
WHERE id = '223456789';


