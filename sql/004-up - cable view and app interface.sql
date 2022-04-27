CREATE VIEW AI_CABLE AS SELECT * FROM T_CABLETYPE;

--
/
--

CREATE OR REPLACE TRIGGER TRG_AI_CABLE INSTEAD OF
    INSERT OR UPDATE OR DELETE ON AI_CABLE
    FOR EACH ROW
BEGIN
-- INSERTING
    IF INSERTING THEN
        INSERT INTO T_CABLETYPE (
            ID,
            CTYPE,
            DIM,
            CREATED,
            CREATED_BY,
            MODIFIED,
            MODIFIED_BY
        ) VALUES (
            :NEW.ID,
            :NEW.CTYPE,
            :NEW.DIM,
            :NEW.CREATED,
            :NEW.CREATED_BY,
            :NEW.MODIFIED,
            :NEW.MODIFIED_BY
        );

    END IF;

    -- UPDATING
    IF UPDATING THEN
        UPDATE T_CABLETYPE
        SET
            ID = :NEW.ID,
            CTYPE = :NEW.CTYPE,
            DIM = :NEW.DIM,
            CREATED = :NEW.CREATED,
            CREATED_BY = :NEW.CREATED_BY,
            MODIFIED = :NEW.MODIFIED,
            MODIFIED_BY = :NEW.MODIFIED_BY
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