3. Top 10 Most Order Delivered Rider For 2020 Second Half Compared to First Half

set pagesize 200
column rider_name format a20 TRUNC
column rider_id format 99999 TRUNC
column Total_Sales_1stHalf format 999,999.00
column Total_Sales_2ndHalf format 999,999.00
column Total_Orders_1stHalf format 999 
column Total_Orders_2ndHalf format 999 
column Rank_1stHalf format 99 
column Rank_2ndHalf format 99 
column Late_No_1stHalf format 99 
column Late_No_2ndHalf format 99 
COLUMN Total_Orders_1stHalf HEADING 'Total|Orders|1stHalf'
COLUMN Total_Orders_2ndHalf HEADING 'Total|Orders|2ndHalf'
COLUMN Late_No_1stHalf HEADING 'Late|No|1stHalf'
COLUMN Late_No_2ndHalf HEADING 'Late|No|2ndHalf'
COLUMN Rank_1stHalf HEADING 'Rank|1st|Half'
COLUMN Rank_2ndHalf HEADING 'Rank|2nd|Half'
COLUMN Rider_id HEADING 'Rider|ID'
COLUMN Rider_name HEADING 'Rider|Name'

CREATE OR REPLACE VIEW top_rider_firstHalf AS
SELECT * 
FROM(
SELECT r.rider_id, r.rider_name, COUNT(distinct s.orderid) AS Total_Orders_1stHalf,
       r.rider_lateno AS Late_No_1stHalf, SUM(s.line_total) AS Total_Sales_1stHalf,
       RANK() OVER (ORDER BY count(distinct s.orderid) DESC) Rank_1stHalf
FROM sales_fact s, DIM_riders r
WHERE s.rider_key = r.rider_key
      AND EXTRACT(year FROM s.order_date) = 2020
      AND (EXTRACT(month FROM s.order_date) BETWEEN 1 AND 6)
GROUP BY rider_id, rider_name, rider_lateno
ORDER BY Total_Orders_1stHalf DESC
)
WHERE Rank_1stHalf <=10;

CREATE OR REPLACE VIEW top_rider_secondHalf AS
SELECT r.rider_id, r.rider_name, COUNT(distinct s.orderid) AS Total_Orders_2ndHalf,
       r.rider_lateno AS Late_No_2ndHalf, SUM(s.line_total) AS Total_Sales_2ndHalf
FROM sales_fact s, DIM_riders r
WHERE s.rider_key = r.rider_key
      AND EXTRACT(year FROM s.order_date) = 2020
      AND (EXTRACT(month FROM s.order_date) BETWEEN 7 AND 12)
GROUP BY rider_id, rider_name, rider_lateno;

set linesize 95
TTITLE CENTER 'Top 10 Most Order Delivered Rider For 2020 Second Half Compared to First Half' SKIP 1 -
CENTER      ============================================================================= SKIP 1

SELECT a.*, b.Total_Orders_2ndHalf, b.Late_No_2ndHalf, b.Total_Sales_2ndHalf,
       RANK() OVER (ORDER BY Total_Orders_2ndHalf DESC) Rank_2ndHalf
FROM top_rider_firstHalf a, top_rider_secondHalf b
WHERE a.rider_id = b.rider_id;