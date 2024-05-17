create table discount (
discount_code int not null,
amount int null,
type varchar(10) null check ( status in ('percent', 'cash')),
status  varchar(10) null check ( status in ('used', 'not used')),
expire_time datetime null,
primary key(discount_code)
);

INSERT INTO discount 
    (discount_code, amount, type, status, expire_time)
VALUES
    (1, 10, 'percent', 'not used', '2024-11-09 15:45:21'),
    (2, 20, 'percent', 'not used', '2024-9-09 22:10:21'),
    (3, 30000, 'cash', 'not used', '2024-10-09 23:45:21')