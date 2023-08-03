select c.customer_id, concat(c.first_name, ' ',c.last_name) as customer_fullname, c.email, c.activebool, p.payment_date, row_number() over (order by p.payment_date desc) as latest_purchase
from customer c left join payment p
on c.customer_id=p.customer_id
where c.email like '%@%'
limit 100

--find the latest 100 payment with the corresponding customer details including email for further marketing usage