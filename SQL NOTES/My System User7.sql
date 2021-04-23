
--TRIGGERS
--Triggers are like functions but ==>
--Triggers are executed 'BEFORE' or 'AFTER' SQL Statements like SELECT, INSERT INTO, DELETE, UPDATE etc. /table level triggers
--Triggers are executed 'BEFORE' or 'AFTER' SQL Statements like DROP, TRUNCATE etc. //Data base level triggers
--Mainly there are 2  types triggers
--1) DML Triggers==> TABLE level Triggers ==> SELECT, INSERT INTO, DELETE, UPDATE etc
--2) DDL Triggers==> DATAbase level Triggers ==> DROP, TRUNCATE, CREATE etc.

--FUNCTIONS and Procedures are executed manually , TRIGGER are executed automatically by Oracle Server
--There is no 'Trigger call' buy For functions and Procedures there is call

--UPDATE SET ==> You updated 5 rows. You wanna give a message to user
--If you want to give a message to the user after updating 5 rows , you need to creatE a trigger
--That kind of triggers are called "Statement Level Triggers"
--All triggers are "Statement Level Triggers" as default

--If you want to give a message to user after every row is updated , you need to create a Trigger. 
--That kind of triggers are called "Record Level Triggers". if you want to need this soort, you need to declare it

DROP TABLE workers;

CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5)
);

INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);


                            --DML TERIGGERS==> TABLE LEVEL
--STATEMENT LEVEL TRIGGER
CREATE OR REPLACE TRIGGER workers_trigger BEFORE UPDATE ON workers
BEGIN 
    dbms_output.put_line('This trigger it is executed before update on workers ');
END;

UPDATE workers
SET salary = salary + 500
WHERE id = 10002;

--RECORD LEVEL TRIGGER

CREATE OR REPLACE TRIGGER  w_recordlevel_trigger AFTER DELETE ON workers FOR EACH ROW
BEGIN 
     dbms_output.put_line('This trigger it is executed after delete on workers table');
END;

DELETE FROM workers
WHERE id< 10004;


                                             --DDL TRIGGERS == DATABASE LEVEL TRIGGERS
                                             
CREATE OR REPLACE TRIGGER hr_ddl_trigger BEFORE DROP ON hr.schema 
BEGIN
    DBMS_OUTPUT.PUT_LINE('This is DDL Trigger and will be executed before dropping table!');
END;

DROP TABLE bank_customers;

--How to DISABLE or ENABLE a TRIGGER
ALTER TRIGGER hr_ddl_trigger DISABLE;
ALTER TRIGGER hr_ddl_trigger ENABLE;

--How to DISABLE or ENABLE all TRIGGERS on a Table
ALTER TABLE workers DISABLE ALL TRIGGERS;
ALTER TABLE workers ENABLE ALL TRIGGERS;

--How to DROP DDL and DML Triggers
DROP TRIGGER hr_ddl_trigger;



        --1. FIRST REAL LIFE EXAMPLE
DROP TABLE workers;

CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5)
);

INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);
SELECT * FROM workers;

CREATE TABLE workers_history
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5),
    update_date DATE
);

SELECT * FROM workers_history;

CREATE OR REPLACE TRIGGER wor_history_trigger BEFORE UPDATE OF salary ON workers FOR EACH ROW
BEGIN   
    INSERT INTO workers_history VALUES(:old.id, :old.name, :old.salary, sysdate);
END;

UPDATE workers 
SET salary = salary+ 900
WHERE id = 10002;

    --2. REAL LIFE EXAMPLE ABOUT TRIGGERS

--WHEN you update the salary of a worker, insert to folowing data into salary changes table]
--Name, old salary, new salary, raise amount, date

CREATE TABLE salary_changes
(
    name VARCHAR2(50),
    old_salary NUMBER(5),
    new_salary NUMBER(5),
    raise_amount NUMBER (5),
    update_date DATE
);
SELECT * FROM salary_changes; 

CREATE OR REPLACE TRIGGER sal_changes_trigger BEFORE UPDATE OF salary ON workers FOR EACH ROW
BEGIN   
    INSERT INTO salary_changes VALUES(:old.name, :old.salary, :new.salary, :new.salary- :old.salary, sysdate);
END;

UPDATE workers 
SET salary = salary+ 900
WHERE id < 10003;

DROP TRIGGER sal_changes_trigger;


--3 .rEAL LIFE EXAMPLE
--Cerate a trigger like
--When you UPDATE any record or INSERT any record  it will be triggered
--It will store updated or inserted records into CHANGES table

CREATE TABLE changes
(
    order_number NUMBER(3),
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5),
    change_date DATE
);

CREATE SEQUENCE seq_changes;

CREATE OR REPLACE TRIGGER w_updateinsert_trigger BEFORE INSERT OR UPDATE ON workers FOR EACH ROW
BEGIN 
    INSERT INTO changes VALUES(seq_changes.NEXTVAL, :new.id, :new.name, :new.salary, sysdate );
END;
SELECT  * FROM changes;

SELECT  * FROM workers;
INSERT INTO workers VALUES(10005, 'xxx yyy', 6600);

UPDATE workers
SET name = 'MMM NNNN'
WHERE id<10003;


--4 .rEAL LIFE EXAMPLE
--Cerate a trigger like
--When you UPDATE any record or INSERT any record  it will be triggered
--It will store updated or inserted records into CHANGES table

CREATE TABLE records1
(
    order_number NUMBER(3),
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5),
    change_date DATE
);

CREATE SEQUENCE seq_records;

CREATE OR REPLACE TRIGGER w_di_trigger BEFORE DELETE OR INSERT ON workers FOR EACH ROW
BEGIN 
        INSERT INTO records1 VALUES (seq_records.NEXTVAL, :old.id, :old.name, :old.salary, sysdate);
END;

SELECT  * FROM records1;
DELETE FROM records1;
SELECT  * FROM workers;

DELETE FROM workers
WHERE id = 10001;

INSERT INTO workers VALUES (10005, 'Ali Can', 8800);



----23.12.2020 
CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5)
);

INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);


CREATE TABLE changes
(
    order_number NUMBER(3),
 type CHAR(20),
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5),
    change_date DATE
);
SELECT * FROM workers;
SELECT * FROM changes;

--Cerate a trigger like
--When you DELETE or INSERT any record  it will be triggered
--It will store DELETED or inserted records into CHANGES table
--USE SEQUENCE AND DATE IN CHANGES TABLE

DROP SEQUENCE seq_changes;
CREATE SEQUENCE seq_changes;

CREATE OR REPLACE TRIGGER w_di_trigger1  BEFORE DELETE OR INSERT on workers FOR EACH ROW
BEGIN 
    IF :old.id IS NULL THEN 
        INSERT INTO changes VALUES(seq_changes.NEXTVAL, 'Inserted', :new.id, :new.name, :new.salary, sysdate);
    ELSE
        INSERT INTO changes VALUES(seq_changes.NEXTVAL, 'Deleted', :old.id, :old.name, :old.salary, sysdate);
    END IF;    
        
END;

SELECT * FROM workers;
SELECT * FROM changes;

DELETE FROM workers
WHERE id = 10004;

INSERT INTO workers VALUES (10005, 'Tom Hanks', 11000 );
INSERT INTO workers VALUES (10006, 'Angelina Julie', 22000 );
INSERT INTO workers VALUES (10007, 'John Walker', 23000 );

DROP TABLE changes;


----------------------------
 --CURSORS
--Cursor is a pointer which points Context Area
--Data which Cursor holds is called "Active Set"
?
--There are 2 types of Cursors
    --a)Implicit Cursors (Pre-defined Cursors): Created by Oracle
    --b)Explicit Cursors (User-defined Cursors): Created by user
?
--Implicit Cursors:
    --a)%FOUND(Returns Boolean): If INSERT INTO, UPDATE SET, and DELETE commands affects at least 1 records then
    --                           %FOUND Cursor returns true, otherwise it returns false.
    
    
CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5)
);
?
INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);
?
--Example: By getting id from user delete an existing record
--When you execute the following code you will get "Procedure Successfully Completed" message 
--but more specific message like "Record whose id is 10001 is deleted" would be better
DECLARE
    emp_id workers.id%TYPE := '&emp_id';
BEGIN
    DELETE FROM workers WHERE id = emp_id; 
END;
?
--By using Cursor we can achieve to get more specific messages
DECLARE
    emp_id workers.id%TYPE := '&emp_id';
BEGIN
    DELETE FROM workers WHERE id = emp_id; 
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Record is deleted whose id is '||emp_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No record is deleted');
    END IF;    
END;
?
SELECT * FROM workers;
--Example: Raise the salary of a worker whose id will be entered by user.
--         If the salary is raised print name, old salary, and new salary to the console.
--         Use %FOUND Cursor.
?
DECLARE
    emp_id workers.id%TYPE := '&emp_id';
    emp_name workers.name%TYPE;
    emp_old_salary workers.salary%TYPE;
    emp_new_salary workers.salary%TYPE;
BEGIN
    SELECT salary
    INTO emp_old_salary
    FROM workers
    WHERE id = emp_id;
?
    UPDATE workers
    SET salary = salary*1.1
    WHERE id = emp_id;
    
    SELECT name, salary
    INTO emp_name, emp_new_salary
    FROM workers
    WHERE id = emp_id;
    
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Salary is updated '||emp_name||' - '||emp_old_salary||' - '||emp_new_salary);
    END IF;
    
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Salary is not updated');
        
END;
?
    --b)%NOTFOUND(Returns Boolean): If INSERT INTO, UPDATE SET, and DELETE commands affects at least 1 records then
    --                              %NOTFOUND Cursor returns false, otherwise it returns true.
    
    --c)%ROWCOUNT(Returns Integer): It returns the number of records which are affected by INSERT INTO, UPDATE SET, and DELETE statements
    --                              It returns 0, if no record is affected.
?
--Example: Update the salary in workers table. 
--         If no records could be updated return 'No update!'
--         If any records are updated return the number of records which are updated
?
SELECT * FROM workers;
?
DECLARE 
  num_of_rec NUMBER(2);
  emp_id workers.id%TYPE := '&emp_id';
BEGIN
    UPDATE workers
    SET salary = salary + 500
    WHERE id > emp_id;
    
    IF SQL%NOTFOUND THEN
        num_of_rec := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE(num_of_rec || ' records are updated');
    ELSIF SQL%FOUND THEN
        num_of_rec := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE('Number of updated records is '||num_of_rec);
    END IF;     
END;


                                    --EXPLICIT CuRSORS
--For explicit corsors, you have to do 4 steps
    --a)Declare the Cursor
    --b)Open the corsor
    --c)Fetch the corsor
    --d)Close the cursor

--Example: your manager ask you to prepare a report which displays the raised salaries ,
--          But the manager did not ask you to update the salaries , he wants to see on a report just to see 
--          if the salaries are raised. 
--          if the salary is less then 8000 raISE it by %20, otherwise 10

--CURSOR WITH LOOP
DECLARE 
    raised_salary workers.salary%TYPE;
    emp_name workers.name%TYPE;
        CURSOR cursor1 IS SELECT name, salary FROM workers;
BEGIN
        OPEN cursor1;
    
    LOOP
        FETCH cursor1 INTO emp_name, raised_salary;
        IF raised_salary < 8000 THEN
        raised_salary := raised_salary*1.2;
        ELSE
         raised_salary := raised_salary*1.1;
        END IF;
        
        EXIT WHEN cursor1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(emp_name || '--->' || raised_salary);
     END LOOP;
        CLOSE cursor1;
        
END;

SELECT * FROM workers;

                                        --CURSOR WITH FOR LOOP
--When you use cursor with FOR LOOP just Declaration of cursor is enough
--No nned to OPEN, FETCH  and CLOSE cursor

--When you use cursor with FOR LOOp no need to use variable
--because every data will be "r" variable
DECLARE 
        CURSOR cursor2 IS SELECT name, salary FROM workers;
BEGIN
      FOR r IN cursor2 LOOP
        IF r.salary < 8000 THEN
             r.salary := r.salary*1.2;
        ELSE
             r.salary := r.salary*1.1;
        END IF;
        
        EXIT WHEN cursor2%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(r.name || '--->' || r.salary);
     END LOOP;
         
END;

--CURSOR with "WHILE LOOP"
--When you use Cursor with "while loop" you need to DECLARE, to OPEN, to FETCH, to CLOSE cursor

DECLARE
    CURSOR cursor3 IS SELECT name, salary FROM workers;
        r cursor3%ROWTYPE;
BEGIN
        OPEN cursor3;
        FETCH cursor3 INTO r;
        
    WHILE cursor3%FOUND LOOP
        IF r.salary < 8000 THEN
            r.salary := r.salary*1.2;
        ELSE
            r.salary := r.salary*1.1;
       END IF; 
       DBMS_OUTPUT.PUT_LINE(r.name||' --> '||r.salary);
       FETCH cursor3 INTO r;
    END LOOP;     
       CLOSE cursor3;
END;










