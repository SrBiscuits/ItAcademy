-- Nivell 1
-- Exercici 1
create database sprint4;
use sprint4;

create table credit_cards(
id varchar(10) primary key,
user_id int,
iban varchar(35),
pan varchar(25),
pin varchar(10),
cvv varchar(5),
track1 varchar(50),
track2 varchar(50),
expiring_date varchar(10)
);

create table companies(
company_id varchar(10) primary key,
company_name varchar(50),
phone varchar(15),
email varchar(60),
country varchar(50),
website varchar(100)
);

create table products(
id int primary key,
product_name varchar(50),
price varchar(20),
colour varchar(30),
weight float,
warehouse_id varchar(50)
);

create table users(
id int primary key,
name varchar(30),
surname varchar(30),
phone varchar(15),
email varchar(100),
birth_date varchar(30),
country varchar(50),
city varchar (50),
postal_code varchar(10),
adress varchar(200)
);

create table transaction(
id varchar(255) primary key,
card_id varchar(10),
business_id varchar(10),
timestamp timestamp,
amount decimal(10,2),
declined boolean,
product_ids varchar(255),
user_id int,
lat float,
longitude float,

foreign key (card_id) references credit_cards(id),
foreign key (user_id) references users(id),
foreign key (business_id) references companies(company_id)
);


LOAD DATA INFILE 'C:\\Users\\xXSrBiscuitXx\\Desktop\\ITACADEMY\\especializacion\\sprint4\\users.csv' 
INTO TABLE users
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE 'C:\\Users\\xXSrBiscuitXx\\Desktop\\ITACADEMY\\especializacion\\sprint4\\credit_cards.csv' 
INTO TABLE credit_cards
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'C:\\Users\\xXSrBiscuitXx\\Desktop\\ITACADEMY\\especializacion\\sprint4\\companies.csv' 
INTO TABLE companies
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'C:\\Users\\xXSrBiscuitXx\\Desktop\\ITACADEMY\\especializacion\\sprint4\\products.csv' 
INTO TABLE products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'C:\\Users\\xXSrBiscuitXx\\Desktop\\ITACADEMY\\especializacion\\sprint4\\transactions.csv' 
INTO TABLE transaction
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';

select users.name, users.surname, subquery.conteo
from (select user_id as id, count(*) as conteo
from transaction
group by user_id
having conteo>30
order by conteo desc) as subquery
join (
 select name,surname, id
 from users
) as users on users.id = subquery.id;

-- Exercici 2
select credit_cards.iban, avg(transaction.amount) as mediaGasto
from transaction
join credit_cards on card_id = credit_cards.id
join companies on business_id = company_id
where company_name="Donec ltd" and declined=0
group by credit_cards.iban;

-- Nivell 2
-- Exercici 1
create table activeCards(
	id varchar(10),
    active bool,
    
    foreign key (id) references credit_cards(id)
);

insert into activeCards (id)
select id from credit_cards;

-- vista -- cardsdeclined
with transacciones_ordenadas as (
    select card_id, timestamp, declined, row_number() over (partition by card_id order by timestamp desc) as rn
    from transaction
)
select card_id
from transacciones_ordenadas
where rn <= 3  -- Solo las 3 últimas transacciones
group by card_id
having sum(case when declined = 1 then 1 else 0 end) = 3; 

update activeCards
left join cardsdeclined on id = card_id
set active = case
    when card_id is not null then false
    else true
end;

select * from activecards;

-- Nivell 3
-- Exercici 1



select product_id, count(*)
from transactions_products
group by product_id;

