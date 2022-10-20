CREATE TABLE `minions`.`minions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `age` INT NULL,
  PRIMARY KEY (`id`));
  
  CREATE TABLE `minions`.`towns` (
  `town_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`town_id`));
  
ALTER TABLE `minions`.`towns` 
CHANGE COLUMN `town_id` `id` INT NOT NULL AUTO_INCREMENT ;


ALTER TABLE `minions`.`minions` 
ADD COLUMN `town_id` INT NOT NULL AFTER `age`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `town_id`),
ADD INDEX `fk_minions_towns_idx` (`town_id` ASC) VISIBLE;

ALTER TABLE `minions`.`minions` 
ADD CONSTRAINT `fk_minions_towns`
  FOREIGN KEY (`town_id`)
  REFERENCES `minions`.`towns` (`id`);
  
  
SELECT * FROM minions.minions;

INSERT INTO `minions`.`towns` (`name`) VALUES ('Sofia');
INSERT INTO `minions`.`towns` (`name`) VALUES ('Plovdiv');
INSERT INTO `minions`.`towns` (`name`) VALUES ('Varna');

INSERT INTO `minions`.`minions` (`name`, `age`, `town_id`) VALUES ('Kevin', 22, 1);
INSERT INTO `minions`.`minions` (`name`, `age`, `town_id`) VALUES ('Bob', 15, 3);
INSERT INTO `minions`.`minions` (`name`, `age`, `town_id`) VALUES ('Steward', NULL, 2);







/*•	id – unique number for every person there will be no more than 231-1people. (Auto incremented)
•	name – full name of the person will be no more than 200 Unicode characters. (Not null)
•	picture – image with size up to 2 MB. (Allow nulls)
•	height –  In meters. Real number precise up to 2 digits after floating point. (Allow nulls)
•	weight –  In kilograms. Real number precise up to 2 digits after floating point. (Allow nulls)
•	gender – Possible states are m or f. (Not null)
•	birthdate – (Not null)
•	biography – detailed biography of the person it can contain max allowed Unicode characters. (Allow nulls)
*/

CREATE TABLE `people`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(200) NOT NULL,
`picture` BLOB,
`height` FLOAT (5, 2),
`weight` FLOAT (5, 2),
`gender` CHAR(1) NOT NULL,
`birthdate` DATE NOT NULL,
`biography` TEXT
);

INSERT INTO `people` (`name`, `gender`, `birthdate`) VALUES ('Ivan', 'M', '2020-01-01');
INSERT INTO `people` (`name`, `gender`, `birthdate`) VALUES ('Pesho', 'M', '2020-01-01');
INSERT INTO `people` (`name`, `gender`, `birthdate`) VALUES ('Gosho', 'M', '2020-01-01');
INSERT INTO `people` (`name`, `gender`, `birthdate`) VALUES ('Stoyan', 'M', '2020-01-01');
INSERT INTO `people` (`name`, `gender`, `birthdate`) VALUES ('Grozdan', 'M', '2020-01-01');




CREATE TABLE `users`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`username` VARCHAR(30) NOT NULL,
`password` VARCHAR(26) NOT NULL,
`profile_picture` BLOB,
`last_login_time` DATETIME,
`is_deleted` BOOLEAN
);

INSERT INTO `users` (`username`, `password`) VALUES ('vanio', 'ivan123');
INSERT INTO `users` (`username`, `password`) VALUES ('peshkata', 'peshkata123' );
INSERT INTO `users` (`username`, `password`) VALUES ('goshuu', 'goshuu123' );
INSERT INTO `users` (`username`, `password`) VALUES ('stoyanchoo', 'stoyanchoo123' );
INSERT INTO `users` (`username`, `password`) VALUES ('grozdi', 'grozdi123');

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users 
PRIMARY KEY (`id`, `username`);



ALTER TABLE `users` 
CHANGE COLUMN `last_login_time` `last_login_time` DATETIME NULL DEFAULT NOW() ;



ALTER TABLE `minions`.`users` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`),
ADD UNIQUE INDEX `username_UNIQUE` (`username`);

CREATE SCHEMA `movies`;
USE `movies`;
CREATE TABLE `directors` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`director_name` VARCHAR(30) NOT NULL,
`notes` TEXT
);


CREATE TABLE `genres` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`genre_name` VARCHAR(30) NOT NULL,
`notes` TEXT
);

CREATE TABLE `categories` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`category_name` VARCHAR(30) NOT NULL,
`notes` TEXT
);


CREATE TABLE `movies` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`title` VARCHAR(30) NOT NULL,
`director_id` INT,
`copyright_year` YEAR,
`length` INT,
`genre_id` INT,
`category_id` INT,
`rating` DOUBLE,
`notes` TEXT
);

INSERT INTO `directors` (`director_name`) VALUES
('Ivan Ivanov'),
('Gosho Goshov'), 
('Pesho Peshov'), 
('Grozdi Grozdev'), 
('Sasho Sashov');

INSERT INTO `genres` (`genre_name`) VALUES
('OPE'),
('OMM'), 
('OPS'), 
('LSCS'),
('OQA');

INSERT INTO `categories` (`category_name`) VALUES
('comedia'),
('comedia'), 
('comedia'), 
('comedia'),
('comedia');

INSERT INTO `movies` (`title`) VALUES
('AMMs are comming'),
('Parts are comming'), 
('AC is comming'), 
('Parts are here'), 
('How was done before');

CREATE SCHEMA `car_rental`;
USE `car_rental`;


CREATE TABLE `categories` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`category` VARCHAR(30) NOT NULL,
`daily_rate` DOUBLE,
`weekly_rate` DOUBLE,
`monthly_rate` DOUBLE,
`weekend_rate` DOUBLE

);

CREATE TABLE `cars` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`plate_number` VARCHAR(30) NOT NULL,
`make` VARCHAR(20) NOT NULL,
`model` VARCHAR(20) NOT NULL,
`car_year` YEAR NOT NULL,
`category_id` INT NOT NULL, 
`doors` INT NOT NULL,
`picture` BLOB,
`car_condition` TEXT NOT NULL,
`available` BOOLEAN NOT NULL
);


CREATE TABLE `employees` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(30) NOT NULL,
`last_name` VARCHAR(30) NOT NULL,
`title` VARCHAR(20) NOT NULL,
`notes` TEXT
);

CREATE TABLE `customers` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`driver_licence_number` INT NOT NULL,
`full_name` VARCHAR(50) NOT NULL,
`address` TEXT NOT NULL,
`city` VARCHAR(20) NOT NULL,
`zip_code` INT, 
`notes` TEXT
);

CREATE TABLE `rental_orders` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`employee_id` INT NOT NULL, 
`customer_id` INT NOT NULL, 
`car_id`INT NOT NULL, 
`car_condition` VARCHAR(50) NOT NULL, 
`tank_level` VARCHAR(20) NOT NULL, 
`kilometrage_start` INT NOT NULL, 
`kilometrage_end` INT NOT NULL, 
`total_kilometrage` INT NOT NULL, 
`start_date` DATE NOT NULL, 
`end_date` DATE NOT NULL, 
`total_days` INT NOT NULL, 
`rate_applied` VARCHAR(20) NOT NULL, 
`tax_rate` DOUBLE NOT NULL, 
`order_status` VARCHAR(20), 
`notes` TEXT
);

INSERT INTO `categories` (`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`) VALUES

('fisr class', 50.00, 300.00, 1000.00, 60.00),
('second class', 40.00, 250.00, 800.00, 50.00),
('third class', 30.00, 180.00, 700.00, 40.00);


INSERT INTO `cars` (`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `car_condition`, `available`) VALUES 

('E0036KS', 'BMW', '318i', '2020', 1, 4,  'OK', TRUE),
('BG0036KS', 'AUDI', 'A4', '2020', 1, 4,  'OK', TRUE),
('EU0036KS', 'SKODA', 'OCTAVIA', '2020', 1, 4,  'OK', TRUE);



INSERT INTO `employees` (`first_name`, `last_name`, `title`) VALUES

('Ivan', 'Ivanov', 'driver'),
('Gosho', 'Goshov', 'cleaner'),
('Pesho', 'Peshov', 'director');

INSERT INTO `customers` (`driver_licence_number`, `full_name`, `address`, `city` ) VALUES 

(11111, 'GROZDI GROZDEV', 'NARODEN GEROI 11', 'SOFIA'),
(22222, 'PESHKO PESHKOV', 'NARODEN GEROI 11', 'SOFIA'),
(22222, 'STOYAN STOYANOV', 'NARODEN GEROI 11', 'SOFIA');


INSERT INTO `rental_orders` (`employee_id`, `customer_id`, `car_id`, `car_condition`, `tank_level`, `kilometrage_start`, `kilometrage_end`, `total_kilometrage`, `start_date`, `end_date`, `total_days`, `rate_applied`, `tax_rate`) VALUES

(1, 1, 1, 'GOOD', 'FULL', 1000, 2000, 1000, '2020-01-01', '2020-01-10', 10, 100.00, 20.00 ),
(2, 2, 2, 'GOOD', 'FULL', 2000, 2000, 2000, '2020-02-02', '2020-01-10', 10, 100.00, 20.00 ),
(3, 3, 3, 'GOOD', 'FULL', 3000, 3000, 3000, '2020-03-03', '2020-01-10', 10, 100.00, 20.00 );

CREATE SCHEMA `soft_uni`;

USE `soft_uni`;

CREATE TABLE `towns`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
);

CREATE TABLE `addresses` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`address_text` TEXT,
`town_id` INT
);

CREATE TABLE `departments`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
);



CREATE TABLE `employees`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(30) NOT NULL,
`middle_name` VARCHAR(30) NOT NULL,
`last_name` VARCHAR(30) NOT NULL,
`job_title` VARCHAR(30) NOT NULL,
`department_id` INT NOT NULL,
`hire_date` DATE NOT NULL,
`salary` DECIMAL(10,2) NOT NULL,
`address_id` INT 

);

ALTER TABLE `addresses` 
ADD CONSTRAINT `fk_addresses_towns`
  FOREIGN KEY (`town_id`)
  REFERENCES `towns` (`id`);
  
ALTER TABLE `employees` 
ADD CONSTRAINT `fk_employees_departments` 
FOREIGN KEY (`department_id`)
REFERENCES `departments` (`id`);

ALTER TABLE `employees` 
ADD CONSTRAINT `fk_employees_addresses` 
FOREIGN KEY (`address_id`)
REFERENCES `addresses` (`id`);


INSERT INTO `towns` (`name`) VALUES

('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

INSERT INTO `departments` (`name`) VALUES

('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

INSERT INTO `employees` (`first_name`, `middle_name`,  `last_name`, `job_title`, `department_id`, `hire_date`, `salary`) VALUES

('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);


SELECT * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;

SELECT * FROM `towns`
ORDER BY `name` ASC;

SELECT * FROM `departments`
ORDER BY `name` ASC;

SELECT * FROM `employees`
ORDER BY `salary` DESC;

SELECT `name` FROM `towns`
ORDER BY `name` ASC;
SELECT `name` FROM `departments`
ORDER BY `name` ASC;
SELECT `first_name`, `last_name`, `job_title`, `salary` FROM `employees`
ORDER BY `salary` DESC;


UPDATE employees
SET 
salary = salary * 1.1
WHERE id > 0;
SELECT `salary` FROM `employees`;


TRUNCATE TABLE `occupancies`;

DROP DATABASE soft_uni;


