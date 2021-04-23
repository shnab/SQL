--Drop workers and changes tables if you have on Schema
--Create workers and changes tables
DROP TABLE workers;
DROP TABLE changes;
CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5)
);

SELECT * FROM workers;

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
?
--Create a record level trigger like 
--When you DELETE or INSERT any record it will be triggered
--It will store deleted or inserted records with the statement name into "changes" table
--Use sequence and date in records table
?
CREATE SEQUENCE seq_changes;
?
CREATE OR REPLACE TRIGGER w_di_trigger BEFORE DELETE OR INSERT ON workers FOR EACH ROW
BEGIN
    IF :old.id IS NULL THEN
        INSERT INTO changes VALUES(seq_changes.NEXTVAL, 'Inserted', :new.id, :new.name, :new.salary, sysdate);
    ELSE
        INSERT INTO changes VALUES(seq_changes.NEXTVAL, 'Deleted', :old.id, :old.name, :old.salary, sysdate);
    END IF;
END;
?
SELECT * FROM workers;
SELECT * FROM changes;
?
INSERT INTO workers VALUES('10005', 'Tom Hanks', 11000);
?
DELETE FROM workers
WHERE id = 10001;