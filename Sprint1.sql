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

select country, avg(amount)
from company
join transaction on company.id = transaction.company_id
where transaction.declined = 0
group by country
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

