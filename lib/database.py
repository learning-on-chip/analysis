import sqlite3

class Database:
    def execute(path, code, *arguments):
        connection = sqlite3.connect(path)
        cursor = connection.cursor()
        cursor.execute(code, arguments)
        result = cursor.fetchall()
        connection.close()
        return result
