-- Query 1: 
--Delete all past rides before the start of the current year
DELETE FROM Ride
WHERE Ride_Date < DATE_TRUNC('year', CURRENT_DATE);

-- Query 2: 
--Delete volunteers who are not registered as drivers or transport assistants
DELETE FROM Volunteer
WHERE Volunteer_ID NOT IN (
  SELECT Volunteer_ID FROM Driver
  UNION
  SELECT Volunteer_ID FROM Transport_Assistant
);

-- Query 3: 
--Delete patients who had no rides in the past 6 months and have no future rides
-- These patients are assumed to no longer need transport services
DELETE FROM Patient
WHERE Patient_ID NOT IN (
    -- Patients with recent rides (last 6 months)
    SELECT DISTINCT Patient_ID
    FROM Ride
    WHERE Ride_Date >= CURRENT_DATE - INTERVAL '6 months'
)
AND Patient_ID NOT IN (
    -- Patients with future rides
    SELECT DISTINCT Patient_ID
    FROM Ride
    WHERE Ride_Date >= CURRENT_DATE
);
