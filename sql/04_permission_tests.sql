-- =========================================================
-- 04_permission_tests.sql
-- Demonstrates what each user CAN and CANNOT do.
-- Do NOT run this whole file as root.
-- Connect as each user in turn and run ONLY that user's section,
-- one statement at a time. Screenshot each result for the slides.
-- Expected results are noted next to each statement.
-- =========================================================

-- =========================================================
-- SECTION A: connect as  student1  (password: Student#2026)
-- =========================================================
USE student_records;

SELECT * FROM courses;                                   -- ✅ ALLOWED
SELECT * FROM grades;                                    -- ❌ DENIED (SELECT command denied)
SELECT * FROM students;                                  -- ❌ DENIED
UPDATE grades SET mark = 100 WHERE student_id = 1;       -- ❌ DENIED (UPDATE command denied)
DELETE FROM courses WHERE course_code = 'BIT2210';       -- ❌ DENIED (DELETE command denied)


-- =========================================================
-- SECTION B: connect as  lecturer1  (password: Lecturer#2026)
-- =========================================================
USE student_records;

SELECT s.first_name, s.last_name, g.course_code, g.mark  -- ✅ ALLOWED
FROM grades g JOIN students s ON s.student_id = g.student_id
WHERE g.course_code = 'BIT3360';

UPDATE grades SET mark = 75.0                            -- ✅ ALLOWED
WHERE student_id = 2 AND course_code = 'BIT3360';

INSERT INTO grades (student_id, course_code, mark)       -- ✅ ALLOWED
VALUES (5, 'BIT3360', 60.0);

DELETE FROM grades WHERE student_id = 8;                 -- ❌ DENIED (DELETE command denied)
UPDATE students SET programme = 'X' WHERE student_id = 1;-- ❌ DENIED (UPDATE command denied)
DROP TABLE grades;                                       -- ❌ DENIED (DROP command denied)


-- =========================================================
-- SECTION C: connect as  admin1  (password: Admin#2026)
-- =========================================================
USE student_records;

SELECT * FROM students;                                  -- ✅ ALLOWED
INSERT INTO courses VALUES ('BIT3399', 'Test Course', 5);-- ✅ ALLOWED
DELETE FROM courses WHERE course_code = 'BIT3399';       -- ✅ ALLOWED (clean-up)
CREATE USER 'hacker'@'localhost' IDENTIFIED BY 'x';      -- ❌ DENIED: admin1 controls this
                                                         --    database, not the whole server
