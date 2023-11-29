CREATE USER 'jino'@'%' IDENTIFIED BY 'secret';
GRANT ALL PRIVILEGES ON *.* to 'jino'@'%';

CREATE DATABASE student; 
USE student;
CREATE TABLE students (studentName VARCHAR(255), email VARCHAR(255), studentID INT NOT NULL AUTO_INCREMENT,
PRIMARY KEY(studentID));

INSERT INTO students (studentName, email) values ("first student", "firststudent@mydomain.ie"); 
INSERT INTO students (studentName, email) values ("second student", "secondstudent@mydomain.ie ");
SELECT * FROM students;
exit;