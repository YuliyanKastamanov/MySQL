CREATE TABLE contries (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL UNIQUE,
    continent VARCHAR(30) NOT NULL,
    currency VARCHAR(5) NOT NULL
);

CREATE TABLE actors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    height INT,
    awards INT,
    country_id INT NOT NULL,
    CONSTRAINT fk_actors_countries FOREIGN KEY (country_id)
        REFERENCES contries (id)
);


CREATE TABLE movies_additional_info (
    id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(10 , 2 ) NOT NULL,
    runtime INT NOT NULL,
    picture_url VARCHAR(80) NOT NULL,
    budget DECIMAL(10 , 2 ),
    release_date DATE NOT NULL,
    has_subtitles TINYINT(1),
    `description` TEXT
);

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(70) UNIQUE,
    country_id INT NOT NULL,
    movie_info_id INT NOT NULL UNIQUE,
    CONSTRAINT fk_movies_movies_additional_info FOREIGN KEY (movie_info_id)
        REFERENCES movies_additional_info (id),
    CONSTRAINT fk_movies_countries FOREIGN KEY (country_id)
        REFERENCES contries (id)
);


CREATE TABLE genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE genres_movies (
    genre_id INT,
    movie_id INT,
    KEY pk_genre_movies (genre_id , movie_id),
    CONSTRAINT fk_genres_movies_genres FOREIGN KEY (genre_id)
        REFERENCES genres (id),
    CONSTRAINT fk_genres_movies_movies FOREIGN KEY (movie_id)
        REFERENCES movies (id)
);

CREATE TABLE movies_actors (
    movie_id INT,
    actor_id INT,
    KEY pk_movies_actors (movie_id , actor_id),
    CONSTRAINT fk_movies_actors_movies FOREIGN KEY (movie_id)
        REFERENCES movies (id),
    CONSTRAINT fk_movies_actors_actors FOREIGN KEY (actor_id)
        REFERENCES actors (id)
);


#exc 02
INSERT INTO actors (first_name, last_name, birthdate, height, awards, country_id)
SELECT (REVERSE(a.first_name)), (REVERSE(a.last_name)), (DATE (a.birthdate - 2)), (a.height + 10), (a.country_id),(3) FROM actors AS a
WHERE a.id <= 10;


UPDATE movies_additional_info 
SET 
    runtime = runtime - 10
WHERE
    id BETWEEN 15 AND 25;


DELETE c FROM countries AS c
        LEFT JOIN
    movies AS m2 ON c.id = m2.country_id 
WHERE
    m2.country_id IS NULL;


SELECT 
    *
FROM
    countries
ORDER BY currency DESC , id;


SELECT 
    m.id, m.title, ma.runtime, ma.budget, ma.release_date
FROM
    movies AS m
        JOIN
    movies_additional_info AS ma ON m.movie_info_id = ma.id
WHERE
    YEAR(ma.release_date) BETWEEN 1996 AND 1999
ORDER BY ma.runtime , m.id
LIMIT 20;


SELECT 
    CONCAT_WS(' ', a.first_name, a.last_name) AS full_name,
    CONCAT((REVERSE(a.last_name)),
            (CHAR_LENGTH(a.last_name)),
            '@cast.com') AS email,
    (2022 - YEAR(a.birthdate)) AS age,
    a.height
FROM
    actors AS a
        LEFT JOIN
    movies_actors AS ma ON a.id = ma.actor_id
WHERE
    ma.actor_id IS NULL
ORDER BY a.height;


SELECT 
    c.`name`, COUNT(m.id) AS movies_count
FROM
    countries AS c
        LEFT JOIN
    movies AS m ON c.id = m.country_id
GROUP BY c.`name`
HAVING movies_count >= 7
ORDER BY c.`name` DESC;


SELECT 
    m.title,
    (CASE
        WHEN ma.rating <= 4 THEN 'poor'
        WHEN ma.rating <= 7 THEN 'good'
        ELSE 'excellent'
    END) AS rating,
    IF(ma.has_subtitles, 'english', '-') AS subtitles,
    ma.budget
FROM
    movies AS m
        LEFT JOIN
    movies_additional_info AS ma ON m.movie_info_id = ma.id
ORDER BY ma.budget DESC;


#exc 10
DELIMITER $$


CREATE FUNCTION udf_actor_history_movies_count(full_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN

RETURN(
SELECT COUNT(g.`name`) FROM actors AS a
LEFT JOIN movies_actors AS ma
ON a.id = ma.actor_id
LEFT JOIN movies AS m
ON ma.movie_id = m.id
LEFT JOIN genres_movies AS gm
ON m.id = gm.movie_id
LEFT JOIN genres AS g
ON gm.genre_id = g.id
WHERE (concat_ws(' ', a.first_name, a.last_name)) = full_name AND g.`name` = 'History'
GROUP BY g.`name`);


END;

DELIMITER ;


#exc 11
DELIMITER $$


CREATE PROCEDURE udp_award_movie (movie_title VARCHAR(50))
BEGIN
	UPDATE actors AS a
	JOIN movies_actors AS ma
	ON a.id = ma.actor_id
	JOIN movies AS m
	ON ma.movie_id = m.id
	SET a.awards = a.awards + 1
	WHERE m.title = movie_title;
END;

DELIMITER ;