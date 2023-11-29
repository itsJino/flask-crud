CREATE USER 'jino'@'%' IDENTIFIED BY 'secret';
GRANT ALL PRIVILEGES ON *.* to 'jino'@'%';

CREATE DATABASE student; 
USE student;

CREATE TABLE students (studentID INT NOT NULL AUTO_INCREMENT, studentName VARCHAR(255), course VARCHAR(255), year INT,
PRIMARY KEY(studentID));

INSERT INTO students (studentName, course, year) values ("first student", "Computer Science", 1); 
INSERT INTO students (studentName, course, year) values ("second student", "Physics", 3);

exit;
