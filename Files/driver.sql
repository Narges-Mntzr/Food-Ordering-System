-- create
CREATE TABLE driver(
  user_id INTEGER PRIMARY KEY,
  car_tag VARCHAR(10) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Function
CREATE FUNCTION validate_car_tag(@tag VARCHAR(10))
RETURNS BOOLEAN
AS
BEGIN
    DECLARE @regex VARCHAR(100) = '^[0-9]{2}[A-Z][0-9]{3}\|[0-9]{2}$'

    IF @tag LIKE @regex
        RETURN True
    ELSE
        RETURN False
END

-- Trigger
CREATE TRIGGER check_valid_data
ON driver
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @car_tag_valid Boolean;
    DECLARE @car_tag VARCHAR(20);

    SELECT @car_tag = inserted.car_tag
    FROM inserted;

    SELECT @car_tag_valid  = check_nat_code(@car_tag)

    IF @car_tag_valid = 0
        BEGIN
            RAISERROR ('Invalid nat_code: %s', 16, 1, (SELECT car_tag FROM inserted));
        END
    ELSE
        BEGIN
            INSERT INTO customer (user_id, car_tag)
            SELECT *
            FROM inserted;
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

-- test
SELECT validate_car_tag('74A255|13'); -- Returns 1 (true)
SELECT validate_car_tag('74A25|13'); -- Returns 0 (false)

select * from driver
select * from view_driver_info