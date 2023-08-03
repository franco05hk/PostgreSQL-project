select count(title), rating from film
where rental_rate between 0.99 and 2.99
group by rating
--to check the distribution of film by rating count, to see if any rating films are more likely to have a low rental rate