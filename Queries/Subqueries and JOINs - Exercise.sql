SELECT 
    e.employee_id, e.job_title, e.address_id, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a USING (address_id)
ORDER BY e.address_id
LIMIT 5;

SELECT 
    e.first_name, e.last_name, t.`name` AS town, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a USING (address_id)
        JOIN
    towns AS t USING (town_id)
ORDER BY e.first_name , e.last_name
LIMIT 5;


SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.`name` AS department_name
FROM
    employees AS e
        JOIN
    departments AS d USING (department_id)
WHERE
    d.`name` = 'Sales'
ORDER BY e.employee_id DESC;

SELECT 
    e.employee_id,
    e.first_name,
    e.salary,
    d.`name` AS department_name
FROM
    employees AS e
        JOIN
    departments AS d USING (department_id)
WHERE
    e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

SELECT 
    e.employee_id, e.first_name
FROM
    employees AS e
        LEFT JOIN
    employees_projects AS ep USING (employee_id)
WHERE
    ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

SELECT 
    e.employee_id, e.first_name, p.`name` AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS ep USING (employee_id)
        JOIN
    projects AS p USING (project_id)
WHERE
    DATE(p.start_date) > '2002-08-13'
        AND p.end_date IS NULL
ORDER BY e.first_name , p.name
LIMIT 5;


SELECT 
    e.employee_id,
    e.first_name,
    IF(YEAR(p.start_date) < 2005,
        p.`name`,
        NULL) AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS ep USING (employee_id)
        JOIN
    projects AS p USING (project_id)
WHERE
    e.employee_id = 24
ORDER BY project_name;


SELECT 
    e.employee_id,
    e.first_name,
    e.manager_id,
    m.first_name AS manager_name
FROM
    employees AS e
        INNER JOIN
    employees AS m ON e.manager_id = m.employee_id
WHERE
    e.manager_id IN (3 , 7)
ORDER BY e.first_name;


SELECT 
    e.employee_id,
    CONCAT_WS(' ', e.first_name, e.last_name) AS manager_name,
    CONCAT_WS(' ', m.first_name, m.last_name) AS manager_name,
    d.`name` AS department_name
FROM
    employees AS e
        INNER JOIN
    employees AS m ON e.manager_id = m.employee_id
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    d.manager_id IS NOT NULL
ORDER BY e.employee_id
LIMIT 5;


SELECT 
    e.employee_id,
    CONCAT_WS(' ', e.first_name, e.last_name) AS manager_name,
    CONCAT_WS(' ', m.first_name, m.last_name) AS manager_name,
    d.`name` AS department_name
FROM
    employees AS e
        INNER JOIN
    employees AS m ON e.manager_id = m.employee_id
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    d.manager_id IS NOT NULL
ORDER BY e.employee_id
LIMIT 5;



SELECT 
    AVG(e.salary) AS min_average_salary
FROM
    departments AS d
        JOIN
    employees AS e USING (department_id)
GROUP BY d.`name`
ORDER BY min_average_salary
LIMIT 1;


SELECT 
    mc.country_code, m.mountain_range, p.peak_name, p.elevation
FROM
    mountains_countries AS mc
        JOIN
    mountains AS m ON mc.mountain_id = m.id
        JOIN
    peaks AS p ON m.id = p.mountain_id
WHERE
    mc.country_code = 'BG'
        AND p.elevation > 2835
ORDER BY p.elevation DESC;


SELECT 
    mc.country_code, COUNT(m.mountain_range) AS mountain_range
FROM
    mountains_countries AS mc
        JOIN
    mountains AS m ON mc.mountain_id = m.id
WHERE
    mc.country_code IN ('US' , 'RU', 'BG')
GROUP BY mc.country_code
ORDER BY mountain_range DESC;


SELECT 
    c.country_name, r.river_name
FROM
    countries AS c
        LEFT JOIN
    countries_rivers AS cr USING (country_code)
        LEFT JOIN
    rivers AS r ON cr.river_id = r.id
WHERE
    c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;

CREATE TABLE IF NOT EXISTS `continents_currencies` AS SELECT `c`.`continent_code`,
    `c`.`currency_code`,
    COUNT(`c`.`currency_code`) AS `currency_usage` FROM
    `countries` AS `c`
GROUP BY `c`.`continent_code` , `c`.`currency_code`
HAVING `currency_usage` > 1
ORDER BY `c`.`continent_code` , `c`.`currency_code`;
 
SELECT 
    `cc`.*
FROM
    `continents_currencies` AS `cc`
        LEFT JOIN
    `continents_currencies` AS `cc2` ON `cc`.`continent_code` = `cc2`.`continent_code`
        AND `cc`.`currency_usage` < `cc2`.`currency_usage`
WHERE
    `cc2`.`currency_usage` IS NULL;


SELECT 
    COUNT(*) AS country_count
FROM
    countries AS c
        LEFT JOIN
    mountains_countries AS mc USING (country_code)
WHERE
    mc.mountain_id IS NULL;


SELECT 
    c.country_name,
    MAX(p.elevation) AS highest_peak_elevation,
    MAX(r.length) AS longest_river_length
FROM
    countries AS c
        JOIN
    countries_rivers AS cr USING (country_code)
        JOIN
    rivers AS r ON cr.river_id = r.id
        JOIN
    mountains_countries AS mc USING (country_code)
        JOIN
    mountains AS m ON mc.mountain_id = m.id
        JOIN
    peaks AS p ON m.id = p.mountain_id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC , longest_river_length DESC , c.country_name
LIMIT 5;

