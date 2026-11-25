-- =========================================================
-- 02_sample_data.sql
-- Fictional sample data for the student_records database.
-- Run after 01_schema.sql, logged in as root.
-- =========================================================

USE student_records;

INSERT INTO students (first_name, last_name, email, programme, year_of_study) VALUES
('Mwila',    'Banda',    'mwila.banda@sample.edu',    'BSc Software Engineering',  3),
('Chanda',   'Mulenga',  'chanda.mulenga@sample.edu', 'BSc Software Engineering',  3),
('Natasha',  'Phiri',    'natasha.phiri@sample.edu',  'BSc Information Technology', 2),
('Kelvin',   'Tembo',    'kelvin.tembo@sample.edu',   'BSc Information Technology', 3),
('Bupe',     'Kabwe',    'bupe.kabwe@sample.edu',     'BSc Computer Science',      1),
('Joseph',   'Zulu',     'joseph.zulu@sample.edu',    'BSc Computer Science',      2),
('Mutinta',  'Hamoonga', 'mutinta.h@sample.edu',      'BSc Software Engineering',  4),
('Lubasi',   'Lungu',    'lubasi.lungu@sample.edu',   'BSc Information Technology', 1),
('Chipo',    'Mwansa',   'chipo.mwansa@sample.edu',   'BSc Software Engineering',  2),
('Daliso',   'Sakala',   'daliso.sakala@sample.edu',  'BSc Computer Science',      3),
('Thandiwe', 'Chirwa',   'thandiwe.c@sample.edu',     'BSc Software Engineering',  3),
('Musonda',  'Kapata',   'musonda.kapata@sample.edu', 'BSc Information Technology', 4);

INSERT INTO courses (course_code, course_title, credits) VALUES
('BIT3360', 'Advanced Databases',              15),
('BSE3340', 'Mobile Application Development',  15),
('BSE3310', 'Object-Oriented Programming',     15),
('BIT2210', 'Computer Networks',               10);

INSERT INTO grades (student_id, course_code, mark) VALUES
(1,  'BIT3360', 72.5), (1,  'BSE3340', 68.0), (1,  'BSE3310', 81.0),
(2,  'BIT3360', 65.0), (2,  'BSE3340', 74.5),
(3,  'BIT2210', 58.0), (3,  'BIT3360', 61.5),
(4,  'BIT3360', 79.0), (4,  'BIT2210', 70.0),
(5,  'BIT2210', 55.5),
(6,  'BSE3310', 63.0), (6,  'BIT2210', 67.5),
(7,  'BIT3360', 88.0), (7,  'BSE3340', 91.0), (7,  'BSE3310', 85.5),
(8,  'BIT2210', 49.0),
(9,  'BSE3310', 71.0), (9,  'BIT3360', 66.0),
(10, 'BIT3360', 77.5), (10, 'BSE3340', 69.0),
(11, 'BSE3340', 82.0), (11, 'BSE3310', 76.5),
(12, 'BIT3360', 59.5), (12, 'BIT2210', 64.0);

-- Quick check: should show 12 students, 4 courses, 24 grades
SELECT (SELECT COUNT(*) FROM students) AS students,
       (SELECT COUNT(*) FROM courses)  AS courses,
       (SELECT COUNT(*) FROM grades)   AS grades;
