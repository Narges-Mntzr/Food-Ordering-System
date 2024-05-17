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
-- select table
SELECT * FROM orders;