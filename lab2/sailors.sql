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



drop database if exists sailors;

create database sailors;
use sailors;

create table if not exists Sailors(
	sid int primary key,
	sname varchar(35) not null,
	rating float not null,
	age int not null
);

create table if not exists Boat(
	bid int primary key,
	bname varchar(35) not null,
	color varchar(25) not null
);

create table if not exists reserves(
	sid int not null,
	bid int not null,
	sdate date not null,
	foreign key (sid) references Sailors(sid) on delete cascade,
	foreign key (bid) references Boat(bid) on delete cascade
);

insert into Sailors values
(1,"Albert", 5.0, 40),
(2, "Nakul", 5.0, 49),
(3, "Darshan", 9, 18),
(4, "Astorm Gowda", 2, 68),
(5, "Armstormin", 7, 19);


insert into Boat values
(1,"Boat_1", "Green"),
(2,"Boat_2", "Red"),
(103,"Boat_3", "Blue");

insert into reserves values
(1,103,"2023-01-01"),
(1,2,"2023-02-01"),
(2,1,"2023-02-05"),
(3,2,"2023-03-06"),
(5,103,"2023-03-06"),
(1,1,"2023-03-06");

select * from Sailors;
select * from Boat;
select * from reserves;

--1. Find the colours of the boats reserved by Albert
select color 
from Sailors s, Boat b, reserves r 
where s.sid=r.sid and b.bid=r.bid and s.sname="Albert";

Blue
Red
Green

--2. Find all the sailor sids who have rating atleast 8 or reserved boat 103

(select sid from Sailors where Sailors.rating>=8)
UNION
(select sid from reserves where reserves.bid=103);

3
5

--3. Find the names of the sailor who have not reserved a boat whose name contains the string "storm". Order the name in the ascending order

select s.sname from Sailors s
where s.sid not in 
(select s1.sid from Sailors s1, reserves r1 where r1.sid=s1.sid and s1.sname like "%storm%")
and s.sname like "%storm%"
order by s.sname ASC;

Astorm Gowda
  
--4. Find the name of the sailors who have reserved all boats

select sname from Sailors s where not exists
	(select * from Boat b where not exists
		(select * from reserves r where r.sid=s.sid and b.bid=r.bid));

Albert

--5. Find the name and age of the oldest sailor

select sname, age
from Sailors where age in (select max(age) from Sailors);

+--------------+-----+
| sname        | age |
+--------------+-----+
| Astorm Gowda |  68 |
+--------------+-----+

  --6. For each boat which was reserved by atleast 2 sailors with age >= 40, find the bid and average age of such sailors

  SELECT b.bid, AVG(s.age) AS average_age
FROM Sailors s, Boat b, reserves r
WHERE r.sid = s.sid AND r.bid = b.bid AND s.age >= 40
GROUP BY bid
HAVING 2 <= COUNT(DISTINCT r.sid);

+-----+-------------+
| bid | average_age |
+-----+-------------+
| 103 |        54.5 |
+-----+-------------+

--7. Create a view that shows the names and colours of all the boats that have been reserved by a sailor with a specific rating.

CREATE VIEW ReservedBoatsWithRatedSailor AS
SELECT DISTINCT b.bname, b.color
FROM Sailors s, Boat b, reserves r
WHERE s.sid = r.sid AND b.bid = r.bid AND s.rating = 5;

SELECT * FROM ReservedBoatsWithRatedSailor;

+-------+-------+
| bname | color |
+-------+-------+
| Boat_1 | Green |
| Boat_2 | Red   |
+-------+-------+


  --8. Trigger that prevents boats from being deleted if they have active reservation
  
DELIMITER //
CREATE OR REPLACE TRIGGER CheckAndDelete
BEFORE DELETE ON Boat
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT * FROM reserves WHERE reserves.bid = OLD.bid) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Boat is reserved and hence cannot be deleted';
    END IF;
END;
//

DELIMITER ;
delete from Boat where bid=103;-- This gives error since boat 103 is reserved
