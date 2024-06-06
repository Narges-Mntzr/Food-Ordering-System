create table discount (
discount_code int not null,
amount int null,
type varchar(10) null check ( type in ('percent', 'cash')),
expire_time datetime null,
primary key(discount_code)
);

INSERT INTO discount 
    (discount_code, amount, type, expire_time)
VALUES
    (1, 10, 'percent', '2024-11-09 15:45:21'),
    (2, 20, 'percent', '2024-9-09 22:10:21'),
    (3, 30000, 'cash', '2024-10-09 23:45:21')
