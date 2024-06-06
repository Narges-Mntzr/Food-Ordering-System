drop table users
-- create
CREATE TABLE users (
    id INT PRIMARY KEY identity(1,1),
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone_num VARCHAR(20),
    email VARCHAR(100) NOT NULL UNIQUE,
    identify_code VARCHAR(10) NOT NULL 
);
-- insert
INSERT INTO users (password, name, phone_num, email, identify_code)
VALUES ('mypassword123', 'Shirin Behnaminia', '1234567890', 'shirin.beh@example.com', 'ABC123');

INSERT INTO users (password, name, email, identify_code)
VALUES ('qwerty456', 'Narges Montazeri', 'narges81@example.com', 'XYZ789');

INSERT INTO users (password, name, phone_num, email, identify_code)
VALUES ('securepass', 'Parto Sabzevari', '9876543210', 'parto@example.net', 'DEF456');

-- test
select * from users;