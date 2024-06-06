create table opinion (
opinion_id int not null,
user_id int not null,
restaurant_id int not null,
score int check (score>0 and score<=5),
text varchar(100) null,
primary key(opinion_id),
foreign key (user_id) references users(id),
foreign key (restaurant_id) references restaurant(id)
);

INSERT INTO opinion 
    (opinion_id, user_id, restaurant_id, score, text)
VALUES
    (11, 1, 101, 5, 'perfect'),
    (22, 2, 102, 3 , 'not bad'),
    (33, 3, 103, 2, 'bad')

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

SELECT *
FROM restaurant_opinions(101)