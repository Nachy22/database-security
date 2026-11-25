# Connection settings shared by both login programs.
# The app logs in as 'app_user', which can ONLY read and add
# rows in the app_users table (least privilege). It never uses root.

DB_CONFIG = {
    "host": "localhost",
    "port": 3306,
    "user": "app_user",
    "password": "AppUser#2026",
    "database": "student_records",
}
