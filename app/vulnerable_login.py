# =========================================================
# vulnerable_login.py  -  INSECURE on purpose (for the demo)
# Builds the SQL query by gluing the user's input into a string.
# This allows SQL injection.
# =========================================================
import mysql.connector
from config import DB_CONFIG


def login(username, password):
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()

    # DANGER: user input is pasted straight into the SQL text
    query = (
        "SELECT username, role FROM app_users "
        f"WHERE username = '{username}' "
        f"AND password_hash = SHA2('{password}', 256)"
    )
    print("\nSQL sent to the database:\n  " + query + "\n")

    cursor.execute(query)
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    return user


if __name__ == "__main__":
    print("=== VULNERABLE LOGIN ===")
    u = input("Username: ")
    p = input("Password: ")
    result = login(u, p)
    if result:
        print(f"LOGIN SUCCESSFUL - welcome {result[0]} (role: {result[1]})")
    else:
        print("LOGIN FAILED - wrong username or password")
