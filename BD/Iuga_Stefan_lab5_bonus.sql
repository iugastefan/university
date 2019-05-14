WITH DEPT_COSTURI AS (SELECT DEPARTMENT_NAME,
                             SUM(E.SALARY) DEPT_COST
                      FROM EMPLOYEES E,
                           DEPARTMENTS D
                      WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
                      GROUP BY DEPARTMENT_NAME)
SELECT department_name, DEPT_COST, (SELECT avg(DEPT_COST) FROM DEPT_COSTURI)
FROM DEPT_COSTURI
WHERE DEPT_COST > (SELECT avg(DEPT_COST) FROM DEPT_COSTURI)
ORDER BY DEPARTMENT_NAME;

SELECT DEPARTMENT_NAME,
       sum(SALARY),
       (SELECT avg(sum(SALARY))
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID),
       round(avg(SALARY), 2)
FROM DEPARTMENTS D,
     EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
HAVING sum(SALARY) > (SELECT avg(sum(SALARY))
                      FROM EMPLOYEES E,
                           DEPARTMENTS D
                      WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
                      GROUP BY E.DEPARTMENT_ID);
