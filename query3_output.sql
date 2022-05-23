SQL> set linesize 95
SQL> TTITLE CENTER 'Top 10 Most Order Delivered Rider For 2020 Second Half Compared to First Half' SKIP 1 -
> CENTER      ============================================================================= SKIP 1
SQL> 
SQL> SELECT a.*, b.Total_Orders_2ndHalf, b.Late_No_2ndHalf, b.Total_Sales_2ndHalf,
  2         RANK() OVER (ORDER BY Total_Orders_2ndHalf DESC) Rank_2ndHalf
  3  FROM top_rider_firstHalf a, top_rider_secondHalf b
  4  WHERE a.rider_id = b.rider_id;

         Top 10 Most Order Delivered Rider For 2020 Second Half Compared to First Half
         =============================================================================
                              Total    Late       Total Rank   Total    Late       Total Rank
 Rider Rider                 Orders      No       Sales  1st  Orders      No       Sales  2nd
    ID Name                 1stHalf 1stHalf     1stHalf Half 2ndHalf 2ndHalf     2ndHalf Half
------ -------------------- ------- ------- ----------- ---- ------- ------- ----------- ----
 10001 FLOSSIE MEGANY           238       0   67,040.48    7     268       0   94,719.52    1
 10072 LIBBY SCHOFFEL           238       0   77,045.80    7     262       0   73,209.82    2
 10075 CAREY ZEBEDEE            242       0   71,609.30    3     254       0   57,629.14    3
 10043 VERNOR ZORER             238       0   81,333.46    7     247       0   67,358.60    4
 10010 SISSIE DAKHNO            238       0   66,232.09    7     244       0   77,889.88    5
 10029 CARTER CORNEY            241       0   64,084.06    4     234       0   66,560.06    6
 10098 ZORA STREIGHT            240       0   75,101.78    6     232       0   58,357.82    7
 10082 DALLAS CADOGAN           241       0   73,111.53    4     222       0   63,715.02    8
 10092 SEE BLACKHURST           243       0   79,153.47    2     219       0   67,346.06    9
 10003 TIMOTHEA DAEN            248       0   61,823.02    1     210       0   74,302.07   10

10 rows selected.

SQL> spool off
