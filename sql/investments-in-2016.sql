SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance i
JOIN
   (
   SELECT tiv_2015
   FROM Insurance
   GROUP BY tiv_2015
   HAVING COUNT(DISTINCT pid) > 1
   ) AS t0
ON i.tiv_2015 = t0.tiv_2015
JOIN
   (
   SELECT CONCAT(lat, lon) AS lat_lon
   FROM Insurance
   GROUP BY CONCAT(lat, lon)
   HAVING COUNT(DISTINCT pid) = 1
   ) AS t1
ON CONCAT(i.lat, i.lon) = t1.lat_lon
