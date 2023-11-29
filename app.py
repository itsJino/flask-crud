from flask import Flask, request, render_template
from flask_mysqldb import MySQL
from flask_cors import CORS
import json

mysql = MySQL()
app = Flask(__name__)
CORS(app)

# MySQL Instance configurations
app.config['MYSQL_USER'] = 'jino'
app.config['MYSQL_PASSWORD'] = 'secret'
app.config['MYSQL_DB'] = 'student'
app.config['MYSQL_HOST'] = '34.154.116.119'
mysql.init_app(app)

@app.route('/')
def index():
    return render_template('index.html')

def execute_query(query):
    try:
        cur = mysql.connection.cursor()
        print("Executing query:", query)
        cur.execute(query)
        mysql.connection.commit()
        print("Query executed successfully")
        return True
    except Exception as e:
        print("Error:", e)
        return False
    
@app.route("/read", methods=['GET'])  # Default - Show Data
def read():
    try:
        cur = mysql.connection.cursor()
        cur.execute('''SELECT * FROM students''')
        rv = cur.fetchall()
        Results = []
        for row in rv:
            Result = {}
            Result['ID'] = row[0]
            Result['Name'] = row[1].replace('\n', ' ')
            Result['course'] = row[2]
            Result['year'] = row[3]
            Results.append(Result)
        response = {'Results': Results, 'count': len(Results)}
        ret = app.response_class(
            response=json.dumps(response),
            status=200,
            mimetype='application/json'
        )
        return ret
    except Exception as e:
        return '{"Result": "Error", "Message": "' + str(e) + '"}'

@app.route("/add", methods=['POST'])  # Add Student
def add():
    name = request.json.get('name')
    course = request.json.get('course')
    year = request.json.get('year')
    try:
        query = '''INSERT INTO students(studentName, course, year) VALUES('{}', '{}', '{}');'''.format(name, course, year)
        success = execute_query(query)

        if success:
            return '{"Result": "Success"}'
        else:
            return '{"Result": "Error"}'
    except Exception as e:
        return '{"Result": "Error", "Message": "' + str(e) + '"}'

if __name__ == "__main__":
    app.run(host='0.0.0.0', port='8080')