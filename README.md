# postgresql sample project

For learning purpose, this project is going to explore some sql findings in DVD rental database.

details and download link of the dataset:
https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/

## 📚 Introduction
This is a hands-on application of PostgreSQL for learning purpose. 

Tables in the dataset: 'actor', 'film', 'film_actor', 'category', 'film_category', 'store', 'inventory', 'rental', 'payment', 'staff', 'customer', 'address', 'city', and 'country'. 

## 🎯 Objective
- Implement SQL querying techniques to explore and manipulate the data.
- Utilize PostgreSQL database system for managing and interacting with the data.
- Leverage Git commands for version control and effective collaboration.
- Maintain comprehensive project documentation and a well-structured code repository here on GitHub.

## 📃 Query Abstract
Query 1:
Retrieve film details released in 2006 with a rental rate above 4 in English, sorting by length and title.
'select f.film_id, f.title as name_of_film, f.release_year, f.length, f.description, l.name as language,f.rental_rate
from film f join language l
on f.language_id=l.language_id
where release_year=2006
and length > 140
and f.language_id=1
and f.rental_rate>4
order by f.length desc, f.title'
<br>Query 2:
Identify the top 10 actors involved in the most films, showcasing the count of their film involvements.
'select concat(a.first_name, ' ' ,a.last_name) as actor_fullname , count(f.title)
from actor a
join film_actor fm
on a.actor_id=fm.actor_id
join film f 
on fm.film_id=f.film_id
group by actor_fullname
order by count(f.title) desc
limit 10'
<br>Query 3:
Calculate the count of films per category with the highest replacement cost, ordered by the count.
'select c.name as film_category, count(f.title) as number_of_film from film f
left join film_category fc
on f.film_id=fc.film_id
left join category c
on fc.category_id=c.category_id
where replacement_cost = 29.99
group by film_category
order by number_of_film desc'
<br>Query 4:
Count films by rating with a rental rate between 0.99 and 2.99, grouped by rating.
'select count(title), rating from film
where rental_rate between 0.99 and 2.99
group by rating'
<br>Query 5:
Determine the count of unique actors involved in action movies.
'select count(distinct(fa.actor_id)) from film_actor fa 
right join film f on fa.film_id=f.film_id
right join film_category fc on fa.film_id=fc.film_id
right join category c on fc.category_id=c.category_id
where c.category_id=1'
<br>Query 6:
List staff members who have completed at least one transaction in both rentals and payments, including their details.
'select distinct staff_id, concat(first_name, ' ', last_name) as staff_fullname, username, active from staff
where staff_id in
(select staff_id from rental)
and 
staff_id in
(select staff_id from payment)'
<br>Query 7:
Obtain customer details along with the latest 100 payment dates and their corresponding email addresses.
'select c.customer_id, concat(c.first_name, ' ',c.last_name) as customer_fullname, c.email, c.activebool, p.payment_date, row_number() over (order by p.payment_date desc) as latest_purchase
from customer c left join payment p
on c.customer_id=p.customer_id
where c.email like '%@%'
limit 100'
<br>Query 8:
Find customer details of those who returned films in May, including email addresses.
'with return_in_may as (
select rental_id, customer_id, extract(month from return_date) as month
from rental
where extract(month from return_date) = 5)

select r.rental_id, r.customer_id, r.month, c.email, concat(c.first_name, ' ', c.last_name) as customer_fullname from return_in_may r
join customer c on r.customer_id=c.customer_id'

<br>Query 9:
Group customer addresses into city categories (A, B, C, and others) and count customers in each category.
'select count(c.customer_id), 
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
order by city_category'

<br>Query 10:
Calculate statistics for animation film lengths, including min, max, and average lengths.
'select round(min(f.length)) as min_length, round(max(f.length)) as max_length, round(avg(f.length)) as average_length from film f
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
where c.name='Animation''

<br>Query 11:
Rank customers based on their total rentals returned in May, even when customers have the same rental count.
'with return_in_may as (
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
order by customer_rank;'
## 🔧 Tool
- PostgreSQL (Version: 7.3)
- Git (Version: 3.2.7)

## 📊 DVD Rental ER Model
<p align="center">
  <img src="https://github.com/gordonkwokkwok/DVD-Rental-PostgreSQL-Project/assets/112631794/5c55cbde-9e67-4363-99bc-177bf7903882" alt="Image" width="700">
</p>

## 📃 DVD Rental Database Tables
There are 15 tables in the DVD Rental database:

- actor – stores actors data including first name and last name.
- film – stores film data such as title, release year, length, rating, etc.
- film_actor – stores the relationships between films and actors.
- category – stores film’s categories data.
- film_category- stores the relationships between films and categories.
- store – contains the store data including manager staff and address.
- inventory – stores inventory data.
- rental – stores rental data.
- payment – stores customer’s payments.
- staff – stores staff data.
- customer – stores customer data.
- address – stores address data for staff and customers
- city – stores city names.
- country – stores country names.

📝 To restore a .tar file in pgAdmin, follow these steps:
```
1. First, you need to convert the dvdrental.zip file into a dvdrental.tar file. You can use a compression tool like 7-Zip or WinRAR to extract the contents of the dvdrental.zip file. Once extracted, you can create a new archive and save it as dvdrental.tar.

2. Open pgAdmin and connect to your PostgreSQL database server.

3. In the left column of pgAdmin, locate the "Servers" group and expand it. Then expand the server you want to restore the dvdrental.tar file to.

4. Right-click on the "Databases" option under the server and select "Restore..." from the context menu.

5. In the "Restore" dialog box, navigate to the location where you have the dvdrental.tar file saved. Select the file and click on the "OK" or "Open" button to start the restore process.

6. Configure the restore options as needed. You can specify the target database, choose whether to drop existing objects, set the format to "Custom or Tar," and adjust other options according to your requirements.

7. Click the "Restore" button to initiate the restore process. pgAdmin will read the dvdrental.tar file and restore the database schema and data accordingly.

8. Once the restore process completes, you should see a success message indicating that the restore was successful.
```
By following these steps, you will be able to restore the dvdrental.tar file in pgAdmin and have the database available for use.

## 👥 Contributer
- Franco Fan

##  Queries and explanations
Please check in 'overview of queries.md'

##  Output
Output cvs is stored in the Q folders
