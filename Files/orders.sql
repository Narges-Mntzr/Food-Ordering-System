-- create orders table
CREATE TABLE orders (
    order_number INT PRIMARY KEY,
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(10) DEFAULT 'pending' CHECK (status IN ('canceled', 'pending', 'success')),
    delivery_courier_id INT NULL,
    FOREIGN KEY (delivery_courier_id) REFERENCES deliveryCourier(id)
);


-------------------------------------------------------------------------------
-- insert data
INSERT INTO orders 
    (order_number, date_time, status, delivery_courier_id)
VALUES
    (10001, DATEADD(DAY, -3, GETDATE()), 'canceled', NULL),
    (10002, DATEADD(DAY, -2, GETDATE()), 'success', 1),
    (10003, DATEADD(DAY, -2, GETDATE()), 'success', 2),
    (10004, DATEADD(DAY, -2, GETDATE()), 'success', 3),
    (10005, DATEADD(DAY, -1, GETDATE()), 'canceled', NULL),
    (10006, GETDATE(), 'success', 4),
    (10007, GETDATE(), 'pending', NULL),
    (10008, GETDATE(), 'pending', NULL),
    (10009, GETDATE(), 'success', 5),
    (10010, GETDATE(), 'success', 5);

-------------------------------------------------------------------------------
-- functions 
CREATE FUNCTION CalculateOrderTotalPrice (@order_number INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @total_price DECIMAL(10, 2);

    SELECT @total_price = SUM(od.quantity * f.price)
    FROM orderDetail od
    INNER JOIN food f ON od.food_id = f.id
    WHERE od.order_number = @order_number;

    RETURN @total_price;
END;

-------------------------------------------------------------------------------
-- triggers 
CREATE TRIGGER CheckOrderStatusBeforeAssignCourier
ON orders
AFTER UPDATE
AS
BEGIN
    IF UPDATE(delivery_courier_id)
    BEGIN
        DECLARE @order_number INT;
        DECLARE @status VARCHAR(10);

        SELECT @order_number = inserted.order_number,
               @status = inserted.status
        FROM inserted;

        IF @status <> 'success'
        BEGIN
            RAISERROR ('Cannot assign delivery courier to order with status other than "success".', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;
    END;
END;

-- test CheckOrderStatusBeforeAssignCourier trigger
-- Raise error
UPDATE orders
SET delivery_courier_id = 1
WHERE order_number = 10001;

-- Changed successfully
UPDATE orders
SET delivery_courier_id = 4
WHERE order_number = 10007;

-------------------------------------------------------------------------------
-- select table
SELECT *, dbo.CalculateOrderTotalPrice(order_number) AS total_price FROM orders;