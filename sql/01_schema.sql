-- =========================================================
-- 01_schema.sql
-- BIT3360 Advanced Databases - Database Security Prototype
-- Creates the student_records database and its tables.
-- Run this first, logged in as root.
-- =========================================================

DROP DATABASE IF EXISTS student_records;
CREATE DATABASE student_records;
USE student_records;

-- Students enrolled at the college
CREATE TABLE students (
    student_id   INT AUTO_INCREMENT PRIMARY KEY,
    first_name   VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    email        VARCHAR(100) NOT NULL UNIQUE,
    programme    VARCHAR(100) NOT NULL,
    year_of_study TINYINT     NOT NULL CHECK (year_of_study BETWEEN 1 AND 5)
);

-- Courses offered
CREATE TABLE courses (
    course_code  VARCHAR(10)  PRIMARY KEY,
    course_title VARCHAR(100) NOT NULL,
    credits      TINYINT      NOT NULL
);

-- Marks each student got in each course
CREATE TABLE grades (
    grade_id     INT AUTO_INCREMENT PRIMARY KEY,
    student_id   INT         NOT NULL,
    course_code  VARCHAR(10) NOT NULL,
    mark         DECIMAL(5,2) NOT NULL CHECK (mark BETWEEN 0 AND 100),
    FOREIGN KEY (student_id)  REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_code) REFERENCES courses(course_code) ON DELETE CASCADE,
    UNIQUE (student_id, course_code)
);

-- Login accounts for the small Python app (used in the SQL injection demo).
-- Passwords are stored as bcrypt hashes, never plain text.
-- This table is filled by the Python setup script, not here.
CREATE TABLE app_users (
    user_id       INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role          ENUM('admin', 'lecturer', 'student') NOT NULL
);
