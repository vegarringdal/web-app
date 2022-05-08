CREATE OR REPLACE VIEW AI_WEB_REST_API AS
    SELECT
        A.ID,
        A.NAME,
        A.DATA,
        A.ENABLED,
        A.CREATED,
        A.CREATED_BY,
        A.MODIFIED,
        A.MODIFIED_BY
    FROM
        T_WEB_REST_API A;

CREATE OR REPLACE TRIGGER TR_AI_WEB_REST_API INSTEAD OF
    INSERT OR UPDATE OR DELETE ON AI_WEB_REST_API
    FOR EACH ROW
DECLARE
   V_APINAME VARCHAR2(100);

BEGIN 
    
    IF(:NEW.DATA IS NOT NULL) THEN
        V_APINAME := JSON_VALUE(:NEW.DATA, '$.APINAME');
    END IF;


    -- INSERTING
    IF INSERTING THEN
        INSERT INTO T_WEB_REST_API (
            NAME,
            DATA,
            ENABLED
        ) VALUES (
             V_APINAME,
            :NEW.DATA,
            :NEW.ENABLED
        );

    END IF;

    -- UPDATING
    IF UPDATING THEN
        UPDATE T_WEB_REST_API
        SET
            NAME = V_APINAME,
            DATA = :NEW.DATA,
            ENABLED = :NEW.ENABLED
        WHERE
            ID = :OLD.ID;

    END IF;

    -- DELETING
    IF DELETING THEN
        DELETE FROM T_WEB_REST_API
        WHERE
            ID = :OLD.ID;

    END IF;
END;