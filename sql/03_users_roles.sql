-- =========================================================
-- 03_users_roles.sql
-- Creates roles and users with different permissions
-- (principle of least privilege).
-- Run after 02_sample_data.sql, logged in as root.
-- Safe to re-run: it drops the users/roles first.
-- =========================================================

USE student_records;

-- ---------- Clean up (so the script can be re-run) ----------
DROP USER IF EXISTS 'admin1'@'localhost', 'lecturer1'@'localhost',
                    'student1'@'localhost', 'app_user'@'localhost';
DROP ROLE IF EXISTS 'admin_role', 'lecturer_role', 'student_role', 'app_role';

-- ---------- 1. Create roles ----------
CREATE ROLE 'admin_role', 'lecturer_role', 'student_role', 'app_role';

-- Admin: full control of the student_records database
GRANT ALL PRIVILEGES ON student_records.* TO 'admin_role';

-- Lecturer: can view records and enter/update marks,
-- but cannot delete anything or change table structure
GRANT SELECT ON student_records.students TO 'lecturer_role';
GRANT SELECT ON student_records.courses  TO 'lecturer_role';
GRANT SELECT, INSERT, UPDATE ON student_records.grades TO 'lecturer_role';

-- Student: can only view the list of courses
GRANT SELECT ON student_records.courses TO 'student_role';

-- Python app account: can only read and add login accounts
-- (the app never needs to touch grades or student records)
GRANT SELECT, INSERT ON student_records.app_users TO 'app_role';

-- ---------- 2. Create users ----------
CREATE USER 'admin1'@'localhost'    IDENTIFIED BY 'Admin#2026';
CREATE USER 'lecturer1'@'localhost' IDENTIFIED BY 'Lecturer#2026';
CREATE USER 'student1'@'localhost'  IDENTIFIED BY 'Student#2026';
CREATE USER 'app_user'@'localhost'  IDENTIFIED BY 'AppUser#2026';

-- ---------- 3. Assign roles to users ----------
GRANT 'admin_role'    TO 'admin1'@'localhost';
GRANT 'lecturer_role' TO 'lecturer1'@'localhost';
GRANT 'student_role'  TO 'student1'@'localhost';
GRANT 'app_role'      TO 'app_user'@'localhost';

-- Roles are not active on login unless set as default
SET DEFAULT ROLE ALL TO 'admin1'@'localhost', 'lecturer1'@'localhost',
                        'student1'@'localhost', 'app_user'@'localhost';

-- ---------- 4. Check what each user is allowed to do ----------
SHOW GRANTS FOR 'admin1'@'localhost'    USING 'admin_role';
SHOW GRANTS FOR 'lecturer1'@'localhost' USING 'lecturer_role';
SHOW GRANTS FOR 'student1'@'localhost'  USING 'student_role';
SHOW GRANTS FOR 'app_user'@'localhost'  USING 'app_role';
