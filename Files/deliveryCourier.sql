-- create deliveryCourier table
CREATE TABLE deliveryCourier (
    id INT PRIMARY KEY  IDENTITY(1,1),
    start_time DATETIME NOT NULL,
    end_time DATETIME DEFAULT NULL,
    driver_id INT NOT NULL,
    status VARCHAR(10) DEFAULT 'pending' CHECK (status IN ('pending', 'started', 'finished')),
    FOREIGN KEY (driver_id) REFERENCES driver(user_id)
);

select * from driver
-------------------------------------------------------------------------------
-- insert data
INSERT INTO deliveryCourier 
    (start_time, end_time, driver_id, status)
VALUES
    ('2024-05-15 09:15:00', '2024-05-15 11:00:00', 2, 'finished'),
    ('2024-05-15 12:00:00', '2024-05-15 14:00:00', 2, 'finished'),
    ('2024-05-16 08:00:00', '2024-05-16 10:00:00', 1, 'finished'),
    ('2024-05-17 10:30:00', NULL, 1, 'pending'),
    ('2024-05-17 15:30:00', NULL, 2, 'started');


-------------------------------------------------------------------------------
-- functions 
CREATE FUNCTION CalculateDeliveryTime (@courier_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @delivery_time INT;

    SELECT @delivery_time = DATEDIFF(MINUTE, start_time, end_time)
    FROM deliveryCourier
    WHERE id = @courier_id;

    RETURN @delivery_time;
END;

-------------------------------------------------------------------------------
-- triggers 
CREATE TRIGGER CheckPendingDeliveryCourier
ON deliveryCourier
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN deliveryCourier AS dc ON i.driver_id = dc.driver_id
        WHERE dc.status <> 'finished'
    )
    BEGIN
        RAISERROR ('Driver already has a pending delivery.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
    ELSE
    BEGIN
        INSERT INTO deliveryCourier (driver_id, start_time, end_time, status)
        SELECT driver_id, start_time, end_time, status
        FROM inserted;
    END;
END;

-- test CheckPendingDeliveryCourier trigger
-- Raise error
INSERT INTO deliveryCourier 
    (start_time, driver_id)
VALUES
    ('2024-05-17 10:30:00', 1);
-- Changed successfully
INSERT INTO deliveryCourier 
    (start_time, driver_id)
VALUES
    ('2024-05-17 10:30:00', 3);

-------------------------------------------------------------------------------
-- select table
SELECT *, dbo.CalculateDeliveryTime(id) AS DeliveryTimeInMinutes
FROM deliveryCourier;
