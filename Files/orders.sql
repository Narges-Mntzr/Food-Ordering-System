CREATE TABLE orders (
    order_number INT PRIMARY KEY,
    date_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(10) DEFAULT 'pending' CHECK (status IN ('canceled', 'pending', 'success')),
    delivery_courier_id INT NULL,
    FOREIGN KEY (delivery_courier_id) REFERENCES deliveryCourier(id)
);
