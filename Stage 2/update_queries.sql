-- Query 1: 
--Mark drivers as night-available if they completed more than 1 night ride
UPDATE Driver
SET Night_Avail = 'Y'
WHERE Volunteer_ID IN (
    SELECT Driver_ID
    FROM Ride
    WHERE (EXTRACT(HOUR FROM Pickup_Time) >= 19 OR EXTRACT(HOUR FROM Pickup_Time) < 7)
    GROUP BY Driver_ID
    HAVING COUNT(*) > 1
);


-- Query 2: 
--Postpone all Haifa rides on 2025-04-10 by 1 hour (due to a power outage)
UPDATE Ride
SET Pickup_Time = Pickup_Time + INTERVAL '1 hour'
WHERE Ride_Date = '2025-11-28'
  AND Destination_Address ILIKE '%Haifa%'
  AND Pickup_Time <= TIME '22:59:59';


-- Query 3: 
--Update last name of volunteer Noa Kaplan to Shemesh (after marriage)
UPDATE Volunteer
SET Last_Name = 'Shemesh'
WHERE Volunteer_ID = 104731999;

