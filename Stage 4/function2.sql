-- ================================================
-- Description: Return a refcursor with all borrows
--              of products with expired warranty
--              and not marked as returned.
-- ================================================

CREATE OR REPLACE FUNCTION get_unreturned_expired_warranty()
RETURNS refcursor
LANGUAGE plpgsql
AS $$
DECLARE
    ref refcursor := 'mycursor';
BEGIN
    OPEN ref FOR
        SELECT b.borrow_id, b.patientid, p.id AS product_id, p.name, p.warranty_expiration
        FROM borrow b
        JOIN product p ON b.productid = p.id
        WHERE b.returned IS DISTINCT FROM 'Y'
          AND p.warranty_expiration < CURRENT_DATE;

    RETURN ref;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error during function execution: %', SQLERRM;
        RETURN NULL;
END;
$$;


-- ================================================
-- Test block (optional): run the function
-- ================================================
--BEGIN;
--SELECT get_unreturned_expired_warranty();
--FETCH ALL FROM mycursor;
--COMMIT;

