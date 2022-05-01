CREATE TABLE T_WEB_GRID_CONFIG (
    ID NUMBER GENERATED ALWAYS AS IDENTITY,
    USER_ID NUMBER,
    NAME VARCHAR(100) UNIQUE NOT NULL,
    DATA CLOB,
    CREATED DATE DEFAULT SYSDATE,
    CREATED_BY VARCHAR2(100),
    MODIFIED DATE DEFAULT SYSDATE,
    MODIFIED_BY VARCHAR2(100),
    CONSTRAINT WEB_GRID_CONFIG_VALID_JSON_CHECK CHECK (DATA IS JSON (STRICT)) ENABLE
);

CREATE OR REPLACE TRIGGER tr_web_grid_config_audit BEFORE
    INSERT OR UPDATE ON t_web_grid_config
    FOR EACH ROW
BEGIN
    IF inserting THEN
        :new.created_by := f_get_current_user();
        :new.modified_by := f_get_current_user();
    END IF;

    IF updating THEN
        :new.modified_by := f_get_current_user();
        :new.modified := sysdate;
    END IF;

END;