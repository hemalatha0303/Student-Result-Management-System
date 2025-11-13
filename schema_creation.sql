-- =============================================================
-- 1.DEPARTMENTS TABLE
-- =============================================================
CREATE TABLE DEPARTMENTS (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(50) NOT NULL UNIQUE,
    dept_code VARCHAR2(10) UNIQUE,
    hod_name VARCHAR2(50),
    office_email VARCHAR2(50)
);

-- =============================================================
-- 2.COURSES TABLE
-- =============================================================
CREATE TABLE COURSES (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(50) NOT NULL,
    department VARCHAR2(10),
    duration_years NUMBER(1),
    dept_id NUMBER,
    CONSTRAINT fk_course_dept FOREIGN KEY (dept_id)
        REFERENCES DEPARTMENTS(dept_id) ON DELETE SET NULL
);

-- =============================================================
-- 3. SUBJECTS TABLE
-- =============================================================
CREATE TABLE SUBJECTS (
    subject_id NUMBER PRIMARY KEY,
    subject_name VARCHAR2(50) NOT NULL,
    course_id NUMBER,
    max_marks NUMBER(3) DEFAULT 100,
    min_marks NUMBER(3) DEFAULT 35,
    dept_id NUMBER,
    CONSTRAINT fk_subject_course FOREIGN KEY (course_id)
        REFERENCES COURSES(course_id) ON DELETE CASCADE,
    CONSTRAINT fk_subject_dept FOREIGN KEY (dept_id)
        REFERENCES DEPARTMENTS(dept_id) ON DELETE SET NULL
);

-- =============================================================
-- 4.STUDENTS TABLE
-- =============================================================
CREATE TABLE STUDENTS (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(30) NOT NULL,
    last_name VARCHAR2(30) NOT NULL,
    dob DATE,
    email VARCHAR2(50) UNIQUE,
    phone VARCHAR2(15),
    gender CHAR(1),
    course_id NUMBER,
    dept_id NUMBER,
    CONSTRAINT fk_student_course FOREIGN KEY (course_id)
        REFERENCES COURSES(course_id) ON DELETE SET NULL,
    CONSTRAINT fk_student_dept FOREIGN KEY (dept_id)
        REFERENCES DEPARTMENTS(dept_id) ON DELETE SET NULL
);

-- =============================================================
-- 5.EXAMS TABLE
-- =============================================================
CREATE TABLE EXAMS (
    exam_id NUMBER PRIMARY KEY,
    exam_name VARCHAR2(50) NOT NULL,
    exam_date DATE,
    course_id NUMBER,
    CONSTRAINT fk_exam_course FOREIGN KEY (course_id)
        REFERENCES COURSES(course_id) ON DELETE CASCADE
);

-- =============================================================
-- 6.TEACHERS TABLE
-- =============================================================
CREATE TABLE TEACHERS (
    teacher_id NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    email VARCHAR2(50) UNIQUE,
    subject_id NUMBER,
    CONSTRAINT fk_teacher_subject FOREIGN KEY (subject_id)
        REFERENCES SUBJECTS(subject_id) ON DELETE SET NULL
);

-- =============================================================
-- 7.RESULTS TABLE
-- =============================================================
CREATE TABLE RESULTS (
    result_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    subject_id NUMBER,
    exam_id NUMBER,
    marks_obtained NUMBER(3),
    grade CHAR(2),
    CONSTRAINT fk_result_student FOREIGN KEY (student_id)
        REFERENCES STUDENTS(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_result_subject FOREIGN KEY (subject_id)
        REFERENCES SUBJECTS(subject_id) ON DELETE CASCADE,
    CONSTRAINT fk_result_exam FOREIGN KEY (exam_id)
        REFERENCES EXAMS(exam_id) ON DELETE CASCADE
);
