# Transport Management System - Ezer Mizion

## 📌 
**Submitted by:** Esther Rosen & Noa Kopolovich  
**System:** Transport Management System  
**Selected Unit:** Patient Transport Division - Ezer Mizion  

---

## 📖 Table of Contents
1. [Introduction](#introduction)
2. [Project Stages](#project-stages)
   - [Stage 1: Initial System Design](#stage-1-initial-system-design)
     - [ERD - Entity-Relationship Diagram](#erd---entity-relationship-diagram)
     - [DSD - Data Structure Diagram](#dsd---data-structure-diagram)
     - [Data Insertion Methods](#data-insertion-methods)
     - [Database Backup and Restore](#database-backup-and-restore)
   - [Stage 2: Constraints and SQL Queries](#stage-2-constraints-and-sql-queries)  
     - [SQL Queries](#sql-queries)  
       - [SELECT Queries](#select-queries)  
       - [DELETE Queries](#delete-queries)  
       - [UPDATE Queries](#update-queries)  
     - [Constraints](#constraints)

---

## Introduction
The **Ezer Mizion** Transport Management System is designed to manage patient transportation logistics to hospitals, clinics, and other medical centers. The system maintains records of **patients**, **vehicles**, **destinations**, **drivers**, **transport assistants**, and **rides**.

### 🎯 **Main Functionality**
✔ Manage patient records and ride history.  
✔ Assign vehicles and drivers to trips.  
✔ Support volunteers accompanying patients when needed.  
✔ Document destination points (hospitals, clinics, etc.).  
✔ Track vehicle availability and maintenance.  

---

## Project Stages

---

### Stage 1: Initial System Design

#### ERD - Entity-Relationship Diagram
![ERD](https://github.com/user-attachments/assets/bba8d985-750e-42d8-bdab-7fc84a903914)

#### DSD - Data Structure Diagram
![DSD](https://github.com/user-attachments/assets/93b057d7-0ba5-42d7-91ce-8dfbb8eff4e7)

---

#### Data Insertion Methods

In this stage, we populated our database using three different methods:

1. **CSV Import**  
   We created and cleaned data in Excel, saved it as `.csv`, and imported it into the database via pgAdmin.  
   ![csv](https://github.com/user-attachments/assets/052e4eba-965e-47b3-8d37-2e2115479c3e)


2. **Mockaroo**  
   We generated sample datasets using [mockaroo.com](https://mockaroo.com/) and saved them in CSV format, then loaded them into the relevant tables.  
   ![mockeroo](https://github.com/user-attachments/assets/8c7b1db3-dd25-43fa-9152-b09204da8745)


3. **Python Script**  
   We wrote a custom Python script using `psycopg2` to connect to the database and insert hundreds of realistic records, including volunteers, drivers, assistants, and rides.  
   ![script](https://github.com/user-attachments/assets/7636f529-40c5-419b-87ea-f336951087c0)
   
    
---

#### Database Backup and Restore

We backed up our populated database and restored it on another user account to simulate data migration or system transfer.

- **Backup:** Performed using pgAdmin’s “Backup…” option in Custom format.  
- **Restore:** Created a new database and used the “Restore…” function with the backup file.  

![גיבוי](https://github.com/user-attachments/assets/5ab36a3b-c286-44cc-bc01-7d5c179c3297)
![שחזור](https://github.com/user-attachments/assets/553b6d81-5dc7-4909-92b9-801212bd50d6)


---

### Stage 2: Constraints and SQL Queries

#### SQL Queries

- ##### SELECT Queries
  **Query 1**
  This query shows each patient with the number of past and future rides. It helps track ride history and upcoming transport needs.

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
![צילום מסך 2025-04-02 172626](https://github.com/user-attachments/assets/2d4acfe7-9dda-4a26-8b4c-3ab838ef8d59)

    
  **Query 2**
     This query returns the top 3 volunteers with the highest number of rides for each past month.
     It helps identify the most active volunteers over time and can be used for recognition or performance tracking.

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
![צילום מסך 2025-04-02 173329](https://github.com/user-attachments/assets/653b716b-2d99-47fe-a0a4-8e9e1d717fe3)



  **Query 3**

   This query returns all drivers who are available for night shifts, showing how many night rides they have actually completed.
   It helps evaluate how active night drivers are during their declared availability hours (from 19:00 to 07:00).
   -- Show night-available drivers and how many night rides they have completed

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

![צילום מסך 2025-04-02 173908](https://github.com/user-attachments/assets/fde5f7e0-e552-42a5-a3c2-0f95ab79f506)


  **Query 4**
  This query lists all volunteers who have a birthday in the current month.
  It also calculates their current age. This can be used to send birthday greetings or recognize volunteers.

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
![צילום מסך 2025-04-02 174132](https://github.com/user-attachments/assets/bf0fd372-d403-4d04-b1ca-a7e9cc7ebfe8)


  **Query 5**

  This query finds all patient-driver pairs who live in the same city.
  It compares the city in the driver's profile to the city extracted from the patient's address.
  This can help optimize ride assignments based on location proximity.

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
   ORDER BY City;

  ![image](https://github.com/user-attachments/assets/8cbb3f29-ae56-4c0e-8259-2871961d140d)

  **Query 6**

   This query shows how many vehicles of each type exist in the system, and how many of them are available today (not assigned to any ride).
   It helps monitor vehicle availability for the current day based on ride scheduling.\

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
   GROUP BY  v.Type
   ORDER BY  v.Type;

![image](https://github.com/user-attachments/assets/abc8c224-3c0f-4151-b4e0-77f0cd126ea6)

  **Query 7**

   This query returns the top 5 most popular destinations for each year based on the number of rides.
   It helps identify which medical centers receive the highest transport demand annually.

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

![image](https://github.com/user-attachments/assets/3114b8ed-847b-4e25-817e-113ab1a2640a)

  **Query 8**

  This query returns all volunteers with medical training who are not assigned as assistants in any ride today.
  It helps find available medically trained assistants for new rides.

   SELECT 
       Volunteer_ID,
       First_Name || ' ' || Last_Name AS Full_Name,
       Phone_Number
   FROM 
       Transport_Assistant
   NATURAL JOIN Volunteer  -- Join by Volunteer_ID
   WHERE 
       Has_Medical_Training = 'Y'  -- Only assistants with medical training
   
   -- Exclude assistants already assigned today
       AND Volunteer_ID NOT IN (
           SELECT Assistant_ID 
           FROM Ride 
           WHERE Ride_Date = CURRENT_DATE
             AND Assistant_ID IS NOT NULL
       )
   ORDER BY 
       Last_Name, First_Name;

![image](https://github.com/user-attachments/assets/6a89581c-795c-4608-8eb3-8f8afcdbfa4b)

  
- ##### DELETE Queries
- ##### UPDATE Queries

#### Constraints
