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
in , sub query, concat, as

-code: query7-
select c.customer_id, concat(c.first_name, ' ',c.last_name) as customer_fullname, c.email, c.activebool, p.payment_date, row_number() over (order by p.payment_date desc) as latest_purchase
from customer c left join payment p
on c.customer_id=p.customer_id
where c.email like '%@%'
limit 100

-explanation-
Query to find the latest 100 payment with the corresponding customer details including email for further marketing usage

-techniques used-
like, %, limit, concat, left join

-code: query8-
with return_in_may as (
select rental_id, customer_id, extract(month from return_date) as month
from rental
where extract(month from return_date) = 5)

select r.rental_id, r.customer_id, r.month, c.email, concat(c.first_name, ' ', c.last_name) as customer_fullname from return_in_may r
join customer c on r.customer_id=c.customer_id


-explanation-
Query to find the customer fullname, email who returned film in May for marketing purpose

-techniques used-
CTE, join, concat

-code: query9-
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

-explanation-
Query to find out the customer address count in each city_category we want to separate them into for marketing purpose

-techniques used-
case when, like, join, group by, order by

-code: query10-
select round(min(f.length)) as min_length, round(max(f.length)) as max_length, round(avg(f.length)) as average_length from film f
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
where c.name='Animation'

-explanation-
Query to find out the min, max, average length of animation type of film

-techniques used-
round, max, min, avg, join

-code: query11-
with return_in_may as (
select rental_id, customer_id, extract(month from return_date) as month
from rental
where extract(month from return_date) = 5),
 
customer_rental_counts AS (
SELECT customer_id, COUNT(rental_id) AS total_rentals
FROM return_in_may
GROUP BY customer_id)

SELECT
    r.rental_id,
    r.customer_id,
    r.month,
    c.email,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_fullname,
    RANK() OVER (ORDER BY crc.total_rentals DESC) AS customer_rank
FROM
    return_in_may r
JOIN
    customer c ON r.customer_id = c.customer_id
JOIN
    customer_rental_counts crc ON r.customer_id = crc.customer_id
order by customer_rank;


-explanation-
Query to find the ranking of total rentals for those customers which have return some fils within May
findings: same customer details found to registered as diff. customer_id, and the data tells that multiple customers have the same number of total rentals returned in May.

-techniques used-
CTE, rank over
