
CREATE VIEW AI_DRUM AS SELECT * FROM T_DRUM;


--
/
--



CREATE OR REPLACE TRIGGER TRG_AI_DRUMS INSTEAD OF
    INSERT OR UPDATE OR DELETE ON AI_DRUM
    FOR EACH ROW
BEGIN
-- INSERTING
    IF INSERTING THEN
        INSERT INTO T_DRUM (
            ID,
            TNAME,
            CABLETYPE_ID,
            DRUM_RECIVED,
            LENGTH_RECIVED,
            LENGTH_LOST,
            USE_METERMARKING,
            COMMENT_FOREMAN,
            COMMENT_STORAGE,
            LOCATION,
            LOCATION_COMMENT,
            CREATED,
            CREATED_BY,
            MODIFIED,
            MODIFIED_BY
        ) VALUES (
            :NEW.ID,
            :NEW.TNAME,
            :NEW.CABLETYPE_ID,
            :NEW.DRUM_RECIVED,
            :NEW.LENGTH_RECIVED,
            :NEW.LENGTH_LOST,
            :NEW.USE_METERMARKING,
            :NEW.COMMENT_FOREMAN,
            :NEW.COMMENT_STORAGE,
            :NEW.LOCATION,
            :NEW.LOCATION_COMMENT,
            :NEW.CREATED,
            :NEW.CREATED_BY,
            :NEW.MODIFIED,
            :NEW.MODIFIED_BY
        );

    END IF;

    -- UPDATING
    IF UPDATING THEN
        UPDATE T_DRUM
        SET
            ID = :NEW.ID,
            TNAME = :NEW.TNAME,
            CABLETYPE_ID = :NEW.CABLETYPE_ID,
            DRUM_RECIVED = :NEW.DRUM_RECIVED,
            LENGTH_RECIVED = :NEW.LENGTH_RECIVED,
            LENGTH_LOST = :NEW.LENGTH_LOST,
            USE_METERMARKING = :NEW.USE_METERMARKING,
            COMMENT_FOREMAN = :NEW.COMMENT_FOREMAN,
            COMMENT_STORAGE = :NEW.COMMENT_STORAGE,
            LOCATION = :NEW.LOCATION,
            LOCATION_COMMENT = :NEW.LOCATION_COMMENT,
            CREATED = :NEW.CREATED,
            CREATED_BY = :NEW.CREATED_BY,
            MODIFIED = :NEW.MODIFIED,
            MODIFIED_BY = :NEW.MODIFIED_BY
        WHERE
            ID = :OLD.ID;

    END IF;
    
    -- DELETING
    IF DELETING THEN
        DELETE FROM T_DRUM
        WHERE
            ID = :OLD.ID;

    END IF;
END;