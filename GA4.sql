-- A travel company TravelOnTheGo maintains the record of passengers and price to travel
-- between two cities, for bus type (Sitting and Sleeper).
create schema TravelOnGo ;
use TravelOnGo ;

-- Create Table for passenger

Create table Passenger (
      Passenger_name varchar (50),
      Category varchar(10),
      Gender char,
      Boarding_City varchar(20),
	  Destination_City varchar(20),
      Distance int,
      Bus_Type varchar(20)
);

-- Create table for prices
Create table Price (
	  Bus_Type varchar(20),
	  Distance int,
	  Price int
      );
-- Insert records into Passengers table.
insert into Passenger values ('Sejal','AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
insert into Passenger values ('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
insert into Passenger values ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
insert into Passenger values ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into Passenger values ('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000 ,'Sleeper');
insert into Passenger values ('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
insert into Passenger values ('Hemant', 'Non-AC', 'M', 'panaji', 'Mumbai', 700, 'Sleeper');
insert into Passenger values ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
insert into Passenger values ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

-- Insert records into Price table
insert into Price Values ('Sleeper', 350, 770);
insert into Price Values ('Sleeper', 500, 1100);
insert into Price Values ('Sleeper', 600, 1320);
insert into Price Values ('Sleeper', 700, 1540);
insert into Price Values ('Sleeper', 1000, 2200);
insert into Price Values ('Sleeper', 1200, 2640);
insert into Price Values ('Sleeper', 1500, 2700);
insert into Price Values ('Sitting', 500, 620);
insert into Price Values ('Sitting', 600, 744);
insert into Price Values ('Sitting', 700, 868);
insert into Price Values('Sitting', 1000, 1240);
insert into Price Values('Sitting', 1200, 1488);
insert into Price Values('Sitting', 1500, 1860);

-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KMs?
SELECT 
    Gender, COUNT(*)
FROM
    passenger
WHERE
    Distance >= 600
GROUP BY passenger.Gender;

-- 4) Find the minimum ticket price for Sleeper Bus.
SELECT 
    MIN(Price)
FROM
    price
WHERE
    Bus_TYPE = 'Sleeper';

-- 5) Select passenger names whose names start with character 'S'
SELECT 
    Passenger_name
FROM
    passenger
WHERE
    Passenger_name LIKE '%S'
        OR Passenger_name LIKE 'S%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
-- Destination City, Bus_Type, Price in the output
SELECT DISTINCT
    passenger.Passenger_name,
    passenger.Boarding_City,
    passenger.Destination_City,
    passenger.Bus_Type,
    price.Price
FROM
    passenger,
    price
WHERE
    passenger.Bus_Type = price.Bus_Type
        AND passenger.Distance = price.Distance;
-- 7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a
-- distance of 1000 KMs.				
SELECT DISTINCT
    Passenger_name, Price
FROM
    passenger,
    price
WHERE
    passenger.Bus_Type = price.Bus_Type
        && passenger.Distance = price.Distance
        AND passenger.Bus_Type = 'Sitting'
        AND passenger.Distance = 1000;
    

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel 
	SELECT DISTINCT p1.Passenger_name, p1.Boarding_city 
    as Destination_city, p1.Destination_city 
    as Boardng_city, 
    p2.Bus_type, p2.Price FROM passenger p1, 
    price p2 WHERE p1.Distance = p2.Distance
    and Passenger_name = 'Pallavi';


-- 9) List the distances from the "Passenger" table which are unique 
	SELECT DISTINCT
    Distance
FROM
    passenger
ORDER BY Distance DESC;

-- 10) Display the passenger name and percentage of distance travelled by that passenger 
	SELECT 
    Passenger_name,
    Distance * 100.0 / (SELECT 
            SUM(Distance)
        FROM
            passenger) AS Percentage_Distance
FROM
    passenger;

-- 11) Display the distance, price in three categories in table Price
	SELECT 
    Distance,
    Price,
    CASE
        WHEN Price >= 1000 THEN 'Expensive'
        WHEN Price < 1000 AND Price >= 500 THEN 'Average Cost'
        WHEN Price < 500 THEN 'Cheap'
    END AS Category
FROM
    Price;
