DECLARE
    NR NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE(NR + 1);
END;/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Invat PL/SQL');
END;
/

<<principal>>
DECLARE
    V_CLIENT_ID     NUMBER(4)    := 1600;
    V_CLIENT_NUME   VARCHAR2(50) := 'N1';
    V_NOU_CLIENT_ID NUMBER(3)    := 500;
BEGIN
    <<SECUNDAR>>
        DECLARE
        V_CLIENT_ID       NUMBER(4)    := 0;
        V_CLIENT_NUME     VARCHAR2(50) := 'N2';
        V_NOU_CLIENT_ID   NUMBER(3)    := 300;
        V_NOU_CLIENT_NUME VARCHAR2(50) := 'N3';
    BEGIN
        V_CLIENT_ID := V_NOU_CLIENT_ID;
        PRINCIPAL.V_CLIENT_NUME :=
                V_CLIENT_NUME || ' ' || V_NOU_CLIENT_NUME;
        --poziția 1
    END;
    V_CLIENT_ID := (V_CLIENT_ID * 12) / 10;
--poziția 2
END;
/

DECLARE
    V_DEP DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
    SELECT
        DEPARTMENT_NAME
      INTO V_DEP
      FROM
          EMPLOYEES   E
              ,
          DEPARTMENTS D
     WHERE
         E.DEPARTMENT_ID = D.DEPARTMENT_ID
     GROUP BY DEPARTMENT_NAME
    HAVING
            COUNT(*) = (SELECT
            MAX(COUNT(*))
                          FROM
                              EMPLOYEES
                         GROUP BY DEPARTMENT_ID);
    DBMS_OUTPUT.PUT_LINE('Departamentul ' || V_DEP);
END;
/

VARIABLE rezultat VARCHAR2(35)
VARIABLE nr_angajati NUMBER
BEGIN
    SELECT
        DEPARTMENT_NAME
            ,
        count(E.EMPLOYEE_ID)
      INTO :rezultat,:nr_angajati
      FROM
          EMPLOYEES   E
              ,
          DEPARTMENTS D
     WHERE
         E.DEPARTMENT_ID = D.DEPARTMENT_ID
     GROUP BY DEPARTMENT_NAME
    HAVING
            COUNT(*) = (SELECT
            MAX(COUNT(*))
                          FROM
                              EMPLOYEES
                         GROUP BY DEPARTMENT_ID);
    DBMS_OUTPUT.PUT_LINE('Departamentul ' || :rezultat || ' Nr angajati: ' || :nr_angajati);
END;
/
PRINT rezultat

SELECT *
  FROM
      EMPLOYEES;


-- 6 tema
VARIABLE rezultat VARCHAR2(35)
VARIABLE numar NUMBER
BEGIN
    SELECT
        DEPARTMENT_NAME, count(*)
      INTO :rezultat,:numar
      FROM
          EMPLOYEES   E
              ,
          DEPARTMENTS D
     WHERE
         E.DEPARTMENT_ID = D.DEPARTMENT_ID
     GROUP BY DEPARTMENT_NAME
    HAVING
            COUNT(*) = (SELECT
            MAX(COUNT(*))
                          FROM
                              EMPLOYEES
                         GROUP BY DEPARTMENT_ID);
    DBMS_OUTPUT.PUT_LINE('Departamentul: ' || :rezultat);
    DBMS_OUTPUT.PUT_LINE('Angajati: ' || :numar);
END;
/
PRINT rezultat
PRINT numar




-- exercitii
-- 2
-- a
SELECT
    ZI, sum(NUMAR)
  FROM
      (
           SELECT
               to_char(BOOK_DATE, 'YYYY-MM-DD') ZI,
               count(*) NUMAR
             FROM
                 RENTAL
            WHERE
                extract(MONTH FROM BOOK_DATE) = 10
            GROUP BY
                BOOK_DATE
            UNION
           SELECT
               to_char(to_date('01-OCT-2019') + LEVEL - 1, 'YYYY-MM-DD') ZI,
               0
             FROM
                 DUAL
          CONNECT BY
              LEVEL <= extract(DAY FROM (last_day('01-OCT-2019'))))
 GROUP BY
     ZI
 ORDER BY
     ZI;

CREATE TABLE OCTOMBRIE_IUGA
(
    ID INTEGER GENERATED ALWAYS AS IDENTITY, DATA DATE, CONSTRAINT OCT_PK PRIMARY KEY ("ID")
);

-- b
DECLARE
    MAXIM INTEGER(2);
BEGIN
    MAXIM := extract(DAY FROM last_day('01-OCT-2019')) - 1;
    FOR I IN 0..MAXIM LOOP
        INSERT INTO OCTOMBRIE_IUGA
        VALUES
            (default, to_date('01-OCT-2019') + I);
    END LOOP;
    COMMIT;
END;

SELECT
    ZI, sum(NUMAR)
  FROM
      (
          SELECT
              to_char(BOOK_DATE, 'YYYY-MM-DD') ZI,
              count(*) NUMAR
            FROM
                RENTAL
           WHERE
               extract(MONTH FROM BOOK_DATE) = 10
           GROUP BY
               BOOK_DATE
           UNION
          SELECT
              to_char(DATA, 'YYYY-MM-DD') ZI,
              0
            FROM
                OCTOMBRIE_IUGA
           GROUP BY DATA)
 GROUP BY
     ZI
 ORDER BY
     ZI;

-- 3
DECLARE
    NUME  VARCHAR(20) := &nume_tast;
    NUMAR NUMBER(3);
BEGIN
    SELECT count(DISTINCT TITLE_ID)
      INTO NUMAR
      FROM
          RENTAL
              JOIN MEMBER ON RENTAL.MEMBER_ID = MEMBER.MEMBER_ID
     WHERE
         MEMBER.FIRST_NAME = NUME
     GROUP BY MEMBER.FIRST_NAME;
    DBMS_OUTPUT.PUT_LINE(NUME || ': ' || NUMAR);
EXCEPTION
    WHEN TOO_MANY_ROWS
        THEN
            DBMS_OUTPUT.PUT_LINE(NUME || ': Eroare mai multi useri cu acest nume!');
    WHEN NO_DATA_FOUND
        THEN
            DBMS_OUTPUT.PUT_LINE(NUME || ': Eroare nu sunt date!');
END;
/


-- 4
DECLARE
    NUME      VARCHAR(20) := &nume_tast;
    NUMAR     NUMBER(3);
    NUMAR_TOT NUMBER(3);
BEGIN

    SELECT count(DISTINCT TITLE_ID)
      INTO NUMAR_TOT
      FROM TITLE;

    SELECT count(DISTINCT TITLE_ID)
      INTO NUMAR
      FROM
          RENTAL
              JOIN MEMBER ON RENTAL.MEMBER_ID = MEMBER.MEMBER_ID
     WHERE
         MEMBER.FIRST_NAME = NUME
     GROUP BY MEMBER.FIRST_NAME;
    DBMS_OUTPUT.PUT_LINE(NUME || ': ' || NUMAR);
    CASE
        WHEN NUMAR / NUMAR_TOT >= 0.75
            THEN
                DBMS_OUTPUT.PUT_LINE('Categoria 1');
        WHEN NUMAR / NUMAR_TOT >= 0.5
            THEN
                DBMS_OUTPUT.PUT_LINE('Categoria 2');
        WHEN NUMAR / NUMAR_TOT >= 0.25
            THEN
                DBMS_OUTPUT.PUT_LINE('Categoria 3');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Categoria 4');
    END CASE;
EXCEPTION
    WHEN
        TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE(NUME || ': Eroare mai multi useri cu acest nume!');
    WHEN
        NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(NUME || ': Eroare nu sunt date!');
END;


-- 5
CREATE TABLE MEMBER_IUGA AS SELECT * FROM MEMBER;
COMMIT;
ALTER TABLE MEMBER_IUGA
    ADD DISCOUNT NUMBER(*, 2) DEFAULT 0 NOT NULL;

DECLARE
    ID        NUMBER(4) := &id_tast;
    NUMAR     NUMBER(3);
    NUMAR_TOT NUMBER(3);
BEGIN
    SELECT count(DISTINCT TITLE_ID)
      INTO NUMAR_TOT
      FROM TITLE;
    SELECT count(DISTINCT TITLE_ID)
      INTO NUMAR
      FROM
          RENTAL
     WHERE
         MEMBER_ID = ID
     GROUP BY
         MEMBER_ID;
    UPDATE MEMBER_IUGA
       SET
           DISCOUNT =
               CASE
                   WHEN NUMAR / NUMAR_TOT >= 0.75
                       THEN
                       0.1
                   WHEN NUMAR / NUMAR_TOT >= 0.5
                       THEN
                       0.05
                   WHEN NUMAR / NUMAR_TOT >= 0.25
                       THEN
                       0.03
                       ELSE
                       0.0
               END
     WHERE
         MEMBER_ID = ID;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(ID || ': Actualizare reusita!');
EXCEPTION
    WHEN
        TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE(ID || ': Eroare mai multi useri cu acest id!');
    WHEN
        NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(ID || ': Eroare nu sunt date!');
END;
