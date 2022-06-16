use sakila;


/*1. How many copies of the film Hunchback Impossible exist in the inventory system?*/
select  f.title,  count(i.film_id) as films_availables
from (inventory as i) 
left join (film as f) using(film_id)
where f.title = "Hunchback Impossible" ;

select count(film_id) as number_copies
from inventory
where film_id = (select film_id
				 from film
				 where title = 'Hunchback Impossible');


/*2. List all films whose length is longer than the average of all the films.  */
select title
from film
where length > ( select avg(length) as avg_length
				 from film );

/*3. Use subqueries to display all actors who appear in the film Alone Trip.  */
select first_name, last_name
from actor where actor_id in (select actor_id
							from film_actor
							where film_id in (select film_id
											 from film
											 where title = 'Alone Trip')); 


/*4. Sales have been lagging among young families, and you wish to target all family 
movies for a promotion. Identify all movies categorized as family films */
select title
from film
where film_id in (select film_id
				  from film_category as fc
				  where category_id in (select category_id
									    from category as c
									    where name = 'Family'));
select title
from film
where film_id in (select film_id
				from film_category as fc
				join category as c using(category_id)
				where c.name = 'Family');


/*5. Get name and email from customers from Canada using subqueries. 
Do the same with joins. Note that to create a join, you will have to 
identify the correct tables with their primary keys and foreign keys, 
that will help you get the relevant information. */
select first_name, last_name, email
from customer
where address_id in (select address_id
						from address 
						where city_id in (select city_id
										  from city
										  where country_id in(select country_id
															  from country
															  where country = 'Canada')));
#JOIN WAY														
select cu.first_name, cu.last_name, cu.email
from country as co
join city as c using(country_id)
join address as a using(city_id)
join customer as cu using(address_id)
where co.country = 'Canada';


/*6. Optional Which are films starred by the most prolific actor? 
Most prolific actor is defined as the actor that has acted in the 
most number of films. First you will have to find the most prolific 
actor and then use that actor_id to find the different films that he/she starred. */

select title
from film
where film_id in (select film_id
				  from film_actor
			      where actor_id in (
									select actor_id from (
														select actor_id, count(film_id) as number_films
														from film_actor
														group by actor_id
														order by number_films desc 
                                                        limit 1) as sub1));

#OTHER WAY
with mpa as (select actor_id 
			 from film_actor
			 group by actor_id 
			 order by count(film_id) desc limit 1)
            
            select title
            from film 
            join film_actor using (film_id)
            where actor_id = (select actor_id from mpa);



/*7. Films rented by most profitable customer. 
You can use the customer table and payment table to find the most 
profitable customer ie the customer that has made the largest sum of payments */
select title
from film
where film_id in(select film_id
				from inventory 
				where inventory_id in(select inventory_id
										from rental
										where customer_id = (select customer_id
															 from payment
															 group by customer_id
															 order by sum(amount) desc
															 limit 1)));


/*8. Customers who spent more than the average payments */