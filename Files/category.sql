-- create category table
CREATE TABLE category
(
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL
);

-------------------------------------------------------------------------------
-- insert data
INSERT INTO category 
    (name) 
VALUES
    ('Appetizers'),
    ('Main Courses'),
    ('Desserts'),
    ('Beverages');

-------------------------------------------------------------------------------
-- select table
SELECT * FROM category;
