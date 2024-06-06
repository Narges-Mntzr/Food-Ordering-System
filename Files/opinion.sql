drop table opinion

create table opinion (
opinion_id int not null identity(1,1),
user_id int not null,
restaurant_id int not null,
score int check (score>0 and score<=5),
text varchar(100) null,
primary key(opinion_id),
foreign key (user_id) references users(id),
foreign key (restaurant_id) references restaurant(id)
);

INSERT INTO opinion 
    ( user_id, restaurant_id, score, text)
VALUES
    ( 1, 1, 5, 'perfect'),
    ( 2, 3, 3 , 'not bad'),
    ( 3, 2, 2, 'bad')


--drop function restaurant_opinions
create function restaurant_opinions (@restaurant_id int)
returns @ReturnTable table(

	restaurant_id int NOT NULL,
	text varchar(100) null,
	user_id int
) 
AS   
BEGIN  
INSERT @ReturnTable
SELECT restaurant_id, text , user_id
FROM opinion 
Where @restaurant_id = restaurant_id
RETURN;
END;  

-- drop view get_avg_rate
create view get_avg_rate as
select restaurant_id , avg(score) as avg_rate 
from opinion
group by restaurant_id


select * from get_avg_rate 
order by avg_rate desc


SELECT *
FROM restaurant_opinions(2)