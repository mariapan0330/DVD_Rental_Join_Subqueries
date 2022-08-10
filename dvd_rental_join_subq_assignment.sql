-- Q1: List all customers who live in Texas (use JOINs)--------------------> customer & address
-- A1: There's 5 = Kim Cruz, Richard McCrary, Jennifer Davis, Bryan Hardison, and Ian Still
SELECT c.first_name, c.last_name, a.district
FROM address a
JOIN customer c 
ON c.address_id = a.address_id
WHERE a.district = 'Texas';



-- Q2: Get all payments above $6.99 with the Customer’s full name --------------------> customer & payment
SELECT c.first_name, c.last_name, p.amount
FROM customer c 
JOIN payment p 
ON c.customer_id = p.customer_id 
WHERE p.amount > 6.99;



-- Q3: Show all customer names who have made payments over $175 (use subqueries) --------------------> customer & payment
-- Strategy: (1) Find totals for each customer, (2) Return the ones with totals over 175
-- A3: There's 6 = Karl Seal, Rhonda Kennedy, Clara Shaw, Eleanor Hunt, Marion Snyder, and Tommy Collazo.

SELECT c.first_name, c.last_name, payment_sums.amt_sum
FROM (
	SELECT customer_id, sum(amount) AS amt_sum
	FROM payment
	GROUP BY customer_id
) AS payment_sums
JOIN customer c
ON c.customer_id = payment_sums.customer_id
WHERE payment_sums.amt_sum > 175;



-- Q4: List all customers that live in Argentina (use the city table) --------------------> address > city > country
-- A4: There's 13 of them
SELECT customer.first_name, customer.last_name, city.city, country.country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id 
JOIN country
ON city.country_id = country.country_id
WHERE country.country = 'Argentina';



-- Q5: Which film category has the most movies in it (show with the count)? --------------------> film_category > category
-- *(we did this in class. try doing it yourself or maybe find the film category with the LEAST movies in it)
-- A5: Most = Sports with 74 movies. Least = Music with 51 movies

-- Strategy: (1) Find the category_id with the most movies in it, (2) Use the category_id to name the category
-- MOST
SELECT category_count.movies_count, category.name FROM (
	SELECT category_id, count(*) AS movies_count
	FROM film_category
	GROUP BY category_id
	ORDER BY count(*) DESC
	LIMIT 1
) AS category_count
JOIN category
ON category_count.category_id = category.category_id;

-- Strategy2: Same as MOST but without desc keyword
-- LEAST
SELECT category_count.movies_count, category.name FROM (
	SELECT category_id, count(*) AS movies_count
	FROM film_category
	GROUP BY category_id
	ORDER BY count(*)
	LIMIT 1
) AS category_count
JOIN category
ON category_count.category_id = category.category_id;



-- Q6: What film had the most actors in it (show film info)? --------------------> film_actor > film
-- A6: #508, Lambs Cincinatti (A Insightful Story of a Man And a Feminist who must Fight a Composer in Australia) 2006, PG-13, with 15 actors
SELECT film.title, film.description, film.release_year, film.rating, actor_counter.actor_count FROM (
	SELECT film_id, count(*) AS actor_count
	FROM film_actor
	GROUP BY film_id
	ORDER BY actor_count DESC
	LIMIT 1
) AS actor_counter
JOIN film 
ON actor_counter.film_id = film.film_id;



-- Q7: Which actor has been in the least movies? --------------------> film_actor > actor
-- A3: Emily Dee was in 14 movies. Sorry, Emily

SELECT actor.first_name, actor.last_name, film_counter.film_count FROM (
	SELECT actor_id, count(*) AS film_count
	FROM film_actor
	GROUP BY actor_id
	ORDER BY film_count
	LIMIT 1
) AS film_counter
JOIN actor
ON film_counter.actor_id = actor.actor_id;



-- Q8: Which country has the most cities? --------------------> city > country
-- A8: India, with 60 cities.
SELECT country.country, city_counter.city_count FROM (
	SELECT country_id, count(*) AS city_count
	FROM city
	GROUP BY country_id
	ORDER BY city_count DESC
	LIMIT 1
) AS city_counter
JOIN country
ON city_counter.country_id = country.country_id;



-- Q9: List the actors who have been in more than 3 films but less than 6. --------------------> film_actor > actor
-- Emily Dee from #7 was in the least amount of movies and she had 14. So, no actors have been in only 4 or 5 movies.
-- but here's that in code i guess

SELECT actor.first_name, actor.last_name, film_counter.film_count FROM (
	SELECT actor_id, count(*) AS film_count
	FROM film_actor
	GROUP BY actor_id
) AS film_counter
JOIN actor
ON film_counter.actor_id = actor.actor_id
WHERE film_counter.film_count BETWEEN 4 AND 5;




















