SELECT DISTINCT
    f.origin_city AS origin_city,
    f.dest_city AS dest_city,
    f.actual_time AS time
FROM FLIGHTS AS f,
(
    SELECT f1.origin_city AS origin_city,
           MAX(f1.actual_time) AS max_time
    FROM FLIGHTS AS f1
    GROUP BY f1.origin_city
) AS mt
WHERE f.origin_city = mt.origin_city
      AND f.actual_time = mt.max_time
ORDER BY f.origin_city,
         f.dest_city;