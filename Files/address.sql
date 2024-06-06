-- create
CREATE TABLE address (
  postal_code VARCHAR(10) NOT NULL,
  title VARCHAR(100) NULL,
  city VARCHAR(100) NOT NULL,
  street VARCHAR(200) NOT NULL,
  phone_number VARCHAR(20) NULL,
  latitude DECIMAL(10,6) NULL,
  longitude DECIMAL(10,6) NULL,
  PRIMARY KEY (postal_code)
);

-- insert
INSERT INTO address (postal_code, title, city, street, phone_number, latitude, longitude) 
VALUES 
('12345', 'Home', 'New York', '123 Main Street', '555-1234', 40.7128, -74.0060),
('54321', 'Work', 'Los Angeles', '456 Elm Street', '555-5678', 34.0522, -118.2437);
