-- create orderDetail table
CREATE TABLE orderDetail
(
    order_number INT NOT NULL,
    food_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_number, food_id),
    FOREIGN KEY (order_number) REFERENCES orders(order_number),
    FOREIGN KEY (food_id) REFERENCES food(id)
);

-------------------------------------------------------------------------------
-- insert data
INSERT INTO orderDetail 
    (order_number, food_id, quantity)
VALUES
    -- Order 10001
    (10001, 1, 2), -- Cheeseburger x2
    (10001, 3, 1),  -- Caesar Salad x1
    -- Order 10002
    (10002, 2, 1),  -- Margherita Pizza x1
    (10002, 5, 2),  -- Iced Tea x2
    -- Order 10003
    (10003, 4, 1),  -- Chocolate Brownie x1
    (10003, 6, 1), -- Chicken Alfredo x1
    -- Order 10004
    (10004, 7, 1),  -- Mango Smoothie x1
    -- Order 10005
    (10005, 1, 1),  -- Cheeseburger x1
    -- Order 10006
    (10006, 3, 1),  -- Caesar Salad x1
    (10006, 4, 1),  -- Chocolate Brownie x1
    (10006, 6, 1), -- Chicken Alfredo x1
    -- Order 10007
    (10007, 2, 1),  -- Margherita Pizza x1
    -- Order 10008
    (10008, 5, 1),  -- Iced Tea x1
    -- Order 10009
    (10009, 7, 1),  -- Mango Smoothie x1
    -- Order 10010
    (10010, 7, 1);  -- Mango Smoothie x1

-------------------------------------------------------------------------------
-- select table
SELECT * FROM orderDetail;