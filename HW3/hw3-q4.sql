SELECT DISTINCT
    f2.dest_city AS city
FROM FLIGHTS AS f1,
     FLIGHTS AS f2
WHERE f1.dest_city = f2.origin_city
      AND f1.origin_city = 'Seattle WA'
      AND f2.dest_city != 'Seattle WA'
      AND f2.dest_city NOT IN (
                                  SELECT f3.dest_city 
                                  FROM FLIGHTS AS f3 
                                  WHERE f3.origin_city = 'Seattle WA'
                              )
ORDER BY city;