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