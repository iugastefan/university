BEGIN
    FOR V_DEPT IN (SELECT DEPARTMENT_ID, DEPARTMENT_NAME
                     FROM DEPARTMENTS
                    WHERE
                        DEPARTMENT_ID IN (10, 20, 30, 40))
        LOOP
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            DBMS_OUTPUT.PUT_LINE('DEPARTAMENT ' || V_DEPT.DEPARTMENT_NAME);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            FOR V_EMP IN (SELECT LAST_NAME
                            FROM EMPLOYEES
                           WHERE
                               DEPARTMENT_ID = V_DEPT.DEPARTMENT_ID)
                LOOP
                    DBMS_OUTPUT.PUT_LINE(V_EMP.LAST_NAME);
                END LOOP;
        END LOOP;
END;
/

DECLARE
    CURSOR V_DEPT IS SELECT DEPARTMENT_ID, DEPARTMENT_NAME
                       FROM DEPARTMENTS
                      WHERE
                          DEPARTMENT_ID IN (10, 20, 30, 40);
    CURSOR V_EMP(CONDITIE DEPARTMENTS.DEPARTMENT_ID%TYPE) IS (SELECT LAST_NAME
                                                                FROM EMPLOYEES
                                                               WHERE
                                                                   DEPARTMENT_ID = CONDITIE);
    V_DEPT_ID   DEPARTMENTS.DEPARTMENT_ID%TYPE;
    V_DEPT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    V_LAST_NAME EMPLOYEES.LAST_NAME%TYPE;
BEGIN
    OPEN V_DEPT;
    LOOP
        FETCH V_DEPT INTO V_DEPT_ID,V_DEPT_NAME;
        EXIT WHEN V_DEPT%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE('DEPARTAMENT ' || V_DEPT_NAME);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        OPEN V_EMP(V_DEPT_ID);
        LOOP
            FETCH V_EMP INTO V_LAST_NAME;
            EXIT WHEN V_EMP%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(V_LAST_NAME);
        END LOOP;
        CLOSE V_EMP;
    END LOOP;
    CLOSE V_DEPT;
END;
/

DECLARE
    CURSOR V_DEPT IS SELECT DEPARTMENT_ID ID, DEPARTMENT_NAME NUME
                       FROM DEPARTMENTS
                      WHERE
                          DEPARTMENT_ID IN (10, 20, 30, 40);
    CURSOR V_EMP(CONDITIE DEPARTMENTS.DEPARTMENT_ID%TYPE) IS (SELECT LAST_NAME L_NUME
                                                                FROM EMPLOYEES
                                                               WHERE
                                                                   DEPARTMENT_ID = CONDITIE);
BEGIN

    FOR I IN V_DEPT LOOP
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE('DEPARTAMENT ' || I.NUME);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        FOR J IN V_emp(I.ID) LOOP
            DBMS_OUTPUT.PUT_LINE(J.L_NUME);
        END LOOP;
    END LOOP;
END;
/

