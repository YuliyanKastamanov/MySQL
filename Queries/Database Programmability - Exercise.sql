#exc 01
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT first_name, last_name FROM employees
	WHERE salary > 35000
	ORDER BY first_name, last_name, employee_id;
	END $$
    
DELIMITER ;
    

#exc 02 
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(min_salary DECIMAL(19, 4))
BEGIN
	SELECT first_name, last_name FROM employees
	WHERE salary >= min_salary
	ORDER BY first_name, last_name, employee_id;
    
END $$
DELIMITER ;

#exc 03
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(town_name VARCHAR(50))
BEGIN
	SELECT `name` FROM towns
	WHERE `name` LIKE concat(town_name, '%')
	ORDER BY `name`;
END $$
DELIMITER ;

#exc 04
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
	SELECT e.first_name, e.last_name FROM employees AS e
	LEFT JOIN addresses AS a
	USING(address_id)
	LEFT JOIN towns AS t
	USING(town_id)
	WHERE t.`name` = town_name
	ORDER BY e.first_name, e.last_name, e.employee_id;
END$$ 
DELIMITER ;


#exc 05
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(19, 4))
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    DECLARE salary_level VARCHAR(8);
    IF salary < 30000 THEN SET salary_level := 'Low';
    ELSEIF salary <= 50000 THEN SET salary_level := 'Average';
    ELSE SET salary_level := 'High';
    END IF;
    RETURN salary_level;
END$$
DELIMITER ;


#exc 06
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(19, 4))
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    DECLARE salary_level VARCHAR(8);
    IF salary < 30000 THEN SET salary_level := 'Low';
    ELSEIF salary <= 50000 THEN SET salary_level := 'Average';
    ELSE SET salary_level := 'High';
    END IF;
    RETURN salary_level;
END$$
 
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(8)) 
BEGIN
    SELECT first_name, last_name
    FROM employees
    WHERE ufn_get_salary_level(salary) LIKE salary_level
    ORDER BY first_name DESC, last_name DESC;
END$$
DELIMITER ;


#exc 07
DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN word REGEXP (CONCAT('^[', set_of_letters, ']+$'));
END$$
DELIMITER ;


#exc 08
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name() 
BEGIN
  SELECT CONCAT(`first_name`, " ", `last_name`) AS `full_name`
  FROM `account_holders`
  ORDER BY `full_name`, `id`;
END $$
DELIMITER ;


#exc 11
DELIMITER $$

CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19, 4), yearly_interest DOUBLE, yers INT)
RETURNS DECIMAL(19, 4)
DETERMINISTIC
BEGIN
    DECLARE future_sum DECIMAL(19, 4);
    SET future_sum := sum * POW(1 + yearly_interest, yers);
    RETURN future_sum;
END$$

CREATE PROCEDURE usp_calculate_future_value_for_account(id INT, interest_rate DECIMAL(19,4))
BEGIN
    SELECT a.`id` AS 'account_id', ah.`first_name`, ah.`last_name`, 
    a.`balance` AS 'current_balance', ufn_calculate_future_value(a.balance, interest_rate, 5) AS 'balance_in_5_years'
    FROM `account_holders` AS ah
    JOIN `accounts` AS a ON a.`account_holder_id` = ah.`id`
    WHERE a.`id` = id;
END$$
DELIMITER ;


#exc 12
DELIMITER $$
CREATE PROCEDURE usp_deposit_money(id INT, money_amount DECIMAL(19,4))
BEGIN
    START TRANSACTION;
    IF(money_amount <= 0 ) THEN
    ROLLBACK;
    ELSE
        UPDATE `accounts` AS ac SET ac.`balance` = ac.`balance` + money_amount
        WHERE ac.`id` = id;
    END IF; 
END $$
DELIMITER ;


#exc 13
DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(id int, money_amount decimal(19,4))
BEGIN
    START TRANSACTION;
    IF (money_amount <= 0 OR (SELECT `balance` FROM accounts AS a WHERE a.`id` = id) < money_amount) THEN
    ROLLBACK;
    ELSE
        UPDATE accounts as ac SET ac.balance = ac.balance - money_amount
        WHERE ac.id = id;
        COMMIT;
    END IF; 
END $$
DELIMITER ;


#exc 14
DELIMITER $$

CREATE PROCEDURE usp_transfer_money(fromID int, toID int,money_amount decimal(19,4))
BEGIN
    START TRANSACTION;
    IF(money_amount <= 0 OR (SELECT `balance` from `accounts` where `id` = fromID) < money_amount
    OR fromID = toID 
    OR (SELECT COUNT(id) FROM `accounts` WHERE `id` = fromID) <> 1
    OR (SELECT COUNT(id) FROM `accounts` WHERE `id` = toID) <> 1) 
    THEN ROLLBACK;
    ELSE
        UPDATE `accounts` SET `balance` = `balance` - money_amount
        WHERE `id` = fromID;
        UPDATE `accounts` SET `balance` = `balance` + money_amount
        WHERE `id` = toID;
        COMMIT;
    END IF; 
END $$
DELIMITER ;


