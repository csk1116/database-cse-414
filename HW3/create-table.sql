CREATE EXTERNAL DATA SOURCE flightdata_blob
WITH (TYPE = BLOB_STORAGE, 
LOCATION = 'https://introdatamanagement.blob.core.windows.net/flightdata'
);

CREATE TABLE CARRIERS (
    cid VARCHAR(7) PRIMARY KEY,
    name VARCHAR(83)
);

CREATE TABLE MONTHS (
    mid INT PRIMARY KEY,
    month VARCHAR(9)
);

CREATE TABLE WEEKDAYS (
    did INT PRIMARY KEY,
    day_of_week VARCHAR(9)
);

CREATE TABLE FLIGHTS (
    fid INT PRIMARY KEY,
    month_id INT REFERENCES MONTHS(mid),  -- 1-12
    day_of_month INT,  -- 1-31 
    day_of_week_id INT REFERENCES WEEKDAYS(did),  -- 1-7, 1 = Monday, 2 = Tuesday, etc
    carrier_id VARCHAR(7) REFERENCES CARRIERS(cid), 
    flight_num INT,
    origin_city VARCHAR(34), 
    origin_state VARCHAR(47), 
    dest_city VARCHAR(34), 
    dest_state VARCHAR(46), 
    departure_delay INT, -- in mins
    taxi_out INT,        -- in mins
    arrival_delay INT,   -- in mins
    canceled INT,        -- 1 means canceled
    actual_time INT,     -- in mins
    distance INT,        -- in miles
    capacity INT, 
    price INT            -- in $
);