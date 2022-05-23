set serveroutput on
-- write anonymous block of code to generate date data

declare
   start_date      date; -- start of analysis date
   end_date        date; -- end of analysis date 
   v_dayOfWeek     number(1);
   v_dayNumCalMth  number(2);
   v_dayNumCalYr   number(3);
   v_weekEndDate   date;
   v_weekYear      number(2);
   v_calMonthName  varchar(9);
   v_calMonthNo    number(2);
   v_calYear_month char(7);
   v_quarter       char(2);
   v_calYear       number(4);
   v_weekDay_ind   char(1);
   v_holiday_ind   char(1);
   
begin
-- set the start and end date e.g. date from 1 Jan 2011 to 31 Dec 2020
   start_date := to_date('01/01/2015','dd/mm/yyyy');
   end_date   := to_date('31/12/2021','dd/mm/yyyy');
   v_holiday_ind := 'N';

   while (start_date <= end_date) LOOP
      v_dayOfWeek    := to_char(start_date,'D');
      v_dayNumCalMth := extract (day from start_date);
      v_dayNumCalYr  := to_char(start_date,'ddd');
      v_weekEndDate  := start_date+(7-to_char(start_date,'d'));
      v_weekYear     := to_char(start_date,'ww');
      v_calMonthName := to_char(start_date,'MONTH');     
      v_calMonthNo   := extract (month from start_date);
      v_calYear_month:= to_char(start_date,'YYYY-MM');
      v_calYear      := extract (year from start_date);

      if (v_calMonthNo <=3) then
         v_quarter :='Q1';
      elsif (v_calMonthNo <=6) then
         v_quarter :='Q2';
      elsif (v_calMonthNo <=9) then
         v_quarter :='Q3';
      else
         v_quarter :='Q4';
      end if;

      if (v_dayOfWeek BETWEEN 2 and 6) then
          v_weekDay_ind := 'Y';  
      else
          v_weekDay_ind := 'N';
      end if;

 insert into DIM_Date values(
             date_seq.nextval, start_date, v_dayOfWeek,
             v_dayNumCalMth,v_dayNumCalYr, v_weekEndDate, v_weekYear,
             v_calMonthName, v_calMonthNo, v_calYear_month, v_quarter,
             v_calYear, v_holiday_ind, v_weekDay_ind); 

/*
      dbms_output.put_line(date_seq.nextval||' date is : '||to_char(start_date,'dd-mm-yyyy')||
      ' '||v_dayOfWeek||' '||v_dayNumCalMth||' '||v_dayNumCalYr||' '||v_weekDay_ind);
*/

      start_date := start_date+1;
   end LOOP;
end;
/

select date_key, cal_date, cal_quarter, weekday_ind,
       holiday_ind, calWeek_endDate
from DIM_date
order by 1;

select min(orderDate), max(orderDate)
from orders;

















