-- create
CREATE TABLE customer (
  user_id INTEGER PRIMARY KEY,
  nat_code VARCHAR(20) NOT NULL,
  default_address VARCHAR(10),
  FOREIGN KEY (default_address) REFERENCES address(postal_code),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Functions 
CREATE FUNCTION check_nat_code(@NatCode VARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @valid INT;
    DECLARE @C INT;
    DECLARE @N INT;
    DECLARE @R INT;

    SET @C = CAST(SUBSTRING(@NatCode, 10, 1) AS INT);
    SET @N = (CAST(SUBSTRING(@NatCode, 1, 1) AS INT) * 10) +
             (CAST(SUBSTRING(@NatCode, 2, 1) AS INT) * 9) +
             (CAST(SUBSTRING(@NatCode, 3, 1) AS INT) * 8) +
             (CAST(SUBSTRING(@NatCode, 4, 1) AS INT) * 7) +
             (CAST(SUBSTRING(@NatCode, 5, 1) AS INT) * 6) +
             (CAST(SUBSTRING(@NatCode, 6, 1) AS INT) * 5) +
             (CAST(SUBSTRING(@NatCode, 7, 1) AS INT) * 4) +
             (CAST(SUBSTRING(@NatCode, 8, 1) AS INT) * 3) +
             (CAST(SUBSTRING(@NatCode, 9, 1) AS INT) * 2);

    SET @R = @N % 11;

    IF ((@R = 0 AND @C = 0) OR (@R = 1 AND @C = 1) OR (@R > 1 AND @C = 11 - @R))
        SET @valid = 1;
    ELSE
        SET @valid = 0;

    RETURN @valid;
END;



-- Triggers
CREATE TRIGGER check_valid_nat
ON customer
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @nat_code_valid INT;
    DECLARE @nat_code VARCHAR(20);

    SELECT @nat_code = nat_code
    FROM inserted;

    SELECT @nat_code_valid = dbo.check_nat_code(@nat_code);

    IF @nat_code_valid = 0
    BEGIN
        print ('Invalid nat_code: %s');
    END
    ELSE
    BEGIN
        INSERT INTO customer (user_id, nat_code)
        SELECT user_id, nat_code
        FROM inserted;
    END
END;


-- View
CREATE VIEW view_customer_info
AS
SELECT c.*, u.*
FROM customer c
JOIN users u ON c.user_id = u.id;


CREATE VIEW view_customer_address
AS
SELECT c.*, a.*
FROM customer c
JOIN address a ON c.default_address = a.postal_code;


-- insert
    -- valid
    INSERT INTO customer (user_id, nat_code)
    VALUES (1, '1273789857');

    INSERT INTO customer (user_id, nat_code, default_address)
    VALUES (2, '1273789857', '12345');

    -- invalid
    INSERT INTO customer (user_id, nat_code)
    VALUES (2, 'DEF789');

    INSERT INTO customer (user_id, nat_code)
    VALUES (100, 'DEF789');

-- test
select * from customer;
select * from view_customer_info;
select * from view_customer_address;