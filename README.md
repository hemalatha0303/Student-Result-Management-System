# Student Result Management System (SQL + Oracle)

## Overview

The **Student Result Management System (SRMS)** is a **relational database project** designed to efficiently store, manage, and query student academic data.  
It covers **departments, courses, subjects, teachers, exams, and student results**, ensuring data integrity and logical relationships across all entities.

This system helps administrators, teachers, and students easily:
- Record marks and grades
- Track performance
- Manage courses and exams
- Generate analytical insights

---

## Database Design

### Entities and Relationships

| Entity | Description |
|--------|--------------|
| **DEPARTMENTS** | Represents each department (e.g., CSE, ECE, IT) |
| **COURSES** | Represents degree programs offered by departments |
| **SUBJECTS** | Contains subject details for each course |
| **TEACHERS** | Stores faculty details who handle subjects |
| **STUDENTS** | Records student information and their course/department |
| **EXAMS** | Holds exam information for each subject/course |
| **RESULTS** | Stores student marks, grades, and exam results |

---

### Relationships Between Entities

| Relationship | Type | Example |
|---------------|------|----------|
| Department → Course | 1-to-many | One department has many courses |
| Course → Subject | 1-to-many | One course includes many subjects |
| Department → Student | 1-to-many | CSE dept has many students |
| Course → Student | 1-to-many | B.Tech CSE course has many students |
| Subject → Teacher | 1-to-1 / 1-to-many | Each subject taught by one teacher |
| Course + Subject → Exam | 1-to-many | DBMS (subject) under CSE course has multiple exams |
| Student + Subject + Exam → Result | many-to-one (composite relationship) | Each result entry belongs to one student, subject, and exam |

---

## Database Schema (DDL)

The database uses **7 main tables**:

- **DEPARTMENTS**
- **COURSES**
- **SUBJECTS**
- **TEACHERS**
- **STUDENTS**
- **EXAMS**
- **RESULTS**

Each table includes **primary keys**, **foreign keys**, and **indexes** for efficient data retrieval.

To create all tables, run the SQL script:

> @schema.sql
