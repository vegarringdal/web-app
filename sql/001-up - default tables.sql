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
CREATE OR REPLACE FUNCTION f_get_current_user RETURN VARCHAR IS
BEGIN -- IF WEB CLIENT ID WILL HAVE USER
-- IF NOT WEB OR ANYTHING ELSE WE USE OS_USER
    RETURN nvl(sys_context('USERENV', 'CLIENT_IDENTIFIER'), sys_context('USERENV', 'OS_USER'));
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
CREATE TABLE T_WEB_ROLE (
    ID NUMBER GENERATED ALWAYS AS IDENTITY,
    NAME VARCHAR2(100) NOT NULL,
    DESCRIPTION VARCHAR2(100) NOT NULL,
    CREATED DATE DEFAULT SYSDATE,
    CREATED_BY VARCHAR2(100),
    MODIFIED DATE DEFAULT SYSDATE,
    MODIFIED_BY VARCHAR2(100)
);

CREATE TRIGGER tr_web_role_audit BEFORE
    INSERT OR UPDATE ON t_web_role
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
CREATE TABLE T_WEB_USER_ROLE (
    ID NUMBER GENERATED ALWAYS AS IDENTITY,
    WEB_ROLE_ID NUMBER NOT NULL,
    WEB_USER_ID NUMBER NOT NULL,
    CREATED DATE DEFAULT SYSDATE,
    CREATED_BY VARCHAR2(100),
    MODIFIED DATE DEFAULT SYSDATE,
    MODIFIED_BY VARCHAR2(100)
);

CREATE TRIGGER tr_web_user_role_audit BEFORE
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

CREATE TRIGGER tr_web_rest_api_audit BEFORE
    INSERT OR UPDATE ON t_web_rest_api
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

CREATE TRIGGER tr_web_grid_config_audit BEFORE
    INSERT OR UPDATE ON t_web_grid_config
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
CREATE VIEW ai_web_user AS
    SELECT
        *
    FROM
        t_web_user;

CREATE OR REPLACE TRIGGER tr_ai_web_user INSTEAD OF
    INSERT OR UPDATE OR DELETE ON ai_web_user
    FOR EACH ROW
BEGIN -- INSERTING
    IF inserting THEN
        INSERT INTO t_web_user (
            firstname,
            lastname,
            username
        ) VALUES (
            :new.firstname,
            :new.lastname,
            :new.username
        );

    END IF;

-- UPDATING
    IF updating THEN
        UPDATE t_web_user
        SET
            firstname = :new.firstname,
            lastname = :new.lastname,
            username = :new.username
        WHERE
            id = :old.id;

    END IF;

-- DELETING
    IF deleting THEN
        DELETE FROM t_web_user
        WHERE
            id = :old.id;

    END IF;
END;

--
/
--
CREATE VIEW ai_web_role AS
    SELECT
        *
    FROM
        t_web_role;

CREATE OR REPLACE TRIGGER tr_ai_web_role INSTEAD OF
    INSERT OR UPDATE OR DELETE ON ai_web_role
    FOR EACH ROW
BEGIN -- INSERTING
    IF inserting THEN
        INSERT INTO t_web_role (
            name,
            description
        ) VALUES (
            :new.name,
            :new.description
        );

    END IF;

-- UPDATING
    IF updating THEN
        UPDATE t_web_role
        SET
            name = :new.name,
            description = :new.description
        WHERE
            id = :old.id;

    END IF;

-- DELETING
    IF deleting THEN
        DELETE FROM t_web_role
        WHERE
            id = :old.id;

    END IF;
END;

--
/
--
CREATE VIEW ai_web_user_role AS
    SELECT
        a.id,
        a.web_role_id,
        a.web_user_id,
        b.name,
        c.username
    FROM
        t_web_user_role a
        LEFT JOIN t_web_role      b ON b.id = a.web_role_id
        LEFT JOIN t_web_user      c ON c.id = a.web_user_id;

CREATE OR REPLACE TRIGGER tr_ai_web_user_role INSTEAD OF
    INSERT OR UPDATE OR DELETE ON ai_web_user_role
    FOR EACH ROW
BEGIN -- INSERTING
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
END;
--
/
--