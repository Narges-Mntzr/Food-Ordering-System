-- drop table discount
create table discount (
discount_code int not null identity(1,1),
amount int null,
type varchar(10) null check ( type in ('percent', 'cash')),
expire_time datetime null,
primary key(discount_code)
);

INSERT INTO discount 
    (amount, type, expire_time)
VALUES
    ( 10, 'percent', '2024-11-09 15:45:21.000'),
    ( 20, 'percent', '2024-9-09 22:10:21.000'),
    ( 30000, 'cash', '2024-10-09 23:45:21.000')

-- drop view available_discounts
create view available_discounts as
select *
from discount
where expire_time > CURRENT_TIMESTAMP


select * from available_discounts
