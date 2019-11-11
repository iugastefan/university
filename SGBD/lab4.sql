DECLARE
    TYPE EID IS VARRAY (5) OF NUMBER(6);
    IDS    EID := EID();
    OLDSAL EMPLOYEES.SALARY%TYPE;
    NEWSAL EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT EMPLOYEE_ID BULK COLLECT
      INTO IDS
      FROM EMPLOYEES
     WHERE
         COMMISSION_PCT IS NULL
     ORDER BY SALARY
     FETCH FIRST 5 ROWS ONLY;
    FOR I IN IDS.FIRST .. IDS.LAST LOOP
        SELECT SALARY INTO OLDSAL FROM EMPLOYEES WHERE EMPLOYEE_ID = IDS(I) FOR UPDATE;
        NEWSAL := OLDSAL * 1.05;
        DBMS_OUTPUT.PUT_LINE(I || ': ' || OLDSAL || '->' || NEWSAL);
        UPDATE EMPLOYEES SET SALARY=NEWSAL WHERE EMPLOYEE_ID = I;
    END LOOP;
    ROLLBACK;
END;
/

CREATE OR REPLACE TYPE TIP_ORASE_IUGA AS VARRAY (10) OF VARCHAR2(20);/
DROP TABLE EXCURSIE_IUGA;/
CREATE TABLE EXCURSIE_IUGA
(
    COD_EXCURSIE NUMBER(4) PRIMARY KEY, DENUMIRE VARCHAR2(20), ORASE TIP_ORASE_IUGA, STATUS VARCHAR2(11)
);
/
DECLARE
    TYPE EXCURSIE IS TABLE OF EXCURSIE_IUGA%ROWTYPE;
    V_EXCURSIE EXCURSIE;
    V_ORASE    EXCURSIE_IUGA.ORASE%TYPE;
    V_POZ1     NUMBER(2) := -1;
    V_POZ2     NUMBER(2) := -1;
BEGIN
    INSERT INTO EXCURSIE_IUGA
    VALUES
        (1, 'Excursie1', TIP_ORASE_IUGA('Oras1'), 'Disponibil');
    INSERT INTO EXCURSIE_IUGA
    VALUES
        (2, 'Excursie2', TIP_ORASE_IUGA('Oras1'), 'Disponibil');
    INSERT INTO EXCURSIE_IUGA
    VALUES
        (3, 'Excursie3', TIP_ORASE_IUGA('Oras1'), 'Disponibil');
    INSERT INTO EXCURSIE_IUGA
    VALUES
        (4, 'Excursie4', TIP_ORASE_IUGA('Oras1'), 'Disponibil');
    INSERT INTO EXCURSIE_IUGA
    VALUES
        (5, 'Excursie5', TIP_ORASE_IUGA('Oras1'), 'Disponibil');
    COMMIT;

    SELECT ORASE
      INTO V_ORASE
      FROM EXCURSIE_IUGA
     WHERE
         COD_EXCURSIE = 3;


    -- a
    V_ORASE.EXTEND;
    V_ORASE(V_ORASE.LAST) := 'OrasNouA';

    -- b
    V_ORASE.EXTEND;
    FOR I IN REVERSE V_ORASE.FIRST + 1 .. V_ORASE.LAST LOOP
        V_ORASE(I) := V_ORASE(I - 1);
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
    V_ORASE(2) := 'OrasNouB';

    -- c
    FOR I IN V_ORASE.FIRST .. V_ORASE.LAST LOOP
        IF V_ORASE(I) = 'OrasNouA' THEN
            V_POZ1 := I;
        END IF;
        IF V_ORASE(I) = 'OrasNouB' THEN
            V_POZ2 := I;
        END IF;
    END LOOP;


    FOR I IN V_ORASE.FIRST..V_ORASE.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(V_ORASE(I));
    END LOOP;
    UPDATE EXCURSIE_IUGA
       SET ORASE =V_ORASE
     WHERE
         COD_EXCURSIE = 3;

    DELETE FROM EXCURSIE_IUGA RETURNING COD_EXCURSIE,DENUMIRE,ORASE,STATUS BULK COLLECT INTO V_EXCURSIE;
    FOR I IN V_EXCURSIE.FIRST..V_EXCURSIE.LAST LOOP
        DBMS_OUTPUT.PUT(V_EXCURSIE(I).COD_EXCURSIE || ' ');
        DBMS_OUTPUT.PUT(V_EXCURSIE(I).DENUMIRE || ' ');
        FOR J IN V_EXCURSIE(I).ORASE.FIRST..V_EXCURSIE(I).ORASE.LAST LOOP
            DBMS_OUTPUT.PUT(V_EXCURSIE(I).ORASE(J) || ' ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(V_EXCURSIE(I).STATUS);
    END LOOP;
    COMMIT;

EXCEPTION
    WHEN
        OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DELETE FROM EXCURSIE_IUGA;
        COMMIT;
END;
/