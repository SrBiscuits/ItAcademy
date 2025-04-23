-- Nivell 1
-- Exercici 1
CREATE TABLE credit_card (
  id varchar(15) NOT NULL,
  iban varchar(40) DEFAULT NULL,
  pin varchar(10) DEFAULT NULL,
  cvv int DEFAULT NULL,
  expiring_date date NOT NULL,
  PRIMARY KEY (id)
);

alter table transaction add
FOREIGN KEY (credit_card_id) 
REFERENCES credit_card(id); 

show create table credit_card;

-- Exercici 2
UPDATE credit_card
SET iban = "R323456312213576817699999"
WHERE id = 'CcU-2938';

-- Exercici 3
insert into data_user (id,name,surname,phone,email,birth_date,country,city,postal_code,address,personal_emal)
values ('9999',null,null,null,null,null,null,null,null,null,null);

insert into credit_card (id,iban,pin,cvv,expiring_date,fecha_actual)
values ('CcU-9999',null,null,null,'2025-12-12',null);

insert into company (id,company_name,phone,email,country)
values ('b-9999',null,null,null,null);

INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined) 
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', '829.999', '-117.999', null ,'111.11', '0');

-- Exercici 4
alter table credit_card drop pan;
SELECT * FROM transactions.credit_card;

-- Nivell 2
-- Exercici 1
Delete from transaction
WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

-- Exercici 2
create view vistamarketing as
select company_name, phone, country , avg(amount) as average
from company
join transaction on transaction.company_id = company.id
group by transaction.company_id, phone, country
order by average desc;

select * from vistamarketing;

-- Exercici 3
select * from vistamarketing
where country = "Germany";

-- Nivell 3
-- Exercici 1
alter table company drop website;
rename table user to data_user;
alter table data_user add personal_email varchar(100);
alter table credit_card change cvv cvv int;
alter table credit_card add fecha_actual date;

alter table data_user drop
foreign key data_user_ibfk_1;

alter table transaction add
foreign key(user_id)
references data_user(id);

-- Exercici 2
create view informetecnico as
select transaction.id as IdTransaccion, name as Nombre, surname As Apellido, iban as IBAN,
	company_name as NombreCompañia, amount as Cantidad
from transaction
join company on company_id = company.id
join credit_card on credit_card_id=credit_card.id
join data_user on user_id=data_user.id
order by transaction.id desc;

select * from informetecnico;