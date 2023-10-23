SELECT DISTINCT
    f.origin_city AS city
FROM FLIGHTS AS f
WHERE f.canceled = 0
      AND 4 * 60>ALL
      (
          SELECT f1.actual_time
          FROM FLIGHTS AS f1
          WHERE f.origin_city = f1.origin_city
      )
ORDER BY city;

