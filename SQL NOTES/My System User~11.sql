
--Procedures DO NOT RETURN any values
--Parameters in Procedure may have 3 different types; IN, OUT, IN/OUT
--Procedures can not be used to gether with SQL Statements like SELECT, UPDATE, INSERT, DELETE etc.
--From Inside the procedures, we can call functions

--Create a procedures which select the MIN value of 2 numbers 

DECLARE 
a number := '&firstNumber';
b  number := '&secondNumber';
c NUMBER;

PROCEDURE findMinPr(x IN NUMBER, y IN NUMBER, z OUT NUMBER) IS 

BEGIN 
    IF x<y THEN
    z := x;
    ELSE 
    z := y;
    END IF;

END;

BEGIN 
    findMinPr(a,b,c);
    DBMS_OUTPUT.put_line('Minimum of '||a||' and '||b||' is '||c);

END;

--Create a procedure to calculate the square of a number
DECLARE
num NUMBER := '&numberToCalculateSquare';

PROCEDURE sqrNumP(x IN OUT NUMBER) IS

BEGIN

x := x*x;

END;

BEGIN
    sqrNumP(num);
    DBMS_OUTPUT.put_line('The square: '||num);
END;


CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5),
    CONSTRAINT id7_pk PRIMARY KEY(id)
);

INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);

--Create a procedure to icrease the salary of a worker whose id is given by user and the increase 

--Between  the SQL statements , you may or may not use 'COMMIT' statement
--Nortmally SQL exucutes COMMIT; 

DECLARE 
worker_id workers.id%TYPE := '&worker_id';
raise_amount workers.salary%TYPE := '&raise_amount';
raised_salary workers.salary%TYPE;

PROCEDURE raiseSalaryP(w_id IN CHAR, r_amount IN NUMBER, r_salary OUT NUMBER) IS

BEGIN 
    UPDATE workers
    SET salary = salary + r_amount
    WHERE id = w_id;
    
    COMMIT;
    
    SELECT salary 
    INTO r_salary
    FROM workers
    WHERE id = w_id;
END;

BEGIN 
    raiseSalaryP(worker_id, raise_amount, raised_salary);
    dbms_output.put_line('Raised salary is ' ||raised_salary);
END;

SELECT * FROM workers;

CREATE TABLE accounts
(
    id CHAR(3),
    name VARCHAR2(50),
    balance NUMBER(10,2)
);
INSERT INTO accounts VALUES(101, 'Ali Can', 12000);
INSERT INTO accounts VALUES(102, 'Veli Han', 2000);
INSERT INTO accounts VALUES(103, 'Mary Star', 7000);
INSERT INTO accounts VALUES(104, 'Angie Ocean', 8500);

SELECT * FROM accounts;
?
--Create a procedure to withdraw money from an account.
--Account id and withdraw amount will be given by user.
--If the withdraw amount is greater than the balance withdraw cannot be done
--otherwise do withdraw and display the remaining balance on the output console.
?
DECLARE
account_id accounts.id%TYPE := '&account_id';
withdraw_amount accounts.balance%TYPE := '&withdraw_amount';
remaining_balance accounts.balance%TYPE;
account_balance accounts.balance%TYPE;

PROCEDURE withdrawP(a_id IN CHAR, w_amount IN NUMBER, r_balance OUT NUMBER) IS

BEGIN
?
    SELECT balance
    INTO account_balance
    FROM accounts
    WHERE id = a_id;
    
    IF w_amount <= account_balance THEN
        UPDATE accounts
        SET balance = balance - w_amount
        WHERE id = a_id;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient amount!');
    END IF; 
    
    SELECT balance
    INTO r_balance
    FROM accounts
    WHERE id = a_id;
?
?
END;
?
BEGIN
    withdrawP(account_id, withdraw_amount, remaining_balance);
    DBMS_OUTPUT.PUT_LINE('Remaining balance is '||remaining_balance);
END;

--HOW TO drop PROCEDURE

DROP PROCEDURE withdrawP;


--SEQUENCES
--If you need to create consecutive number values for a column you should create Sequence

CREATE SEQUENCE seq1
START WITH 101 --First turn will start wtih 101
INCREMENT BY 2 -- The values with be increased 2 by 2
MAXVALUE 105  -- The greatest value will be 105, greater than 105, YOU WILL get error 
MINVALUE 97  --Second and next cycles with start with 97
CYCLE --STARTING AGAIN AND AGAIN FROM MINVALUE
CACHE 3; --Cache is front memory. SQL holds 20 values in CACHE default, f your cycle has less than 20, use CACHE 
        --When you do not use Cycle, if you want to hold more than 20 values in Cache you need to declare as well
         --Using Cache improves performance
        
CREATE TABLE students
(
    student_id NUMBER(3),
    student_name VARCHAR2 (50)
);

INSERT INTO students VALUES (SEQ1.nextval, '&student_name');

SELECT * FROM students;

DROP SEQUENCE SEQ1;
DROP TABLE students;

CREATE TABLE parents
(
    parent_id NUMBER(3),
    parent_name VARCHAR2 (50)
);

--ALTER SEQUENCE SEQ1 RESTART WITH 101;

INSERT INTO parents VALUES (SEQ1.nextval, '&parent_name');

SELECT * FROM parents;
DROP TABLE parents;


--HOW TO ALTER SEQUENCE
?
CREATE TABLE bank_customers
(
    customer_order_number NUMBER(3),
    customer_name VARCHAR2(50)
);
?
CREATE SEQUENCE seq1
START WITH 101
INCREMENT BY 2
MAXVALUE 105;
?
--If you want to alter a sequence, you can alter "INCREMENT BY", "MAXVALUE", "MINVALUE", open a CYCLE
--but you CANNOT ALTER "START WITH"
--Note: If you need to alter "START WITH", dropping Sequence and creating it again is recommended
?
--Increase MAXVALUE to 107
ALTER SEQUENCE seq1
MAXVALUE 107;
?
INSERT INTO bank_customers VALUES(seq1.NEXTVAL, '&customer_name');
?
SELECT * FROM bank_customers;
?
DELETE FROM bank_customers;
?
--Update "INCREMENT BY" to 1
DROP SEQUENCE seq1;
?
ALTER SEQUENCE seq1
INCREMENT BY 1;
?
INSERT INTO bank_customers VALUES(seq1.NEXTVAL, '&customer_name');
?
SELECT * FROM bank_customers;
?
DELETE FROM bank_customers;
?
--Open a CYCLE
--When you open a CYCLE if you do not declare MINVALUE, CYCLE starts with 1
ALTER SEQUENCE seq1
CYCLE
CACHE 3;
?
INSERT INTO bank_customers VALUES(seq1.NEXTVAL, '&customer_name');
?
SELECT * FROM bank_customers;



















 