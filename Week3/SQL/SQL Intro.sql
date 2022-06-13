use sakila;

/*1. Review the tables in the database.*/

show tables;


/*2. Explore tables by selecting all columns from each 
table or using the in built review features for your client.*/

#Short way

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
;
# OR
SELECT DATA_TYPE from INFORMATION_SCHEMA.COLUMNS where
table_schema = "sakila" ;

/* 3. Select one column from a table. Get film titles.*/
select distinct title
from film;

/* 4. Select one column from a table and alias it. 
Get unique list of film languages under the alias language. 
Note that we are not asking you to obtain the language per each 
film, but this is a good time to think about how you might get that information in the future.
*/

select name as "language" from language;

/* 5.
5.1 Find out how many stores does the company have? 
= 2 stores
*/
select count(distinct store_id) as total_stores
from store;


/* 5.2 Find out how many employees staff does the company have? */
select count(distinct staff_id) as total_employees
from staff;

/* 5.3 Return a list of employee first names only? */
select first_name
from staff ; 