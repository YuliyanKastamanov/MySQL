USE `soft_uni`;

#exc 1
SELECT * FROM `departments` 
ORDER BY `department_id`;

#exc 2
SELECT `name` FROM `departments`
ORDER BY `department_id`;

#exc 3
SELECT `first_name`, `last_name`, `salary` FROM `employees`
ORDER BY `employee_id`;

#exc 4
SELECT `first_name`, `middle_name`, `last_name` FROM `employees`
ORDER BY `employee_id`;

#exc 5
SELECT concat(`first_name`,'.', `last_name`, '@softuni.bg') AS `full_email_address`
FROM `employees`;

#exc 6
SELECT DISTINCT `salary` FROM `employees`;

#exc 7
SELECT * FROM `employees`
WHERE `job_title` = 'Sales Representative'
ORDER BY `employee_id`;

#exc 8
SELECT `first_name`, `last_name`, `job_title` FROM `employees`
WHERE `salary` BETWEEN 20000 AND 30000
#WHERE `salary`>= 20000 AND `salary`<= 30000
ORDER BY `employee_id`;


#exc 9
SELECT concat_ws(' ', `first_name`, `middle_name`, `last_name`) AS 'Full Name'
FROM `employees`
WHERE `salary` IN (25000, 14000, 12500, 23600);

#exc 10
SELECT `first_name`, `last_name` FROM `employees`
WHERE `manager_id` IS NULL;

#exc 11
SELECT `first_name`, `last_name`, `salary` FROM `employees`
WHERE `salary` > 50000
ORDER BY `salary` DESC;

#exc 12
SELECT `first_name`, `last_name` FROM `employees`
ORDER BY `salary` DESC
LIMIT 5;

#exc 13
SELECT `first_name`, `last_name` FROM `employees`
WHERE `department_id` != 4;

#exc 14
SELECT * FROM `employees`
ORDER BY `salary` DESC, `first_name`, `last_name` DESC, `middle_name`;

#exc 15
CREATE VIEW `v_employees_salaries` AS
    SELECT 
        `first_name`, `last_name`, `salary`
    FROM
        `employees`;
# select view by using following command
SELECT * FROM `v_employees_salaries`;

#exc 16
CREATE VIEW `v_employees_job_titles` AS
SELECT concat_ws(' ', `first_name`, `middle_name`, `last_name`) AS 'full_name', `job_title`
FROM `employees`;

#exc 17
SELECT DISTINCT `job_title` FROM  `employees`
ORDER BY `job_title`;

#exc 18
SELECT * FROM `projects`
ORDER BY `start_date`, `name`, `project_id`
LIMIT 10;

#exc 19
SELECT `first_name`, `last_name`, `hire_date` FROM `employees`
ORDER BY `hire_date` DESC
LIMIT 7;

#exc 20
#1-Engineering, 2-Tool Design, 4-Marketing, 11-Information Services 
UPDATE  `employees`
SET `salary` = `salary` * 1.12
WHERE `department_id` IN (1, 2, 4, 11);
SELECT `salary` FROM `employees`;

#exc 21
USE `geography`;
SELECT `peak_name` FROM `peaks`
ORDER BY `peak_name`;

#exc 22
SELECT `country_name`, `population` FROM `countries`
WHERE `continent_code` = 'EU'
ORDER BY `population` DESC, `country_name`
LIMIT 30;

#exc 23
USE `geography`;
SELECT `country_name`, `country_code`, IF (`currency_code` = 'EUR', 'Euro', 'Not Euro') AS `currency`
 FROM `countries`
 ORDER BY `country_name`;
 
#exc 24
USE `diablo`;
SELECT `name` FROM `characters`
ORDER BY `name`;






