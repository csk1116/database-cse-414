SELECT DISTINCT
    f.origin_city AS origin_city,
    100.0 * ISNULL(
            (
                SELECT COUNT(fid)
                FROM FLIGHTS
                WHERE 1.5 * 60 > actual_time
                      AND canceled = 0
                      AND origin_city = f.origin_city
                GROUP BY origin_city
            ), 0) / count(f.fid) AS percentage
FROM FLIGHTS AS f
WHERE f.canceled = 0
GROUP BY f.origin_city
ORDER BY percentage,
         origin_city;