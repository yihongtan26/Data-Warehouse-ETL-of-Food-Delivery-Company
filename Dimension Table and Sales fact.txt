-------------------------------------------------------------------------------------------
create sequence DIM_menu_seq
start with 10001
increment by 1;

create table DIM_menu
(menu_key 		 number  	 not null,
 menu_list_id 		 number(5) 	 not null,
 menu_name 		 varChar(100) 	 not null,
 category_id		 number(5)	 not null,
 category_name 		 varChar(50) 	 not null,
 time_meal_id 		 number(5) 	 not null,
 time_section 		 varchar(50) 	 not null,
 price_per_unit 	 number(6,2) 	 not null,
 unit_sold		 number(6) 	 not null,
 restaurant_id		 number(5)	 not null,
 primary key(menu_key)
);

insert into DIM_menu
select DIM_menu_seq.nextval,m.menuListId, UPPER(m.name), m.categoryID,UPPER(c.name),
	m.timemealID,UPPER(t.timeSection),m.pricePerUnit,m.unitSold,m.restaurantid
from menulist m, timemeal t, category c
where m.categoryid = c.categoryid AND m.timemealid = t.timemealid;
--------------------------------------------------------------------------------------------


DROP sequence DIM_Restaurant_seq;
CREATE sequence DIM_Restaurant_seq
START with 10001
Increment by 1;


Create Table Dim_Restaurants 
(restaurant_key 	number 		not null, 
restaurantID 		number(5) 	not null, 
rest_BranchID 		number(5) 	not null, 
rest_name 		varchar(60) 	not null, 
rest_TypeName 		varchar(20) 	not null, 
rest_city 		varchar(30) 	not null, 
rest_state 		varchar(20) 	not null, 
rest_postcode 		NUMBER(7) 	not null, 
primary key(restaurant_key) 
);

INSERT into DIM_Restaurants
SELECT DIM_Restaurant_seq.nextval,
       A.restaurantID,B.BranchID, UPPER(A.name),
       UPPER(C.typeName), UPPER(B.city),
       UPPER(B.state), B.postcode
FROM Restaurant A, Branch B, RestaurantType C
WHERE (A.restaurantID = B.restaurantID) AND
      (A.restaurantTypeID = C.restaurantTypeID);
--------------------------------------------------------------------------------------------

Create Table Dim_Users 
(user_key 	number 		not null,
user_ID 	number(5) 	not null, 
user_Name 	varchar(50) 	not null,
user_Gender 	char(1) 	not null,
user_dob 	date 		not null,
postcode 	number(7) 	not null,
city 		varchar(30) 	not null,
state 		varchar(30) 	not null,
primary key(user_key)
);

CREATE sequence dim_users_seq
Start with 10001
Increment by 1;

Insert into DIM_USERS
Select dim_users_seq.nextval,
	usersID, upper(name), upper(gender), dob, postcode, upper(city) , upper(state)
from users; 

---------------------------------------------------------------------------------------------
Create Table DIM_riders
(rider_key 	number 		not null,
 rider_id 	number(5) 	not null,
 rider_Name 	varchar(50) 	not null,
 rider_LateNo 	number(5)	not null,
 primary key(rider_key) 
);

CREATE sequence dim_rider_seq
Start with 10001
Increment by 1;

Insert into DIM_riders
Select dim_rider_seq.nextval,
	riderID, upper(name),lateNO
from rider; 

-------------------------------------------------------------------------------------------------
Create Table DIM_Promotion
(promotion_key 	number 		not null,
 promotion_id 	number(5)	not null,
 promotion_code varchar(15) 	not null,
 discount_rate 	number(2)	not null,
 primary key(promotion_key)     
);

CREATE sequence dim_promotion_seq
Start with 10001
Increment by 1;

Insert into DIM_Promotion values (10000, 10000,'NONE', 0);
Insert into DIM_Promotion
Select dim_promotion_seq.nextval,
	promotionId, upper(promotecode), discountrate
from promotion; 


---------------------------------------------------------------------------------------------

-- generate 10 years of date , e.g. 2011 to 2020
drop sequence date_seq;
create sequence date_seq
start with 100001
increment by 1;

drop table DIM_Date;
create table DIM_Date
(Date_key             number    not null,-- surrogate key
 cal_date             date      not null, -- every date of the date range
 dayOfWeek            number(1), -- 1 to 7
 dayNum_calMonth      number(2), -- 1 to 31
 dayNum_calYear       number(3), -- 1 to 366
 calWeek_endDate      date,
 calWeek_numYear      number(2), -- 1 to 53 weeks
 calMonth_name        varchar(9), -- JANUARY to DECEMBER
 calMonth_numYear     number(2),  -- 01 to 12
 cal_year_month       char(7),    -- 'YYYY-MM'
 cal_quarter          char(2),    -- 'Q1' to 'Q4'
 cal_Year             number(4),
 holiday_ind          char(1),    -- 'Y' or 'N'
 weekday_ind          char(1),    -- 'Y' or 'N'
primary key(Date_key) 
);

create or replace procedure prc_Updt_Holiday(in_Date IN date) IS
begin
   update DIM_Date
   set holiday_ind = 'Y'
   where cal_date = in_Date;
   if (SQL%NOTFOUND) then
      dbms_output.put_line('No rows updated');
   else
      dbms_output.put_line('Data updated');
   end if;
exception
   when OTHERS then
      dbms_output.put_line('Database errors...');
end;
/
exec prc_Updt_Holiday('31-DEC-21')
----------------------------------------------------------------------------------------------------------------------------------------------------
drop table temp_table
CREATE TABLE temp_order AS SELECT * FROM orders;

UPDATE temp_order
SET  promotionid = 10000
WHERE promotionid IS NULL;

create table SALES_FACT
(date_key     		number 			not null,
 menu_key     		number 			not null,
 user_key 		number 			not null,
 rider_key 		number 			not null,
 restaurant_key	  	number		   	not null,
 promotion_key	 	number 			not null,
 orderid	 	number	 		not null,
 quantity 	 	number(3)	  	not null,
 price_each	 	number(6,2) 		not null,
 line_total	 	number(9,2) 		not null,
 discount_amount 	number(7,2) 		not null,
 actual_amount_paid 	number(7,2) 		not null,
 rating		 	number(1) 		not null,
 order_date	  	date		   	not null,
 primary key(date_key,menu_key, user_key, rider_key,restaurant_key,promotion_key, orderID),
 FOREIGN KEY (date_Key) REFERENCES DIM_DATE (date_Key),
 FOREIGN KEY (menu_key) REFERENCES DIM_menu (menu_key),
 FOREIGN KEY (user_key) REFERENCES DIM_Users (user_key),
 FOREIGN KEY (rider_key) REFERENCES DIM_Riders (rider_key),
 FOREIGN KEY (restaurant_key) REFERENCES DIM_restaurants (restaurant_key),
 FOREIGN KEY (promotion_key) REFERENCES DIM_promotion (promotion_key)
);

insert into Sales_Fact
select d.date_key,m.menu_key, u.user_key, r.rider_key,e.restaurant_key,p.promotion_key,b.orderid,b.quantity,m.price_per_unit, (b.quantity*m.price_per_unit) AS line_total, (b.quantity*m.price_per_unit*(p.discount_rate/100)) AS discount_amount,
		(b.quantity*m.price_per_unit)-((b.quantity*m.price_per_unit)*(p.discount_rate/100)) AS actual_amount_paid,o.rating, o.orderdatetime
from DIM_Date D
     join temp_order o
          on trunc(d.cal_date) = trunc(o.orderdatetime)
     join orderdetails b
          on b.orderid = o.orderid
     join DIM_menu M
          on M.menu_list_id = b.menulistid
     join DIM_Users U
          on U.user_id = o.usersid
     join DIM_Riders R
          on R.rider_id = o.riderid
     join DIM_promotion P
          on P.promotion_id = o.promotionid
     join DIM_restaurants E
          on E.rest_branchID = o.branchID;
