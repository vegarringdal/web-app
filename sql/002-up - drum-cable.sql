CREATE TABLE T_CABLETYPE (
    ID          NUMBER
        GENERATED ALWAYS AS IDENTITY,
    CTYPE       VARCHAR(50) NOT NULL,
    DIM         VARCHAR(50) NOT NULL,
    CREATED     DATE DEFAULT SYSDATE,
    CREATED_BY  VARCHAR(100),
    MODIFIED    DATE DEFAULT SYSDATE,
    MODIFIED_BY VARCHAR(100)
);
--
/
--
CREATE TRIGGER TR_CABLETYPE_AUDIT BEFORE
    INSERT OR UPDATE ON T_CABLETYPE
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
--
/
--
CREATE TABLE T_DRUM (
    ID               NUMBER
        GENERATED ALWAYS AS IDENTITY,
    TNAME            VARCHAR(50) NOT NULL,
    CABLETYPE_ID     NUMBER NOT NULL,
    DRUM_RECIVED     DATE,
    LENGTH_RECIVED   NUMBER,
    LENGTH_LOST      NUMBER,
    USE_METERMARKING CHAR(1) DEFAULT '1',
    COMMENT_FOREMAN  VARCHAR(4000),
    COMMENT_STORAGE  VARCHAR(4000),
    LOCATION         VARCHAR(100),
    LOCATION_COMMENT VARCHAR(500),
    CREATED          DATE DEFAULT SYSDATE,
    CREATED_BY       VARCHAR(100),
    MODIFIED         DATE DEFAULT SYSDATE,
    MODIFIED_BY      VARCHAR(100)
);
--
/
--
CREATE TRIGGER TR_DRUM_AUDIT BEFORE
    INSERT OR UPDATE ON t_DRUM
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

CREATE TRIGGER tr_web_user_audit BEFORE
    INSERT OR UPDATE ON t_web_user
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

--
/
--

BEGIN
    FOR C IN 1..10000 LOOP
        INSERT INTO T_CABLETYPE (
            CTYPE,
            DIM
        ) VALUES (
            'TYPE_' || C,
            '2X2X1.5'
        );

    END LOOP;
END;

--
/
--

BEGIN
    FOR C IN 1..10000 LOOP
        INSERT INTO T_DRUM (
            TNAME,
            LENGTH_RECIVED
        ) VALUES (
            'T-' || TO_CHAR(1000 + C),
            C,
            500
        );

    END LOOP;
END;
--
/
--

--SET SERVEROUTPUT ON;

--BEGIN
--    FOR V_COUNTER IN 1..100
--    LOOP
--        DBMS_OUTPUT.PUT_LINE(  );
--    END LOOP;
--END;