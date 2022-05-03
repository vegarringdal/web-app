-- dummy data

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
            CABLETYPE_ID,
            LENGTH_RECIVED
        ) VALUES (
            'T-' || TO_CHAR(1000 + C),
            C,
            500
        );

    END LOOP;
END;