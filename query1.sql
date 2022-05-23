1. Top 10 Most Popular Restaurant For Year 2020 Second Half Compared To First Half For Selected City

set pagesize 200
column rest_name format a20 TRUNC
column Rest_branchid format 99999 TRUNC
column Total_Orders_1stHalf format 999 TRUNC
column Total_Orders_2ndHalf format 999 TRUNC
column Average_Rating format 9.00 TRUNC
column Total_Sales_1stHalf format 999,999.00 TRUNC
column Total_Sales_2ndHalf format 999,999.00 TRUNC
column Popular_Ranking_1stHalf format 99 TRUNC
column Popular_Ranking_2ndHalf format 99 TRUNC


COLUMN Total_Orders_1stHalf HEADING 'Total|Orders|1stHalf'
COLUMN Total_Sales_1stHalf HEADING 'Total|Sales|1stHalf'
COLUMN Average_Rating_1stHalf HEADING 'Avg|Rating|1stHalf'
COLUMN Popular_Ranking_1stHalf HEADING 'Rank|1st|Half'
COLUMN Total_Orders_2ndHalf HEADING 'Total|Orders|2ndHalf'
COLUMN Total_Sales_2ndHalf HEADING 'Total|Sales|2ndHalf'
COLUMN Average_Rating_2ndHalf HEADING 'Avg|Rating|2ndHalf'
COLUMN Popular_Ranking_2ndHalf HEADING 'Rank|2nd|Half'
COLUMN Rest_branchid HEADING 'Rest|Branch|ID'
COLUMN Rest_Name HEADING 'Rest|Name'


CREATE OR REPLACE VIEW top_rest2020_firstHalf AS
SELECT *
FROM(SELECT r.rest_branchid, r.rest_name, r.rest_city, COUNT(distinct s.orderid) AS Total_Orders_1stHalf,
     SUM(s.line_total) AS Total_Sales_1stHalf, ROUND(AVG(s.rating),2) AS Average_Rating_1stHalf,
     RANK() OVER (ORDER BY count(distinct s.orderid) DESC) Popular_Ranking_1stHalf
     FROM sales_fact s, DIM_restaurants r
     WHERE s.restaurant_key = r.restaurant_key
           AND rest_city = UPPER('&city_input')
           AND EXTRACT(year FROM s.order_date) = 2020
           AND (EXTRACT(month FROM s.order_date) BETWEEN 1 AND 6)
     GROUP BY rest_branchid, rest_name, rest_city
     ORDER BY Total_Orders_1stHalf DESC)
WHERE Popular_Ranking_1stHalf <= 10;

CREATE OR REPLACE VIEW top_rest2020_secondHalf AS
SELECT *
FROM(SELECT r.rest_branchid, r.rest_name,
     COUNT(distinct s.orderid) AS Total_Orders_2ndHalf,
     SUM(s.line_total) AS Total_Sales_2ndHalf, ROUND(AVG(s.rating),2) AS Average_Rating_2ndHalf
     FROM sales_fact s, DIM_restaurants r
     WHERE s.restaurant_key = r.restaurant_key
           AND EXTRACT(year FROM s.order_date) = 2020
           AND (EXTRACT(month FROM s.order_date) BETWEEN 7 AND 12)
     GROUP BY r.rest_branchid, r.rest_name);

set linesize 99
TTITLE CENTER 'Top 10 Most Popular Restaurant For Year 2020 Second Half Compared To First Half For Selected City' SKIP 1 -
CENTER      ================================================================================================= SKIP 1

SELECT a.rest_branchid, a.rest_name, a.Total_Orders_1stHalf, a.Total_Sales_1stHalf,
       a.Average_Rating_1stHalf, a.Popular_Ranking_1stHalf, b.Total_Orders_2ndHalf,
       b.Total_Sales_2ndHalf, b.Average_Rating_2ndHalf,
       RANK() OVER (ORDER BY b.Total_Orders_2ndHalf DESC) Popular_Ranking_2ndHalf
FROM top_rest2020_firstHalf a, top_rest2020_secondHalf b
WHERE a.rest_branchid = b.rest_branchid;