CREATE TABLE T_WEB_USER (
    ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    FIRSTNAME VARCHAR2(100) NOT NULL,
    LASTNAME VARCHAR2(100) NOT NULL,
    USERNAME VARCHAR2(100) NOT NULL,
    CREATED DATE DEFAULT SYSDATE,
    CREATED_BY VARCHAR2(100),
    MODIFIED DATE DEFAULT SYSDATE,
    MODIFIED_BY VARCHAR2(100)
);

CREATE OR REPLACE TRIGGER TR_WEB_USER_AUDIT BEFORE
    INSERT OR UPDATE ON T_WEB_USER
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.CREATED_BY := F_GET_CURRENT_USER();
        :NEW.MODIFIED_BY := F_GET_CURRENT_USER();
    END IF;

    IF UPDATING THEN
        :NEW.MODIFIED_BY := F_GET_CURRENT_USER();
        :NEW.MODIFIED := SYSDATE;
    END IF;
END;