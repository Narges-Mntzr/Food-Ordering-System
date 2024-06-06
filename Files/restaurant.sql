drop table restaurant

create table restaurant (
id int not null identity(1,1),
name varchar(20) not null,
create_time datetime null,
address varchar(50),
primary key(id)
);

INSERT INTO restaurant 
    ( name, create_time, address)
VALUES
    ('shahrzad', '2008-11-09 15:45:21', 'chaharbagh'),
    ('aseman', '2018-10-2 11:45:20', 'sanaati'),
    ('pizapiza', '2015-12-01 14:02:20', 'sepahanshahr');


CREATE VIEW restaurant_view AS
WITH average_score AS
    (SELECT AVG(score) AS avg_score, restaurant_id as r_id
    FROM opinion
    GROUP BY restaurant_id
),
totalSales AS
    (SELECT COUNT(*) AS tot_sales, restaurant_id as re_id
    FROM orders
    GROUP BY restaurant_id
)
SELECT id , name , create_time, address, avg_score, tot_sales
FROM restaurant 
INNER JOIN average_score ON (restaurant.id = average_score.r_id) 
INNER JOIN totalSales ON (restaurant.id = totalSales.re_id);
