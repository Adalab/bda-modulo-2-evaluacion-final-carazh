USE sakila;
-- 1. Select all movie names without duplicates.
-- Using distinct to remove duplicates.
SELECT DISTINCT title 
	FROM film;
-- 2. Show the names of all movies that have a rating of "PG-13".
SELECT title
	FROM film
	WHERE rating = 'PG-13';
-- 3. Find the title and description of all movies that contain the word "amazing" in their description.
SELECT title, description
	FROM film
	WHERE description LIKE '%amazing%';
-- 4. Find the titles of all movies that have a duration greater than 120 minutes.
SELECT title 
	FROM film
	WHERE length > 120;
-- 5. Retrieve the names of all actors.
SELECT CONCAT(first_name," ",last_name) AS 'Full Name' 
	FROM actor;
-- 6. Find the first and last names of actors who have "Gibson" in their last name
-- Using '%GIBSON%' instead of 'GIBSON' just in case someone in the future have a compound name.
SELECT first_name, last_name
	FROM actor
	WHERE last_name LIKE '%GIBSON%';
-- 7. Find the names of actors who have an actor_id between 10 and 20.
SELECT actor_id , CONCAT(first_name," ",last_name) AS 'Full Name'
	FROM actor
    WHERE actor_id <11;
-- 8. Find the titles of movies in the film table that are neither "R" nor "PG-13" in terms of their rating.
SELECT title, rating
	FROM film
	WHERE rating NOT LIKE 'R' AND rating NOT LIKE 'PG-13';
-- 9. Find the total number of movies in each rating from the film table and display the rating along with the count.
SELECT  rating as 'Rating Classification' , COUNT(film_id) as 'Count of movies' 
	FROM film
    GROUP BY rating;
-- 10. Find the total number of movies rented by each customer and display the customer ID, their first name, last name, along with the number of movies rented
SELECT c.customer_id as 'Customer Id', COUNT(r.rental_id) AS 'Rented Movies',   CONCAT(c.first_name," ",c.last_name) AS 'Customer Name' FROM customer as c
	LEFT JOIN rental as r 
	USING (customer_id)
	GROUP BY (c.customer_id);
-- 11. Find the total number of movies rented by category and display the category name along with the rental count.
SELECT c.name as Name ,COUNT(fc.film_id) as 'Rentals Count'
	FROM film_category as fc
	INNER JOIN film AS f
	USING (film_id)
    INNER JOIN category AS c
	USING (category_id)
    GROUP BY (fc.category_id);
-- 12. "Find the average duration of movies for each rating in the film table and display the rating along with the average duration."
-- I use AVG to calculate the average duration of the movies. Then organiced in Categories.
-- I use ROUND to make the average duration have max 2 decimals.
SELECT  c.name, ROUND(AVG(f.length),2) as 'Average duration'FROM film as f
	LEFT JOIN film_category as fc
    USING (film_id)
    LEFT JOIN category as c 
    USING (category_id)
    GROUP BY (c.name);
-- 13. "Find the first and last names of the actors who appear in the movie with the title 'Indian Love.'"
SELECT CONCAT(a.first_name," ",a.last_name) as 'Actor in Indian Love Movie'
	FROM film as f
    LEFT JOIN film_actor as fa
    USING (film_id)
    LEFT JOIN actor as a
    USING (actor_id)
	WHERE f.title = 'INDIAN LOVE';
-- 14. "Show the titles of all movies that contain the word 'dog' or 'cat' in their description."
SELECT title, description 
	FROM film
	WHERE description LIKE '%DOG%' or description LIKE '%CAT%';
-- 15. "Are there any actors or actresses who do not appear in any movie in the film_actor table?"
SELECT CONCAT(a.first_name," ",a.last_name) as 'Actor Name' , f.* 
	FROM film as f
    LEFT JOIN film_actor as fa
    USING (film_id)
    LEFT JOIN actor as a
    USING (actor_id)
	WHERE f.title IS NULL;
-- pensar la forma de seleccionar de la tabla actor usando una subquery con la tabla film actor. 
-- 16."Find the titles of all movies that were released between 2005 and 2010."
-- duda : no hay nada que no sea del año 2006
SELECT title, release_year 
	FROM film 
	WHERE release_year BETWEEN '2005' and '2010';
-- 17. "Find the titles of all movies that are in the same category as 'Family.'"
SELECT f.title, c.name FROM film as f
	INNER JOIN film_category as fc
	USING (film_id)
	INNER JOIN category as c
	USING (category_id)
	WHERE c.name = 'Family';
-- 18. "Show the first and last names of actors who appear in more than 10 movies."
SELECT  CONCAT(a.first_name," ",a.last_name) as 'Actor Name',COUNT(f.film_id) as Counter  FROM actor as a
INNER JOIN film_actor as fa
USING (actor_id)
INNER JOIN film as f
USING (film_id)
GROUP BY (a.actor_id)
HAVING counter > 10;
-- 19. "Find the titles of all movies that are rated 'R' and have a duration of more than 2 hours in the film table."
-- To verify that it's correct, add these two fields in the SELECT: rating, length.
SELECT title
	FROM film
	WHERE rating = 'R' AND length > 120;
-- 20. "Find the movie categories that have an average duration greater than 120 minutes and display the category name along with the average duration."
SELECT  c.name,  ROUND(AVG(f.length),2) as Average FROM film as f
	LEFT JOIN film_category as fc
    USING (film_id)
    LEFT JOIN category as c 
    USING (category_id)
    GROUP BY (c.name)
    HAVING Average > 120;
-- 21. "Find the actors who have acted in at least 5 movies and show the actor's name along with the number of movies they have acted in."
SELECT  a.actor_id as 'Actor Id' , CONCAT(a.first_name," ",a.last_name) as 'Actor Name',COUNT(f.film_id) as Counter  FROM actor as a
	INNER JOIN film_actor as fa
	USING (actor_id)
	INNER JOIN film as f
	USING (film_id)
	GROUP BY (a.actor_id)
	HAVING counter > 5; 
-- 22. "Find the titles of all movies that were rented for more than 5 days. Use a subquery to find the rental_ids with a duration greater than 5 days and then select the corresponding movies."
select rental_id, datediff(return_date, rental_date) as dias_dif
from rental
-- 23. "Find the first and last names of actors who have not acted in any movies in the 'Horror' category. Use a subquery to find the actors who have acted in 'Horror' movies and then exclude them from the list of actors."
