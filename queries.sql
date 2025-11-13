--Basic Level Queries
-- 1 Retrieve all students enrolled.
SELECT student_id, first_name, last_name, email FROM STUDENTS;

-- 2 List all subjects under the 'B.Tech Computer Science' course.
SELECT subject_id, subject_name, max_marks, min_marks
FROM SUBJECTS
WHERE course_id = 101;

-- 3 Get all students belonging to the 'CSE' department.
SELECT first_name, last_name, email
FROM STUDENTS
WHERE dept_id = 10;

-- 4 Display all courses and their corresponding departments.
SELECT c.course_name, d.dept_name
FROM COURSES c
JOIN DEPARTMENTS d ON c.dept_id = d.dept_id;

-- 5 Show all teachers and the subjects they teach.
SELECT t.name AS teacher_name, s.subject_name
FROM TEACHERS t
JOIN SUBJECTS s ON t.subject_id = s.subject_id
ORDER BY t.name;

--
--Intermediate Level Queries
--
-- 6 Show a student's marks and subjects (Student ID = 1)
SELECT s.first_name, s.last_name, sub.subject_name, r.marks_obtained, r.grade
FROM STUDENTS s
JOIN RESULTS r ON s.student_id = r.student_id
JOIN SUBJECTS sub ON r.subject_id = sub.subject_id
WHERE s.student_id = 1;

-- 7 List all student results for Exam ID = 502
SELECT s.first_name || ' ' || s.last_name AS student_name,
       sub.subject_name, e.exam_name, r.marks_obtained, r.grade
FROM RESULTS r
JOIN STUDENTS s ON r.student_id = s.student_id
JOIN SUBJECTS sub ON r.subject_id = sub.subject_id
JOIN EXAMS e ON r.exam_id = e.exam_id
WHERE r.exam_id = 502
ORDER BY r.marks_obtained DESC;

-- 8 Find total marks obtained by each student in Exam 502
SELECT s.student_id, s.first_name, s.last_name,
       SUM(r.marks_obtained) AS total_marks
FROM STUDENTS s
JOIN RESULTS r ON s.student_id = r.student_id
WHERE r.exam_id = 502
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY total_marks DESC;

-- 9 Calculate average marks per subject
SELECT s.subject_name, ROUND(AVG(r.marks_obtained), 2) AS avg_marks
FROM RESULTS r
JOIN SUBJECTS s ON r.subject_id = s.subject_id
GROUP BY s.subject_name
ORDER BY avg_marks DESC;

-- 10 List all teachers teaching subjects in CSE department
SELECT t.name, s.subject_name, d.dept_name
FROM TEACHERS t
JOIN SUBJECTS s ON t.subject_id = s.subject_id
JOIN DEPARTMENTS d ON s.dept_id = d.dept_id
WHERE d.dept_code = 'CSE';

--
--Advanced Level Queries
--
-- 11 Find students who failed any subject
SELECT DISTINCT s.student_id, s.first_name, s.last_name,
       sub.subject_name, r.marks_obtained, sub.min_marks
FROM STUDENTS s
JOIN RESULTS r ON s.student_id = r.student_id
JOIN SUBJECTS sub ON r.subject_id = sub.subject_id
WHERE r.marks_obtained < sub.min_marks
ORDER BY s.student_id;

-- 12 Compute total marks, percentage, and overall pass/fail for each student in Exam 502
WITH ExamMarks AS (
    SELECT r.student_id, r.marks_obtained, sub.max_marks,
           CASE WHEN r.marks_obtained < sub.min_marks THEN 0 ELSE 1 END AS pass_status
    FROM RESULTS r
    JOIN SUBJECTS sub ON r.subject_id = sub.subject_id
    WHERE r.exam_id = 502
)
SELECT s.student_id, s.first_name || ' ' || s.last_name AS student_name,
       SUM(em.marks_obtained) AS total_marks,
       SUM(em.max_marks) AS max_marks,
       ROUND((SUM(em.marks_obtained)*100)/SUM(em.max_marks), 2) AS percentage,
       CASE WHEN MIN(em.pass_status) = 0 THEN 'FAIL' ELSE 'PASS' END AS overall_status
FROM STUDENTS s
JOIN ExamMarks em ON s.student_id = em.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY percentage DESC;

-- 13 Get the student with highest marks in Exam 502
SELECT s.first_name, s.last_name, SUM(r.marks_obtained) AS total_marks
FROM STUDENTS s
JOIN RESULTS r ON s.student_id = r.student_id
WHERE r.exam_id = 502
GROUP BY s.first_name, s.last_name
ORDER BY total_marks DESC
FETCH FIRST 1 ROW ONLY;

-- 14 Find all subjects that have no assigned teachers
SELECT s.subject_id, s.subject_name, c.course_name
FROM SUBJECTS s
JOIN COURSES c ON s.course_id = c.course_id
WHERE NOT EXISTS (
    SELECT 1 FROM TEACHERS t WHERE t.subject_id = s.subject_id
);

-- 15 Find courses with no students enrolled
SELECT c.course_id, c.course_name
FROM COURSES c
WHERE NOT EXISTS (
    SELECT 1 FROM STUDENTS s WHERE s.course_id = c.course_id
);

-- 16 Generate leaderboard for Exam 502 with ranks
WITH StudentTotals AS (
    SELECT student_id, SUM(marks_obtained) AS total_marks
    FROM RESULTS
    WHERE exam_id = 502
    GROUP BY student_id
)
SELECT DENSE_RANK() OVER (ORDER BY total_marks DESC) AS rank,
       s.first_name || ' ' || s.last_name AS student_name,
       st.total_marks
FROM StudentTotals st
JOIN STUDENTS s ON s.student_id = st.student_id
ORDER BY rank;

-- 17 Find subject with the lowest average marks (only subjects with >1 student)
SELECT s.subject_name, ROUND(AVG(r.marks_obtained), 2) AS avg_marks
FROM RESULTS r
JOIN SUBJECTS s ON r.subject_id = s.subject_id
GROUP BY s.subject_name
HAVING COUNT(r.student_id) > 1
ORDER BY avg_marks ASC
FETCH FIRST 1 ROW ONLY;

-- 18 UNION Example: List all distinct names of teachers and students
SELECT name FROM TEACHERS
UNION
SELECT first_name || ' ' || last_name FROM STUDENTS;

-- 19 Subquery Example: Find students who scored above the average in DBMS (subject_id = 1002)
SELECT s.first_name, s.last_name, r.marks_obtained
FROM RESULTS r
JOIN STUDENTS s ON s.student_id = r.student_id
WHERE r.subject_id = 1002
  AND r.marks_obtained > (SELECT AVG(marks_obtained) FROM RESULTS WHERE subject_id = 1002);

-- 20 CASE Example: Assign grade category based on percentage
SELECT s.first_name, s.last_name,
       ROUND((SUM(r.marks_obtained)*100)/SUM(sub.max_marks), 2) AS percentage,
       CASE
           WHEN (SUM(r.marks_obtained)*100)/SUM(sub.max_marks) >= 85 THEN 'Distinction'
           WHEN (SUM(r.marks_obtained)*100)/SUM(sub.max_marks) >= 70 THEN 'First Class'
           WHEN (SUM(r.marks_obtained)*100)/SUM(sub.max_marks) >= 50 THEN 'Second Class'
           ELSE 'Fail'
       END AS classification
FROM STUDENTS s
JOIN RESULTS r ON s.student_id = r.student_id
JOIN SUBJECTS sub ON r.subject_id = sub.subject_id
GROUP BY s.first_name, s.last_name
ORDER BY percentage DESC;
