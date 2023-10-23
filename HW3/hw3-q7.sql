SELECT DISTINCT
    c.name AS carrier
FROM FLIGHTS AS f,
     CARRIERS AS c
WHERE c.cid = f.carrier_id
      AND f.origin_city = 'Seattle WA'
      AND f.dest_city = 'New York NY'
ORDER BY carrier;