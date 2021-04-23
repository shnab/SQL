
















DROP FUNCTION addf;

CREATE OR REPLACE FUNCTION addf (num1 NUMBER, num2 NUMBER)
RETURN NUMBER IS 
BEGIN 
    RETURN num1+num2;
END;

EXECUTE DBMS_OUTPUT.PUT_LINE(addf(10,20));

CREATE OR REPLACE FUNCTION getName(id CHAR)
RETURN VARCHAR2 IS
s_name students.std_name%TYPE;
BEGIN
    SELECT std_name 
    INTO s_name
    FROM students
    WHERE std_id= id;
    RETURN s_name;
END;

EXECUTE DBMS_OUTPUT.PUT_LINE(getName(101));
DROP FUNCTION getName;

		--Create a procedure to find the minimum one of 2 numbers
CREATE OR REPLACE PROCEDURE findMin(x IN NUMBER, y IN NUMBER, z OUT NUMBER) IS
BEGIN
    IF x<y THEN
       z :=x;
    ELSE 
       z :=y; 
    END IF;
END;

DROP PROCEDURE findMin;

		--Create a procedure to get the name and grade of a sudents table when yu enter student id
CREATE OR REPLACE PROCEDURE getNameGrade(id IN CHAR, name OUT VARCHAR, grade OUT NUMBER) IS
BEGIN
    SELECT std_name, std_grade
    INTO name, grade
    FROM students
    WHERE std_id = id;
END;










SELECT first_name, last_name, salary 
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

CREATE TABLE words
(
    word_id CHAR(3),
    word VARCHAR2(15),
    word_length NUMBER(2)
);

INSERT INTO words VALUES('101', 'hat', 3);
INSERT INTO words VALUES('102', 'hot', 3);
INSERT INTO words VALUES('103', 'hit', 3);
INSERT INTO words VALUES('104', 'hut', 3);
INSERT INTO words VALUES('104', 'selena', 6);
INSERT INTO words VALUES('104', 'yusuf', 5);
INSERT INTO words VALUES('104', 'adem', 4);
INSERT INTO words VALUES('104', 'hct', 3);











