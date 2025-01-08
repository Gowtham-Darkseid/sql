CREATE OR REPLACE TRIGGER trg_employee_restriction
BEFORE INSERT OR DELETE OR UPDATE ON employee
FOR EACH ROW
DECLARE
    current_day VARCHAR2(9);
    current_hour NUMBER;
BEGIN
    current_day := TO_CHAR(SYSDATE, 'D');
    current_hour := TO_CHAR(SYSDATE, 'HH24');
    IF current_day IN ('1', '7') OR current_hour < 8 OR current_hour > 20 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cannot perform operation outside working hours (8 AM - 8 PM) or on weekends (Saturday/Sunday).');
    END IF;
END;
/
