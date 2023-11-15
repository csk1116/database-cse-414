DROP TABLE Lending;
DROP TABLE Books;
DROP TABLE Members;


CREATE TABLE Books (
    isbn INT PRIMARY KEY,
    title VARCHAR(1000),
    author VARCHAR(1000),
    genre VARCHAR(1000),
    publisher VARCHAR(1000)
);

CREATE TABLE Members (
    id INT PRIMARY KEY,
    name VARCHAR(1000)
);

CREATE TABLE Lending (
       l_isbn INT REFERENCES Books(isbn),
       l_id INT REFERENCES Members(id),
       checkout DATETIME,
       returned DATETIME,
       PRIMARY KEY(l_isbn, l_id, checkout)
);

INSERT INTO Books (
    isbn,
    title,
    author,
    genre,
    publisher) VALUES (0, 'test', 'au', '1000', 'pu'), 
    (1, 'ti', 'au1', '1000', 'pu1'), (2, 'sakh', 'au3', 'history', 'pu2'),
    (3, 'tt', 'su4', 'music', 'pu5'),
    (4, 'Leaves of Grass', 'au5', 'kk', 'pu6'),
    (5, 'Moby Dick', 'au6', 'ff', 'pu7');

INSERT INTO Members (
    id,
    name
) VALUES (1, 'eric'), (2, 'apple'), (3, 'kate');

INSERT INTO Lending (
    l_isbn,
    l_id,
    checkout,
    returned
) VALUES (0, 1, GETDATE(), NULL), (1, 2, GETDATE(), NULL), 
(3, 3, GETDATE(), GETDATE()), (4, 1, '2007-05-08 12:35:29.123', '2007-05-08 12:35:29.123'), (5, 1, '2007-05-08 12:35:29.123', '2007-05-08 12:35:29.123'),
(4, 1, GETDATE(), GETDATE()), (5, 1, GETDATE(), GETDATE()),
(4, 3, GETDATE(), GETDATE()), (5, 3, GETDATE(), GETDATE());


SELECT m.name AS member_name, b.title AS book_title
FROM Books AS b, Members AS m, Lending AS l
WHERE l.l_isbn = b.isbn
    AND l.l_id = m.id
    AND l.returned IS NULL 
ORDER BY m.name DESC;

SELECT b.genre AS genre, COUNT(l.checkout) AS number_of_checkout
FROM Books AS b LEFT OUTER JOIN Lending AS l
    ON l.l_isbn = b.isbn
GROUP BY b.genre
ORDER BY number_of_checkout;

SELECT DISTINCT m.id, m.name
FROM Members m
JOIN Lending l1 ON m.id = l1.l_id
JOIN Lending l2 ON m.id = l2.l_id
JOIN Books b1 ON l1.l_isbn = b1.isbn
JOIN Books b2 ON l2.l_isbn = b2.isbn
WHERE b1.title = 'Leaves of Grass' AND b2.title = 'Moby Dick';

SELECT DISTINCT m1.id AS id, m1.name AS name
FROM Members AS m1, Lending AS l1, Books AS b1  
WHERE m1.id = l1.l_id
    AND l1.l_isbn = b1.isbn 
    AND b1.title = 'Leaves of Grass'
    AND M1.id IN (
                    SELECT m2.id
                    FROM Members AS m2, Lending AS l2, Books AS b2  
                    WHERE m2.id = l2.l_id
                        AND l2.l_isbn = b2.isbn
                        AND b2.title = 'Moby Dick'
                 );