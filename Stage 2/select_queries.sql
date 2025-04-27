-- Query 1
-- For each patient: total past and future rides, without using CASE
SELECT 
    p.Patient_ID,
    p.First_Name,
    p.Last_Name,

    -- Past rides (before today)
    (SELECT COUNT(*) 
     FROM Ride r1 
     WHERE r1.Patient_ID = p.Patient_ID 
       AND r1.Ride_Date < CURRENT_DATE) AS past_rides,

    -- Future rides (today and onward)
    (SELECT COUNT(*) 
     FROM Ride r2 
     WHERE r2.Patient_ID = p.Patient_ID 
       AND r2.Ride_Date >= CURRENT_DATE) AS future_rides

FROM 
    Patient p
ORDER BY 
    past_rides DESC;


-- Query 2
-- This query returns the top 3 volunteers (by number of rides) for each month.
-- Each row represents one month and includes the names, IDs, and ride counts of the top 3 volunteers.
-- If multiple volunteers have the same number of rides, only the first ones will be selected based on their Volunteer_ID.
-- The data only includes past rides (Ride_Date < CURRENT_DATE).

WITH stats AS (
    SELECT 
        EXTRACT(YEAR FROM r.Ride_Date) AS ride_year,
        EXTRACT(MONTH FROM r.Ride_Date) AS ride_month,
        v.Volunteer_ID,
        MIN(v.First_Name || ' ' || v.Last_Name) AS full_name,  
        COUNT(*) AS total_rides
    FROM 
        Ride r
    JOIN Volunteer v ON v.Volunteer_ID = r.Driver_ID OR v.Volunteer_ID = r.Assistant_ID
    WHERE 
        r.Ride_Date < CURRENT_DATE
    GROUP BY 
        ride_year, ride_month, v.Volunteer_ID
),
-- Build a list of distinct year-month combinations
month_list AS (
    SELECT DISTINCT ride_year, ride_month FROM stats
)

SELECT 
    m.ride_year,
    m.ride_month,

    -- Get the top volunteer by ride count
    (SELECT s1.Volunteer_ID || ' - ' || s1.full_name || ' (' || s1.total_rides || ')'
     FROM stats s1
     WHERE s1.ride_year = m.ride_year AND s1.ride_month = m.ride_month
     ORDER BY s1.total_rides DESC, s1.Volunteer_ID
     LIMIT 1 OFFSET 0) AS top1,

    -- Get the second top volunteer
    (SELECT s2.Volunteer_ID || ' - ' || s2.full_name || ' (' || s2.total_rides || ')'
     FROM stats s2
     WHERE s2.ride_year = m.ride_year AND s2.ride_month = m.ride_month
     ORDER BY s2.total_rides DESC, s2.Volunteer_ID
     LIMIT 1 OFFSET 1) AS top2,

    -- Get the third top volunteer
    (SELECT s3.Volunteer_ID || ' - ' || s3.full_name || ' (' || s3.total_rides || ')'
     FROM stats s3
     WHERE s3.ride_year = m.ride_year AND s3.ride_month = m.ride_month
     ORDER BY s3.total_rides DESC, s3.Volunteer_ID
     LIMIT 1 OFFSET 2) AS top3

FROM month_list m
ORDER BY m.ride_year, m.ride_month;


-- Query 3
-- This query shows all drivers who are marked as available for night shifts,
-- along with the number of rides they actually drove during night hours (from 19:00 to 07:00).
-- This helps evaluate how active night drivers are during their declared availability.

SELECT 
    d.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    COUNT(*) AS night_rides_count
FROM 
    Driver d
NATURAL JOIN Volunteer v
JOIN Ride r ON r.Driver_ID = d.Volunteer_ID
WHERE 
    d.Night_Avail = 'Y'  -- Only drivers who declared night availability

    -- Include rides between 19:00 and 07:00
    AND (
        EXTRACT(HOUR FROM r.Pickup_Time) >= 19 OR  
        EXTRACT(HOUR FROM r.Pickup_Time) < 7        
    )

    AND r.Ride_Date < CURRENT_DATE  -- Only past rides
GROUP BY 
    d.Volunteer_ID, v.First_Name, v.Last_Name
ORDER BY 
    night_rides_count DESC;



-- Query 4
-- Volunteers who have birthdays in the current month, including their age
SELECT 
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Date_of_Birth,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, v.Date_of_Birth)) AS age
FROM 
    Volunteer v
WHERE 
    EXTRACT(MONTH FROM v.Date_of_Birth) = EXTRACT(MONTH FROM CURRENT_DATE)
ORDER BY 
    EXTRACT(DAY FROM v.Date_of_Birth);


-- Query 5
-- Patient-driver pairs who live in the same city
SELECT 
    p.Patient_ID,
    p.First_Name || ' ' || p.Last_Name AS Patient_Name,
    d.Volunteer_ID AS Driver_ID,
    v.First_Name || ' ' || v.Last_Name AS Driver_Name,
    TRIM(v.City) AS City
FROM 
    Patient p
JOIN Ride r ON r.Patient_ID = p.Patient_ID
JOIN Driver d ON d.Volunteer_ID = r.Driver_ID
JOIN Volunteer v ON v.Volunteer_ID = d.Volunteer_ID
WHERE 
    TRIM(v.City) = TRIM(SUBSTRING(p.Address FROM ', (.+)$'))
GROUP BY 
    p.Patient_ID, p.First_Name, p.Last_Name,
    d.Volunteer_ID, v.First_Name, v.Last_Name, v.City, p.Address
ORDER BY 
    City;


-- Query 6
-- For each vehicle type: total count and how many are available today (no rides today)
SELECT 
    v.Type AS Vehicle_Type,
    
    COUNT(*) AS total_vehicles,

    COUNT(*) - COUNT(r_today.Vehicle_ID) AS available_today
FROM 
    Vehicle v
LEFT JOIN (
    SELECT DISTINCT Vehicle_ID
    FROM Ride
    WHERE Ride_Date = CURRENT_DATE
) AS r_today
ON v.Vehicle_ID = r_today.Vehicle_ID
GROUP BY 
    v.Type
ORDER BY 
    v.Type;

-- Query 7
-- Top 5 destinations by number of rides per year

SELECT 
    stats.ride_year,
    stats.Destination_Name,
    stats.Destination_Address,
    stats.ride_count
FROM (
    -- Count how many rides went to each destination per year
    SELECT 
        EXTRACT(YEAR FROM r.Ride_Date) AS ride_year,
        r.Destination_Name,
        r.Destination_Address,
        COUNT(*) AS ride_count
    FROM 
        Ride r
    GROUP BY 
        EXTRACT(YEAR FROM r.Ride_Date), r.Destination_Name, r.Destination_Address
) AS stats
WHERE (
    -- Keep only destinations that are among the top 5 for their year
    SELECT COUNT(*) 
    FROM (
        SELECT 
            r2.Destination_Name,
            r2.Destination_Address,
            COUNT(*) AS ride_count
        FROM Ride r2
        WHERE EXTRACT(YEAR FROM r2.Ride_Date) = stats.ride_year
        GROUP BY r2.Destination_Name, r2.Destination_Address
        HAVING COUNT(*) > stats.ride_count
    ) AS higher
) < 5
ORDER BY 
    stats.ride_year, stats.ride_count DESC;


-- Query 8
-- Volunteers with medical training who are not assigned today 
SELECT 
    Volunteer_ID,
    First_Name || ' ' || Last_Name AS Full_Name,
    Phone_Number
FROM 
    Transport_Assistant
NATURAL JOIN Volunteer
WHERE 
    Has_Medical_Training = 'Y'
    AND Volunteer_ID NOT IN (
        SELECT Assistant_ID 
        FROM Ride 
        WHERE Ride_Date = CURRENT_DATE
          AND Assistant_ID IS NOT NULL
    )
ORDER BY 
    Last_Name, First_Name;
