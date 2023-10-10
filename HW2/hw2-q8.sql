-- query result -> 22 rows
SELECT c.name AS name,
       SUM(f.departure_delay) AS delay
FROM FLIGHTS AS f,
     CARRIERS AS c
WHERE f.carrier_id = c.cid
GROUP BY f.carrier_id;