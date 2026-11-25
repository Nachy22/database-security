-- =========================================================
-- 05_app_users.sql
-- Adds login accounts for the Python app.
-- Passwords are stored as SHA-256 hashes, never as plain text.
-- Run as root, after 03_users_roles.sql.
-- =========================================================

USE student_records;

DELETE FROM app_users;

INSERT INTO app_users (username, password_hash, role) VALUES
('admin',    SHA2('Admin@123',    256), 'admin'),
('mwila',    SHA2('Lecturer@123', 256), 'lecturer'),
('chanda',   SHA2('Student@123',  256), 'student');

-- Check: you should see 3 users and long scrambled hashes, not the passwords
SELECT username, password_hash, role FROM app_users;
