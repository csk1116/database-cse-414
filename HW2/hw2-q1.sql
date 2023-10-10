-- query result -> 3 rows
SELECT DISTINCT
    f.flight_num as flight_num
FROM FLIGHTS AS f
    JOIN WEEKDAYS AS w
        ON f.day_of_week_id = w.did
    JOIN CARRIERS AS c
        ON f.carrier_id = c.cid
WHERE f.origin_city = 'Seattle WA'
      AND f.dest_city = 'Boston MA'
      AND c.name = 'Alaska Airlines Inc.'
      AND w.day_of_week = 'Monday';
