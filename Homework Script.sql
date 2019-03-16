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

