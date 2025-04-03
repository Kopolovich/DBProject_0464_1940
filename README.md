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
  
##### Query 1

This query shows each patient with the number of past and future rides. It helps track ride history and upcoming transport needs.

![image](https://github.com/user-attachments/assets/938b97cc-c59d-4a60-93f1-5ece6abf4a50)  
![image](https://github.com/user-attachments/assets/9bca6070-a939-4e0d-a2c8-9af4b67ab0ce)

##### Query 2

This query returns the top 3 volunteers with the highest number of rides for each past month.  
It helps identify the most active volunteers over time and can be used for recognition or performance tracking.

![image](https://github.com/user-attachments/assets/aba89053-119b-48fa-a2a7-96832834dd25)  
![image](https://github.com/user-attachments/assets/5d36cfdd-56e6-4d43-b376-e999c9309a5d)

##### Query 3

This query returns all drivers who are available for night shifts, showing how many night rides they have actually completed.  
It helps evaluate how active night drivers are during their declared availability hours (from 19:00 to 07:00).

![image](https://github.com/user-attachments/assets/feea35e2-265b-4e0d-81bf-e6a8986262ee)  
![image](https://github.com/user-attachments/assets/3d837720-c059-4424-ae80-bf39787a40d7)

##### Query 4

This query lists all volunteers who have a birthday in the current month.  
It also calculates their current age. This can be used to send birthday wishes or recognize volunteers.

![image](https://github.com/user-attachments/assets/652feca7-2529-4601-810c-0e174f674967)  
![image](https://github.com/user-attachments/assets/1240fa5e-2e88-465d-93fd-ec4f0a33aa6c)

##### Query 5

This query finds all patient-driver pairs who live in the same city.  
It compares the city in the driver's profile to the city extracted from the patient's address.  
This can help optimize ride assignments based on location proximity.

![image](https://github.com/user-attachments/assets/0b45f899-6687-434e-b1e6-1330897b6592)  
![image](https://github.com/user-attachments/assets/9f2e1665-96a6-49a3-bddf-850ca1f859e4)

##### Query 6

This query shows how many vehicles of each type exist in the system, and how many of them are available today (not assigned to any ride).  
It helps monitor vehicle availability for the current day based on ride scheduling.

![image](https://github.com/user-attachments/assets/1f1c164a-8eb5-43fb-9ea8-adf3d69dda0a)  
![image](https://github.com/user-attachments/assets/575bbcca-31eb-4359-ad8a-5ab005d80894)

##### Query 7

This query returns the top 5 most popular destinations for each year based on the number of rides.  
It helps identify which medical centers receive the highest transport demand annually.

![image](https://github.com/user-attachments/assets/c459101d-2398-479a-8985-9bfb050d5990)  
![image](https://github.com/user-attachments/assets/25a56a65-e837-4d84-a505-13b39dc69a93)

##### Query 8

This query returns all volunteers with medical training who are not assigned as assistants in any ride today.  
It helps find available medically trained assistants for new rides.

![image](https://github.com/user-attachments/assets/85f8fefa-fcc4-4aab-9652-f90fd4f523dd)  
![image](https://github.com/user-attachments/assets/937ddac5-6787-44db-ae4f-3e7f4f7af380)

  
- ##### DELETE Queries

  
- ##### UPDATE Queries
  
  Update Query 1 – Night Availability
     This update automatically marks drivers as available for night shifts if they have already completed more than one ride during night hours.
     It reflects actual driver activity and keeps the system data up to date based on performance.
  ![צילום מסך 2025-04-03 102706](https://github.com/user-attachments/assets/de372603-ca44-47dc-aef2-f9caf33d53ce)
   Before update:
![צילום מסך 2025-04-03 102341](https://github.com/user-attachments/assets/4ec496ce-bcd0-4c70-90a1-6f132124da92)
   After update:

  ![צילום מסך 2025-04-03 102541](https://github.com/user-attachments/assets/df156a57-f817-4186-9cd1-4f4792d530aa)

   Update Query 2 – Haifa Ride Delay
      On November 28th, 2025, a power outage occurred in the city of Haifa, affecting hospitals and clinics.
      As a response, all scheduled rides to Haifa on that day were delayed by one hour to ensure proper coordination and patient safety.
  ![צילום מסך 2025-04-03 104804](https://github.com/user-attachments/assets/c9110125-1672-4fb2-bbfd-392f9778ef42)
     Before update:
![צילום מסך 2025-04-03 104624](https://github.com/user-attachments/assets/4523cec0-4f00-4f5a-b10a-10cff484adbe)
     After update:
  ![צילום מסך 2025-04-03 104845](https://github.com/user-attachments/assets/7c458f2f-0af8-4b76-87c1-7a6d404f9673)

   Update Query 3 – Volunteer Name Change
      While volunteering together, Noa Kaplan and Ori Shemesh met and formed a special connection.
      After getting married, Noa changed her last name to Shemesh — and the system was updated to reflect her new chapter in life.
![צילום מסך 2025-04-03 110915](https://github.com/user-attachments/assets/e3360e23-2f94-4a9e-9dd1-3d13617a482c)
      Before update:
  ![צילום מסך 2025-04-03 110836](https://github.com/user-attachments/assets/73c6643a-259d-4ed8-87ff-62af3a77a8ab)
      After update:
  ![צילום מסך 2025-04-03 110946](https://github.com/user-attachments/assets/3dada275-f384-4f21-9970-1274bbfb87d6)

#### Constraints
