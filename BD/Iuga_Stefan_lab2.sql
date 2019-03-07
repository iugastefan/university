-- 23
SELECT LAST_NAME || ' ' || FIRST_NAME NUME,
       nvl(DEPARTMENT_ID, 0)          ID_DEPARTAMENT,
       CASE
         WHEN DEPARTMENT_ID IS NULL THEN 'fara departament'
         ELSE to_char(DEPARTMENT_ID)
         END                          ID_DEPARTAMENT
FROM EMPLOYEES;

-- 24
SELECT avg(COMMISSION_PCT)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

SELECT avg(COMMISSION_PCT)
FROM EMPLOYEES;

-- 25 a
SELECT LAST_NAME || ' ' || FIRST_NAME NUME
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;
-- 25 b
SELECT LAST_NAME || ' ' || FIRST_NAME NUME,
       CASE
         WHEN MANAGER_ID IS NULL THEN 'nu are sef'
         ELSE to_char(MANAGER_ID)
         END                          ID_DEPARTAMENT
FROM EMPLOYEES;

-- 26
SELECT LAST_NAME || ' ' || FIRST_NAME                                        NUME,
       nvl2(COMMISSION_PCT, (SALARY + SALARY * COMMISSION_PCT) * 12, SALARY) VENIT
FROM EMPLOYEES;

-- 27
SELECT nullif(length(LAST_NAME), length(FIRST_NAME))
FROM EMPLOYEES;

-- 28
SELECT nvl(to_char(nullif(length(LAST_NAME), length(FIRST_NAME))), 'valori egale')
FROM EMPLOYEES;

-- 29
SELECT LAST_NAME || ' ' || FIRST_NAME NUME,
       SALARY,
       CASE
         WHEN months_between(sysdate, HIRE_DATE) > 200 THEN SALARY * 1.2
         WHEN months_between(sysdate, HIRE_DATE) > 150 THEN SALARY * 1.15
         WHEN months_between(sysdate, HIRE_DATE) > 100 THEN SALARY * 1.1
         ELSE SALARY * 1.05
         END                          SALARIU_REVIZUIT
FROM EMPLOYEES;
