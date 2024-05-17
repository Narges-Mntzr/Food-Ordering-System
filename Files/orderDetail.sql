CREATE TABLE orderDetail
(
    order_id INT NOT NULL,
    food_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, food_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_number),
    FOREIGN KEY (food_id) REFERENCES food(id)
);