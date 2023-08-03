
with return_in_may as (
select rental_id, customer_id, extract(month from return_date) as month
from rental
where extract(month from return_date) = 5)

select r.rental_id, r.customer_id, r.month, c.email, concat(c.first_name, ' ', c.last_name) as customer_fullname from return_in_may r
join customer c on r.customer_id=c.customer_id
