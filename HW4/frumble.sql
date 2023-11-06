-- Part 4 --

-- a. -- (using sqlite3)

.mode tabs

CREATE TABLE Sales (
    name VARCHAR(20),
    discount VARCHAR(5),
    month VARCHAR(5),
    price INT
);

--.import /Users/CSK/Documents/repo/database-cse-414/HW4/mrFrumbleData.txt Sales






-- b. -- (using sqlite3)

-- To make checking step less, I would like to check 3 to 1 dependencies first
-- There are 4 combinations:
-- 1. name, discount, month -> price
-- 2. name, discount, price -> month
-- 3. name, month, price -> discount
-- 4. discount, month, price -> name

-- let's check 1. name, discount, month -> price
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.name = s2.name
      AND s1.discount = s2.discount
      AND s1.month = s2.month
      AND s1.price != s2.price;
-- query result: 0, name, discount, month -> price (holds)

-- This means at least one attribute holds X -> price
-- let's check individually

-- check name -> price
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.name = s2.name
      AND s1.price != s2.price;
-- query result: 0, name -> price (holds)

-- check discount -> price
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.discount = s2.discount
      AND s1.price != s2.price;
-- query result: 55170, discount -> price (does not hold)

-- check discount -> price
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.discount = s2.discount
      AND s1.price != s2.price;
-- query result: 55170, discount -> price (does not hold)

-- check month -> price
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.month = s2.month
      AND s1.price != s2.price;
-- query result: 13208, month -> price (does not hold)

-- until now we have:
-- holds: name -> price
-- X hold: discount -> price
-- X hold: month -> price

-- let's check 2. name, discount, price -> month
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.name = s2.name
      AND s1.discount = s2.discount
      AND s1.price = s2.price
      AND s1.month != s2.month;
-- query result: 1334, name, discount, price -> month (does not hold)

-- This means name -> month (X hold), discount -> month (X hold), and price -> month (X hold)

-- until now we have:
-- holds: name -> price
-- X hold: discount -> price
-- X hold: month -> price
-- X hold: name -> month
-- X hold: discount -> month
-- X hold: price -> month

-- let's check 3. name, month, price -> discount
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.name = s2.name
      AND s1.month = s2.month
      AND s1.price = s2.price
      AND s1.discount != s2.discount;
-- query result: 0, name, month, price -> discount (holds)

-- This means at least one attribute holds X -> discount
-- let's check individually

-- check name -> discount
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.name = s2.name
      AND s1.discount != s2.discount;
-- query result: 3286, name -> discount (does not hold)

-- check month -> discount
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.month = s2.month
      AND s1.discount != s2.discount;
-- query result: 0, month -> discount (holds)

-- check price -> discount
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.price = s2.price
      AND s1.discount != s2.discount;
-- query result: 14964, price -> discount (does not hold)

-- until now we have:
-- holds: name -> price
-- holds: month -> discount
-- X hold: discount -> price
-- X hold: month -> price
-- X hold: name -> month
-- X hold: discount -> month
-- X hold: price -> month
-- X hold: name -> discount
-- X hold: price -> discount

-- Finally, let's check 4. discount, month, price -> name
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.discount = s2.discount
      AND s1.month = s2.month
      AND s1.price = s2.price
      AND s1.name != s2.name;
-- query result: 1492, discount, month, price -> name (does not hold)

-- This means discount -> name (X hold), month -> name (X hold), and price -> name (X hold)

-- Now we have checked all combination of 1 to 1 fds:
-- holds: name -> price
-- holds: month -> discount
-- X hold: discount -> price
-- X hold: month -> price
-- X hold: name -> month
-- X hold: discount -> month
-- X hold: price -> month
-- X hold: name -> discount
-- X hold: price -> discount
-- X hold: discount -> name
-- X hold: month -> name
-- X hold: price -> name

-- Therefore, the only non-trivial we can conclude is name, month -> price, discount
-- can be derived by the above fds we hold:
-- {name}+ = {name, price} and {month}+ = {month, discount}
-- => {name, month}+ = {name, discount, month, price}
-- we get name, month -> name, discount, month, price, which implies name, month -> discount, price.

-- Now we have all non-trivial fds:
-- holds: name -> price
-- holds: month -> discount
-- holds: name, month -> price, discount

-- * We don't have to check fd like name, discount -> month, price
-- To be considered hold, it must hold name, discount -> month and name, discount -> price
-- Since we know name -> month (X hold) and discount -> month (X hold)
-- So, name, discount -> month (X hold). Hence name, discount -> month, price (X hold)

-- Ans: 
-- holds: name -> price
-- holds: month -> discount
-- holds: name, month -> price, discount






-- c. -- (using sqlite3)

-- we have Fds:
-- name -> price
-- month -> discount
-- name, month -> discount, price

-- R(name, discount, month, price)
-- {name}+ = {name, price} 
-- {name}+ != {name} and {name}+ != {name, discount, month, price}

-- decompose R into R1(name, price), R2(name, discount, month)
-- Check R1 is in BCNF
-- R2 is not because {month}+ = {month, discount}
-- {month}+ != {month} and {month}+ != {name, discount, month}

-- decompose R2 into R3(month, discount), R4(name, month)
-- check R3 and R4 are both in BCNF

--Result:
-- R1(name, price), R3(month, discount), R4(name, month)

CREATE TABLE name_price (
    name VARCHAR(20) PRIMARY KEY,
    price INT
);

CREATE TABLE month_discount (
    month VARCHAR(5) PRIMARY KEY,
    discount VARCHAR(5)
);

CREATE TABLE name_month (
    name VARCHAR(20) REFERENCES name_price(name),
    month VARCHAR(5) REFERENCES month_discount(month),
    PRIMARY KEY(name, month)
);





-- d. -- (using sqlite3)

INSERT INTO name_price
SELECT DISTINCT name, price FROM Sales;

SELECT COUNT(*)  
FROM name_price;
-- query result: 36

INSERT INTO month_discount
SELECT DISTINCT month, discount FROM Sales;

SELECT COUNT(*)  
FROM month_discount;
-- query result: 12

INSERT INTO name_month
SELECT DISTINCT name, month FROM Sales;

SELECT COUNT(*)  
FROM name_month;
-- query result: 426

