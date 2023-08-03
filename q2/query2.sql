select concat(a.first_name, ' ' ,a.last_name) as actor_fullname , count(f.title)
from actor a
join film_actor fm
on a.actor_id=fm.actor_id
join film f 
on fm.film_id=f.film_id
group by actor_fullname
order by count(f.title) desc
limit 10
--find out the top 10 actors that involve in multiple films and the count of the films