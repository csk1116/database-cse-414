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

-- check 1 -> 1 --
-- we have to check all non-trivial 1 -> 1 fds

-- name -> discount (does not hold) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.name = s2.name
      AND s1.discount != s2.discount;
-- query result: 3286, which means same name has different discounts.

-- name -> month (does not hold) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.name = s2.name
      AND s1.month != s2.month;
-- query result: 4620, which means same name can be sold in different months.

-- name -> price (holds) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.name = s2.name
      AND s1.price != s2.price;
-- query result: 0, which means each name has only one price.

-- discount -> name (does not hold) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.discount = s2.discount
      AND s1.name != s2.name;
-- query result: 61398, which means same discount can be applied to different names.

-- discount -> month (does not hold) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.discount = s2.discount
      AND s1.month != s2.month;
-- query result: 48032, which means same discount can appear in different months.

-- discount -> price (does not hold) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.discount = s2.discount
      AND s1.price != s2.price;
-- query result: 55170, which means same discount can be applied to different price.

-- month -> name (does not hold) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.month = s2.month
      AND s1.name != s2.name;
-- query result: 14700, which means same month can sale different name.

-- month -> discount (holds) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.month = s2.month
      AND s1.discount != s2.discount;
-- query result: 0, which means each month has only one discount.

-- month -> price (does not hold) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.month = s2.month
      AND s1.price != s2.price;
-- query result: 13208, which means same month can have different prices.

-- price -> name (does not hold) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.price = s2.price
      AND s1.name != s2.name;
-- query result: 17906, which means same price can be assigned to different names.

-- price -> discount (does not hold) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.price = s2.price
      AND s1.discount != s2.discount;
-- query result: 14964, which means same price can have different discounts.

-- price -> month (does not hold) --
SELECT COUNT(*)
FROM Sales as s1,
     Sales as s2
WHERE s1.price = s2.price
      AND s1.month != s2.month;
-- query result: 21034, which means same price can appear in different months.


-- Until now, we got:
-- name -> price, month -> discount 


-- check 2 -> 2 --
-- we can derive: name, month -> price, discount (no need to check)
-- also we don't need to check (name, price) -> (discount, month),
-- (discount, month -> name, price), (discount, price) -> (name, month)

-- name, discount -> month, price (holds)
SELECT COUNT(*) 
FROM Sales as s1,
     Sales as s2
WHERE s1.name = s2.name 
      AND s1.discount = s2.discount
      AND s1.month != s2.month
      AND s1.price != s2.price;
-- query result: 0, which means each (name, discount) has unique (month, price).

-- month, price -> name, discount (holds)
SELECT COUNT(*) 
FROM Sales as s1,
     Sales as s2
WHERE s1.name != s2.name 
      AND s1.discount != s2.discount
      AND s1.month = s2.month
      AND s1.price = s2.price;
-- query result: 0, which means each (month, price) has unique (name, discount).


-- Finally, we have non-trivial FD: 
-- name -> price
-- month -> discount
-- name, month -> price, discount
-- name, discount -> month, price
-- month, price -> name, discount





-- c. -- (using sqlite3)

-- we have Fds:
-- name -> price
-- month -> discount
-- name, month -> price, discount
-- name, discount -> month, price
-- month, price -> name, discount

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

