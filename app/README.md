# Database Security Prototype
BIT3360 Advanced Databases – Group Assignment (Database Security)

A small student-records database that demonstrates two security measures:
1. **Access control:** users with different permissions (least privilege), using MySQL roles.
2. **Parameterised queries:** a Python login app shown in a vulnerable version and a secure version, to demonstrate SQL injection and how to prevent it.

All data is fictional sample data. Security tests were carried out only on this database.

## Tools used
- MySQL Server 26.7 (Community)
- VS Code with the *Database Client* (MySQL) extension
- Python 3 with `mysql-connector-python`

## Folder structure
```
database-security/
  sql/
    01_schema.sql           creates the student_records database and tables
    02_sample_data.sql      12 students, 4 courses, 24 grades
    03_users_roles.sql      roles, users and their permissions
    04_permission_tests.sql what each user can and cannot do
    05_app_users.sql        login accounts for the Python app (hashed passwords)
  app/
    config.py               connection settings (app connects as app_user, not root)
    vulnerable_login.py     login built by joining strings (open to SQL injection)
    secure_login.py         same login using a parameterised query
  README.md
```

## Setup
1. Run `01` → `02` → `03` → `05` in order, logged in as **root**.
2. Install the Python library: `pip install mysql-connector-python`

## Database users and permissions
| User | Password | Role | Can | Cannot |
|---|---|---|---|---|
| admin1 | Admin#2026 | admin_role | Everything in `student_records` | Create server users |
| lecturer1 | Lecturer#2026 | lecturer_role | View students/courses/grades, add and update marks | Delete grades, edit students, drop tables |
| student1 | Student#2026 | student_role | View courses | View grades or students, change anything |
| app_user | AppUser#2026 | app_role | Read and add rows in `app_users` | Touch any other table |

## Demo 1: permissions
Log in as each user and run that user's section of `04_permission_tests.sql`.
Allowed statements succeed; denied statements return `ERROR 1142 … command denied`
(or `ERROR 1227` for `CREATE USER` as admin1).

## Demo 2: SQL injection vs. parameterised queries
From the `app` folder:

| Program | Username | Password | Result |
|---|---|---|---|
| `python vulnerable_login.py` | `admin` | `Admin@123` | Login successful (normal) |
| `python vulnerable_login.py` | `admin'#` | anything | **Login successful – attack works** |
| `python secure_login.py` | `admin'#` | anything | **Login failed – attack blocked** |

**Why:** in the vulnerable version, `'#` closes the username and turns the password
check into a comment. In the secure version the input is sent separately from the SQL
as data, so it can never change the query.

App logins: `admin / Admin@123`, `mwila / Lecturer@123`, `chanda / Student@123`.

## Limitations
- Passwords are hashed with unsalted SHA-256 to keep the demo simple. A real system
  should use a salted, slow hash such as bcrypt or Argon2.
- Database passwords are stored in `config.py`; a real app would use environment variables.
