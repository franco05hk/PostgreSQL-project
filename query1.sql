select f.film_id, f.title as name_of_film, f.release_year, f.length, f.description, l.name as language,f.rental_rate
from film f join language l
on f.language_id=l.language_id
where release_year=2006
and length > 140
and f.language_id=1
and f.rental_rate>4
order by f.length desc, f.title
--finding the film details which they are release in 2006 with a rental rate more than 4 and in english language, which sorting from the longest film length to the smallest and also sort by film name alphabetically if there's more than 1 film with the same film length


