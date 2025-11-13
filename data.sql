
-- 1.Departments
INSERT INTO DEPARTMENTS VALUES (10, 'Computer Science and Engineering', 'CSE', 'Dr. Alan Turing', 'cse.office@college.edu');
INSERT INTO DEPARTMENTS VALUES (20, 'Electronics and Communication', 'ECE', 'Dr. Ada Lovelace', 'ece.office@college.edu');
INSERT INTO DEPARTMENTS VALUES (30, 'Information Technology', 'IT', 'Dr. Linus Torvalds', 'it.office@college.edu');

-- 2.Courses
INSERT INTO COURSES VALUES (101, 'B.Tech Computer Science', 'CSE', 4, 10);
INSERT INTO COURSES VALUES (102, 'B.Tech Electronics', 'ECE', 4, 20);
INSERT INTO COURSES VALUES (103, 'M.Tech Data Science', 'CSE', 2, 10);
INSERT INTO COURSES VALUES (104, 'B.Tech Information Tech', 'IT', 4, 30);

-- 3.Subjects
INSERT INTO SUBJECTS VALUES (1001, 'Data Structures', 101, 100, 35, 10);
INSERT INTO SUBJECTS VALUES (1002, 'Database Systems', 101, 100, 35, 10);
INSERT INTO SUBJECTS VALUES (1003, 'Machine Learning', 103, 100, 40, 10);
INSERT INTO SUBJECTS VALUES (2001, 'Digital Logic', 102, 100, 35, 20);
INSERT INTO SUBJECTS VALUES (2002, 'Signals and Systems', 102, 100, 40, 20);
INSERT INTO SUBJECTS VALUES (3001, 'Web Programming', 104, 100, 35, 30);
INSERT INTO SUBJECTS VALUES (3002, 'Cloud Computing', 104, 100, 40, 30);

-- 4.Students
INSERT INTO STUDENTS VALUES (1, 'Alice', 'Smith', TO_DATE('2003-05-15', 'YYYY-MM-DD'), 'alice.s@mail.com', '9991112222', 'F', 101, 10);
INSERT INTO STUDENTS VALUES (2, 'Bob', 'Johnson', TO_DATE('2004-02-20', 'YYYY-MM-DD'), 'bob.j@mail.com', '9992223333', 'M', 101, 10);
INSERT INTO STUDENTS VALUES (3, 'Charlie', 'Lee', TO_DATE('2003-11-01', 'YYYY-MM-DD'), 'charlie.l@mail.com', '9993334444', 'M', 102, 20);
INSERT INTO STUDENTS VALUES (4, 'David', 'Brown', TO_DATE('2002-07-30', 'YYYY-MM-DD'), 'david.b@mail.com', '9994445555', 'M', 103, 10);
INSERT INTO STUDENTS VALUES (5, 'Emma', 'Wilson', TO_DATE('2003-09-18', 'YYYY-MM-DD'), 'emma.w@mail.com', '9995556666', 'F', 104, 30);

-- 5.Exams
INSERT INTO EXAMS VALUES (501, 'Semester 1 - Mid Term', TO_DATE('2025-10-15', 'YYYY-MM-DD'), 101);
INSERT INTO EXAMS VALUES (502, 'Semester 1 - Final', TO_DATE('2025-12-20', 'YYYY-MM-DD'), 101);
INSERT INTO EXAMS VALUES (503, 'Semester 1 - Mid Term', TO_DATE('2025-10-15', 'YYYY-MM-DD'), 102);
INSERT INTO EXAMS VALUES (504, 'Semester 1 - Final', TO_DATE('2025-12-20', 'YYYY-MM-DD'), 104);

-- 6.Teachers
INSERT INTO TEACHERS VALUES (701, 'Prof. Robert Martin', 'rmartin@college.edu', 1002);
INSERT INTO TEACHERS VALUES (702, 'Prof. Grace Hopper', 'ghopper@college.edu', 1001);
INSERT INTO TEACHERS VALUES (703, 'Prof. Charles Babbage', 'cbabbage@college.edu', 2001);
INSERT INTO TEACHERS VALUES (704, 'Prof. Linus Torvalds', 'ltorvalds@college.edu', 3001);

-- 7.Results
INSERT INTO RESULTS VALUES (10001, 1, 1001, 502, 85, 'A');
INSERT INTO RESULTS VALUES (10002, 1, 1002, 502, 92, 'A+');
INSERT INTO RESULTS VALUES (10003, 2, 1001, 502, 76, 'B+');
INSERT INTO RESULTS VALUES (10004, 2, 1002, 502, 65, 'B');
INSERT INTO RESULTS VALUES (10005, 3, 2001, 503, 88, 'A');
INSERT INTO RESULTS VALUES (10006, 3, 2002, 503, 34, 'F');
INSERT INTO RESULTS VALUES (10007, 5, 3001, 504, 90, 'A+');
INSERT INTO RESULTS VALUES (10008, 5, 3002, 504, 82, 'A');

COMMIT;