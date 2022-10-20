# EXC 1
SELECT `id`, `first_name`, `last_name`, `job_title`
FROM  `employees`
ORDER BY `id`;


# EXC 2
SELECT `id`, CONCAT( `first_name`,' ', `last_name`) AS `full_name`, `job_title` `job_title`, `salary`
FROM  `employees`
WHERE `salary`> 1000.00
ORDER BY `id`;



# EXC 3
UPDATE `employees` 
SET `salary` = `salary` + 100 
WHERE `job_title` = 'Manager';
SELECT `salary` FROM `employees`;

# EXC 4
SELECT * FROM `employees`
ORDER BY `salary` DESC
LIMIT 1;

# EXC 5
SELECT * FROM `employees`
WHERE `department_id` = 4 AND `salary` >= 1000
ORDER BY `id`;

# EXC 6
DELETE  FROM `employees`
WHERE `department_id` = 1 OR `department_id` = 2;
SELECT * FROM `employees`
ORDER BY `id`;