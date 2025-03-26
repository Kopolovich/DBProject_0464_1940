-- Drop tables in the correct order to avoid foreign key conflicts
DROP TABLE IF EXISTS Ride;
DROP TABLE IF EXISTS Driver;
DROP TABLE IF EXISTS Transport_Assistant;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Vehicle;
DROP TABLE IF EXISTS Destination;
DROP TABLE IF EXISTS Volunteer;