
bulk insert Carriers from 'carriers.csv'
with (ROWTERMINATOR = '0x0a',
DATA_SOURCE = 'flightdata_blob', FORMAT='CSV', CODEPAGE = 65001, --UTF-8 encoding
FIRSTROW=1,TABLOCK);

bulk insert Months from 'months.csv'
with (ROWTERMINATOR = '0x0a',
DATA_SOURCE = 'flightdata_blob', FORMAT='CSV', CODEPAGE = 65001, --UTF-8 encoding
FIRSTROW=1,TABLOCK);

bulk insert Weekdays from 'weekdays.csv'
with (ROWTERMINATOR = '0x0a',
DATA_SOURCE = 'flightdata_blob', FORMAT='CSV', CODEPAGE = 65001, --UTF-8 encoding
FIRSTROW=1,TABLOCK);

-- Import for the large Flights table.
-- This last import might take a little under 10 minutes on the
-- provided server settings
bulk insert Flights from 'flights-small.csv'
with (ROWTERMINATOR = '0x0a',
DATA_SOURCE = 'flightdata_blob', FORMAT='CSV', CODEPAGE = 65001, --UTF-8 encoding
FIRSTROW=1,TABLOCK);

-- Indexes, which we’ll discuss later this quarter, will make your
-- homework queries run much faster (optional, but STRONGLY recommended).
-- In aggregate, these three statements will take about 10 minutes
create index Flights_idx1 on Flights(origin_city,dest_city,actual_time);
create index Flights_idx2 on Flights(actual_time);
create index Flights_idx3 on Flights(dest_city,origin_city,actual_time);




