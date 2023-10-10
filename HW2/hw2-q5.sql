-- query result -> 6 rows
SELECT c.name AS name,
       100.0 * AVG(f.canceled) AS percentage
FROM FLIGHTS AS f,
     CARRIERS AS c
WHERE f.carrier_id = c.cid
      AND f.origin_city = 'Seattle WA'
GROUP BY f.carrier_id,
         f.origin_city
HAVING percentage > 0.5
ORDER BY percentage;