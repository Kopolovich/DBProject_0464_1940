<div align="center" style="display: flex; align-items: center;">
  <img src="https://github.com/user-attachments/assets/611c87c9-331b-4c18-8dfa-9ccbdcd0fc88" width="80" style="margin-right: 20px;"/>
  <h1 style="display: inline-block; margin: 0;">Transport Management System - Ezer Mizion</h1>
</div>


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
     - [Rollback and Commit](#rollback-and-commit)
   - [Stage 3: Integration and Views](#stage-3-integration-and-views)
     - [Integration of the Medical Equipment Loan Unit into Transport Management System](#integration-of-the-medical-equipment-loan-unit-into-transport-management-system)
     - [Views](#views)
   - [Stage 4: PLpgSQL Logic and Triggers](#stage-4-plpgsql-logic-and-triggers)
     - [Program 1 - Driver Availability and Assistant Assignment](#program-1---driver-availability-and-assistant-assignment)
     - [Program 2 - Expired Warranty and Overdue Borrow Handling](#program-2---expired-warranty-and-overdue-borrow-handling)
     - [Triggers](#triggers)
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
   DELETE Query 1 – Remove Old Rides
  
   This query deletes all ride records that took place before the beginning of the current year.
   It helps reduce clutter in the database and keep only recent or relevant transportation history.
  
![צילום מסך 2025-04-03 115530](https://github.com/user-attachments/assets/2b4fef55-f339-4ed4-9b65-68f08118531b)

   Before delete:

  ![צילום מסך 2025-04-03 115407](https://github.com/user-attachments/assets/f8c89fa2-813f-4852-bd37-14510580c0a9)

   After delete:

  ![צילום מסך 2025-04-03 115626](https://github.com/user-attachments/assets/2c3d9de1-52fb-4661-990e-f854dbccaf12)


   DELETE Query 2 – Clean Up Unused Volunteers
  
   This query removes volunteers who are not registered as drivers or assistants.
   These may be outdated entries or volunteers who never became active in the system.

![צילום מסך 2025-04-03 121521](https://github.com/user-attachments/assets/225c4c0b-90aa-44f6-bf9b-e885e135be79)

   Before delete:

![צילום מסך 2025-04-03 121105](https://github.com/user-attachments/assets/9a1a2e7c-952b-445e-bc5c-150bbc3d7a1d)

   After delete:

   ![צילום מסך 2025-04-03 121602](https://github.com/user-attachments/assets/cd2e77fc-b875-4ff7-b2db-98a5b531feb4)


   DELETE Query 3 – Remove Inactive Patients
   
   Patients who haven’t used the transport service in the last 6 months and have no upcoming rides are considered inactive.  
   This query removes them from the system to keep the patient list up to date.

   
![צילום מסך 2025-04-03 124357](https://github.com/user-attachments/assets/7ee67f8f-82c2-48a7-963e-2cb928dea7eb)

   Before delete:

   ![צילום מסך 2025-04-03 124225](https://github.com/user-attachments/assets/c1ae86f4-7cc9-4fb0-9cd1-58fcb169e217)

   After delete:

   ![צילום מסך 2025-04-03 124436](https://github.com/user-attachments/assets/0c815e6e-255c-4a09-876e-0d1d7a0107b8)

  
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
   
![עדכון חתונה](https://github.com/user-attachments/assets/1a132419-062c-4b08-a414-5a00790e1375)

#### Constraints

**Constraint 1 – Foreign Key with Cascade Delete (Ride → Patient)**

If a patient is deleted, all of their related rides will also be deleted automatically.  
This keeps the data clean and avoids rides linked to non-existent patients.

![image](https://github.com/user-attachments/assets/63e90b92-9117-4924-9e09-ec26873062c8)

The screenshot shows that we were able to successfully delete 4 patients,
even though they were referenced as foreign keys in the Ride table.  
This worked because of the ON DELETE CASCADE constraint we added to the foreign key between Ride and Patient.

![צילום מסך 2025-04-03 124357](https://github.com/user-attachments/assets/f2856af5-687d-4317-8ebf-f85083a80399)

**Constraint 2 - Valid Vehicle Type Check**

The vehicle type can only be one of: 'Accessible van', 'car', or 'Ambulance'.
This ensures consistency and prevents incorrect vehicle types from being added.

![image](https://github.com/user-attachments/assets/677dda88-794c-49e8-8f66-72639d15460b)

![צילום מסך 2025-04-07 143039](https://github.com/user-attachments/assets/53c073c1-ebe3-4db0-a3e2-03156ea1caab)

**Constraint 3 - Is_Disabled Field Check**

The Is_Disabled field must be either 'Y' (Yes) or 'N' (No).  
This makes the patient's accessibility status clear and standardized.

![image](https://github.com/user-attachments/assets/1c732d83-3ec2-4508-b2fa-ae4ebe63ccfb)

![צילום מסך 2025-04-07 143233](https://github.com/user-attachments/assets/f1475255-5550-484f-918d-ec92d23ebec7)

**Constraint 4 - Gender Field Check**

The Gender field must be 'F' (Female) or 'M' (Male).  
This keeps gender values consistent and easy to use in the system.

![image](https://github.com/user-attachments/assets/8227dbc9-ff4d-4a03-946a-d555de434d5d)

![צילום מסך 2025-04-07 143331](https://github.com/user-attachments/assets/d0a064fc-6491-4521-b964-d52b812e2c27)

**Constraint 5 - Default Value for Medical Training**

If Has_Medical_Training is not entered for a transport assistant, it will default to 'N'.  
This prevents missing data and assumes no training unless specified.

![image](https://github.com/user-attachments/assets/f8e2f9aa-b4f5-4148-be15-a530132fcb2f)

![צילום מסך 2025-04-07 144316](https://github.com/user-attachments/assets/1660d75b-a6b1-487a-8d6b-cdfdefd04c58)

#### Rollback and Commit

**Rollback:**

![צילום מסך 2025-04-24 104348](https://github.com/user-attachments/assets/61e95012-03fe-452a-b7f4-b0a1323e7fd9)

![צילום מסך 2025-04-24 104429](https://github.com/user-attachments/assets/aefbac93-7491-4d8a-8de7-65fcbf8ae755)

**Commit:**

![צילום מסך 2025-04-24 104614](https://github.com/user-attachments/assets/bf39e45b-127f-4973-900c-82826f55d7bc)

![צילום מסך 2025-04-24 104654](https://github.com/user-attachments/assets/dd97a413-ecd9-4a40-9298-534a162c0d98)


### Stage 3: Integration and Views
#### Integration of the Medical Equipment Loan Unit into Transport Management System

DSD of Medical Equipment Loan Unit: 

![DSD medical](https://github.com/user-attachments/assets/35d5901c-2d40-4027-9fb6-324c9a08396d)

ERD of Medical Equipment Loan Unit:

![ERD medical](https://github.com/user-attachments/assets/cb1d657d-d1e1-4476-8e58-aea2049c90d6)

Integrated ERD:

![ERD integraded](https://github.com/user-attachments/assets/0cb4166a-e3cd-4281-8d7c-9c4e10244360)

Integrated DSD:

![DSD integraded](https://github.com/user-attachments/assets/d7186ee6-cca4-4f4f-87b4-12c931b9b5b1)


Integration Decisions:

In this stage, we integrated the database schema of the Medical Equipment Loan Unit into the existing system of the Patient Transport Division. The goal was to unify both services into a centralized management system while preserving data integrity and minimizing duplication.

Key integration decisions included:

* Merging medical service centers (Service_Center) into the existing Destination table and renaming it to Medical_Center.

* Creating tables for Supplier, Product, and Borrow to manage equipment loans.

* Inserting real data from the original schemas using INSERT INTO ... SELECT and SQL imports.

* Unifying Client with Patient while renaming and normalizing attributes.

* Creating a new subtype of volunteer: Service_Assistant, based on Employee, with special fields such as Role and linked medical center.

Integration Process:

 Part 1 – Create tables for equipment management

![image](https://github.com/user-attachments/assets/a8c4305e-0510-4859-9228-38acb9deadee)


 Part 2 – Convert Destination to Medical_Center and integrate service centers

![image](https://github.com/user-attachments/assets/71801484-0e52-49c7-aeba-968d7d1ba403)


  Part 3 – Unify Patient structure and insert Client data

![image](https://github.com/user-attachments/assets/84b397dd-d192-4956-9812-97afcb862538)


  Part 4 – Create and populate Borrow table
  
![image](https://github.com/user-attachments/assets/43603bc8-e4c1-442a-a9ca-33f0b7655439)


  Part 5 – Create Service_Assistant and import from Employee

![image](https://github.com/user-attachments/assets/5d75a08d-3057-40bd-bc05-29bed0f06726)


#### Views

📄 View 1: view_transport_summary

This view summarizes patient rides, showing the patient name, ride date, destination, driver, and assistant (if any).  
It joins the Ride, Patient, Medical_Center, Driver, and Volunteer tables to present a clear overview of each transport event.  
Useful for tracking ride assignments and reviewing volunteer involvement.

![image](https://github.com/user-attachments/assets/a748ec43-6944-4875-bc57-9d281292caa1)

![צילום מסך 2025-05-07 145316](https://github.com/user-attachments/assets/851cd171-1a87-44e3-baab-f792d4a3fcd2)


✅ Query 1 – Number of rides per assistant (including their full name), only for rides where an assistant was present.
  
![image](https://github.com/user-attachments/assets/51e44027-9d4d-44a2-935d-c3c7615e52b0)


✅ Query 2 – List all patients who had rides in a specific month (March 2025)

![image](https://github.com/user-attachments/assets/40ebd9bd-9270-46b2-9839-0da9c66790e9)



📄 View 2: view_borrow_summary

This view provides a complete summary of medical equipment borrowing activities.
It includes the patient name and contact info, the product borrowed, the borrowing and return dates, and the service center where the product was collected.

It combines data from Borrow, Patient, Product, and Medical_Center, presenting it as a single unified structure for easy querying and analysis.

![image](https://github.com/user-attachments/assets/3e0b1980-35a6-4e69-84fb-17b5b16799e1)

![image](https://github.com/user-attachments/assets/d4f51335-8682-4a9d-a7f9-3d88f4729250)


✅ Query 1 – Patients and Their List of Unreturned Products

This query returns all patients who currently have unreturned medical equipment.
For each patient, it shows their name, phone number, and a comma-separated list of the product names they have not yet returned.
It provides a clear, readable summary that is ideal for contacting patients or generating return reminders.

![image](https://github.com/user-attachments/assets/456457cd-b239-487d-a762-a10131828037)


✅ Query 2 – Most Commonly Borrowed Products

This query returns a list of all medical products and the total number of times each one was borrowed.
It helps identify which items are in highest demand across all patients and time periods.
This information is useful for inventory planning, purchasing decisions, and prioritizing stock availability for popular equipment.

![image](https://github.com/user-attachments/assets/cf02841a-a9f4-4ca6-8709-8d9d1c5442cb)


### Stage 4: PLpgSQL Logic and Triggers
#### Program 1 - Driver Availability and Assistant Assignment

This main program combines two components:

1. A function that checks a driver's availability over the next 14 days.
2. A procedure that automatically assigns transport assistants to rides that currently have none.
   
It helps ensure proper coverage for future rides by analyzing driver availability and resolving assistant gaps.


Function: get_driver_idle_days(driver_id INT)
This function receives a driver ID as input and returns a refcursor pointing to a list of dates within the next 14 days on which the driver is not scheduled for any rides.

The function:
* Creates (if not already existing) a temporary table: temp_driver_idle_dates.
* Deletes any previous data for that driver from the table.
* Loops through the next 14 calendar days.
* Inserts each day where the driver has no rides.
* Returns a refcursor with the list of those idle dates, ordered chronologically.

![image](https://github.com/user-attachments/assets/be267e54-e1a7-40fa-9dbc-196a5660e21f)

Procedure: reassign_ride_assistants()
This procedure scans all upcoming rides that currently have no assigned assistant (assistant_id IS NULL and ride_date >= CURRENT_DATE).

For each ride:
* It searches for a transport assistant who is not already assigned to another ride on the same day, and is not the ride's driver.
* If such an assistant is found, the ride is updated with their ID.
* If not, a notice is printed.
The goal is to automatically fill open assistant slots, while ensuring availability and avoiding conflicts.

![image](https://github.com/user-attachments/assets/9ca4df0a-bc36-4bf3-a3dd-8ddeeb00e12f)

This screenshot shows the two components (get_driver_idle_days and reassign_ride_assistants) listed under the database functions and procedures in pgAdmin.

![image](https://github.com/user-attachments/assets/a795beeb-bcbf-4267-adb8-fc6185017e28)

Main Program: Random Driver Idle Check & Assistant Reassignment
This main program performs a two-part operation:

1. Driver Availability Report
  It randomly selects one driver from the driver table and uses the get_driver_idle_days(driver_id) function to retrieve all of their idle days over the next 14 days. These idle dates are printed   as notices to the console.

2. Assistant Assignment Automation
  It then calls the reassign_ride_assistants() procedure, which automatically fills in transport assistants for all future rides that currently have none assigned.

This combination provides both real-time driver availability insight and improves scheduling integrity by resolving missing assistant assignments in future rides.

![image](https://github.com/user-attachments/assets/c30590f0-9371-43f6-b1db-d4e00caeac16)

Ride Table Before Execution:
This screenshot shows the state of the ride table before the program was run. Several future rides (ride_date >= CURRENT_DATE) have a NULL value in the assistant_id column, meaning no assistant is currently assigned.

![image](https://github.com/user-attachments/assets/edcf15d9-71fd-462a-8460-299b89a8c01f)

Program Output:

![image](https://github.com/user-attachments/assets/0382147b-d133-462a-9c8b-fbff8ccce9f5)

Ride Table After Execution:
This screenshot shows the updated ride table.
All future rides now have a value in the assistant_id column — confirming that assistants were successfully assigned where needed.

![image](https://github.com/user-attachments/assets/ccf1b401-aefa-43d9-9594-04c557bd155f)



#### Program 2 - Expired Warranty and Overdue Borrow Handling

Function: get_unreturned_expired_warranty()

This function returns a refcursor pointing to all borrow records where the borrowed product's warranty has expired and the product has not yet been marked as returned.
* It joins the borrow and product tables.
* Filters for borrows where returned IS DISTINCT FROM 'Y'.
* Filters for products whose warranty_expiration is before today's date.
* Returns these rows through a named cursor (mycursor) for further use.

![image](https://github.com/user-attachments/assets/07f191cc-14b5-4b95-91f3-a4ff1afa0496)

Procedure: auto_return_long_overdue_borrows()

This procedure scans the borrow table for records that:
* Have not been returned (returned IS DISTINCT FROM 'Y')
* Were borrowed over 6 months ago
It then:
* Updates those borrows to 'L' (Late/Lost)
* Prints a notice for each change
* Checks whether the patient has any additional overdue items and prints a corresponding message
* 
![image](https://github.com/user-attachments/assets/b052d8df-5433-4388-808a-40e1f7a06e7f)

This screenshot shows the two components (get_unreturned_expired_warranty, auto_return_long_overdue_borrows) listed under the database functions and procedures in pgAdmin.

![צילום מסך 2025-05-21 170326](https://github.com/user-attachments/assets/dfa93890-3571-4ad9-8365-2aac6d58fd90)

Main Program Logic
The following block orchestrates the full process:
1. Updates the borrow. returned field constraint to allow an additional 'L' value (for late/irrecoverable items).
2. Calls get_unreturned_expired_warranty() to retrieve and display all currently overdue borrows due to expired warranty.
3. Calls the procedure auto_return_long_overdue_borrows() to mark long-unreturned items as 'L'.

![image](https://github.com/user-attachments/assets/886a4a4e-023b-46c8-82b9-5754ee85e457)

Before Execution – Overdue Borrows (Older Than 6 Months)
This screenshot displays the result of the following query, showing all borrow records that were borrowed more than 6 months ago and are still not marked as returned:

![image](https://github.com/user-attachments/assets/5bad52f3-70f6-4c48-8953-acb9f2389ba0)

Program Output:

![image](https://github.com/user-attachments/assets/34e9cd5a-44d5-4cda-ba48-54c6b69c4bdb)
![image](https://github.com/user-attachments/assets/528dc6bd-87d8-42a0-b65a-acac396ffd8b)

After Execution – Overdue Borrows Marked as 'L'
This screenshot shows the same query result after running the program.
The returned values for the relevant records have been updated to 'L', indicating that the overdue items have been automatically marked as late or lost.

![image](https://github.com/user-attachments/assets/1469eb20-0e57-4944-b235-5eecd53ea2e4)



#### Triggers

**Volunteer Role Conflict Prevention Trigger**
Purpose:
This trigger ensures that each volunteer can hold only one role in the system — as a driver, transport_assistant, or service_assistant.
If a volunteer already appears in one of the other two role tables, any attempt to insert them into a second role will be blocked with an error message.

Trigger for Driver Insertion
The following function and trigger enforce this rule when inserting into the driver table:

![image](https://github.com/user-attachments/assets/56184c99-e377-4604-a7d6-23f1b03f821f)

Other Volunteer Types
The same logic was applied with separate triggers for:

transport_assistant: prevents insertion if the volunteer already appears as a driver or service assistant.
service_assistant: prevents insertion if the volunteer already appears as a driver or transport assistant.
Each of these roles has its own dedicated function and trigger to enforce mutual exclusivity.

![image](https://github.com/user-attachments/assets/1d56902d-0ddf-428e-94b2-f1733389038a)


Role Conflict Enforcement in Action
In this test, a volunteer was successfully added and assigned as a driver.
However, when attempting to assign the same volunteer as a transport assistant, the system rejected the action with an error — confirming that the trigger correctly prevents role conflicts.

![image](https://github.com/user-attachments/assets/30e2770f-a556-4c28-b27e-dd48b641bbd2)

![image](https://github.com/user-attachments/assets/11065bc6-1896-4c56-935e-553e5866f896)

**Future Borrow Date Correction Trigger**
This trigger ensures that no borrow record is created or updated with a borrowed_at date set in the future.
If such a date is detected, it is automatically replaced with the current date (CURRENT_DATE) before the row is saved.

![image](https://github.com/user-attachments/assets/0b62aa81-3a72-4822-afcf-13b141e4d3b9)

Test: Automatic Correction of Future Borrow Date
In this test, a borrow record is inserted with a future date (2025-10-10).
The trigger detects the invalid value and automatically replaces it with the current date.

![image](https://github.com/user-attachments/assets/8b50bddd-2061-4917-bab8-5e2d11db9453)

