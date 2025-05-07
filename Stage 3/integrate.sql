-- =========================================
-- Step 1: Create tables for equipment management
-- =========================================

-- Table storing suppliers for medical equipment
CREATE TABLE Supplier (
  ID NUMERIC(9) NOT NULL,
  Name VARCHAR(40) NOT NULL,
  Phone VARCHAR(11) NOT NULL,
  address VARCHAR(40) NOT NULL,
  PRIMARY KEY (ID)
);

-- Table storing products and linking them to suppliers
CREATE TABLE Product (
  ID INT NOT NULL,
  Name VARCHAR(40) NOT NULL,
  need_return INT NOT NULL,
  warranty_expiration DATE NOT NULL,
  SID NUMERIC(9) NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (SID) REFERENCES Supplier(ID)
);

-- =========================================
-- Step 2: Integrate Service_Center into Destination → renamed Medical_Center
-- =========================================

-- Add optional fields for operation hours and phone number
ALTER TABLE Destination
ADD Operation_Hours VARCHAR(20);

ALTER TABLE Destination
ADD Phone_Number VARCHAR(11);

-- Insert service centers into Destination table with proper type
INSERT INTO Destination (Destination_Name, Destination_Address, Destination_Type, Operation_Hours, Phone_Number)
SELECT ScName, Location, 'service_center', Operation_hours, Phone_number
FROM Service_Center;

-- Drop foreign key before renaming the table
ALTER TABLE Ride
DROP CONSTRAINT ride_destination_name_destination_address_fkey;

-- Rename the Destination table to Medical_Center
ALTER TABLE Destination RENAME TO Medical_Center;

-- Rename relevant columns in Medical_Center
ALTER TABLE Medical_Center RENAME COLUMN Destination_Name TO mc_name;
ALTER TABLE Medical_Center RENAME COLUMN Destination_Address TO mc_address;
ALTER TABLE Medical_Center RENAME COLUMN Destination_Type TO mc_type;

-- Recreate foreign key from Ride to Medical_Center
ALTER TABLE Ride
ADD CONSTRAINT ride_medical_center_fkey
FOREIGN KEY (Destination_Name, Destination_Address)
REFERENCES Medical_Center(mc_name, mc_address);

-- =========================================
-- Step 3: Unify Patient structure and insert Client data
-- =========================================

-- Remove Gender column
ALTER TABLE Patient
DROP COLUMN gender;

-- Add combined name column
ALTER TABLE Patient
ADD Patient_Name VARCHAR(50);

-- Combine first and last names
UPDATE Patient
SET Patient_Name = First_Name || ' ' || Last_Name;

-- Drop original name columns
ALTER TABLE Patient
DROP COLUMN First_Name;
ALTER TABLE Patient
DROP COLUMN Last_Name;

-- Set default values for new attributes
ALTER TABLE Patient
ALTER COLUMN is_disabled SET DEFAULT 'N';

ALTER TABLE Patient
ALTER COLUMN medical_equipment SET DEFAULT 'None';

-- Insert data from Client into Patient
INSERT INTO Patient (patient_id, Patient_Name, Phone_number, address, date_of_birth)
SELECT 
  ID,
  Name, 
  Phone_number,
  address,
  DATE '2000-01-01'  
FROM Client;

-- =========================================
-- Step 4: Create and populate Borrow table with center names
-- =========================================

-- New Borrow table structure including center name and address
CREATE TABLE Borrow (
  Borrow_ID SERIAL,
  Borrowed_at DATE NOT NULL,
  returned INT NOT NULL,
  PatientID INT NOT NULL,
  sc_name VARCHAR(35) NOT NULL, 
  sc_address VARCHAR(50) NOT NULL,
  ProductID INT NOT NULL,
  PRIMARY KEY (Borrow_ID),
  FOREIGN KEY (PatientID) REFERENCES Patient(patient_id),
  FOREIGN KEY (sc_name, sc_address) REFERENCES Medical_Center(mc_name, mc_address),
  FOREIGN KEY (ProductID) REFERENCES Product(ID)
);

-- Insert data from Borrow1(original borrow) into new Borrow table
INSERT INTO Borrow (
  Borrowed_at,
  returned,
  PatientID,
  sc_name,
  sc_address,
  ProductID
)
SELECT
  b1.Date,
  b1.return,
  b1.CID,                  
  sc.ScName,
  sc.Location,
  b1.PID
FROM Borrow1 b1
JOIN Service_Center sc ON b1.ScID = sc.ScID;

-- =========================================
-- Step 5: Create Service_Assistant and import from Employee
-- =========================================

-- Create Service_Assistant table as a subtype of Volunteer
CREATE TABLE Service_Assistant (
  Volunteer_ID INT NOT NULL,
  Role VARCHAR(20) NOT NULL,
  volunteers_at VARCHAR(35),
  sc_address VARCHAR(50),
  PRIMARY KEY (Volunteer_ID),
  FOREIGN KEY (volunteers_at, sc_address) REFERENCES Medical_Center(mc_name, mc_address)
);

-- Insert Employee data into Volunteer (with invented date_of_birth and extracted city)
INSERT INTO Volunteer (volunteer_id, name, phone_number, date_of_birth, city)
SELECT 
  ID::INT,                          -- volunteer_id
  Name,                             -- name
  Phone_number,                     -- phone number
  DATE '1980-01-01',                -- invented date_of_birth
  SPLIT_PART(Location, ',', 1)      -- extract city from address
FROM Employee;

-- Insert data into Service_Assistant from Employee
INSERT INTO Service_Assistant (volunteer_id, role, volunteers_at, sc_address)
SELECT 
  ID::INT,
  Role,
  ScName,       -- volunteers_at
  Location      -- sc_address
FROM Employee;
