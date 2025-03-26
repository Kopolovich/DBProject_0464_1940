CREATE TABLE Patient
(
  Patient_ID INT NOT NULL,
  First_Name VARCHAR(20) NOT NULL,
  Last_Name VARCHAR(20) NOT NULL,
  Gender CHAR(1) NOT NULL,
  Date_of_Birth DATE NOT NULL,
  Address VARCHAR(30) NOT NULL,
  Phone_Number INT NOT NULL,
  Is_Disabled CHAR(1) NOT NULL,  
  Medical_Equipment VARCHAR(20) NOT NULL,  
  PRIMARY KEY (Patient_ID)
);

CREATE TABLE Vehicle
(
  Vehicle_ID INT NOT NULL,
  License_Plate INT NOT NULL,
  Type VARCHAR(20) NOT NULL,
  Capacity INT NOT NULL,
  PRIMARY KEY (Vehicle_ID)
);

CREATE TABLE Destination
(
  Destination_Name VARCHAR(35) NOT NULL,
  Destination_Address VARCHAR(50) NOT NULL,
  Destination_Type VARCHAR(20) NOT NULL,
  PRIMARY KEY (Destination_Name, Destination_Address)
);

CREATE TABLE Volunteer
(
  Volunteer_ID INT NOT NULL,
  First_Name VARCHAR(20) NOT NULL,
  Last_Name VARCHAR(20) NOT NULL,
  Date_of_Birth DATE NOT NULL,
  Phone_Number INT NOT NULL,
  City VARCHAR(20) NOT NULL,  
  PRIMARY KEY (Volunteer_ID)
);

CREATE TABLE Driver
(
  Volunteer_ID INT NOT NULL,
  License_Number INT NOT NULL,  
  PRIMARY KEY (Volunteer_ID),
  FOREIGN KEY (Volunteer_ID) REFERENCES Volunteer(Volunteer_ID)
);

CREATE TABLE Transport_Assistant
(
  Volunteer_ID INT NOT NULL,
  Gender CHAR(1) NOT NULL,
  Has_Medical_Training CHAR(1) NOT NULL,  
  PRIMARY KEY (Volunteer_ID),
  FOREIGN KEY (Volunteer_ID) REFERENCES Volunteer(Volunteer_ID)
);

CREATE TABLE Ride
(
  Ride_ID INT NOT NULL,
  Ride_Date DATE NOT NULL,
  Pickup_Time TIME NOT NULL,
  Patient_ID INT NOT NULL,
  Vehicle_ID INT NOT NULL,
  Driver_ID INT NOT NULL,
  Assistant_ID INT,
  Destination_Name VARCHAR(35) NOT NULL,
  Destination_Address VARCHAR(50) NOT NULL,
  PRIMARY KEY (Ride_ID),
  FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
  FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(Vehicle_ID),
  FOREIGN KEY (Driver_ID) REFERENCES Driver(Volunteer_ID),
  FOREIGN KEY (Assistant_ID) REFERENCES Transport_Assistant(Volunteer_ID),
  FOREIGN KEY (Destination_Name, Destination_Address) REFERENCES Destination(Destination_Name, Destination_Address)
);
