from flask import Flask, render_template, request, redirect, url_for
import psycopg2
from psycopg2 import errors, Error as PsycopgError
from psycopg2 import sql

app = Flask(__name__)


def get_db_connection():
    return psycopg2.connect(
        host='localhost',
        port=5432,
        user='esti',
        password='3271',
        dbname='mydatabase'
    )


@app.route("/")
def home():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("""
            SELECT DISTINCT
                name,
                EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) AS age
            FROM volunteer
            WHERE TO_CHAR(date_of_birth, 'MM-DD') BETWEEN 
                TO_CHAR(DATE_TRUNC('week', CURRENT_DATE), 'MM-DD')
                AND 
                TO_CHAR(DATE_TRUNC('week', CURRENT_DATE) + INTERVAL '6 days', 'MM-DD')
            ORDER BY name;
        """)
        birthdays = cur.fetchall()
        cur.close()
        conn.close()
        return render_template("home.html", birthdays=birthdays)
    except Exception:
        return render_template("home.html", birthdays=[], error="Failed to load birthdays.")


def get_volunteer_type(conn, volunteer_id):
    cur = conn.cursor()
    try:
        cur.execute("SELECT 1 FROM driver WHERE volunteer_id = %s", (volunteer_id,))
        if cur.fetchone():
            return "Driver"
        cur.execute("SELECT 1 FROM service_assistant WHERE volunteer_id = %s", (volunteer_id,))
        if cur.fetchone():
            return "Service Assistant"
        cur.execute("SELECT 1 FROM transport_assistant WHERE volunteer_id = %s", (volunteer_id,))
        if cur.fetchone():
            return "Transport Assistant"
        return "Unknown"
    except:
        return "Unknown"


@app.route("/volunteers")
def volunteers():
    try:
        from datetime import date
        today = date.today()
        year = today.year
        month = today.month

        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("SELECT volunteer_id, name, date_of_birth, phone_number, city FROM volunteer ORDER BY name;")
        raw_volunteers = cur.fetchall()
        volunteers = []
        for v in raw_volunteers:
            volunteer_type = get_volunteer_type(conn, v[0])
            volunteers.append((v[0], v[1], v[2], v[3], v[4], volunteer_type))

        cur.execute("""
            WITH stats AS (
                SELECT 
                    EXTRACT(YEAR FROM r.Ride_Date) AS ride_year,
                    EXTRACT(MONTH FROM r.Ride_Date) AS ride_month,
                    v.Volunteer_ID,
                    MIN(v.name) AS full_name,
                    COUNT(*) AS total_rides
                FROM Ride r
                JOIN Volunteer v ON v.Volunteer_ID = r.Driver_ID OR v.Volunteer_ID = r.Assistant_ID
                WHERE r.Ride_Date < CURRENT_DATE
                GROUP BY ride_year, ride_month, v.Volunteer_ID
            )
            SELECT
                (SELECT s1.full_name
                 FROM stats s1
                 WHERE s1.ride_year = %s AND s1.ride_month = %s
                 ORDER BY s1.total_rides DESC, s1.Volunteer_ID
                 LIMIT 1 OFFSET 0) AS top1,
                (SELECT s2.full_name
                 FROM stats s2
                 WHERE s2.ride_year = %s AND s2.ride_month = %s
                 ORDER BY s2.total_rides DESC, s2.Volunteer_ID
                 LIMIT 1 OFFSET 1) AS top2,
                (SELECT s3.full_name
                 FROM stats s3
                 WHERE s3.ride_year = %s AND s3.ride_month = %s
                 ORDER BY s3.total_rides DESC, s3.Volunteer_ID
                 LIMIT 1 OFFSET 2) AS top3
        """, (year, month, year, month, year, month))
        podium = cur.fetchone()

        cur.close()
        conn.close()

        return render_template("volunteers.html", volunteers=volunteers, podium=podium, error=request.args.get("error"))
    except Exception:
        return render_template("volunteers.html", volunteers=[], podium=None, error="Failed to load volunteers.")


@app.route("/volunteers/add", methods=["POST"])
def add_volunteer():
    try:
        name = request.form["name"]
        dob = request.form["dob"]
        phone = request.form["phone"]
        city = request.form["city"]
        vtype = request.form["type"]

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT COALESCE(MAX(volunteer_id), 0)+1 FROM volunteer")
        vid = cur.fetchone()[0]

        cur.execute(
            "INSERT INTO volunteer (volunteer_id, name, date_of_birth, phone_number, city) VALUES (%s, %s, %s, %s, %s)",
            (vid, name, dob, phone, city))

        if vtype == "Driver":
            license_number = request.form["license_number"]
            night_avail = request.form["night_avail"]
            cur.execute("INSERT INTO driver (volunteer_id, license_number, night_avail) VALUES (%s, %s, %s)",
                        (vid, license_number, night_avail))
        elif vtype == "Service Assistant":
            role = request.form["role"]
            volunteers_at = request.form["volunteers_at"]
            sc_address = request.form["sc_address"]
            cur.execute(
                "INSERT INTO service_assistant (volunteer_id, role, volunteers_at, sc_address) VALUES (%s, %s, %s, %s)",
                (vid, role, volunteers_at, sc_address))
        elif vtype == "Transport Assistant":
            has_medical_training = request.form["has_medical_training"]
            cur.execute("INSERT INTO transport_assistant (volunteer_id, has_medical_training) VALUES (%s, %s)",
                        (vid, has_medical_training))

        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for("volunteers"))

    except Exception:
        return redirect(url_for("volunteers", error="Failed to add volunteer. Please check the input."))


@app.route("/volunteers/delete/<int:id>")
def delete_volunteer(id):
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("DELETE FROM driver WHERE volunteer_id = %s", (id,))
        cur.execute("DELETE FROM service_assistant WHERE volunteer_id = %s", (id,))
        cur.execute("DELETE FROM transport_assistant WHERE volunteer_id = %s", (id,))
        cur.execute("DELETE FROM volunteer WHERE volunteer_id = %s", (id,))
        conn.commit()

        cur.close()
        conn.close()
        return redirect(url_for("volunteers"))

    except errors.ForeignKeyViolation:
        conn.rollback()
        return redirect(url_for("volunteers", error="Cannot delete volunteer assigned to a ride."))
    except Exception:
        return redirect(url_for("volunteers", error="Unexpected error during deletion."))


@app.route("/volunteers/edit/<int:id>", methods=["GET", "POST"])
def edit_volunteer(id):
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        if request.method == "POST":
            name = request.form["name"]
            dob = request.form["dob"]
            phone = request.form["phone"]
            city = request.form["city"]
            vtype = request.form["type"]

            cur.execute("""
                UPDATE volunteer
                SET name = %s, date_of_birth = %s, phone_number = %s, city = %s
                WHERE volunteer_id = %s
            """, (name, dob, phone, city, id))

            if vtype == "Driver":
                license_number = request.form["license_number"]
                night_avail = request.form["night_avail"]
                cur.execute("""
                    UPDATE driver
                    SET license_number = %s, night_avail = %s
                    WHERE volunteer_id = %s
                """, (license_number, night_avail, id))

            elif vtype == "Service Assistant":
                role = request.form["role"]
                volunteers_at = request.form["volunteers_at"]
                sc_address = request.form["sc_address"]
                cur.execute("""
                    UPDATE service_assistant
                    SET role = %s, volunteers_at = %s, sc_address = %s
                    WHERE volunteer_id = %s
                """, (role, volunteers_at, sc_address, id))

            elif vtype == "Transport Assistant":
                has_medical_training = request.form["has_medical_training"]
                cur.execute("""
                    UPDATE transport_assistant
                    SET has_medical_training = %s
                    WHERE volunteer_id = %s
                """, (has_medical_training, id))

            conn.commit()
            cur.close()
            conn.close()
            return redirect(url_for("volunteers"))

        # GET request
        cur.execute("SELECT name, date_of_birth, phone_number, city FROM volunteer WHERE volunteer_id = %s", (id,))
        v = cur.fetchone()

        def get_type_and_fields():
            cur.execute("SELECT license_number, night_avail FROM driver WHERE volunteer_id = %s", (id,))
            d = cur.fetchone()
            if d:
                return "Driver", {"license_number": d[0], "night_avail": d[1]}

            cur.execute("SELECT role, volunteers_at, sc_address FROM service_assistant WHERE volunteer_id = %s", (id,))
            d = cur.fetchone()
            if d:
                return "Service Assistant", {"role": d[0], "volunteers_at": d[1], "sc_address": d[2]}

            cur.execute("SELECT has_medical_training FROM transport_assistant WHERE volunteer_id = %s", (id,))
            d = cur.fetchone()
            if d:
                return "Transport Assistant", {"has_medical_training": d[0]}

            return "Unknown", {}

        vtype, extra = get_type_and_fields()
        cur.close()
        conn.close()
        return render_template("edit_volunteer.html", id=id, v=v, vtype=vtype, extra=extra)

    except Exception:
        return redirect(url_for("volunteers", error="Failed to load or update volunteer."))

@app.route("/patients")
def patients():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("""
            SELECT patient_id, patient_name, date_of_birth, phone_number, address, is_disabled, medical_equipment
            FROM patient ORDER BY patient_name;
        """)
        patients = cur.fetchall()
        cur.close()
        conn.close()
        return render_template("patients.html", patients=patients, error=request.args.get("error"))
    except Exception:
        return render_template("patients.html", patients=[], error="Failed to load patients.")

@app.route("/patients/add", methods=["POST"])
def add_patient():
    try:
        pid = request.form["patient_id"]
        name = request.form["patient_name"]
        dob = request.form["date_of_birth"]
        phone = request.form["phone_number"]
        address = request.form["address"]
        disabled = request.form["is_disabled"]
        equipment = request.form["medical_equipment"]

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("""
            INSERT INTO patient (patient_id, patient_name, date_of_birth, phone_number, address, is_disabled, medical_equipment)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (pid, name, dob, phone, address, disabled, equipment))

        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for("patients"))

    except Exception:
        return redirect(url_for("patients", error="Failed to add patient."))

@app.route("/patients/delete/<int:id>")
def delete_patient(id):
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("DELETE FROM patient WHERE patient_id = %s", (id,))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for("patients"))
    except errors.ForeignKeyViolation:
        return redirect(url_for("patients", error="Cannot delete patient assigned to a ride."))
    except Exception:
        return redirect(url_for("patients", error="Unexpected error during deletion."))
@app.route("/patients/edit/<int:id>", methods=["GET", "POST"])
def edit_patient(id):
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        if request.method == "POST":
            name = request.form["patient_name"]
            dob = request.form["date_of_birth"]
            phone = request.form["phone_number"]
            address = request.form["address"]
            disabled = request.form["is_disabled"]
            equipment = request.form["medical_equipment"]

            cur.execute("""
                UPDATE patient
                SET patient_name = %s,
                    date_of_birth = %s,
                    phone_number = %s,
                    address = %s,
                    is_disabled = %s,
                    medical_equipment = %s
                WHERE patient_id = %s
            """, (name, dob, phone, address, disabled, equipment, id))

            conn.commit()
            cur.close()
            conn.close()
            return redirect(url_for("patients"))

        # GET
        cur.execute("""
            SELECT patient_id, patient_name, date_of_birth, phone_number, address, is_disabled, medical_equipment
            FROM patient WHERE patient_id = %s
        """, (id,))
        p = cur.fetchone()
        cur.close()
        conn.close()
        return render_template("edit_patient.html", p=p)

    except Exception:
        return redirect(url_for("patients", error="Failed to edit patient."))

@app.route("/rides")
def rides():
    conn = get_db_connection()
    cur = conn.cursor()

    # Fetch rides with related names
    cur.execute("""
        SELECT r.ride_id, r.ride_date, r.pickup_time,
               p.patient_name,
               d.name AS driver_name,
               a.name AS assistant_name,
               r.destination_name, r.destination_address
        FROM ride r
        JOIN patient p ON r.patient_id = p.patient_id
        JOIN volunteer d ON r.driver_id = d.volunteer_id
        LEFT JOIN volunteer a ON r.assistant_id = a.volunteer_id
        ORDER BY r.ride_id;
    """)
    rides = cur.fetchall()

    # Fetch options for selects
    cur.execute("SELECT patient_id, patient_name FROM patient")
    patients = cur.fetchall()
    cur.execute("SELECT vehicle_id, license_plate, type FROM vehicle")
    vehicles = cur.fetchall()
    cur.execute("SELECT v.volunteer_id, v.name FROM driver d JOIN volunteer v ON d.volunteer_id = v.volunteer_id")
    drivers = cur.fetchall()
    cur.execute("SELECT v.volunteer_id, v.name FROM transport_assistant t JOIN volunteer v ON t.volunteer_id = v.volunteer_id")
    assistants = cur.fetchall()
    cur.execute("SELECT mc_name, mc_address FROM medical_center")
    destinations = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("rides.html", rides=rides, patients=patients, vehicles=vehicles,
                           drivers=drivers, assistants=assistants, destinations=destinations, error=request.args.get("error"))

@app.route("/rides/add", methods=["POST"])
def add_ride():
    ride_date = request.form["ride_date"]
    pickup_time = request.form["pickup_time"]
    patient_id = request.form["patient_id"]
    vehicle_id = request.form["vehicle_id"]
    driver_id = request.form["driver_id"]
    assistant_id = request.form.get("assistant_id") or None
    dest = request.form["destination"]
    destination_name, destination_address = dest.split("|", 1)

    conn = get_db_connection()
    cur = conn.cursor()

    try:
        cur.execute("""
            INSERT INTO ride (ride_id, ride_date, pickup_time, patient_id, vehicle_id, driver_id, assistant_id, destination_name, destination_address)
            VALUES ((SELECT COALESCE(MAX(ride_id), 0)+1 FROM ride), %s, %s, %s, %s, %s, %s, %s, %s)
        """, (ride_date, pickup_time, patient_id, vehicle_id, driver_id, assistant_id, destination_name, destination_address))

        conn.commit()
    except Exception as e:
        conn.rollback()
        conn.close()
        return redirect(url_for("rides", error="Failed to add ride: " + str(e)))

    cur.close()
    conn.close()
    return redirect(url_for("rides"))


@app.route("/rides/delete/<int:id>")
def delete_ride(id):
    conn = get_db_connection()
    cur = conn.cursor()

    try:
        cur.execute("DELETE FROM ride WHERE ride_id = %s", (id,))
        conn.commit()
    except errors.ForeignKeyViolation:
        conn.rollback()
        cur.close()
        conn.close()
        return redirect(url_for("rides", error="Cannot delete ride due to foreign key constraints."))
    except Exception as e:
        conn.rollback()
        cur.close()
        conn.close()
        return redirect(url_for("rides", error="Failed to delete ride: " + str(e)))

    cur.close()
    conn.close()
    return redirect(url_for("rides"))

@app.route("/rides/edit/<int:id>", methods=["POST"])
def edit_ride(id):
    ride_date = request.form["ride_date"]
    pickup_time = request.form["pickup_time"]

    conn = get_db_connection()
    cur = conn.cursor()

    try:
        cur.execute("""
            UPDATE ride
            SET ride_date = %s,
                pickup_time = %s
            WHERE ride_id = %s
        """, (ride_date, pickup_time, id))
        conn.commit()
    except Exception as e:
        conn.rollback()
        conn.close()
        return redirect(url_for("rides", error="Failed to update ride: " + str(e)))

    cur.close()
    conn.close()
    return redirect(url_for("rides"))

@app.route('/assign_assistants', methods=['POST'])
def assign_assistants():
    conn = get_db_connection()
    cur = conn.cursor()
    try:
        cur.execute("CALL reassign_ride_assistants()")
        conn.commit()
        msg = "Assistants reassigned successfully"
    except Exception as e:
        conn.rollback()
        msg = "Error assigning assistants: " + str(e)
    finally:
        cur.close()
        conn.close()
    return redirect(url_for('rides', msg=msg))






@app.route("/borrowed_equipment")
def borrowed_equipment():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT b.borrow_id, b.borrowed_at, b.returned,
               p.patient_name, pr.name,
               b.sc_name, b.sc_address
        FROM borrow b
        JOIN patient p ON b.patientid = p.patient_id
        JOIN product pr ON b.productid = pr.id
        ORDER BY b.borrow_id;
    """)
    borrowed = cur.fetchall()

    cur.execute("SELECT patient_id, patient_name FROM patient")
    patients = cur.fetchall()
    cur.execute("SELECT id, name FROM product")
    products = cur.fetchall()
    cur.execute("SELECT mc_name, mc_address FROM medical_center")
    service_centers = cur.fetchall()

    cur.close()
    conn.close()

    return render_template("borrowed_equipment.html", borrowed=borrowed, patients=patients, products=products, service_centers=service_centers, error=request.args.get("error"))

@app.route("/borrowed_equipment/add", methods=["POST"])
def add_borrowed_equipment():
    try:
        borrowed_at = request.form["borrowed_at"]
        patientid = request.form["patientid"]
        productid = request.form["productid"]
        sc_combined = request.form["service_center"]
        sc_name, sc_address = sc_combined.split("|")

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("""
            INSERT INTO borrow (borrowed_at, returned, patientid, sc_name, sc_address, productid)
            VALUES (%s, 'N', %s, %s, %s, %s);
        """, (borrowed_at, patientid, sc_name, sc_address, productid))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for("borrowed_equipment"))
    except Exception as e:
        return redirect(url_for("borrowed_equipment", error="Failed to add record: " + str(e)))

@app.route("/borrowed_equipment/edit/<int:id>", methods=["POST"])
def edit_borrowed_equipment(id):
    try:
        returned = request.form["returned"]
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("UPDATE borrow SET returned = %s WHERE borrow_id = %s", (returned, id))
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for("borrowed_equipment"))
    except Exception as e:
        return redirect(url_for("borrowed_equipment", error="Update failed: " + str(e)))

@app.route("/borrowed_equipment/delete/<int:id>")
def delete_borrowed_equipment(id):
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        # Check if returned = 'Y' before deleting
        cur.execute("SELECT returned FROM borrow WHERE borrow_id = %s", (id,))
        result = cur.fetchone()
        if result and result[0] == 'Y':
            cur.execute("DELETE FROM borrow WHERE borrow_id = %s", (id,))
            conn.commit()
        else:
            raise Exception("Only returned items can be deleted.")
        cur.close()
        conn.close()
        return redirect(url_for("borrowed_equipment"))
    except Exception as e:
        return redirect(url_for("borrowed_equipment", error="Delete failed: " + str(e)))

@app.route("/expired_borrowed_equipment")
def expired_borrowed_equipment():
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        # Step 1: call the function
        cur.callproc("get_unreturned_expired_warranty")
        ref_name = cur.fetchone()[0]

        # Step 2: fetch raw results
        cur.execute(f'FETCH ALL FROM "{ref_name}";')
        raw_rows = cur.fetchall()

        # Step 3: close the cursor safely
        cur.execute(sql.SQL("CLOSE {};").format(sql.Identifier(ref_name)))

        # Step 4: get all relevant patient IDs
        patient_ids = list({row[1] for row in raw_rows})  # row[1] = patientid
        if not patient_ids:
            return render_template("expired_borrowed_equipment.html", records=[])

        # Step 5: fetch patient info
        format_strings = ','.join(['%s'] * len(patient_ids))
        cur.execute(
            f"SELECT patient_id, patient_name, phone_number FROM patient WHERE patient_id IN ({format_strings})",
            patient_ids
        )
        patient_map = {row[0]: (row[1], row[2]) for row in cur.fetchall()}

        # Step 6: enrich the rows with patient name and phone
        enriched_rows = []
        for row in raw_rows:
            borrow_id = row[0]
            patient_id = row[1]
            product_name = row[3] if len(row) > 3 else "Unknown"
            warranty_exp = row[4] if len(row) > 4 else None

            patient_name, phone_number = patient_map.get(patient_id, ("Unknown", "N/A"))

            enriched_rows.append((patient_name, phone_number, product_name, warranty_exp))

        cur.close()
        conn.close()

        return render_template("expired_borrowed_equipment.html", records=enriched_rows)

    except Exception as e:
        return render_template("expired_borrowed_equipment.html", records=[], error=str(e))




if __name__ == "__main__":
    app.run(debug=True)
