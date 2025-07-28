create database sprint10;

create table SP500(
Date date,
Open float,
High float,
Low float,
Close float,
Volume float,
Day smallint,
Weekday smallint,
Week smallint,
Month smallint,
Year smallint
);

create table ibex35(
Date date,
Open float,
High float,
Low float,
Close float,
AdjClose float,
Volume float
);

LOAD DATA INFILE 'C:\\Users\\xXSrBiscuitXx\\Desktop\\ITACADEMY\\especializacion\\sprint4\\spy.csv' 
INTO TABLE SP500
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
ignore 1 rows;

LOAD DATA INFILE 'C:\\Users\\xXSrBiscuitXx\\Desktop\\ITACADEMY\\especializacion\\sprint4\\IBEX-1994-2020.csv' 
INTO TABLE ibex35
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
ignore 1 rows;

select * from sp500;
select * from ibex35;
