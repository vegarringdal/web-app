CREATE OR REPLACE VIEW AI_CABLE AS
    SELECT
        ID,
        CTYPE,
        DIM,
        CTYPE || ' - ' || DIM CABLETYPE,
        CREATED,
        CREATED_BY,
        MODIFIED,
        MODIFIED_BY
    FROM
        T_CABLETYPE;



CREATE OR REPLACE TRIGGER TRG_AI_CABLE INSTEAD OF
    INSERT OR UPDATE OR DELETE ON AI_CABLE
    FOR EACH ROW
BEGIN
    -- INSERTING
    IF INSERTING THEN
        INSERT INTO T_CABLETYPE (

            CTYPE,
            DIM
    
        ) VALUES (

            :NEW.CTYPE,
            :NEW.DIM
        
        );

    END IF;

    -- UPDATING
    IF UPDATING THEN
        UPDATE T_CABLETYPE
        SET
            CTYPE = :NEW.CTYPE,
            DIM = :NEW.DIM
        
        WHERE
            ID = :OLD.ID;

    END IF;
    
    -- DELETING
    IF DELETING THEN
        DELETE FROM T_CABLETYPE
        WHERE
            ID = :OLD.ID;

    END IF;
END;