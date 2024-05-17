-- create deliveryCourier table
CREATE TABLE deliveryCourier (
    id INT PRIMARY KEY  IDENTITY(1,1),
    start_time DATETIME NOT NULL,
    end_time DATETIME DEFAULT NULL,
    driver_id INT NOT NULL,
    status VARCHAR(10) DEFAULT 'pending' CHECK (status IN ('pending', 'started', 'finished')),
    -- FOREIGN KEY (driver_id) REFERENCES driver(id)
);

-------------------------------------------------------------------------------
-- insert data
INSERT INTO deliveryCourier 
    (start_time, end_time, driver_id, status)
VALUES
    ('2024-05-15 09:15:00', '2024-05-15 11:00:00', 2, 'finished'),
    ('2024-05-15 12:00:00', '2024-05-15 14:00:00', 2, 'finished'),
    ('2024-05-16 08:00:00', '2024-05-16 10:00:00', 1, 'finished'),
    ('2024-05-17 10:30:00', NULL, 1, 'pending'),
    ('2024-05-17 15:30:00', NULL, 2, 'started');


-------------------------------------------------------------------------------
-- select table
SELECT * FROM deliveryCourier;