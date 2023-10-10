/* HW1 */ /* Q2 */

CREATE TABLE Edges ( Source INT PRIMARY KEY, Destination INT );
INSERT INTO Edges (Source, Destination) VALUES (10, 5), (6, 25), (1, 3), (4, 4);

SELECT  *
FROM Edges;

SELECT  Source
FROM Edges;

SELECT  *
FROM Edges
WHERE Source > Destination;
INSERT INTO Edges (Source, Destination) VALUES ('-1', '2000');
-- No. I expected that inserting string into the "source" should cause a datatype conflict issue. However, sqlite uses "dynamic typing." It means that sqlite does not restrict what datatype can store into the column. Therefore, this query is valid.
 /*Q3*/

CREATE TABLE MyRestaurants ( r_name VARCHAR(100) PRIMARY KEY, f_type VARCHAR(50), d_in_min INT CHECK (d_in_min > 0), l_visit VARCHAR(10) CHECK ( length(l_visit) = 10 AND substr(l_visit, 5, 1) = '-' AND substr(l_visit, 8, 1) = '-' ), preference INT CHECK ( preference = 0 OR preference = 1 OR preference = NULL ) ); /*Q4*/
INSERT INTO MyRestaurants ( r_name, f_type, d_in_min, l_visit, preference ) VALUES ( 'Shake Shack', 'fast food', 5, '2022-09-26', TRUE ), ( 'Korean Tofu House', 'Korean food', 21, '2023-09-05', TRUE ), ('Chipotle', 'Mexican food', 6, '2023-09-27', ''), ( 'Burger Master', 'fast food', 2, '2022-09-15', FALSE ), ( 'Little Duck', 'Chinese food', 21, DATE('now', '-3 month'), TRUE ); /*Q5*/ .header ON.mode CSV

SELECT  *
FROM MyRestaurants; .mode LIST

SELECT  *
FROM MyRestaurants; .mode COLUMN.width 15 15 15 15 15

SELECT  *
FROM MyRestaurants; .header OFF.mode CSV

SELECT  *
FROM MyRestaurants; .mode LIST

SELECT  *
FROM MyRestaurants; .mode COLUMN.width 15 15 15 15 15

SELECT  *
FROM MyRestaurants; /*Q6*/

SELECT  r_name
       ,d_in_min
FROM MyRestaurants
WHERE d_in_min <= 20
ORDER BY r_name ASC; /*Q7*/

SELECT  *
FROM MyRestaurants
WHERE preference = TRUE
AND l_visit < date('now', '-3 month'); /*Q8*/

SELECT  *
FROM MyRestaurants
WHERE d_in_min <= 10;