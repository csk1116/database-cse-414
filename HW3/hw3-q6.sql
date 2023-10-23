SELECT DISTINCT
    c.name AS carrier
FROM CARRIERS AS c,
(
    SELECT f.carrier_id
    FROM FLIGHTS AS f
    WHERE f.origin_city = 'Seattle WA'
          AND f.dest_city = 'New York NY'
) AS fc
WHERE c.cid = fc.carrier_id
ORDER BY carrier;