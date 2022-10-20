#exc 01
SELECT `department_id`, COUNT(`department_id`) AS `Number of employees` FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`, `Number of employees`;

#exc 02
SELECT `department_id`, ROUND(AVG(`salary`), 2) AS `Average Salary` FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;

#exc 03
SELECT `department_id`, ROUND(MIN(`salary`), 2) AS `Min Salary` 
FROM `employees`
GROUP BY `department_id`
HAVING `Min Salary` > 800
ORDER BY `department_id`;

#exc 04
SELECT COUNT(`category_id`)  FROM `products`
WHERE `price` > 8
GROUP BY `category_id`
HAVING `category_id` = 2;

#exc 05
SELECT `category_id`, ROUND(AVG(`price`), 2) AS `Average Price`, 
ROUND(MIN(`price`), 2) AS `Cheapest Product`, 
ROUND(MAX(`price`), 2) AS `Most Expensive Product`
FROM `products`
GROUP BY `category_id`;



