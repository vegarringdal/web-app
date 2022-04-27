--
-- DEFAULT TABLES/FUNCTIONS TO BE ABLE TO USE APP
--
-- T_     = TABLE
-- TR_    = TABLE TRIGGER
-- V_     = VIEW   
-- AI_    = APP INTERFACE (UPDATABLE VIEWS)
-- F_     = FUNCTION
-- P_     = PROCEDURE     
--
/
--
CREATE
OR REPLACE FUNCTION F_GET_CURRENT_USER RETURN VARCHAR IS BEGIN -- IF WEB CLIENT ID WILL HAVE USER
-- IF NOT WEB OR ANYTHING ELSE WE USE OS_USER
RETURN NVL(
    SYS_CONTEXT('USERENV', 'CLIENT_IDENTIFIER'),
    SYS_CONTEXT('USERENV', 'OS_USER')
);

END;

--
/ --
/
--
CREATE TABLE T_WEB_USER (
    ID NUMBER GENERATED ALWAYS AS IDENTITY,
    FIRSTNAME VARCHAR2(100) NOT NULL,
    LASTNAME VARCHAR2(100) NOT NULL,
    USERNAME VARCHAR2(100) NOT NULL,
    CREATED DATE DEFAULT SYSDATE,
    CREATED_BY VARCHAR2(100),
    MODIFIED DATE DEFAULT SYSDATE,
    MODIFIED_BY VARCHAR2(100)
);

CREATE TRIGGER TR_WEB_USER_AUDIT BEFORE
INSERT
    OR
UPDATE
    ON T_WEB_USER FOR EACH ROW BEGIN IF INSERTING THEN :NEW.CREATED_BY := F_GET_CURRENT_USER();

:NEW.MODIFIED_BY := F_GET_CURRENT_USER();

END IF;

IF UPDATING THEN :NEW.MODIFIED_BY := F_GET_CURRENT_USER();

:NEW.MODIFIED := SYSDATE;

END IF;

END;

--
/
--
CREATE TABLE T_WEB_ROLE (
    ID NUMBER GENERATED ALWAYS AS IDENTITY,
    NAME VARCHAR2(100) NOT NULL,
    DESCRIPTION VARCHAR2(100) NOT NULL,
    CREATED DATE DEFAULT SYSDATE,
    CREATED_BY VARCHAR2(100),
    MODIFIED DATE DEFAULT SYSDATE,
    MODIFIED_BY VARCHAR2(100)
);

CREATE TRIGGER TR_WEB_ROLE_AUDIT BEFORE
INSERT
    OR
UPDATE
    ON T_WEB_ROLE FOR EACH ROW BEGIN IF INSERTING THEN :NEW.CREATED_BY := F_GET_CURRENT_USER();

:NEW.MODIFIED_BY := F_GET_CURRENT_USER();

END IF;

IF UPDATING THEN :NEW.MODIFIED_BY := F_GET_CURRENT_USER();

:NEW.MODIFIED := SYSDATE;

END IF;

END;

--
/
--
CREATE TABLE T_WEB_USER_ROLE (
    ID NUMBER GENERATED ALWAYS AS IDENTITY,
    WEB_ROLE_ID NUMBER NOT NULL,
    WEB_USER_ID NUMBER NOT NULL,
    CREATED DATE DEFAULT SYSDATE,
    CREATED_BY VARCHAR2(100),
    MODIFIED DATE DEFAULT SYSDATE,
    MODIFIED_BY VARCHAR2(100)
);

CREATE TRIGGER TR_WEB_USER_ROLE_AUDIT BEFORE
INSERT
    OR
UPDATE
    ON T_WEB_USER_ROLE FOR EACH ROW BEGIN IF INSERTING THEN :NEW.CREATED_BY := F_GET_CURRENT_USER();

:NEW.MODIFIED_BY := F_GET_CURRENT_USER();

END IF;

IF UPDATING THEN :NEW.MODIFIED_BY := F_GET_CURRENT_USER();

:NEW.MODIFIED := SYSDATE;

END IF;

END;

--
/
--
CREATE TABLE T_WEB_REST_API (
    ID NUMBER GENERATED ALWAYS AS IDENTITY,
    NAME VARCHAR(100) UNIQUE NOT NULL,
    DATA CLOB,
    ENABLED CHAR(1) DEFAULT '0',
    CREATED DATE DEFAULT SYSDATE,
    CREATED_BY VARCHAR2(100),
    MODIFIED DATE DEFAULT SYSDATE,
    MODIFIED_BY VARCHAR2(100),
    CONSTRAINT WEB_REST_API_VALID_JSON_CHECK CHECK (DATA IS JSON (STRICT)) ENABLE
);

CREATE TRIGGER TR_WEB_REST_API_AUDIT BEFORE
INSERT
    OR
UPDATE
    ON T_WEB_REST_API FOR EACH ROW BEGIN IF INSERTING THEN :NEW.CREATED_BY := F_GET_CURRENT_USER();

:NEW.MODIFIED_BY := F_GET_CURRENT_USER();

END IF;

IF UPDATING THEN :NEW.MODIFIED_BY := F_GET_CURRENT_USER();

:NEW.MODIFIED := SYSDATE;

END IF;

END;

--
/
--
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

CREATE TRIGGER TR_WEB_GRID_CONFIG_AUDIT BEFORE
INSERT
    OR
UPDATE
    ON T_WEB_GRID_CONFIG FOR EACH ROW BEGIN IF INSERTING THEN :NEW.CREATED_BY := F_GET_CURRENT_USER();

:NEW.MODIFIED_BY := F_GET_CURRENT_USER();

END IF;

IF UPDATING THEN :NEW.MODIFIED_BY := F_GET_CURRENT_USER();

:NEW.MODIFIED := SYSDATE;

END IF;

END;

--
/
--
CREATE VIEW AI_WEB_USER AS
SELECT
    *
FROM
    T_WEB_USER;

CREATE
OR REPLACE TRIGGER TR_AI_WEB_USER INSTEAD OF
INSERT
    OR
UPDATE
    OR DELETE ON AI_WEB_USER FOR EACH ROW BEGIN -- INSERTING
    IF INSERTING THEN
INSERT INTO
    T_WEB_USER (
        FIRSTNAME,
        LASTNAME,
        USERNAME
    )
VALUES
    (
        :NEW.FIRSTNAME,
        :NEW.LASTNAME,
        :NEW.USERNAME
    );

END IF;

-- UPDATING
IF UPDATING THEN
UPDATE
    T_WEB_USER
SET
    FIRSTNAME = :NEW.FIRSTNAME,
    LASTNAME = :NEW.LASTNAME,
    USERNAME = :NEW.USERNAME
WHERE
    ID = :OLD.ID;

END IF;

-- DELETING
IF DELETING THEN
DELETE FROM
    T_WEB_USER
WHERE
    ID = :OLD.ID;

END IF;

END;

--
/
--
CREATE VIEW AI_WEB_ROLE AS
SELECT
    *
FROM
    T_WEB_ROLE;

CREATE
OR REPLACE TRIGGER TR_AI_WEB_ROLE INSTEAD OF
INSERT
    OR
UPDATE
    OR DELETE ON AI_WEB_ROLE FOR EACH ROW BEGIN -- INSERTING
    IF INSERTING THEN
INSERT INTO
    T_WEB_ROLE (
        NAME,
        DESCRIPTION
    )
VALUES
    (
        :NEW.NAME,
        :NEW.DESCRIPTION
    );

END IF;

-- UPDATING
IF UPDATING THEN
UPDATE
    T_WEB_ROLE
SET
    NAME = :NEW.NAME,
    DESCRIPTION = :NEW.DESCRIPTION
WHERE
    ID = :OLD.ID;

END IF;

-- DELETING
IF DELETING THEN
DELETE FROM
    T_WEB_ROLE
WHERE
    ID = :OLD.ID;

END IF;

END;

--
/
--
CREATE VIEW AI_WEB_USER_ROLE AS
SELECT
    A.ID,
    A.WEB_ROLE_ID,
    A.WEB_USER_ID,
    B.NAME,
    C.USERNAME
FROM
    T_WEB_USER_ROLE A
    LEFT JOIN T_WEB_ROLE B ON B.ID = A.WEB_ROLE_ID
    LEFT JOIN T_WEB_USER C ON C.ID = A.WEB_USER_ID;

CREATE
OR REPLACE TRIGGER TR_AI_WEB_USER_ROLE INSTEAD OF
INSERT
    OR
UPDATE
    OR DELETE ON AI_WEB_USER_ROLE FOR EACH ROW BEGIN -- INSERTING
IF inserting THEN
    INSERT INTO t_web_user_role (
        web_user_id,
        web_role_id
    ) VALUES (
        :new.web_user_id,
        :new.web_role_id
    );

END IF;

-- UPDATING
IF updating THEN
    UPDATE t_web_user_role
    SET
        web_user_id = :new.web_user_id,
        web_role_id = :new.web_role_id
    WHERE
        id = :old.id;

END IF;

-- DELETING
IF deleting THEN
    DELETE FROM t_web_user_role
    WHERE
        id = :old.id;

END IF;

end;
--
/
--