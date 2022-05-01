CREATE TABLE T_WEB_USER_ROLE (
    ID NUMBER GENERATED ALWAYS AS IDENTITY,
    WEB_ROLE_ID NUMBER NOT NULL,
    WEB_USER_ID NUMBER NOT NULL,
    CREATED DATE DEFAULT SYSDATE,
    CREATED_BY VARCHAR2(100),
    MODIFIED DATE DEFAULT SYSDATE,
    MODIFIED_BY VARCHAR2(100),
    FOREIGN KEY (WEB_ROLE_ID) REFERENCES T_WEB_ROLE(ID),
    FOREIGN KEY (WEB_USER_ID) REFERENCES t_WEB_USER(ID)
);

CREATE OR REPLACE TRIGGER tr_web_user_role_audit BEFORE
    INSERT OR UPDATE ON t_web_user_role
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