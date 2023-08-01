select min(length(last_name))from customer

select * from actor a
where a.first_name = ANY (select first_name from customer)

select * from film 
where rating = 'PG' Or rating = 'G'
order by rating

select * from customer
where first_name ilike 'T%'

select * from film
where length(description) between 50 and 70
