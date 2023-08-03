select count(distinct(fa.actor_id)) from film_actor fa 
right join film f on fa.film_id=f.film_id
right join film_category fc on fa.film_id=fc.film_id
right join category c on fc.category_id=c.category_id
where c.category_id=1

--find out how many unique actors participants in filming action movies
