DO $$
DECLARE
    driver_id INT;
    ref refcursor;
    row RECORD;
BEGIN
    -- Step 1: Choose one random driver
    SELECT volunteer_id INTO driver_id
    FROM driver
    ORDER BY RANDOM()
    LIMIT 1;

    RAISE NOTICE '--- Selected driver: % ---', driver_id;

    -- Step 2: Get idle days for that driver
    ref := get_driver_idle_days(driver_id);

    LOOP
        FETCH ref INTO row;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Driver % is idle on %', driver_id, row.idle_date;
    END LOOP;
    CLOSE ref;

    -- Step 3: Reassign assistants
    RAISE NOTICE '--- Reassigning assistants to unfilled rides ---';
    CALL reassign_ride_assistants();

    RAISE NOTICE '✔ Single-driver idle check and assistant reassignment complete.';
END $$;

