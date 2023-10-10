-- query result -> 3 rows
SELECT c.name AS carrier, MAX(f.price) AS max_price
FROM FLIGHTS AS f, CARRIERS AS c
WHERE f.carrier_id = c.cid AND
((f.origin_city = 'Seattle WA' AND f.dest_city = 'New York NY') OR 
(f.origin_city = 'New York NY' AND f.dest_city = 'Seattle WA'))
GROUP BY
f.carrier_id;

-- SELECT c.name AS carrier,
--        MAX(MAX(f1.price), MAX(f2.price))
-- FROM FLIGHTS AS f1,
--      FLIGHTS AS f2,
--      CARRIERS AS c
-- WHERE f1.carrier_id = c.cid
--       AND f1.origin_city = 'Seattle WA'
--       AND f1.dest_city = 'New York NY'
--       AND f2.origin_city = 'New York NY'
--       AND f2.dest_city = 'Seattle WA'
--       AND f1.carrier_id = f2.carrier_id
-- GROUP BY f1.carrier_id;



