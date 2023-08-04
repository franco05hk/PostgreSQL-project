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

--find the ranking of total rentals for those customers which have return some fils within May
--findings: same customer details found to registered as diff. customer_id, and the data tells that multiple customers have the same number of total rentals returned in May.