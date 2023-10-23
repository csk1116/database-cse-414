-- assume all cities to be the collection of all origin_city
SELECT DISTINCT
    f1.origin_city AS city
FROM FLIGHTS AS f1
WHERE f1.origin_city NOT IN (
                                SELECT DISTINCT
                                    f2.dest_city
                                FROM FLIGHTS AS f2,
                                     FLIGHTS AS f3
                                WHERE f2.origin_city = f3.dest_city
                                      AND f3.origin_city = 'Seattle WA'
                            )
      AND f1.origin_city NOT IN (
                                    SELECT DISTINCT
                                        f4.dest_city
                                    FROM FLIGHTS AS f4
                                    WHERE f4.origin_city = 'Seattle WA'
                                )
ORDER by city;