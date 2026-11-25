# =========================================================
# secure_login.py  -  SAFE version using a parameterised query
# The query has placeholders (%s). The user's input is sent
# separately as data, so it can never change the SQL itself.
# =========================================================
import mysql.connector
from config import DB_CONFIG


def login(username, password):
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()

    # SAFE: the SQL text is fixed; input goes in as parameters
    query = (
        "SELECT username, role FROM app_users "
        "WHERE username = %s AND password_hash = SHA2(%s, 256)"
    )
    print("\nSQL sent to the database:\n  " + query)
    print(f"Parameters sent separately: {(username, password)}\n")

    cursor.execute(query, (username, password))
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    return user


if __name__ == "__main__":
    print("=== SECURE LOGIN (parameterised query) ===")
    u = input("Username: ")
    p = input("Password: ")
    result = login(u, p)
    if result:
        print(f"LOGIN SUCCESSFUL - welcome {result[0]} (role: {result[1]})")
    else:
        print("LOGIN FAILED - wrong username or password")
