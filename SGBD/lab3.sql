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
          , DEPARTMENTS D
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
        DEPARTMENT_NAME, count(E.EMPLOYEE_ID)
        INTO :rezultat,:nr_angajati
        FROM
            EMPLOYEES   E
          , DEPARTMENTS D
        WHERE
            E.DEPARTMENT_ID = D.DEPARTMENT_ID
        GROUP BY DEPARTMENT_NAME
        HAVING
                COUNT(*) = (SELECT
                                MAX(COUNT(*))
                                FROM
                                    EMPLOYEES
                                GROUP BY DEPARTMENT_ID);
    DBMS_OUTPUT.PUT_LINE('Departamentul ' || :rezultat|| ' Nr angajati: '||:nr_angajati);
END;
/
PRINT rezultat

select * from employees;
-- 6 tema
VARIABLE rezultat VARCHAR2(35)
BEGIN
    SELECT
        DEPARTMENT_NAME
        INTO :rezultat
        FROM
            EMPLOYEES   E
          , DEPARTMENTS D
        WHERE
            E.DEPARTMENT_ID = D.DEPARTMENT_ID
        GROUP BY DEPARTMENT_NAME
        HAVING
                COUNT(*) = (SELECT
                                MAX(COUNT(*))
                                FROM
                                    EMPLOYEES
                                GROUP BY DEPARTMENT_ID);
    DBMS_OUTPUT.PUT_LINE('Departamentul ' || :rezultat);
END;
/
PRINT rezultat