-- How to Create Table in Oracle SQL
?
CREATE TABLE students
(
student_id NUMBER(4),
student_name VARCHAR2(50),
grade CHAR(2),
address VARCHAR2(80),
date_of_birth DATE
);
?
--Create workers table which has SSN(char), salary(numeric), name(varchar2), hiring_date(date)
CREATE TABLE workers
(
    ssn CHAR(9),
    salary NUMBER(7,2),
    name VARCHAR2(50),
    hiring_date DATE
);
?
--Insert data into workers table
INSERT INTO workers VALUES('123456789', 20000.00, 'Ali Can', '11-Jan-18');
INSERT INTO workers VALUES('234567891', 13000.50, 'Veli Han', '23-Oct-20');
?
--Insert partial data for a worker
INSERT INTO workers(ssn, name) VALUES('345678912', 'Mary Star');
INSERT INTO workers(ssn, name, hiring_date) VALUES('456789123', 'Angie Ocean', '23-Apr-17');
?
--How to see table with all data
SELECT * FROM workers;


-- Create student table with id(char) ==> 

CREATE TABLE studentss (

    id CHAR(4) PRIMARY KEY,
    name VARCHAR2(50) UNIQUE,
    gpa number (3,2) NOT NULL,
    date_of_birth date
);

INSERT INTO studentss VALUES ('1234', 'Ali CAN', 2.57, '11-Jul-02');
INSERT INTO studentss VALUES ('1235', null, 4.00, '11-Jul-03');
INSERT INTO studentss VALUES ('1236', null, 3.00, '11-Jul-01');

SELECT * FROM studentss;

