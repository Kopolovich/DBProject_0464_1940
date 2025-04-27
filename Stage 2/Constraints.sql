-- 1. Re-define the foreign key from Ride to Patient
-- This ensures that if a patient is deleted, all their rides are automatically removed (cascade deletion)
ALTER TABLE Ride
DROP CONSTRAINT IF EXISTS ride_patient_id_fkey;

ALTER TABLE Ride
ADD CONSTRAINT ride_patient_id_fkey
FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
ON DELETE CASCADE;

-- 2. Allow only specific vehicle types in the Vehicle table
ALTER TABLE Vehicle
ADD CONSTRAINT valid_vehicle_type
CHECK (Type IN ('Accessible van', 'car', 'Ambulance'));

-- 3. Ensure the 'Is_Disabled' field in Patient is only 'Y' (yes) or 'N' (no)
ALTER TABLE Patient
ADD CONSTRAINT valid_is_disabled
CHECK (Is_Disabled IN ('Y', 'N'));

-- 4. Ensure the 'Gender' field in Patient is only 'F' (female) or 'M' (male)
ALTER TABLE Patient
ADD CONSTRAINT valid_gender
CHECK (Gender IN ('F', 'M'));

-- 5. Set default value for 'Has_Medical_Training' to 'N' in Transport_Assistant
-- This avoids missing values and assumes no training unless specified
ALTER TABLE Transport_Assistant
ALTER COLUMN Has_Medical_Training SET DEFAULT 'N';
