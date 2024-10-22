import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash
from config import Config


class User:
    def __init__(self, username, password, role='user'):
        self.username = username
        self.password = generate_password_hash(password)
        self.role = role

    @staticmethod
    def register(username, password):
        conn = mysql.connector.connect(
            host=Config.DB_HOST,
            user=Config.DB_USER,
            password=Config.DB_PASSWORD,
            database=Config.DB_NAME
        )
        cursor = conn.cursor()

        hashed_password = generate_password_hash(password)
        cursor.execute(
            "INSERT INTO Users (username, password, role) VALUES (%s, %s, %s)",
            (username, hashed_password, 'user')
        )

        conn.commit()
        cursor.close()
        conn.close()

    @staticmethod
    def login(username, password):
        conn = mysql.connector.connect(
            host=Config.DB_HOST,
            user=Config.DB_USER,
            password=Config.DB_PASSWORD,
            database=Config.DB_NAME
        )
        cursor = conn.cursor()

        cursor.execute(
            "SELECT password FROM Users WHERE username = %s", (username,))
        result = cursor.fetchone()

        if result and check_password_hash(result[0], password):
            return True  # Επιστροφή True αν η σύνδεση είναι επιτυχής
        else:
            return False  # Επιστροφή False αν η σύνδεση αποτύχει

    @staticmethod
    def IsAdmin(username):
        conn = mysql.connector.connect(
            host=Config.DB_HOST,
            user=Config.DB_USER,
            password=Config.DB_PASSWORD,
            database=Config.DB_NAME
        )
        cursor = conn.cursor()

        cursor.execute(
            "SELECT role FROM Users WHERE username = %s", (username,))
        result = cursor.fetchone()

        if result[0] == 'Admin':
            return True  # Επιστροφή True αν η σύνδεση είναι επιτυχής
        else:
            return False  # Επιστροφή False αν η σύνδεση αποτύχει
