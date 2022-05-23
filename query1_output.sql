SQL> set linesize 99
SQL> TTITLE CENTER 'Top 10 Most Popular Restaurant For Year 2020 Second Half Compared To First Half For Selected City' SKIP 1 -
> CENTER      ================================================================================================= SKIP 1
SQL> 
SQL> SELECT a.rest_branchid, a.rest_name, a.Total_Orders_1stHalf, a.Total_Sales_1stHalf,
  2         a.Average_Rating_1stHalf, a.Popular_Ranking_1stHalf, b.Total_Orders_2ndHalf,
  3         b.Total_Sales_2ndHalf, b.Average_Rating_2ndHalf,
  4         RANK() OVER (ORDER BY b.Total_Orders_2ndHalf DESC) Popular_Ranking_2ndHalf
  5  FROM top_rest2020_firstHalf a, top_rest2020_secondHalf b
  6  WHERE a.rest_branchid = b.rest_branchid;

 Top 10 Most Popular Restaurant For Year 2020 Second Half Compared To First Half For Selected City
 =================================================================================================
  Rest                        Total       Total        Avg Rank   Total       Total        Avg Rank
Branch Rest                  Orders       Sales     Rating  1st  Orders       Sales     Rating  2nd
    ID Name                 1stHalf     1stHalf    1stHalf Half 2ndHalf     2ndHalf    2ndHalf Half
------ -------------------- ------- ----------- ---------- ---- ------- ----------- ---------- ----
 10106 TEXAS CHICKEN             51   11,791.82       3.02    6      57   15,532.47       2.68    1
 10078 KOBQ                      59   30,976.00       2.84    1      54   26,104.00       3.08    2
 10422 RAJA LAUT CURRY HOUS      53    3,012.00       2.87    3      54    3,278.90       2.98    2
 10043 LK WESTERN                51   21,282.00       3.05    6      50   21,681.20       3.02    4
 10386 ARABELLA RESTAURANT       54   22,193.00       3.47    2      45   18,396.00       2.57    5
 10031 THE TOKYO RESTAURANT      51   24,816.00       3.23    6      42   15,567.00       2.51    6
 10452 HAIDILAO HOTPOT           51   31,139.00       3.24    6      39   24,027.00       3.14    7
 10507 NASI KANDAR SUBAIDAH      53    3,501.50       3.19    3      39    2,728.50       3.38    7
 10317 IMPIAN MAJU MAMAK         52   41,771.42       3.22    5      38   28,511.91       3.14    9
 10013 BLACK MARKET              51   20,267.00       2.63    6      32   12,540.00       2.95   10

10 rows selected.

SQL> spool off
