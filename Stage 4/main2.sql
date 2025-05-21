DO $$
DECLARE
    ref refcursor;
    row RECORD;
BEGIN
    -- Step 0: Update CHECK constraint on returned field to allow 'L'
    RAISE NOTICE '--- Step 0: Updating CHECK constraint ---';

    BEGIN
        ALTER TABLE borrow DROP CONSTRAINT borrow_returned_check;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Constraint not found or already removed.';
    END;

    ALTER TABLE borrow ADD CONSTRAINT borrow_returned_check CHECK (returned IN ('Y', 'N', 'L'));
    RAISE NOTICE 'CHECK constraint updated to accept Y, N, and L.';

    -- Step 1: Run function to fetch borrows with expired product warranty
    RAISE NOTICE '--- Step 1: Fetching expired warranty borrows ---';

    ref := get_unreturned_expired_warranty();

    LOOP
        FETCH ref INTO row;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'EXPIRED WARRANTY → Borrow ID: %, Product: %, Patient ID: %', 
            row.borrow_id, row.name, row.patientid;
    END LOOP;
    CLOSE ref;

    -- Step 2: Call procedure to mark long-overdue borrows as "L"
    RAISE NOTICE '--- Step 2: Running overdue borrow processor ---';

    CALL auto_return_long_overdue_borrows();

    -- Done
    RAISE NOTICE '✔ All maintenance steps completed.';
END $$;
