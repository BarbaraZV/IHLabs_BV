use sakila;
/*1. Write a query to display for each store its store ID, city, and country.*/
select s.store_id
	 , ci.city
     , co.country
from store as s
join (address as a) using(address_id)
join (city as ci) using(city_id)
join (country as co) using(country_id);

/*2. Write a query to display how much business, in dollars, 
each store brought in.  */
select  sto.store_id, sum(p.amount) as brought_amount
from  (store as sto)
join (staff as sta) using(store_id)
join (payment as p) using(staff_id)
group by sto.store_id  ;


/*3. What is the average running time(length) of films by category?  */
select  c.name as category_film, round(avg(f.length),2) as avg_running_time
from (category as c) 
join (film_category as fc) using(category_id)
join (film as f) using(film_id)
group by c.name
;

/*4. Which film categories are longest(length)? 
(Hint: You can rely on question 3 output.) */
select  c.name as category_film, round(avg(f.length),2) as avg_running_time
from (category as c) 
join (film_category as fc) using(category_id)
join (film as f) using(film_id)
group by c.name
order by avg_running_time desc
limit 5
;


/*5. Display the most frequently(number of times) rented movies 
in descending order. */
select f.title , count(r.rental_date) number_rental
from rental as r
join (inventory as i) using(inventory_id)
join (film as f) using(film_id)
group by f.title
order by number_rental desc
limit 5
;

/* 6. List the top five genres in gross revenue in descending order.*/
select c.name as genre, sum(p.amount) as revenue
from payment as p
join (rental as r) using(rental_id)
join (inventory as i) using(inventory_id)
join (film as f) using(film_id)
join (film_category as fc) using(film_id)
join (category as c) using(category_id)
group by category_id
order by  revenue desc
limit 5
;

/*7. Is "Academy Dinosaur" available for rent from Store 1?*/
select  f.title,  count(s.store_id ) as films_availables
from store as s
join (inventory as i) using(store_id)
join (film as f) using(film_id)
where f.title = "Academy Dinosaur" and s.store_id = 1
#limit 1
;
