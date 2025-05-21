-- ================================================
-- Description: Assign assistants to future rides without one,
--              using available transport assistants
-- ================================================

CREATE OR REPLACE PROCEDURE reassign_ride_assistants()
LANGUAGE plpgsql
AS $$
DECLARE
    -- Cursor: Select future rides without an assistant
    ride_cur CURSOR FOR
        SELECT * FROM ride
        WHERE assistant_id IS NULL
          AND ride_date >= CURRENT_DATE;

    r ride%ROWTYPE;  -- record for ride row
    new_assistant_id INT;
BEGIN
    OPEN ride_cur;
    LOOP
        FETCH ride_cur INTO r;
        EXIT WHEN NOT FOUND;

        BEGIN
            -- Try to find transport assistant who is available that day and not the driver
            SELECT ta.volunteer_id INTO new_assistant_id
            FROM transport_assistant ta
            JOIN volunteer v ON ta.volunteer_id = v.volunteer_id
            WHERE NOT EXISTS (
                SELECT 1 FROM ride
                WHERE assistant_id = ta.volunteer_id
                  AND ride_date = r.ride_date
            )
              AND ta.volunteer_id <> r.driver_id
            LIMIT 1;

            IF new_assistant_id IS NOT NULL THEN
                -- Assign the assistant to the ride
                UPDATE ride
                SET assistant_id = new_assistant_id
                WHERE ride_id = r.ride_id;

                RAISE NOTICE 'Assistant % assigned to ride % on %', new_assistant_id, r.ride_id, r.ride_date;
            ELSE
                RAISE NOTICE 'No available transport assistant found for ride % on %', r.ride_id, r.ride_date;
            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE NOTICE 'Error assigning assistant to ride %: %', r.ride_id, SQLERRM;
        END;
    END LOOP;

    CLOSE ride_cur;
END;
$$;

-- ================================================
-- Test block (optional): run the procedure
-- ================================================
-- DO $$
-- BEGIN
--     CALL reassign_ride_assistants();
-- END;
-- $$;
