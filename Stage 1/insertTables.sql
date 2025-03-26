INSERT INTO Patient (Patient_ID, First_Name, Last_Name, Date_of_Birth, Address, Is_Disabled, Gender, Medical_Equipment, Phone_Number) VALUES
(10001, 'David', 'Cohen', '1950-06-15', 'Tel Aviv, Dizengoff 10', 'Y', 'M', 'Wheelchair', 0541234567),
(10002, 'Miriam', 'Levi', '1985-11-23', 'Jerusalem, Herzl 5', 'N', 'F', 'None', 0529876543),
(10003, 'Yossi', 'Peretz', '1972-09-07', 'Haifa, HaNassi 20', 'Y', 'M', 'Crutches', 0501122334);

INSERT INTO Vehicle (Vehicle_ID, License_Plate, Type, Capacity) VALUES
(50001, 1234567, 'Van', 4),
(50002, 7654321, 'Minibus', 8),
(50003, 2468135, 'Car', 3);

INSERT INTO Destination (Destination_Name, Destination_Address, Destination_Type) VALUES
('Ichilov Hospital', 'Weizmann 6, Tel Aviv', 'Hospital'),
('Hadassah Ein Kerem', 'Ein Kerem, Jerusalem', 'Hospital'),
('Rambam Hospital', 'HaAliya HaShniya 8, Haifa', 'Hospital');

INSERT INTO Volunteer (Volunteer_ID, First_Name, Last_Name, Date_of_Birth, Phone_Number, City) VALUES
(20001, 'Avi', 'Mizrahi', '1980-04-10', 0587654321, 'Tel Aviv'),
(20002, 'Noa', 'Shahar', '1992-08-21', 0542345678, 'Jerusalem'),
(20003, 'Eitan', 'Goldman', '1975-12-05', 0523456789, 'Haifa'),
(20004, 'Rachel', 'Bar', '1988-03-15', 0506781234, 'Tel Aviv'),
(20005, 'Shimon', 'Katz', '1990-07-22', 0534567890, 'Jerusalem'),
(20006, 'Or', 'Levi', '1983-05-30', 0549876543, 'Haifa');

INSERT INTO Driver (License_Number, Volunteer_ID) VALUES
(1111111, 20001),
(2222222, 20002),
(3333333, 20003);

INSERT INTO Transport_Assistant (Gender, Has_Medical_Training, Volunteer_ID) VALUES
('M', 'Y', 20004),
('F', 'N', 20005),
('M', 'Y', 20006);

INSERT INTO Ride (Ride_ID, Ride_Date, Pickup_Time, Patient_ID, Vehicle_ID, Driver_ID, Assistant_ID, Destination_Name, Destination_Address) VALUES
(1, '2025-04-01', '08:00:00', 10001, 50001, 20001, 20004, 'Ichilov Hospital', 'Weizmann 6, Tel Aviv'),
(2, '2025-04-02', '09:30:00', 10002, 50002, 20002, 20005, 'Hadassah Ein Kerem', 'Ein Kerem, Jerusalem'),
(3, '2025-04-03', '10:15:00', 10003, 50003, 20003, 20006, 'Rambam Hospital', 'HaAliya HaShniya 8, Haifa');
