/*
1. Bubs wants you to track information on his 
customers (first name, last name, email), his
employees (first name, last name, start date, position held),
his products, and the purchases customers make (which customer,
when it was purchased, for how much money). Think about how many
tables you should create. Which data goes in which tables? How
should the tables relate to one another?
*/

-- First table is customers table (customer_id, first_name, last_name, email)
-- Second table is employee table (employee_id, first_name, last_name, start_date, position)
-- Third table is products table (product_id, product_name, product_cost)
-- Fourth table is customer_purchases table (customer_purchases_id, customer_id, product_id, employee_id, purchase_date, order_total)

/*
2. Given the database design you came up with, use Workbench to create 
an EER diagram of the database. Include things like primary keys and
foreign keys, and anything else you think you should have in the tables.
Make sure to use reasonable data types for each column
*/

/*
3. Create a schema called bubsbooties. Within that schema, create the tables
you have diagramed out. Make sure they relate to each other, and that they
have the same reasonable data types you selected previously.
*/

CREATE SCHEMA bubsbooties;

USE bubsbooties;

CREATE TABLE `bubsbooties`.`customers` (
  `customer_id` BIGINT NOT NULL,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `email_address` VARCHAR(100) NULL,
  PRIMARY KEY (`customer_id`));
  
CREATE TABLE `bubsbooties`.`employees` (
  `employee_id` BIGINT NOT NULL,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `hire_date` DATE NULL,
  PRIMARY KEY (`employee_id`));
  
CREATE TABLE `bubsbooties`.`products` (
  `product_id` BIGINT NOT NULL,
  `product_name` VARCHAR(100) NULL,
  `launch_date` DATE NULL,
  PRIMARY KEY (`product_id`));

CREATE TABLE `bubsbooties`.`customer_purchases` (
  `customer_purchase_id` BIGINT NOT NULL,
  `customer_id` BIGINT NULL,
  `product_id` BIGINT NULL,
  `employee_id` BIGINT NULL,
  `purchase_date` DATE NULL,
  PRIMARY KEY (`customer_purchase_id`));

/*
4. Add any constraints you think your tables' columns should have.
Think through which columns need to be unique, which ones are
allowed to have NULL values, etc.
*/

ALTER TABLE `bubsbooties`.`customers` 
CHANGE COLUMN `first_name` `first_name` VARCHAR(100) NOT NULL ,
CHANGE COLUMN `last_name` `last_name` VARCHAR(100) NOT NULL ,
CHANGE COLUMN `email_address` `email_address` VARCHAR(100) NOT NULL ;

ALTER TABLE `bubsbooties`.`employees` 
CHANGE COLUMN `first_name` `first_name` VARCHAR(100) NOT NULL ,
CHANGE COLUMN `last_name` `last_name` VARCHAR(100) NOT NULL ,
CHANGE COLUMN `hire_date` `hire_date` DATE NOT NULL ;

ALTER TABLE `bubsbooties`.`products` 
CHANGE COLUMN `product_name` `product_name` VARCHAR(100) NOT NULL ,
CHANGE COLUMN `launch_date` `launch_date` DATE NOT NULL ;

ALTER TABLE `bubsbooties`.`customer_purchases` 
CHANGE COLUMN `customer_id` `customer_id` BIGINT NOT NULL ,
CHANGE COLUMN `product_id` `product_id` BIGINT NOT NULL ,
CHANGE COLUMN `employee_id` `employee_id` BIGINT NOT NULL ,
CHANGE COLUMN `purchase_date` `purchase_date` DATE NOT NULL ;

ALTER TABLE `bubsbooties`.`employees` 
ADD COLUMN `position` VARCHAR(100) NULL AFTER `hire_date`;

ALTER TABLE `bubsbooties`.`employees` 
CHANGE COLUMN `position` `position` VARCHAR(100) NOT NULL ;

ALTER TABLE `bubsbooties`.`customer_purchases` 
ADD INDEX `customer_customer_id_idx` (`customer_id` ASC) VISIBLE,
ADD INDEX `products_product_id_idx` (`product_id` ASC) VISIBLE,
ADD INDEX `employees_employee_id_idx` (`employee_id` ASC) VISIBLE;
;
ALTER TABLE `bubsbooties`.`customer_purchases` 
ADD CONSTRAINT `customers_customer_id`
  FOREIGN KEY (`customer_id`)
  REFERENCES `bubsbooties`.`customers` (`customer_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `products_product_id`
  FOREIGN KEY (`product_id`)
  REFERENCES `bubsbooties`.`products` (`product_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `employees_employee_id`
  FOREIGN KEY (`employee_id`)
  REFERENCES `bubsbooties`.`employees` (`employee_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

/*
5. Insert at least 3 records of data into each table. The exact values
do not matter, so feel free to make them up. Just make sure that the
data you insert makes sense, and that the tables tie together.
*/

USE bubsbooties;

SELECT * FROM customers;

INSERT INTO customers VALUES 
(1, 'Jason', 'Allen', 'xyz@gmail.com'),
(2, 'Rica', 'Ton', 'abc@gmail.com'),
(3, 'Xian', 'Get', 'aus@gmail.com');

SELECT * FROM employees;

INSERT INTO employees VALUES
(1, 'Jay', 'Jordan', '2019-06-01', 'manager'),
(2, 'Jayz', 'Jordanz', '2019-07-01', 'cashier'),
(3, 'Jayzz', 'Jordanzz', '2019-08-01', 'salesperson');

SELECT * FROM products;

INSERT INTO products VALUES
(1, 'laptop', '2019-05-01'),
(2, 'computer', '2019-05-01'),
(3, 'keyboard', '2019-05-01');

SELECT * FROM customer_purchases;

INSERT INTO customer_purchases VALUES
(1, 1, 1, 2, '2019-11-01'),
(2, 2, 2, 2, '2019-11-01'),
(3, 3, 3, 3, '2019-11-02');

/*
6. Create two users and give them access to the database. The first user, TuckerReilly,
will be the DBA, and should get full database administrator privileges. The
second user, EllaBrody, is an analyst, and only needs read access.
*/

-- Created the two users already. 


