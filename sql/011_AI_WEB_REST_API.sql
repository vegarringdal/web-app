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
declare
   v_apiname varchar2(100);

BEGIN 
    
    if(:NEW.DATA is not null) then
        v_apiname := JSON_VALUE(:NEW.DATA, '$.apiName');
    end if;


    -- INSERTING
    IF INSERTING THEN
        INSERT INTO T_WEB_REST_API (
            NAME,
            DATA,
            ENABLED
        ) VALUES (
             v_apiname,
            :NEW.DATA,
            :NEW.ENABLED
        );

    END IF;

    -- UPDATING
    IF UPDATING THEN
        UPDATE T_WEB_REST_API
        SET
            NAME = v_apiname,
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