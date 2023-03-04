USE mavenmoviesmini;

/*
1. Take a look at the mavenmoviesmini schema.
What do you notice about it?
How many tables are there?
What does the data represent?
What do think about the current schema?
*/

-- Query to examine initial schema
SELECT *
FROM inventory_non_normalized;

/*
2. If you wanted to break out the data from the
inventory_non_normalized table into multiple tables,
how many tables do you think would be ideal? What would you name those tables?
*/

-- inventory (inventory_id, film_id, store_id)
-- film (film_id, title, description, release_year, rental_rate, rating)
-- store (store_id, store_manager_first_name, store_manager_last_name, store_address,store_city, store_district)

/*
3. Based on your answer from #2, create a new schema with the tables
you think will best serve this data set. You can use SQL code or Workbench's
UI tools.
*/

CREATE SCHEMA mavenmoviesmini_normalized;

USE mavenmoviesmini_normalized;

CREATE TABLE film (
  film_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  release_year INT NOT NULL,
  rental_ratfilme DECIMAL(6,2) NOT NULL,
  rating VARCHAR(45) NOT NULL,
  PRIMARY KEY (film_id));
  
CREATE TABLE store (
	store_id INT NOT NULL,
    store_manager_first_name VARCHAR(45) NOT NULL,
    store_manager_last_name VARCHAR(45) NOT NULL,
    store_address VARCHAR(45) NOT NULL,
    store_city VARCHAR(45) NOT NULL,
    store_district VARCHAR(45) NOT NULL,
    PRIMARY KEY (store_id));

/*
4. Next, use the data from the original schema 
to populate the tables in your newly optimized schema
*/

INSERT INTO film (film_id, title, description, release_year, rental_rate, rating)
SELECT DISTINCT film_id, title, description, release_year, rental_rate, rating
FROM mavenmoviesmini.inventory_non_normalized;

SELECT *
FROM inventory;

INSERT INTO film (film_id, title, description, release_year, rental_rate, rating)
SELECT DISTINCT film_id, title, description, release_year, rental_rate, rating
FROM mavenmoviesmini.inventory_non_normalized;

SELECT *
FROM film;

INSERT INTO store (store_id, store_manager_first_name, store_manager_last_name, store_address,store_city, store_district)
SELECT DISTINCT store_id, store_manager_first_name, store_manager_last_name, store_address,store_city, store_district
FROM mavenmoviesmini.inventory_non_normalized;

SELECT *
FROM store;

SELECT
    inventory.film_id,
    film.title,
    COUNT(CASE WHEN inventory.store_id = 1 THEN inventory.inventory_id ELSE NULL END) AS store_1_copies,
    COUNT(CASE WHEN inventory.store_id = 2 THEN inventory.inventory_id ELSE NULL END) AS store_2_copies
FROM inventory
LEFT JOIN film
ON inventory.film_id = film.film_id
GROUP BY inventory.film_id;

/*
5. Make sure your new tables have the proper
primary keys defined and that applicable foreign keys are added.
Add any constraints you think you should apply
to the data as well
*/

ALTER TABLE `mavenmoviesmini_normalized`.`inventory` 
ADD INDEX `inventory_film_id_idx` (`film_id` ASC) VISIBLE,
ADD INDEX `inventory_store_id_idx` (`store_id` ASC) VISIBLE;
;
ALTER TABLE `mavenmoviesmini_normalized`.`inventory` 
ADD CONSTRAINT `inventory_film_id`
  FOREIGN KEY (`film_id`)
  REFERENCES `mavenmoviesmini_normalized`.`film` (`film_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `inventory_store_id`
  FOREIGN KEY (`store_id`)
  REFERENCES `mavenmoviesmini_normalized`.`store` (`store_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*
6. Finally, after doing all this technical work, write a
brief summary of what you have done, in a way that your non-technical client
can understand. Communicate what you did, and why your new schema design is better.

/* Previously, we had one table that was redundantly storing a lot of
information especially about the film description, film title, store information and etc. 
The improvement can be seen on the store table where we were able to cut down the information
into two rows. We've taken one table which was inventory_non_normalized and broken
it down into three tables namely inventory, film, and store.
