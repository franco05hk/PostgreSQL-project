select distinct staff_id, concat(first_name, ' ', last_name) as staff_fullname, username, active from staff
where staff_id in
(select staff_id from rental)
and 
staff_id in
(select staff_id from payment)

--to check the list of unique staff, their fullname, user id in system and their active status