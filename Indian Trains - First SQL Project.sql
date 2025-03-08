use trains;
select * from trains_data;
# Find all trains departing from 'JAMMU TAWI'
select train_number, train_name from trains_data where source = "JAMMU TAWI";
# Find trains running between 'MUMBAI BANDRA TERMINUS' and 'BIKANER JN'
# Find the fastest train from 'JAMMU TAWI' to 'UDHAMPUR'
select train_number, train_name, total_time from trains_data where source = "JAMMU TAWI" and destination="UDHAMPUR" order by total_time ASC limit 1;
# Find the train covering the maximum distance
select train_number, train_name, distance from trains_data order by distance DESC limit 1;
# Find how many trains depart from each station
select source, count(train_name) AS trains from trains_data group by source;
# Find all trains departing at '10:40:00'
select train_number, train_name, departure from trains_data where departure = '10:40:00';
# Find trains that take more than 24 hours
select train_number, train_name, total_time AS Journey from trains_data where total_time >= '1 days 00:00:00';
# Find trains arriving between 23:00 and 04:00
select train_number, train_name, arrival from trains_data where time(arrival) between '23:00:00' and '04:00:00';
# Find the train with the shortest and longest duration
SELECT train_name, train_number, total_time FROM trains_data ORDER BY total_time ASC LIMIT 1;
SELECT train_name, train_number, total_time FROM trains_data ORDER BY total_time DESC LIMIT 1;
# Find Trains Covering Distance Less Than 100 km
SELECT train_name, train_number, distance FROM trains_data where distance < 100;
# Find Trains Departing During Peak Hours (6 AM - 10 AM & 5 PM - 9 PM)
SELECT train_name, train_number, departure FROM trains_data where departure between '06:00:00' and '09:00:00';
SELECT train_name, train_number, departure FROM trains_data where departure between '17:00:00' and '21:00:00';
# Find Trains with Identical Source and Destination. Some train services loop back to the same station
SELECT train_name, train_number, source, destination FROM trains_data where source = destination;
# Find Trains with Duplicate Train Numbers. Check for any inconsistencies in train numbering
select train_number, count(*) from trains_data group by train_number having count(*) > 1;
# Get the Average Travel Time for Each Route
SELECT source, destination, AVG(TIME_TO_SEC(total_time)) / 3600 AS avg_travel_hours FROM trains_data GROUP BY source, destination;
# Find Trains Operating Between Two Specific Times. Find trains operating between 08:00 and 12:00
SELECT train_name,train_number,departure FROM trains_data where departure between '08:00:00' and '12:00:00';
# Find All Unique Train Routes
SELECT DISTINCT source, destination FROM trains_data;
# Rank Trains by Distance Travelled
SELECT train_name, train_number, distance, RANK() OVER (ORDER BY distance DESC) AS distance_rank FROM trains_data;
# Find first and last train departing from 'NEW DELHI'
SELECT train_name,train_number, source, departure FROM trains_data where source = "NEW DELHI" order by departure ASC limit 1;
# Find Trains That Take the Longest Time to Travel a Short Distance. Find inefficient routes (e.g., distance < 200 km but takes long hours)
SELECT train_name,train_number, total_time, distance FROM trains_data where distance < 200 and total_time = '0 days 00:00:00'; 
SELECT train_name,train_number, total_time, distance FROM trains_data where distance < 200 order by total_time desc limit 5; 
# Find the Busiest Train Route (Most Frequent Trips)
SELECT source,destination, count(*) as total_trains FROM trains_data group by source,destination order by total_trains desc limit 5; 
# Find the Least Common Train Route
SELECT source,destination, count(*) as total_trains FROM trains_data group by source,destination order by total_trains asc limit 5;
# Find the Number of Trains Running per Hour
SELECT hour(departure) as departure_hour,count(*) AS number_of_trains FROM trains_data group by departure_hour order by number_of_trains DESC;
# Trains departing in the evening and arriving in the morning
SELECT * FROM trains_data WHERE TIME(departure) BETWEEN '18:00:00' AND '23:59:59' AND TIME(arrival) BETWEEN '00:00:00' AND '06:00:00';