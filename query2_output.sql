SQL> set linesize 100
SQL> TTITLE CENTER 'Total Sales Of Each State For Year 2020 Compared To 2019' SKIP 1 -
> CENTER      ========================================================== SKIP 1
SQL> 
SQL> SELECT a.state, a.total_order2019 AS Total_Order2019, a.total_sales2019 AS Total_Sales2019,
  2         b.total_order2020 AS Total_Order2020, b.total_sales2020 AS Total_Sales2020,
  3         (b.total_sales2020-a.total_sales2019) AS Sales_Diff,
  4         ROUND((((b.total_sales2020-a.total_sales2019)/a.total_sales2019) * 100),2) AS Percent_Sales_Diff
  5  FROM top_state2019 a, top_state2020 b
  6  WHERE a.state = b.state
  7  ORDER BY Total_Sales2019 DESC;

                      Total Sales Of Each State For Year 2020 Compared To 2019
                     ==========================================================
                          Total           Total      Total           Total               Percent
                          Order           Sales      Order           Sales         Sales   Sales
STATE                      2019            2019       2020            2020          Diff    Diff
-------------------- ---------- --------------- ---------- --------------- ------------- -------
SELANGOR                  32661    3,558,775.59      33068    3,707,359.89    148,584.30    4.18
WILAYAH PERSEKUTUAN       20080    2,202,502.18      19971    2,212,835.00     10,332.82     .47
PULAU PINANG              12089    1,282,468.94      11653    1,276,590.91     -5,878.03    -.46
SARAWAK                   11139    1,194,311.46      10625    1,192,964.17     -1,347.29    -.11
PAHANG                     9519    1,088,194.06       9406    1,034,951.55    -53,242.51   -4.89
JOHOR                      9077      995,997.95       8717      978,499.14    -17,498.81   -1.76
PERAK                      7862      880,220.09       7361      796,928.39    -83,291.70   -9.46
NEGERI SEMBILAN            5554      584,223.10       5308      600,257.67     16,034.57    2.74
KEDAH                      4005      440,428.66       3844      460,019.75     19,591.09    4.45
SABAH                      3169      347,194.28       3161      331,770.15    -15,424.13   -4.44
MELAKA                     2027      230,062.61       2070      256,700.91     26,638.30   11.58
PERLIS                     2009      224,859.25       1992      230,967.90      6,108.65    2.72
KELANTAN                   1582      169,872.35       1705      185,542.83     15,670.48    9.22

13 rows selected.

SQL> spool off
