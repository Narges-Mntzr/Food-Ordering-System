CREATE TABLE deliveryCourier (
    id INT PRIMARY KEY,
    start_time DATETIME NOT NULL,
    end_time DATETIME DEFAULT NULL,
    status VARCHAR(10) DEFAULT 'pending' CHECK (status IN ('pending', 'started', 'finished')),
    -- FOREIGN KEY (id) REFERENCES driver(id)
);
