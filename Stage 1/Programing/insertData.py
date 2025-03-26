import random
import psycopg2

# Database connection
conn = psycopg2.connect(
    host='localhost',
    port=5432,
    user='esti',
    password='3271',
    dbname='mydatabase'
)
cursor = conn.cursor()

# Get all volunteer IDs and split them randomly into drivers and assistants
cursor.execute("SELECT Volunteer_ID FROM Volunteer")
volunteers = [row[0] for row in cursor.fetchall()]
random.shuffle(volunteers)

driver_ids = volunteers[:len(volunteers)//2]
assistant_ids = volunteers[len(volunteers)//2:]

# Insert drivers with a random license number and night availability flag (Y/N)
for driver in driver_ids:
    license_number = random.randint(1000000, 9999999)
    night_avail = random.choice(['Y', 'N'])
    cursor.execute(
        "INSERT INTO Driver (License_Number, Volunteer_ID, Night_Avail) VALUES (%s, %s, %s)",
        (license_number, driver, night_avail)
    )
conn.commit()
print("Inserted drivers successfully!")

# Insert transport assistants with random medical training flag (Y/N)
for assistant in assistant_ids:
    medical_training = random.choice(['Y', 'N'])
    cursor.execute(
        "INSERT INTO Transport_Assistant (Has_Medical_Training, Volunteer_ID) VALUES (%s, %s)",
        (medical_training, assistant)
    )
conn.commit()
print("Inserted assistants successfully!")

# Get data for generating rides
cursor.execute("SELECT Patient_ID FROM Patient")
patients = [row[0] for row in cursor.fetchall()]
cursor.execute("SELECT Vehicle_ID FROM Vehicle")
vehicles = [row[0] for row in cursor.fetchall()]
cursor.execute("SELECT Destination_Name, Destination_Address FROM Destination")
destinations = cursor.fetchall()

# Keep track of entities already scheduled at the same time to avoid conflicts
existing_rides = set()

# Function to generate a unique ride that doesn't reuse the same driver, vehicle, patient, or assistant at the same time
def generate_unique_ride():
    while True:
        patient_id = random.choice(patients)
        vehicle_id = random.choice(vehicles)
        driver_id = random.choice(driver_ids)
        assistant_id = random.choice(assistant_ids) if random.random() < 0.8 else None
        destination = random.choice(destinations)
        date = f"2025-04-{random.randint(1, 30):02d}"
        time = f"{random.randint(6, 20):02d}:{random.choice(['00', '15', '30', '45'])}:00"
        ride_key = (date, time, patient_id, vehicle_id, driver_id, assistant_id)
        # Make sure this ride doesn't conflict with existing ones (per entity & time)
        if all(
            (date, time, entity) not in existing_rides for entity in [patient_id, vehicle_id, driver_id, assistant_id]
        ):
            # Mark all entities as busy at this date/time
            existing_rides.update({(date, time, patient_id), (date, time, vehicle_id), (date, time, driver_id)})
            if assistant_id:
                existing_rides.add((date, time, assistant_id))
            return ride_key, destination

# Generate and insert 400 unique rides
for ride_id in range(1, 401):
    (date, time, patient_id, vehicle_id, driver_id, assistant_id), destination = generate_unique_ride()
    cursor.execute(
        "INSERT INTO Ride (Ride_ID, Ride_Date, Pickup_Time, Patient_ID, Vehicle_ID, Driver_ID, Assistant_ID, Destination_Name, Destination_Address) "
        "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
        (ride_id, date, time, patient_id, vehicle_id, driver_id, assistant_id, destination[0], destination[1])
    )
conn.commit()
print("Inserted rides successfully!")

cursor.close()
conn.close()
print("Data inserted successfully!")

