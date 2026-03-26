CREATE TABLE pet_care_log (
    product_id NUMBER,
    log_datetime  TIMESTAMP DEFAULT SYSTIMESTAMP,
    created_by_user VARCHAR2(30),
    log_text VARCHAR2(500),
    last_update_datetime DATE
)

ALTER TABLE pet_care_log ADD updated_by_user VARCHAR2(30)

CREATE OR REPLACE TRIGGER trg_pet_care_log_set_datetime_user
BEFORE INSERT ON pet_care_log
FOR EACH ROW
BEGIN
    :NEW.last_update_datetime := SYSTIMESTAMP;
    :NEW.created_by_user := USER;
END;

CREATE OR REPLACE TRIGGER trg_pet_care_log_check_user
BEFORE UPDATE ON pet_care_log
FOR EACH ROW
BEGIN
    IF :NEW.updated_by_user != USER THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'You can only updated log created by your user'
        );
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_pet_care_log_delete_user
BEFORE DELETE ON pet_care_log
FOR EACH ROW
BEGIN
    IF :NEW.updated_by_user != 'JOEMANAGER' THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'You need authorization to delete a row'
        );
    END IF;
END;