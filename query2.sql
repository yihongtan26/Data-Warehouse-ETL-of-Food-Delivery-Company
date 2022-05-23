2. Total Sales Of Each State For Year 2020 Compared To 2019

set pagesize 200
column state format a20
column Total_Sales2019 format 999,999,999.00
column Total_Sales2020 format 999,999,999.00
column Sales_DIff format 9,999,999.00
column Percent_Sales_Diff format 999.00 
COLUMN Total_Order2019 HEADING 'Total|Order|2019'
COLUMN Total_Order2020 HEADING 'Total|Order|2020'
COLUMN Total_Sales2019 HEADING 'Total|Sales|2019'
COLUMN Total_Sales2020 HEADING 'Total|Sales|2020'
COLUMN Sales_Diff HEADING 'Sales|Diff'
COLUMN Percent_Sales_Diff HEADING 'Percent|Sales|Diff'


CREATE OR REPLACE VIEW top_state2020 AS
SELECT A.*, 2020 AS Year_NUM 
FROM (SELECT u.state, COUNT(*) AS Total_Order2020,
      SUM(line_total) AS Total_Sales2020
      FROM dim_users u, sales_fact s
      WHERE EXTRACT(year from s.order_date) = 2020 AND u.user_key = s.user_key
      GROUP BY u.state
      ORDER BY Total_Sales2020 DESC) A;

CREATE OR REPLACE VIEW top_state2019 AS
SELECT B.*,2019 AS Year_NUM 
FROM (SELECT u.state, count(*) AS Total_Order2019, 
      SUM(line_total) AS Total_Sales2019
      FROM dim_users u, sales_fact s
      WHERE EXTRACT(year FROM s.order_date) = 2019 AND u.user_key = s.user_key
      GROUP BY u.state
      ORDER BY Total_Sales2019 DESC) B;

set linesize 100
TTITLE CENTER 'Total Sales Of Each State For Year 2020 Compared To 2019' SKIP 1 -
CENTER      ========================================================== SKIP 1

SELECT a.state, a.total_order2019 AS Total_Order2019, a.total_sales2019 AS Total_Sales2019,
       b.total_order2020 AS Total_Order2020, b.total_sales2020 AS Total_Sales2020,
       (b.total_sales2020-a.total_sales2019) AS Sales_Diff,
       ROUND((((b.total_sales2020-a.total_sales2019)/a.total_sales2019) * 100),2) AS Percent_Sales_Diff
FROM top_state2019 a, top_state2020 b
WHERE a.state = b.state
ORDER BY Total_Sales2019 DESC;