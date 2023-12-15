select * from TEXT AS T
    -> JOIN BOOK_ADOPTION AS BT USING(book_ISBN)
    -> JOIN COURSE58 AS C USING (course)
    -> where C.dept = 'HISTORY';
+--------+-----------+---------------+-----------+---------+------+---------------+---------+
| course | book_ISBN | title         | publisher | author  | sem  | cname         | dept    |
+--------+-----------+---------------+-----------+---------+------+---------------+---------+
|   1002 |      2002 | World History | Mark      | Mitchel |    2 | World History | History |
+--------+-----------+---------------+-----------+---------+------+---------------+---------+

SELECT
    e.course,
    c.cname AS subject,
    s.regno,
    s.name AS student_name,
    e.marks
FROM
    ENROLL e
JOIN
    COURSE58 c ON e.course = c.course
JOIN
    STUDENT s ON e.regno = s.regno
JOIN
    (
        SELECT
            course,
            MAX(marks) AS max_marks
        FROM
            ENROLL
        GROUP BY
            course
    ) max_marks_per_course ON e.course = max_marks_per_course.course AND e.marks = max_marks_per_course.max_marks;

+--------+----------------------------------+-------+--------------+-------+
| course | subject                          | regno | student_name | marks |
+--------+----------------------------------+-------+--------------+-------+
|   1001 | Computer Science and engineering | S1    | JOHN         |    90 |
|   1002 | World History                    | S2    | PETER        |    91 |
|   1003 | Physical Chemistry               | S3    | JACK         |    92 |
|   1004 | Calculus                         | S4    | YASH         |    93 |
|   1005 | Quantum Physics                  | S5    | KEVIN        |    94 |
+--------+----------------------------------+-------+--------------+-------+
  
SELECT
    e.course,
    c.cname AS subject,
    s.regno,
    s.name AS student_name,
    e.marks
FROM
    ENROLL e
JOIN
    COURSE58 c ON e.course = c.course
JOIN
    STUDENT s ON e.regno = s.regno
JOIN
    (
        SELECT
            course,
            MIN(marks) AS min_marks
        FROM
            ENROLL
        GROUP BY
            course
    ) min_marks_per_course ON e.course = min_marks_per_course.course AND e.marks = min_marks_per_course.min_marks;

+--------+----------------------------------+-------+--------------+-------+
| course | subject                          | regno | student_name | marks |
+--------+----------------------------------+-------+--------------+-------+
|   1001 | Computer Science and engineering | S1    | JOHN         |    90 |
|   1002 | World History                    | S2    | PETER        |    91 |
|   1003 | Physical Chemistry               | S3    | JACK         |    92 |
|   1004 | Calculus                         | S4    | YASH         |    93 |
|   1005 | Quantum Physics                  | S5    | KEVIN        |    94 |
+--------+----------------------------------+-------+--------------+-------+
  
select cname,COUNT(*)
    -> from COURSE58
    -> join ENROLL USING(course)
    -> GROUP BY cname;
+----------------------------------+----------+
| cname                            | COUNT(*) |
+----------------------------------+----------+
| Computer Science and engineering |        1 |
| World History                    |        1 |
| Physical Chemistry               |        1 |
| Calculus                         |        1 |
| Quantum Physics                  |        1 |
+----------------------------------+----------+

SELECT
    e.course,
    c.cname AS subject,
    s.regno,
    s.name AS student_name,
    e.marks
FROM
    ENROLL e
JOIN
    COURSE58 c ON e.course = c.course
JOIN
    STUDENT s ON e.regno = s.regno
JOIN
    (
        SELECT
            course,
            AVG(marks) AS avg_marks
        FROM
            ENROLL
        GROUP BY
            course
    ) avg_marks_per_course ON e.course = avg_marks_per_course.course AND e.marks = avg_marks_per_course.avg_marks;

+--------+----------------------------------+-------+--------------+-------+
| course | subject                          | regno | student_name | marks |
+--------+----------------------------------+-------+--------------+-------+
|   1001 | Computer Science and engineering | S1    | JOHN         |    90 |
|   1002 | World History                    | S2    | PETER        |    91 |
|   1003 | Physical Chemistry               | S3    | JACK         |    92 |
|   1004 | Calculus                         | S4    | YASH         |    93 |
|   1005 | Quantum Physics                  | S5    | KEVIN        |    94 |
+--------+----------------------------------+-------+--------------+-------+

select * from STUDENT where bdate LIKE '2000%';
+-------+-------+----------+------------+
| regno | name  | major    | bdate      |
+-------+-------+----------+------------+
| S1    | JOHN  | COMPUTER | 2000-03-15 |
| S2    | PETER | HISTORY  | 2000-03-16 |
+-------+-------+----------+------------+

 SELECT * FROM COURSE58  WHERE course BETWEEN 1000 AND 1003;
+--------+----------------------------------+------------------+
| course | cname                            | dept             |
+--------+----------------------------------+------------------+
|   1001 | Computer Science and engineering | Computer Science |
|   1002 | World History                    | History          |
|   1003 | Physical Chemistry               | Chemistry        |
+--------+----------------------------------+------------------+

select publisher, COUNT(*)
    -> FROM TEXT
    -> GROUP BY publisher
    -> ORDER BY publisher;
+-----------+----------+
| publisher | COUNT(*) |
+-----------+----------+
| david     |        1 |
| Mark      |        1 |
| root      |        1 |
| Smith     |        1 |
| tom       |        1 |
+-----------+----------+

select title,author from TEXT JOIN BOOK_ADOPTION USING (book_ISBN) JOIN COURSE58 USING (course) WHERE dept = 'Computer Science';
+------------------+--------+
| title            | author |
+------------------+--------+
| Programming in C | Henry  |
+------------------+--------+

SELECT *
    -> FROM TEXT
    -> WHERE book_ISBN NOT IN (SELECT book_ISBN FROM BOOK_ADOPTION);
Empty set (0.00 sec)

SELECT major, COUNT(*) AS num_students
    -> FROM STUDENT
    -> GROUP BY major;
+-----------+--------------+
| major     | num_students |
+-----------+--------------+
| COMPUTER  |            1 |
| HISTORY   |            1 |
| chemistry |            1 |
| maths     |            1 |
| physics   |            1 |
+-----------+--------------+

SELECT c.course, c.cname AS course_name, AVG(e.marks) AS avg_marks
FROM COURSE58 c
LEFT JOIN ENROLL e ON c.course = e.course
GROUP BY c.course, c.cname;
+--------+----------------------------------+-----------+
| course | course_name                      | avg_marks |
+--------+----------------------------------+-----------+
|   1001 | Computer Science and engineering |   90.0000 |
|   1002 | World History                    |   91.0000 |
|   1003 | Physical Chemistry               |   92.0000 |
|   1004 | Calculus                         |   93.0000 |
|   1005 | Quantum Physics                  |   94.0000 |
+--------+----------------------------------+-----------+
SELECT s.regno, s.name AS student_name, c.cname AS course_name
FROM STUDENT s
JOIN ENROLL e ON s.regno = e.regno
JOIN COURSE58 c ON e.course = c.course;
+-------+--------------+----------------------------------+
| regno | student_name | course_name                      |
+-------+--------------+----------------------------------+
| S1    | JOHN         | Computer Science and engineering |
| S2    | PETER        | World History                    |
| S3    | JACK         | Physical Chemistry               |
| S4    | YASH         | Calculus                         |
| S5    | KEVIN        | Quantum Physics                  |
+-------+--------------+----------------------------------+

--------------------------------------------------------------------------------------------------------------

SELECT s.regno, s.name AS student_name, s.major, c.course, c.cname AS course_name
FROM STUDENT s
JOIN ENROLL e ON s.regno = e.regno
JOIN COURSE58 c ON e.course = c.course OR c.dept = s.major;

+-------+--------------+-----------+--------+----------------------------------+
| regno | student_name | major     | course | course_name                      |
+-------+--------------+-----------+--------+----------------------------------+
| S1    | JOHN         | COMPUTER  |   1001 | Computer Science and engineering |
| S2    | PETER        | HISTORY   |   1002 | World History                    |
| S3    | JACK         | chemistry |   1003 | Physical Chemistry               |
| S4    | YASH         | maths     |   1004 | Calculus                         |
| S5    | KEVIN        | physics   |   1005 | Quantum Physics                  |
+-------+--------------+-----------+--------+----------------------------------+

SELECT c.course, c.cname AS course_name
FROM COURSE58 c
WHERE NOT EXISTS (
    SELECT e.course
    FROM ENROLL e
    WHERE e.course = c.course AND e.marks <= 92
);

+--------+-----------------+
| course | course_name     |
+--------+-----------------+
|   1004 | Calculus        |
|   1005 | Quantum Physics |
+--------+-----------------+



