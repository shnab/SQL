SELECT * FROM students03;

SELECT * FROM Diary;

    SELECT
        s.std_name,
        s.grade,
        d.diary_name 
    FROM
        Students03 s FULL 
    JOIN
        Diary d 
            ON s.id = d.student_id;
            
SELECT * FROM students04;

SELECT * FROM books04;

SELECT s.name, b.book_name
FROM students04 s INNER JOIN books04 b
ON s.std_id = b.student_id;


SELECT s.name, b.book_name, b.book_id
FROM students04 s LEFT JOIN books04 b
ON s.std_id = b.student_id;

SELECT s.name, b.book_name, b.book_id
FROM students04 s RIGHT JOIN books04 b
ON s.std_id = b.student_id;

SELECT s.name, b.book_name, b.book_id \r\n"
			+ "FROM Students04 s FULL JOIN FETCH Books04 b\r\n"
			+ "ON s.std_id = b.student;
            
DELETE FROM books04;

