#exc 01
CREATE TABLE addresses(

id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL 

);

CREATE TABLE offices(

id INT PRIMARY KEY AUTO_INCREMENT,
workspace_capacity INT NOT NULL,
website VARCHAR(50),
address_id INT NOT NULL,
CONSTRAINT fk_offices_addresses
FOREIGN KEY (address_id)
REFERENCES addresses(id)
);

CREATE TABLE employees(

id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
age INT NOT NULL,
salary DECIMAL(10,2) NOT NULL,
job_title VARCHAR(20) NOT NULL,
happiness_level CHAR(1) NOT NULL
);

CREATE TABLE teams(

id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(40) NOT NULL,
office_id INT NOT NULL,
leader_id INT NOT NULL UNIQUE,
CONSTRAINT fk_teams_offices
FOREIGN KEY (office_id)
REFERENCES offices(id),
CONSTRAINT fk_teams_employees
FOREIGN KEY (leader_id)
REFERENCES employees(id)

);

CREATE TABLE games(
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL UNIQUE,
`description` TEXT,
rating FLOAT NOT NULL DEFAULT 5.5,
budget DECIMAL(10, 2) NOT NULL,
release_date DATE,
team_id INT NOT NULL,
CONSTRAINT fk_games_teams
FOREIGN KEY (team_id)
REFERENCES teams(id)
);

CREATE TABLE categories(
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(10) NOT NULL
);

CREATE TABLE games_categories(
game_id INT NOT NULL,
category_id INT NOT NULL,
PRIMARY KEY pk_games_category(game_id, category_id),
CONSTRAINT fk_games_categories_games
FOREIGN KEY (game_id)
REFERENCES games(id),
CONSTRAINT fk_games_categories_categories
FOREIGN KEY (category_id)
REFERENCES categories(id)
);


#exc 02
INSERT INTO games (`name`, rating, budget, team_id)
SELECT LOWER(reverse(SUBSTRING(t.`name`, 2))), t.id, t.leader_id * 1000, t.id FROM teams  AS t
WHERE t.id BETWEEN 1 AND 9;


#exc 03
UPDATE employees AS e
JOIN teams AS t
ON e.id = t.leader_id
SET e.salary = e.salary + 1000
WHERE e.salary < 5000 AND e.age <= 40;

#exc 04
DELETE g FROM games AS g
LEFT JOIN games_categories AS gc 
ON g.id = gc.game_id
WHERE gc.category_id IS NULL AND g.release_date IS NULL;


#exc 05
SELECT first_name, last_name, age, salary, happiness_level FROM employees 
ORDER BY salary, id;


#exc 06
SELECT t.`name` AS team_name, a.`name` AS address_name, char_length(a.`name`) AS count_of_characters FROM  teams AS t
JOIN offices AS o
ON t.office_id = o.id
JOIN addresses AS a
ON o.address_id = a.id
WHERE o.website IS NOT NULL
ORDER BY team_name, address_name;


#exc 07
SELECT c.`name`, COUNT(g.id) AS games_count, ROUND(AVG(g.budget),2)  AS avg_budget, MAX(g.rating) AS max_rating FROM categories AS c
LEFT JOIN games_categories AS gc
ON c.id = gc.category_id
LEFT JOIN games AS g
ON gc.game_id = g.id
GROUP BY c.`name`
HAVING max_rating >= 9.5
ORDER BY games_count DESC, c.`name`;


#exc 08
SELECT g.`name`, g.release_date, concat(LEFT(g.`description`, 10), '...') AS summary, 
(CASE
	WHEN month(g.release_date) >= 10 THEN 'Q4'
    WHEN month(g.release_date) >= 7 THEN 'Q3'
    WHEN month(g.release_date) >= 4 THEN 'Q2'
    ELSE 'Q1'
END) AS `quarter`,
t.`name` AS team_name
 FROM games AS g
 JOIN teams AS t ON g.team_id = t.id
WHERE YEAR(g.release_date) = 2022 AND (RIGHT(g.`name`, 1)) = 2 AND month(g.release_date) % 2 = 0
ORDER BY `quarter`;


#exc 09
SELECT g.`name`,
IF (g.budget < 50000, 'Normal budget', 'Insufficient budget')AS budget_level, 
t.`name` AS team_name , 
a.`name` AS address_name
FROM games AS g
LEFT JOIN teams AS t ON g.team_id = t.id
LEFT JOIN offices AS o ON t.office_id = o.id
LEFT JOIN addresses AS a ON o.address_id = a.id
LEFT JOIN games_categories AS gc ON g.id = gc.game_id
WHERE gc.category_id IS NULL AND g.release_date IS NULL
ORDER BY g.`name`;


#exc 10
DELIMITER $$
CREATE FUNCTION udf_game_info_by_name (game_name VARCHAR (20))
RETURNS TEXT
DETERMINISTIC
BEGIN
RETURN(
SELECT concat('The ', g.`name`, ' is developed by a ', t.`name`, ' in an office with an address ', a.`name` ) AS info FROM games AS g
JOIN teams AS t ON t.id = g.team_id
JOIN offices AS o ON t.office_id = o.id
JOIN addresses AS a ON o.address_id = a.id
WHERE g.`name` = game_name

);

END;
DELIMITER ;


#exc 11
DELIMITER $$
CREATE PROCEDURE udp_update_budget(min_game_rating FLOAT)
BEGIN
	UPDATE games AS g
    LEFT JOIN games_categories AS gc
	ON gc.game_id = g.id
	LEFT JOIN categories AS c
	ON gc.category_id  = c.id
	SET g.budget = g.budget + 100000, g.release_date = DATE_ADD(date(g.release_date), INTERVAL 1 YEAR)
	WHERE gc.category_id IS NULL AND g.rating > min_game_rating AND g.release_date IS NOT NULL;
END;
DELIMITER ;
