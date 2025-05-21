-- ================================================
-- Description: Mark all borrows older than 6 months
--              and not returned as 'L' (Late/Lost).
--              Print a warning for each one and check
--              if the patient has other unreturned items.
-- ================================================

CREATE OR REPLACE PROCEDURE auto_return_long_overdue_borrows()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    other_count INT;
    updated_count INT := 0;
BEGIN
    -- Cursor: Select old unreturned borrows
    FOR rec IN
        SELECT borrow_id, patientid, productid, borrowed_at
        FROM borrow
        WHERE returned IS DISTINCT FROM 'Y'
          AND borrowed_at < CURRENT_DATE - INTERVAL '6 months'
    LOOP
        -- Step 1: Update borrow as late
        UPDATE borrow
        SET returned = 'L'
        WHERE borrow_id = rec.borrow_id;

        updated_count := updated_count + 1;

        -- Step 2: Check if patient has more unreturned borrows
        SELECT COUNT(*) INTO other_count
        FROM borrow
        WHERE patientid = rec.patientid
          AND returned IS DISTINCT FROM 'Y'
          AND borrow_id <> rec.borrow_id;

        -- Step 3: Raise a warning with details
        RAISE NOTICE 'Borrow ID % marked as LATE (borrowed on %)', rec.borrow_id, rec.borrowed_at;
        
        IF other_count > 0 THEN
            RAISE NOTICE 'Patient ID % has % other unreturned items.', rec.patientid, other_count;
        END IF;
    END LOOP;

    RAISE NOTICE ' % borrow records updated to LATE.', updated_count;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE ' Error during overdue borrow processing: %', SQLERRM;
END;
$$;
