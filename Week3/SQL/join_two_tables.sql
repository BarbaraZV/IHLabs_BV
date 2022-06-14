use sakila;

/* 1. Which actor has appeared in the most films? */
select a.first_name, a.last_name, count(f.film_id) as films
from actor as a
 join film_actor as f
on a.actor_id = f.actor_id
group by a.actor_id  #a.first_name, a.last_name
order by films desc
limit 1;



/* 2.Most active customer (the customer that has rented 
the most number of films) */ #ELEANOR HUNT	46
select c.first_name
	  , c.last_name
      , count(c.customer_id) as active_customer
from  rental as r 
join customer as c
on r.customer_id = c.customer_id
group by c.customer_id
order by active_customer desc
limit 1
;



/*3. List number of films per category. */

select c.name, count(fc.film_id) as number_films
from category as c
join film_category as fc on c.category_id = fc.category_id
group by c.name
order by number_films ;

/*4. Display the first and last names, as well as the address, 
of each staff member.   */
select s.first_name, s.last_name, a.address
from staff as s
join address as a
on s.address_id = a.address_id;


/* 5. Display the total amount rung up(cobrado) by each staff member in August of 2005. */
select s.first_name, s.last_name, sum(p.amount) rungup_amount
from staff as s
join payment as p 
using(staff_id) # on s.staff_id = p.staff_id
where payment_date like '2005-08%'
group by staff_id
order by s.first_name;




/* 6. List each film and the number of actors who are listed for that film. */
select distinct f.title, count(actor_id) as number_actors
from film as f
join film_actor as a
using(film_id)
group by f.title
order by number_actors desc
limit 10;


/*7. Using the tables payment and customer and the JOIN command, list the total
 paid by each customer. List the customers alphabetically by last name. 
 */
select c.first_name, c.last_name, sum(p.amount) as total_paid
from payment  as p
join customer as c using(customer_id)
group by p.customer_id
order by c.last_name
limit 10
;

/*Optional: Which is the most rented film? The answer is Bucket Brotherhood 
 This query might require using more than one join statement. Give it a try.
*/
select  f.title as title, count(r.rental_date) number_rentals
from rental as r
inner join (inventory as i) using (inventory_id)
inner join (film as f) using (film_id)
group by title
order by number_rentals desc
limit 1;
