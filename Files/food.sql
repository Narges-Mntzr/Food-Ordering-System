-- create food table
CREATE TABLE food
(
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT NOT NULL,
    description TEXT,
    image VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES category(id),
);


-------------------------------------------------------------------------------
-- insert data
INSERT INTO food
    (name, price, description, image, category_id)
VALUES
    ('Cheeseburger', 89000, 'Juicy beef patty topped with melted cheese, and pickles, served on a sesame seed bun.', 'cheeseburger.jpg', 2),
    ('Margherita Pizza', 10900, 'Classic pizza topped with fresh tomato sauce, mozzarella cheese, and basil leaves.', 'margherita_pizza.jpg', 2),
    ('Caesar Salad', 74000, 'Crisp romaine lettuce tossed with Caesar dressing, croutons, and Parmesan cheese.', 'caesar_salad.jpg', 1),
    ('Chocolate Brownie', 59900, 'Rich and fudgy chocolate brownie served warm with a scoop of vanilla ice cream.', 'chocolate_brownie.jpg', 3),
    ('Iced Tea', 40000, 'Refreshing iced tea served with a slice of lemon and ice cubes.', 'iced_tea.jpg', 4),
    ('Chicken Alfredo', 129000, 'Creamy pasta dish with grilled chicken breast, tossed in Alfredo sauce and garnished with parsley.', 'chicken_alfredo.jpg', 2),
    ('Mango Smoothie', 49900, 'Thick and creamy smoothie made with ripe mangoes, yogurt, and honey.', 'mango_smoothie.jpg', 4);

-------------------------------------------------------------------------------
-- select table
SELECT * FROM food;