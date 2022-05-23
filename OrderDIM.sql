drop sequence order_seq;
create sequence order_seq
start with 10001
increment by 1;

drop table DIM_orders;
create table DIM_Orders
(
order_key    number      not null,
orderId      number      not null,
usersId       number(5)   not null,
branchId     number(5)   not null,
riderId      number(5)   not null,
promotionId  number(5)   not null,
amount       number(7,2) not null,
discount     number(7,2) not null,
rating       number(1)   not null,
name         varchar(50) not null,
lateNo       number(5)   not null,
menuListId   number(5)   not null,
quantity     number(3)   not null,
primary key(order_key)
);

insert into DIM_orders
select order_seq.nextval,
       o.orderId, o.usersId, o.branchId, r.riderId, o.promotionId, o.amount,
       o.discount, o.rating, UPPER(r.name), r.lateNo, od.menuListId, od.quantity
from orders o, rider r, orderDetails od
where o.orderId=od.orderId and o.riderId=r.riderId;





---- coding, if some column is null and DIM_XXX table is not null
load data into cursor
  while(cursor row exist)
     if state is null, replace with CITY or Country data
         INSERT into DIM_office ...
	 v_state :=v_city;
     end if
end loop


