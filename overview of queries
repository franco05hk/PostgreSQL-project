-code: query1-
select f.film_id, f.title as name_of_film, f.release_year, f.length, f.description, l.name as language,f.rental_rate
from film f join language l
on f.language_id=l.language_id
where release_year=2006
and length > 140
and f.language_id=1
and f.rental_rate>4
order by f.length desc, f.title

-explanation-
Query to find the film details which they are release in 2006 with a rental rate more than 4 and in english language, which sorting from the longest film length to the smallest and also sort by film name alphabetically if there's more than 1 film with the same film length

-techniques used-
where, order by

-code: query2-
select concat(a.first_name, ' ' ,a.last_name) as actor_fullname , count(f.title)
from actor a
join film_actor fm
on a.actor_id=fm.actor_id
join film f 
on fm.film_id=f.film_id
group by actor_fullname
order by count(f.title) desc
limit 10

-explanation-
Query to find out the top 10 actors that involve in multiple films and the count of the films, starting from the largest count of involvement

-techniques used-
join, group by, order by, limit

-code: query3-
select c.name as film_category, count(f.title) as number_of_film from film f
left join film_category fc
on f.film_id=fc.film_id
left join category c
on fc.category_id=c.category_id
where replacement_cost = 29.99
group by film_category
order by number_of_film desc

-explanation-
Query to find out the number of counts for each film category of highest replacement cost(29.99)

-techniques used-
left join, group by, order by

-code: query4-
select count(title), rating from film
where rental_rate between 0.99 and 2.99
group by rating

-explanation-
Query to find out the count of film by rating which is having a low rental rate

-techniques used-
count, between, group by

-code: query5-
select count(distinct(fa.actor_id)) from film_actor fa 
right join film f on fa.film_id=f.film_id
right join film_category fc on fa.film_id=fc.film_id
right join category c on fc.category_id=c.category_id
where c.category_id=1

-explanation-
Query to find out how many unique actors participants in filming action movies

-techniques used-
count, distinct, right join

-code: query6-
select distinct staff_id, concat(first_name, ' ', last_name) as staff_fullname, username, active from staff
where staff_id in
(select staff_id from rental)
and 
staff_id in
(select staff_id from payment)

-explanation-
Query to find out the list of unique staff, their fullname, user id in system and their active status which had completed at least 1 transaction in both rental and payment

-techniques used-
in 
