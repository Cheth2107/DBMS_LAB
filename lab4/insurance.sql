CREATE DATABASE insurance;

USE insurance;

CREATE TABLE person(
	ID VARCHAR(50) PRIMARY KEY,
	name VARCHAR(50),
	address VARCHAR(100)
);

CREATE TABLE car(
	regno VARCHAR(50) PRIMARY KEY,
	model VARCHAR(50),
	year INT
);

CREATE TABLE accident(
	report_number INT PRIMARY KEY,
	acc_date VARCHAR(50),
	location VARCHAR(50)
);

CREATE TABLE owns(
	ID VARCHAR(50),
	regno VARCHAR(50),
	PRIMARY KEY(ID, regno),
	FOREIGN KEY(ID) REFERENCES person(ID),
	FOREIGN KEY(regno) REFERENCES car(regno)
);

CREATE TABLE participated(
	ID VARCHAR(50),
	regno VARCHAR(50),
	report_number INT,
	damage_amt INT,
	PRIMARY KEY(ID,regno,report_number),
	FOREIGN KEY(ID) REFERENCES person(ID),
	FOREIGN KEY(regno) REFERENCES car(regno),
	FOREIGN KEY(report_number) REFERENCES accident(report_number)
);

INSERT INTO person(ID, name, address)
VALUES
('D01','JOHN','hebbal'),
('D02','JAMES','RK Nagar'),
('D03','JACK','Vijaynagar'),
('D04','ROCK','Jayanagar'),
('D05','PETER','VV Puram');

SELECT * FROM person;

D01	JOHN	hebbal
D02	JAMES	RK Nagar
D03	JACK	Vijaynagar
D04	ROCK	Jayanagar
D05	PETER	VV Puram

INSERT INTO car(regno, model,year)
VALUES
('R01','ferrari','2007'),
('R02','limo','2007'),
('R03','lamborgini','2007'),
('R04','mercedes','2007'),
('R05','porche','2007');

SELECT * FROM car;

R01	ferrari	2007
R02	limo	2007
R03	lamborgini	2007
R04	mercedes	2007
R05	porche	2007

INSERT INTO accident(report_number, acc_date, location)
VALUES
(117,'2023-05-11','street A'),
(118,'2023-05-13','street B'),
(119,'2023-05-14','street C'),
(110,'2023-05-15','street D'),
(120,'2023-05-12','street E');

SELECT * FROM accident;

110	2023-05-15	street D
117	2023-05-11	street A
118	2023-05-13	street B
119	2023-05-14	street C
120	2023-05-12	street E

INSERT INTO owns(ID, regno)
VALUES
('D01','R01'),
('D02','R02'),
('D03','R03'),
('D04','R04'),
('D05','R05');

SELECT * FROM owns;

D01	R01
D02	R02
D03	R03
D04	R04
D05	R05

INSERT INTO participated(ID, regno, report_number, damage_amt)
VALUES
('D01','R01','117','5500'),
('D02','R02','118','6500'),
('D03','R03','119','7500'),
('D04','R04','110','8500'),
('D05','R05','120','9500');

SELECT * FROM participated;

D01	R01	117	5500
D02	R02	118	6500
D03	R03	119	7500
D04	R04	110	8500
D05	R05	120	9500

ALTER TABLE participated
ADD payment VARCHAR(50);

