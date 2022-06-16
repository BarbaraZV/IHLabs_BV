use sakila;

/*1. In the table actor, what last names are not repeated? For example if you would sort the data
 in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, 
 and Debbie Arkoyd. These three actors have the same last name. So we do not want to include this 
 last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire",
 hence we would want this in our output list.*/
select last_name
from actor
group by last_name
having count(last_name) < 2;

/*2. Which last names appear more than once? We would use the same logic as in the 
previous question but this time we want to include the last names of the actors where 
the last name was present more than once*/
select  last_name
from actor
group by last_name
having count(last_name)>1;
#because where keyword cannot be used with aggregated functions.
#having is used to exclude records after grouping
 

/*3. Using the rental table, find out how many rentals were processed by each employee.*/
select staff_id, count(rental_id) as number_rentals
from rental
group by staff_id;


/*4. Using the film table, find out how many films there are of each rating.*/
select rating,  count(film_id) as number_films
from film
group by rating;


/*5. What is the mean length of the film for each rating type. Round off the average 
lengths to two decimal places*/
select rating, round(avg(length),2) as avg_legth
from film
group by rating;

/*6. Which kind of movies (rating) have a mean duration of more than two hours?*/

select rating, round(avg(length),2) as avg_legth
from film
group by rating
having avg_legth > 120;