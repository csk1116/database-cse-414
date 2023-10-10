-- query result -> 12 rows
SELECT DISTINCT
    c.name AS name
FROM FLIGHTS AS f,
     CARRIERS AS c
WHERE f.carrier_id = c.cid
      AND f.canceled = 0
GROUP BY f.carrier_id,
         f.month_id,
         f.day_of_month
HAVING count(*) > 1000;