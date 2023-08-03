select c.name as film_category, count(f.title) as number_of_film from film f
left join film_category fc
on f.film_id=fc.film_id
left join category c
on fc.category_id=c.category_id
where replacement_cost = 29.99
group by film_category
order by number_of_film desc
--Find out how the distribution is for the film category for those films with the highest replacement cost(29.99)