--PACKAGES
?
--Benefits of using Packages
    --1)It makes the organization well
    --2)It makes the search easy
    --3)It improves the performance
    
--1.Step: Create the Package
CREATE OR REPLACE PACKAGE workers_package AS
?
    --To add worker into workers table
    PROCEDURE addWorker(w_id workers.id%TYPE, w_name workers.name%TYPE, w_salary workers.salary%TYPE);
    
    --To delete workers from workers table
    PROCEDURE delWorker(w_id workers.id%TYPE);
?
    --To list all workers from workers table
    PROCEDURE listWorkers;
    
    --To list a worker with his/her id
    PROCEDURE getWorker(w_id workers.id%TYPE);
    
    --To update all salary
    PROCEDURE updateSalary2;
?
END workers_package;
?
--2.Step: Create the Package Body
CREATE OR REPLACE PACKAGE BODY workers_package AS
?
    PROCEDURE addWorker(w_id workers.id%TYPE, w_name workers.name%TYPE, w_salary workers.salary%TYPE) IS
    BEGIN
        INSERT INTO workers VALUES(w_id, w_name, w_salary);
        DBMS_OUTPUT.PUT_LINE(w_id||' is added into the workers table');
    END addWorker;
?
    PROCEDURE delWorker(w_id workers.id%TYPE) IS
    BEGIN
        DELETE FROM workers WHERE id = w_id;
    END delWorker;
    
    PROCEDURE listWorkers IS
        CURSOR w_cursor IS SELECT * FROM workers;
    BEGIN
        FOR r IN w_cursor LOOP
            DBMS_OUTPUT.PUT_LINE(r.id||' - '||r.name||' - '||r.salary);
        EXIT WHEN w_cursor%NOTFOUND; 
        END LOOP;
            DBMS_OUTPUT.PUT_LINE('All workers are listed');
    END listWorkers;
    
    PROCEDURE getWorker(w_id workers.id%TYPE) IS
        CURSOR w_cursor2 IS SELECT * FROM workers;
    BEGIN    
        FOR r IN w_cursor2 LOOP
            IF r.id = w_id THEN
                DBMS_OUTPUT.PUT_LINE(r.id||' - '||r.name||' - '||r.salary);
            END IF;    
            EXIT WHEN w_cursor2%NOTFOUND; 
        END LOOP;    
    END getWorker;   
    
    PROCEDURE updateSalary2 IS
    BEGIN
        test_package.updatesalary;
    END;      
END workers_package;
?
--3.Step: Use the things which are in the workers_package
BEGIN
    --workers_package.listWorkers;
    
    --workers_package.addworker(10005, 'Tom Hanks', 11000);
    
    --workers_package.delWorker(10005);
    
    --workers_package.listWorkers;
    
    workers_package.getworker(10002);
    
    --test_package.updatesalary;
    
    workers_package.updatesalary2;
END;
?
?
--Create a new package
CREATE OR REPLACE PACKAGE test_package AS
?
    --To update salary of all workers
    PROCEDURE updateSalary;
?
END test_package;
?
--Create the body of the new package
CREATE OR REPLACE PACKAGE BODY test_package AS
    
    PROCEDURE updateSalary IS
    BEGIN
        UPDATE workers
        SET salary = salary + 300;
    END;
?
END test_package;
?
SELECT * FROM workers;



