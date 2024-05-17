-- create payment table
CREATE TABLE payment (
    id INT PRIMARY KEY IDENTITY(1,1),
    price DECIMAL(10, 2) NOT NULL,
    card_number VARCHAR(20) NOT NULL,
    status VARCHAR(10) DEFAULT 'pending' CHECK (status IN ('canceled', 'pending', 'success')),
    order_number INT NOT NULL,
    FOREIGN KEY (order_number) REFERENCES orders(order_number)
);

-------------------------------------------------------------------------------
-- insert data
INSERT INTO payment 
    (order_number, price, card_number, status)
VALUES
    (10001, 356000, '1234-5678-9012-3456', 'canceled'),
    (10001, 356000, '1234-5678-9012-3456', 'canceled'),
    (10002, 90900, '2345-6789-0123-4567', 'success'),  
    (10003, 188900, '3456-7890-1234-5678', 'success'), 
    (10004, 49900, '4567-8901-2345-6789', 'canceled'),
    (10004, 49900, '4567-8901-2345-6789', 'success'),
    (10005, 89000, '5678-9012-3456-7890', 'canceled'), 
    (10006, 247900, '6789-0123-4567-8901', 'success'), 
    (10008, 40000, '8901-2345-6789-0123', 'pending'),  
    (10009, 49900, '9012-3456-7890-1234', 'success'),  
    (10010, 49900, '0123-4567-8901-2345', 'success');  

-------------------------------------------------------------------------------
-- triggers 
CREATE TRIGGER UpdateOrderStatus
ON payment
AFTER INSERT
AS
BEGIN
    DECLARE @order_number INT;
    DECLARE @status VARCHAR(10);

    SELECT @order_number = inserted.order_number,
           @status = inserted.status
    FROM inserted;

    IF @status = 'success'
    BEGIN
        UPDATE orders
        SET status = 'success'
        WHERE order_number = @order_number;
    END;
END;

-- test UpdateOrderStatus trigger
INSERT INTO payment 
    (order_number, price, card_number, status)
VALUES
    (10007, 10900, '1234-5678-9012-3456', 'success');

-------------------------------------------------------------------------------
-- select table
SELECT * FROM payment;