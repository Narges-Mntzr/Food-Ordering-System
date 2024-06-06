-- create
CREATE TABLE driver(
  user_id INTEGER PRIMARY KEY,
  car_tag VARCHAR(10) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Function
-- drop function validate_car_tag
CREATE FUNCTION validate_car_tag(@tag VARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @res INT;
    DECLARE @regex VARCHAR(100) = '[0-9][0-9][A-Z][0-9][0-9][0-9]\|[0-9][0-9]$';

    IF (@tag LIKE @regex)
        SET @res = 1;
    ELSE
        SET @res = 0;

    RETURN @res;
END;

-- Trigger
drop trigger check_valid_data
CREATE TRIGGER check_valid_data
ON driver
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @car_tag_valid INT;
    DECLARE @car_tag VARCHAR(20);

    SELECT @car_tag = car_tag
    FROM inserted;

    SELECT @car_tag_valid = dbo.validate_car_tag(@car_tag);

    IF @car_tag_valid = 0
    BEGIN
        print ('Invalid car tag');
    END
    ELSE
    BEGIN
        INSERT INTO customer (user_id, car_tag)
        SELECT user_id, car_tag
        FROM inserted
    END
END;


-- View
CREATE VIEW view_driver_info
AS
SELECT d.*, u.*
FROM driver d
JOIN users u ON d.user_id = u.id;

-- insert
INSERT INTO driver (user_id, car_tag)
VALUES (3, '74A255|13');
INSERT INTO driver (user_id, car_tag)
VALUES (2, '22S987|13');
INSERT INTO driver (user_id, car_tag)
VALUES (1, '31B546|13');

-- test
SELECT dbo.validate_car_tag('74A255|13'); -- Returns 1 (true)
SELECT dbo.validate_car_tag('74A25|13'); -- Returns 0 (false)

select * from driver
select * from view_driver_info