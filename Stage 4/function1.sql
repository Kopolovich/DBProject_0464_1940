-- ================================================
-- Description: Return a refcursor with the upcoming
--              14 days in which the given driver
--              has no scheduled rides.
--              Used to check driver availability.
-- ================================================
CREATE OR REPLACE FUNCTION get_driver_idle_days(driver_id INT)
RETURNS refcursor
LANGUAGE plpgsql
AS $$
DECLARE
    ref refcursor := 'idlecursor';
    d DATE;
    i INT;
BEGIN
    -- Create temporary table to collect idle days
    CREATE TEMP TABLE IF NOT EXISTS temp_driver_idle_dates (
        driver_id INT,
        idle_date DATE
    ) ON COMMIT PRESERVE ROWS;

    -- Clean previous results
    DELETE FROM temp_driver_idle_dates
    WHERE temp_driver_idle_dates.driver_id = get_driver_idle_days.driver_id;

    -- Loop over next 14 days and collect idle ones
    FOR i IN 0..13 LOOP
        d := CURRENT_DATE + i;

        IF NOT EXISTS (
            SELECT 1 FROM ride
            WHERE ride.driver_id = get_driver_idle_days.driver_id
              AND ride_date = d
        ) THEN
            INSERT INTO temp_driver_idle_dates VALUES (get_driver_idle_days.driver_id, d);
        END IF;
    END LOOP;

    -- Return the result set
    OPEN ref FOR
        SELECT idle_date
        FROM temp_driver_idle_dates
        WHERE temp_driver_idle_dates.driver_id = get_driver_idle_days.driver_id
        ORDER BY idle_date;

    RETURN ref;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error in get_driver_idle_days: %', SQLERRM;
        RETURN NULL;
END;
$$;
