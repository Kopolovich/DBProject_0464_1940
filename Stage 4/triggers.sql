-- ===============================================
-- === Part 1: Volunteer Role Restrictions Triggers
-- ===============================================

-- Trigger Function: Block volunteers with other roles from being added to driver
CREATE OR REPLACE FUNCTION trg_block_multi_roles_driver()
RETURNS trigger AS $$
BEGIN
    -- Check if the same volunteer already exists as transport or service assistant
    IF EXISTS (
        SELECT 1 FROM transport_assistant WHERE volunteer_id = NEW.volunteer_id
    ) OR EXISTS (
        SELECT 1 FROM service_assistant WHERE volunteer_id = NEW.volunteer_id
    ) THEN
        RAISE EXCEPTION 'Volunteer % is already assigned to another role', NEW.volunteer_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: Enforces the above rule before inserting into driver
CREATE TRIGGER trg_driver_role_check
BEFORE INSERT ON driver
FOR EACH ROW
EXECUTE FUNCTION trg_block_multi_roles_driver();


-- Trigger Function: Block volunteers with other roles from being added to transport_assistant
CREATE OR REPLACE FUNCTION trg_block_multi_roles_transport()
RETURNS trigger AS $$
BEGIN
    -- Check if the same volunteer already exists as driver or service assistant
    IF EXISTS (
        SELECT 1 FROM driver WHERE volunteer_id = NEW.volunteer_id
    ) OR EXISTS (
        SELECT 1 FROM service_assistant WHERE volunteer_id = NEW.volunteer_id
    ) THEN
        RAISE EXCEPTION 'Volunteer % is already assigned to another role', NEW.volunteer_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: Enforces the above rule before inserting into transport_assistant
CREATE TRIGGER trg_transport_role_check
BEFORE INSERT ON transport_assistant
FOR EACH ROW
EXECUTE FUNCTION trg_block_multi_roles_transport();


-- Trigger Function: Block volunteers with other roles from being added to service_assistant
CREATE OR REPLACE FUNCTION trg_block_multi_roles_service()
RETURNS trigger AS $$
BEGIN
    -- Check if the same volunteer already exists as driver or transport assistant
    IF EXISTS (
        SELECT 1 FROM driver WHERE volunteer_id = NEW.volunteer_id
    ) OR EXISTS (
        SELECT 1 FROM transport_assistant WHERE volunteer_id = NEW.volunteer_id
    ) THEN
        RAISE EXCEPTION 'Volunteer % is already assigned to another role', NEW.volunteer_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: Enforces the above rule before inserting into service_assistant
CREATE TRIGGER trg_service_role_check
BEFORE INSERT ON service_assistant
FOR EACH ROW
EXECUTE FUNCTION trg_block_multi_roles_service();



-- ===============================================
-- === Part 2: Borrow Record Date Correction Trigger
-- ===============================================

-- Trigger Function: Fix borrow date if it's in the future
CREATE OR REPLACE FUNCTION trg_fix_future_borrow_date()
RETURNS trigger AS $$
BEGIN
    -- If the borrowed_at date is later than today, correct it to today's date
    IF NEW.borrowed_at > CURRENT_DATE THEN
        NEW.borrowed_at := CURRENT_DATE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: Enforces the above correction before insert or update on borrow
CREATE TRIGGER trg_fix_borrow_date
BEFORE INSERT OR UPDATE ON borrow
FOR EACH ROW
EXECUTE FUNCTION trg_fix_future_borrow_date();





INSERT INTO borrow (
    borrowed_at, returned, patientid, sc_name, sc_address, productid
) VALUES (
    '2025-10-10',  
    'N',
    200000170,
    'Service Center 277',
    'Jerusalem, Jaffa 50',
    371
);

SELECT borrow_id, borrowed_at
FROM borrow
WHERE patientid = 200000170 AND productid = 371
ORDER BY borrow_id DESC
LIMIT 1;
