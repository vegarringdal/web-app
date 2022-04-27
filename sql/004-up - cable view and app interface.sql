CREATE VIEW V_CABLE AS SELECT * FROM T_CABLETYPE;

--
/
--

CREATE OR REPLACE TRIGGER trg_ai_cable INSTEAD OF
    INSERT OR UPDATE OR DELETE ON v_cable
    FOR EACH ROW
BEGIN
-- INSERTING
    IF inserting THEN
        INSERT INTO t_cabletype (
            id,
            ctype,
            dim,
            created,
            created_by,
            modified,
            modified_by
        ) VALUES (
            :new.id,
            :new.ctype,
            :new.dim,
            :new.created,
            :new.created_by,
            :new.modified,
            :new.modified_by
        );

    END IF;

    -- UPDATING
    IF updating THEN
        UPDATE t_cabletype
        SET
            id = :new.id,
            ctype = :new.ctype,
            dim = :new.dim,
            created = :new.created,
            created_by = :new.created_by,
            modified = :new.modified,
            modified_by = :new.modified_by
        WHERE
            id = :old.id;

    END IF;
    
    -- DELETING
    IF deleting THEN
        DELETE FROM t_cabletype
        WHERE
            id = :old.id;

    END IF;
END;