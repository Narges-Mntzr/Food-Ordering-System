CREATE TABLE payment (
    id INT PRIMARY KEY,
    price DECIMAL(10, 2) NOT NULL,
    card_number VARCHAR(16) NOT NULL,
    status VARCHAR(10) DEFAULT 'pending' CHECK (status IN ('canceled', 'pending', 'success')),
    order_number INT NOT NULL,
    FOREIGN KEY (order_number) REFERENCES orders(order_number)
);
