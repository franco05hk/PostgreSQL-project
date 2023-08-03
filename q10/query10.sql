select round(min(f.length)) as min_length, round(max(f.length)) as max_length, round(avg(f.length)) as average_length from film f
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
where c.name='Animation'

--find out the min, max, average length of animation type of film