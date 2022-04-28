create or replace view ai_drum as
select 
    a.id,
    a.tname,
    a.cabletype_id,
    b.ctype || ' - ' || b.dim cabletype,
    a.drum_recived,
    a.length_recived,
    a.length_lost,
    a.use_metermarking,
    a.comment_foreman,
    a.comment_storage,
    a.location,
    a.location_comment,
    a.created,
    a.created_by,
    a.modified,
    a.modified_by
FROM
    T_drum a
    left join t_cabletype b on b.id = a.cabletype_id;


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

            TNAME,
            CABLETYPE_ID,
            DRUM_RECIVED,
            LENGTH_RECIVED,
            LENGTH_LOST,
            USE_METERMARKING,
            COMMENT_FOREMAN,
            COMMENT_STORAGE,
            LOCATION,
            LOCATION_COMMENT

        ) VALUES (

            :NEW.TNAME,
            :NEW.CABLETYPE_ID,
            :NEW.DRUM_RECIVED,
            :NEW.LENGTH_RECIVED,
            :NEW.LENGTH_LOST,
            :NEW.USE_METERMARKING,
            :NEW.COMMENT_FOREMAN,
            :NEW.COMMENT_STORAGE,
            :NEW.LOCATION,
            :NEW.LOCATION_COMMENT
      
        );

    END IF;

    -- UPDATING
    IF UPDATING THEN
        UPDATE T_DRUM
        SET
            TNAME = :NEW.TNAME,
            CABLETYPE_ID = :NEW.CABLETYPE_ID,
            DRUM_RECIVED = :NEW.DRUM_RECIVED,
            LENGTH_RECIVED = :NEW.LENGTH_RECIVED,
            LENGTH_LOST = :NEW.LENGTH_LOST,
            USE_METERMARKING = :NEW.USE_METERMARKING,
            COMMENT_FOREMAN = :NEW.COMMENT_FOREMAN,
            COMMENT_STORAGE = :NEW.COMMENT_STORAGE,
            LOCATION = :NEW.LOCATION,
            LOCATION_COMMENT = :NEW.LOCATION_COMMENT

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