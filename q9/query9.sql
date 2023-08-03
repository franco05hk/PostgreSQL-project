select count(c.customer_id), 
case
when ct.city like 'A%' Then 'A cities'
when ct.city like 'B%' Then 'B cities'
when ct.city like 'C%' Then 'C cities'
else 'others'
end as city_category
from address a 
join customer c on a.address_id=c.address_id
join city ct on a.city_id=ct.city_id
group by city_category
order by city_category

--find out the customer address count in each city_category we want to separate them into for marketing purpose