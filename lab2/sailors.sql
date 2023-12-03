-- Data Definition Language (DDL) commands in RDBMS

--Consider the database schemas given below.

-- Write ER diagram and schema diagram. The primary keys are 

--underlined and the data types are specified.

--Create tables for the following schema listed below by properly 

--specifying the primary keys and foreign keys.

--Enter at least five tuples for each relation.

--Altering tables,

--Adding and Dropping different types of constraints.

--Also adding and dropping fields in to the relational schemas of the listed
--problems.

--Delete, Update operations

--  A.Sailors database

--SAILORS (sid, sname, rating, age)

--BOAT(bid, bname, color)

--RSERVERS (sid, bid, date)



CREATE database sailors;
USE sailors;

create table sailors(
  sid INT PRIMARY key,
  sname VARCHAR(50),
  rating INT,
  age INT
  );
  
  create table boat(
    bid INT PRIMARY key,
    bname VARCHAR(50),
    color VARCHAR(20)
    );
    
  create table rservers(
    sid INT,
    bid INT,
    date DATE,
    PRIMARY key(sid),
    FOREIGN key(sid) REFERENCES sailors(sid),
    FOREIGN key(bid) REFERENCES boat(bid)
    );
    
INSERT into sailors(sid, sname, rating, age)
VALUES
(601,'john', 7.8, 26),
(602,'james', 8.8, 26),
(603,'jack', 5.8, 26),
(604,'peter', 6.8, 26),
(605,'tyler', 7.5, 26);

INSERT into boat(bid, bname, color)
VALUES
(801,'boat1',red),
(802,'boat2',blue),
(803,'boat3',red),
(804,'boat4',yellow),
(805,'boat5',green);

INSERT into rservers(sid, bid, date)
VALUES
(601,801,2023-01-10),
(602,802,2023-02-11),
(603,803,2023-03-12),
(604,804,2023-04-13),
(605,805,2023-05-14);

SELECT * from sailors;

SELECT * from boat;

SELECT * from rservers;

