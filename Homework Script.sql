use sakila;

#1A and 1B 
SELECT first_name
	,last_name
	,CONCAT(UCASE(first_name), ' ', UCASE(last_name)) as 'Actor Name'
    FROM actor;
    
#2a
SELECT actor_id
	,first_name
	,last_name
 FROM actor
 WHERE first_name = 'Joe';
 
 #2b
 SELECT actor_id
	,first_name
	,last_name
 FROM actor
 WHERE last_name like '%GEN%';
 
  #2c
 SELECT actor_id
	,first_name
	,last_name
 FROM actor
 WHERE last_name like '%LI%'
 ORDER BY last_name, first_name;
 
 #2d
 SELECT country_id
,country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a
ALTER TABLE actor
	ADD `description` BLOB;

#3b
ALTER TABLE actor
	DROP COLUMN `description`;
    
#4a
SELECT last_name
,COUNT(last_name)
FROM actor
GROUP BY last_name;

#4b
SELECT last_name
,COUNT(last_name) as `count`
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

#4c
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' and last_name = 'WILLIAMS';

#4d
UPDATE actor SET first_name = 'GROUCHO' WHERE first_name = 'HARPO';

#5a
SHOW CREATE TABLE address;

#6a
SELECT s.first_name
,s.last_name
,a.address
FROM sakila.staff AS s
LEFT JOIN (
	SELECT address_id
    ,address
    FROM sakila.address) AS a
ON s.address_id = a.address_id;

#6b
SELECT s.first_name
,s.last_name
,SUM(p.amount) as total_sales
FROM sakila.staff AS s
INNER JOIN (
	SELECT staff_id
    ,amount
    FROM sakila.payment) as p
ON s.staff_id = p.staff_id
GROUP BY first_name, last_name;

#6c
SELECT f.film_id
,f.title
,COUNT(fa.actor_id) AS number_of_actors
FROM film as f
INNER JOIN (
	SELECT film_id
    ,actor_id
    FROM film_actor) as fa
ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title;

#6d
SELECT COUNT(inventory_id) as Copies_of_Hunchback_Impossible
FROM sakila.inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

#6e
SELECT c.first_name
,c.last_name
,SUM(p.amount) AS total_amount_paid
FROM customer as c
LEFT JOIN (
	SELECT customer_id
    ,amount
    FROM payment) AS p
ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name;

#7a
SELECT title
FROM film
WHERE LEFT(TITLE, 1) IN ('K', 'Q') 
AND language_id = (SELECT language_id FROM `language` WHERE name = 'English');

#7b
SELECT first_name
,last_name
FROM actor
WHERE actor_id in (
	SELECT actor_id 
	FROM film_actor 
    WHERE film_id = (
		SELECT
		film_id
        FROM film
        WHERE title = 'Alone Trip'
	)
);

#7c
SELECT c.first_name
,c.last_name
,c.email
FROM customer as c
INNER JOIN (
	SELECT a.address_id
    FROM address as a
    INNER JOIN (
		SELECT ci.city_id
        FROM city as ci
        INNER JOIN (
			SELECT co.country_ID
            FROM country as co
            WHERE country = 'Canada') t1
		ON ci.country_id = t1.country_id) as t2
	ON a.city_id = t2.city_id) as  t3
ON c.address_id = t3.address_id;

#7d
SELECT title
FROM film
WHERE film_id in (
	SELECT film_id
	FROM film_category
	WHERE category_id = (
		SELECT category_id
		FROM category
		WHERE `name` = 'Family'
		)
	);

#7e
SELECT title
,count(rental_id) AS number_of_rentals
FROM rental as r
INNER JOIN (
	SELECT f.title
    ,i.inventory_id
    FROM film AS f
    INNER JOIN (
		SELECT inventory_id
        ,film_id
        FROM inventory) as i
	ON i.film_id = f.film_id) as t1
ON t1.inventory_id = r.inventory_id
GROUP BY title
ORDER BY number_of_rentals DESC;

#7f
SELECT s.store_id
,sum(p.amount) as sales
FROM payment as p
INNER JOIN (
	select *
    FROM staff) as s
ON s.staff_id = p.staff_id
GROUP BY s.staff_id;

#7e
SELECT store_id
,city
,country
FROM country AS co
INNER JOIN (
	SELECT store_id
	,city
	,country_id
	FROM city AS c
	INNER JOIN (
		SELECT store_id
		,city_id
		FROM address AS a
		INNER JOIN (
			SELECT store_id
			,address_id
			FROM store ) as s
		ON a.address_id = s.address_id) AS t1
	ON c.city_id = t1.city_id) AS t2
ON co.country_id = t2.country_id;

#7h
SELECT category
,SUM(amount) AS sales
FROM payment as p
INNER JOIN (
	SELECT category
	,rental_id
	FROM rental as r
	INNER JOIN (
		SELECT category
		,inventory_id
		FROM inventory AS i
		INNER JOIN (
			SELECT category
			,film_id
			FROM film_category AS fc
			INNER JOIN (
				SELECT `name` AS category
				,category_id
				FROM category) AS t1
			ON fc.category_id = t1.category_id) AS t2
		ON i.film_id = t2.film_id) AS t3
	ON t3.inventory_id = r.inventory_id) AS t4
ON t4.rental_id = p.rental_id
GROUP BY category
ORDER BY sales DESC
LIMIT 5;

#8a
CREATE VIEW top_five_genres AS
SELECT category
,SUM(amount) AS sales
FROM payment as p
INNER JOIN (
	SELECT category
	,rental_id
	FROM rental as r
	INNER JOIN (
		SELECT category
		,inventory_id
		FROM inventory AS i
		INNER JOIN (
			SELECT category
			,film_id
			FROM film_category AS fc
			INNER JOIN (
				SELECT `name` AS category
				,category_id
				FROM category) AS t1
			ON fc.category_id = t1.category_id) AS t2
		ON i.film_id = t2.film_id) AS t3
	ON t3.inventory_id = r.inventory_id) AS t4
ON t4.rental_id = p.rental_id
GROUP BY category
ORDER BY sales DESC
LIMIT 5;

#8b
SELECT * FROM top_five_genres;

#8c
DROP VIEW top_five_genres

