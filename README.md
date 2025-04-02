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
- ##### DELETE Queries
- ##### UPDATE Queries

#### Constraints
