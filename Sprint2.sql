-- NIVELL 1
-- Exercici 1 
select * from company;
select * from transaction;

-- Exercici 2
select distinct country 
from company
join transaction on company.id = transaction.company_id;

select count(distinct country)
from company;

select company_name, avg(amount)
from company
join transaction on company.id = transaction.company_id
where transaction.declined = 0
group by company_name
order by avg(amount) desc
limit 1;

-- Exercici 3
select *
from transaction
where transaction.company_id IN ( 
	select company.id
    from company 
    where company.country="Germany");

select company.company_name
from company
where company.id in (
	select transaction.company_id
	from transaction
	where transaction.amount > (
		select avg(amount)
		from transaction));
        
select company.company_name
from company
where not exists(
	select 1
    from transaction
    where company.id = transaction.company_id);
    
select company.company_name
from company
where company.id not in(
	select transaction.company_id
    from transaction);
    
-- NIVELL 2
-- Exercici 1 
select date(timestamp) ,sum(amount)
from transaction
group by date(timestamp)
order by sum(amount) desc
limit 5;

-- Exercici 2
select country, avg(amount)
from transaction
join company on company.id = transaction.company_id
group by country
order by avg(amount) desc;

-- Exercici 3
select *
from (select *
from company
where company_name="Non Institute") as subquery
join transaction on transaction.company_id = subquery.id;

select *
from transaction
where transaction.company_id IN ( 
	select company.id
    from company 
    where company.company_name="Non Institute");

-- NIVELL 3
-- Exercici 1
select company.company_name, company.phone, company.country, date(transaction.timestamp) as date, transaction.amount
from company
join transaction on company.id=transaction.company_id
where amount between 100 and 200 and( 
date(transaction.timestamp) like "2021-04-29" or date(transaction.timestamp) like "2021-07-20" or date(transaction.timestamp) like "2022-03-13")
order by amount desc;

-- Exercici 2
select company_name, count(company_id),
case
	when count(company_id) < 4 then "Tiene menos de 4"
    else "Tiene más de 4"
end as cantidad_transacciones
from company
join transaction on company.id = transaction.company_id
group by company_name
order by count(company_id) desc;

