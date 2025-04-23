-- NIVELL 1
-- Exercici 1 
select * from company;
select * from transaction;

-- Exercici 2
select distinct country 
from company
join transaction on company.id = company_id;

select count(distinct country)
from company
join transaction on company_id = company.id;

select company_name, avg(amount) as average
from company
join transaction on company.id = company_id
where declined = 0
group by company_name
order by avg(amount) desc
limit 1;

-- Exercici 3
select *
from transaction
where company_id IN ( 
	select company.id
    from company 
    where country="Germany");

select company_name
from company
where id in (
	select company_id
	from transaction
	where amount > (
		select avg(amount)
		from transaction));
        
select company_name
from company
where not exists(
	select 1
    from transaction
    where company.id = company_id);
    
-- NIVELL 2
-- Exercici 1 
select date(timestamp) ,sum(amount) as media
from transaction
group by date(timestamp)
order by sum(amount) desc
limit 5;

-- Exercici 2
select country, round(avg(amount),2) as media
from transaction
join company on company.id = company_id
group by country
order by avg(amount) desc;

-- Exercici 3
select *
from (select *
from company
where country in(
	select country
	from company 
	where company_name="Non Institute"
)) as subquery
join transaction on company_id = subquery.id;

select *
from transaction
where company_id IN ( 
	select company.id
    from company 
    where country in(
		select country
        from company 
        where company_name="Non Institute"
));

-- NIVELL 3
-- Exercici 1
select company_name, phone, country, date(timestamp) as date, amount
from company
join transaction on company.id=transaction.company_id
where amount between 100 and 200 and( 
date(transaction.timestamp) in ("2021-04-29","2021-07-20", "2022-03-13"))
order by amount desc;

-- Exercici 2
select company_name, count(company_id),
case
	when count(company_id) < 4 then "Tiene menos de 4"
    else "Tiene más de 4"
end as cantidad_transacciones
from company
join transaction on company.id = company_id
group by company_id
order by count(company_id) desc;

