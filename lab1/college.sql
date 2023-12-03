-- Create a table for the structure Student with attributes as SID, NAME, 
-- BRANCH, SEMESTER, ADDRESS, PHONE, EMAIL, Insert atleast 10 
-- tuples and performthe following operationsusing SQL.
-- a. Insert a new student
-- b. Modify the address of the student based on SID
-- c. Delete a student
-- d. List all the students
-- e. List all the students of CSE branch.
-- f. List all the students of CSE branch and reside in Kuvempunagar.

create database college;

use college;

create table student(
  SID INT PRIMARY key,
  name varchar(50),
  branch varchar(50),
  semester INT NOT NULL,
  address varchar(50),
  phone INT,
  email varchar(50)
  );

-- inserting the values to table student

  INSERT into student(SID,name,branch,semester,address,phone,email)
  VALUES
    (001,'arun','CSE',5,'hebbal',111111111,'arun@gmail.com'),
    (002,'ajay','CSE',4,'rk nagar',222222222,'ajay@gmail.com'),
    (003,'akhil','CSE',3,'kuvempunagar',3333333333,'akhiln@gmail.com'),
    (004,'aron','EC',2,'kuvempunagar',44444444444,'aron@gmail.com'),
    (005,'adi','ISE',1,'kuvempunagar',55555555555,'adi@gmail.com');

--listing all the students 

    SELECT * from student;

--adding a new student

    INSERT into student(SID,name,branch,semester,address,phone,email)
  	VALUES
    (006,'lucy','CSE',5,'hsr layout',666666666,'lucy@gmail.com');
    
    SELECT * from student;

-- updating the address based on SID

    update student
    set address = "kuvempunagar"
    WHERE SID = 001;
    
    SELECT * from student;

-- updating the branch based on SID
    update student
    set branch = "ctm"
    where SID = 006;
    
    select  * from student;

--deleting the student based on SID

    delete from student
    where SID = 001;
    
    SELECT * from student;
    
    INSERT into student(SID,name,branch,semester,address,phone,email)
  	VALUES
    (001,'arun','CSE',5,'kuvempunagar',1111111111,'arun@gmail.com');
    
    SELECT * from student;

--printing students from CSE

    SELECT * from student
    where branch = "CSE";

--printing  students from kuvempunagar

    SELECT * from student
    where address = "kuvempunagar";
