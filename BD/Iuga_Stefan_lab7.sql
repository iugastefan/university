-- 1
CREATE TABLE TIMP_IUGA
(
    DATA1 DATE,
    DATA2 TIMESTAMP(5),
    DATA3 TIMESTAMP(5) WITH TIME ZONE
);
INSERT INTO TIMP_IUGA
VALUES (SYSDATE, systimestamp, systimestamp);

SELECT *
FROM TIMP_IUGA;

-- 2
CREATE TABLE SALARIAT_IUGA
(
    COD_ANG        NUMBER(4)              NOT NULL,
    NUME           VARCHAR2(25),
    PRENUME        VARCHAR2(25),
    FUNCTIA        VARCHAR2(20),
    SEF            NUMBER(4),
    DATA_ANGAJARII DATE         DEFAULT SYSDATE,
    VARSTA         NUMBER(2),
    EMAIL          CHAR(20),
    SALARIU        NUMBER(9, 2) DEFAULT 0 NOT NULL
);

-- 3
INSERT INTO SALARIAT_IUGA
VALUES (1, 'n1', 'p1', 'director', NULL, to_date('05.12.2008', 'dd.mm.yyyy'), NULL, 'e1', 5500);

INSERT INTO SALARIAT_IUGA(COD_ANG, NUME, PRENUME, FUNCTIA, SEF, VARSTA, EMAIL)
VALUES (2, 'n2', 'p2', 'economist', 1, 35, 'e2');

INSERT INTO SALARIAT_IUGA(COD_ANG, NUME, PRENUME, FUNCTIA, SEF, VARSTA, EMAIL, DATA_ANGAJARII, SALARIU)
VALUES (&cod,
       '&nume',
       '&prenume',
       '&job', &sef, &varsta,
       '&email', to_date(
       '&data_ang',
       'dd.mm.yyyy'
)
,
&
salariu
);

-- 4
CREATE TABLE ECONOMIST_IUGA AS
SELECT COD_ANG, NUME, PRENUME, SALARIU * 12 AS SALARIU_ANUAL, DATA_ANGAJARII
FROM SALARIAT_IUGA;

-- 5
ALTER TABLE SALARIAT_IUGA
    ADD (DATA_NASTERII DATE);

-- 6
ALTER TABLE SALARIAT_IUGA
    MODIFY (NUME VARCHAR2(30), SALARIU NUMBER(12, 3));
ALTER TABLE SALARIAT_IUGA
    MODIFY (NUME VARCHAR2(20));
ALTER TABLE SALARIAT_IUGA
    MODIFY (SALARIU NUMBER(13, 3));

-- 7
ALTER TABLE SALARIAT_IUGA
    MODIFY (EMAIL VARCHAR2(20));

-- 8
ALTER TABLE SALARIAT_IUGA
    MODIFY (DATA_ANGAJARII DEFAULT sysdate + 1);

-- 9
ALTER TABLE SALARIAT_IUGA
    RENAME COLUMN VARSTA TO VARSTA_ANG;

-- 10
ALTER TABLE SALARIAT_IUGA
    DROP COLUMN VARSTA_ANG;

-- 11
TRUNCATE TABLE TIMP_IUGA;
SELECT *
FROM TIMP_IUGA;
ROLLBACK;

-- 12
RENAME ECONOMIST_IUGA TO ECO_IUGA;

-- 13
CREATE TABLE SALARIAT_IUGA
(
    COD_ANG        NUMBER(4) PRIMARY KEY,
    NUME           VARCHAR2(25) NOT NULL,
    PRENUME        VARCHAR2(25),
    DATA_NASTERII  DATE,
    FUNCTIA        VARCHAR2(9)  NOT NULL,
    SEF            NUMBER(4) REFERENCES SALARIAT_IUGA (COD_ANG),
    DATA_ANGAJARII DATE DEFAULT SYSDATE,
    EMAIL          VARCHAR2(20) UNIQUE,
    SALARIU        NUMBER(9, 2)
        CONSTRAINT CK1_IUGA CHECK (SALARIU > 0),
    COD_DEP        NUMBER(4),
    CONSTRAINT CK2_IUGA CHECK (DATA_ANGAJARII > DATA_NASTERII),
    CONSTRAINT U_IUGA UNIQUE (NUME, PRENUME, DATA_NASTERII)
);

-- 14
DROP TABLE SALARIAT_IUGA;
CREATE TABLE SALARIAT_IUGA
(
    COD_ANG        NUMBER(4),
    NUME           VARCHAR2(25) NOT NULL,
    PRENUME        VARCHAR2(25),
    DATA_NASTERII  DATE,
    FUNCTIA        VARCHAR2(9)  NOT NULL,
    SEF            NUMBER(4),
    DATA_ANGAJARII DATE DEFAULT SYSDATE,
    EMAIL          VARCHAR2(20),
    SALARIU        NUMBER(9, 2),
    COD_DEP        NUMBER(4),
    CONSTRAINT PK_IUGA PRIMARY KEY (COD_ANG),
    CONSTRAINT FK1_IUGA FOREIGN KEY (SEF) REFERENCES SALARIAT_IUGA (COD_ANG),
    CONSTRAINT U1_IUGA UNIQUE (EMAIL),
    CONSTRAINT CK1_IUGA CHECK (DATA_ANGAJARII > DATA_NASTERII),
    CONSTRAINT CK2_IUGA CHECK (SALARIU > 0),
    CONSTRAINT U2_IUGA UNIQUE (NUME, PRENUME, DATA_NASTERII)
);

-- 15 a
CREATE TABLE DEPARTAMENT_IUGA
(
    COD_DEPT NUMBER(4),
    NUME     VARCHAR2(20),
    ORAS     VARCHAR2(25),
    CONSTRAINT PK_DEPT_IUGA PRIMARY KEY (COD_DEPT),
    CONSTRAINT CKNN_DEPT_IUGA CHECK ( ORAS IS NOT NULL)
);
-- b
ALTER TABLE DEPARTAMENT_IUGA
    MODIFY NUME NOT NULL;

-- c
ALTER TABLE DEPARTAMENT_IUGA
    MODIFY NUME NULL;

ALTER TABLE DEPARTAMENT_IUGA
    DROP CONSTRAINT CKNN_DEPT_IUGA;

ALTER TABLE DEPARTAMENT_IUGA
    ADD CONSTRAINT CKNN_DEPT_IUGA CHECK ( ORAS IS NOT NULL);

-- 16
INSERT INTO SALARIAT_IUGA
VALUES (2, 'n2', 'p2', to_date('05.12.1990', 'dd.mm.yyyy'), 'director', NULL, to_date('05.12.2008', 'dd.mm.yyyy'), 'e1',
        5500, 10);
SELECT *
FROM SALARIAT_IUGA;

-- 17
ALTER TABLE SALARIAT_IUGA
    ADD CONSTRAINT FK2_IUGA FOREIGN KEY (COD_DEP) REFERENCES DEPARTAMENT_IUGA (COD_DEPT);

-- 18
INSERT INTO DEPARTAMENT_IUGA
VALUES (10, 'd1', 'o1');

ALTER TABLE SALARIAT_IUGA
    ADD CONSTRAINT FK2_IUGA FOREIGN KEY (COD_DEP) REFERENCES DEPARTAMENT_IUGA (COD_DEPT);

-- 19
INSERT INTO DEPARTAMENT_IUGA
VALUES (20, 'd2', 'o2');
INSERT INTO SALARIAT_IUGA
VALUES (3, 'n3', 'p3', to_date('05.12.1990', 'dd.mm.yyyy'), 'job3', 2, to_date('05.12.2008', 'dd.mm.yyyy'), 'e3',
        5500, 20);
COMMIT;
SELECT *
FROM DEPARTAMENT_IUGA;
SELECT *
FROM SALARIAT_IUGA;

-- 20
DELETE
FROM DEPARTAMENT_IUGA
WHERE COD_DEPT = 20;

-- 21
ALTER TABLE SALARIAT_IUGA
    DROP CONSTRAINT FK2_IUGA;
ALTER TABLE SALARIAT_IUGA
    ADD CONSTRAINT FK2_IUGA FOREIGN KEY (COD_DEP) REFERENCES DEPARTAMENT_IUGA (COD_DEPT) ON DELETE CASCADE;

-- 22
DELETE
FROM DEPARTAMENT_IUGA
WHERE COD_DEPT = 20;
SELECT *
FROM DEPARTAMENT_IUGA;
SELECT *
FROM SALARIAT_IUGA;

-- 23

ALTER TABLE SALARIAT_IUGA
    DROP CONSTRAINT FK2_IUGA;
ALTER TABLE SALARIAT_IUGA
    ADD CONSTRAINT FK2_IUGA FOREIGN KEY (COD_DEP) REFERENCES DEPARTAMENT_IUGA (COD_DEPT) ON DELETE SET NULL;

-- 24
DELETE
FROM DEPARTAMENT_IUGA
WHERE COD_DEPT = 10;
SELECT *
FROM DEPARTAMENT_IUGA;
SELECT *
FROM SALARIAT_IUGA;

-- 25 a
CREATE TABLE WORK_IUGA AS
SELECT *
FROM WORK;
CREATE TABLE PROJECTS_IUGA AS
SELECT *
FROM PROJECTS;

-- b c
CREATE TABLE EMP_IUGA AS
SELECT *
FROM EMPLOYEES;
ALTER TABLE EMP_IUGA
    ADD CONSTRAINT EMP_IUGA_PK PRIMARY KEY (EMPLOYEE_ID);
ALTER TABLE PROJECTS_IUGA
    ADD CONSTRAINT PROJECTS_IUGA_PK PRIMARY KEY (START_DATE, PROJECT_ID);
ALTER TABLE WORK_IUGA
    ADD (CONSTRAINT WORK_IUGA_FK1 FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMP_IUGA (EMPLOYEE_ID),
        CONSTRAINT WORK_IUGA_FK2 FOREIGN KEY (PROJECT_ID) REFERENCES PROJECTS_IUGA (PROJECT_ID),
        CONSTRAINT WORK_IUGA_PK PRIMARY KEY (EMPLOYEE_ID, PROJECT_ID));
-- d
ALTER TABLE WORK_IUGA
    DROP PRIMARY KEY;

-- e
ALTER TABLE WORK_IUGA
    ADD CONSTRAINT WORK_IUGA_PK PRIMARY KEY (EMPLOYEE_ID, PROJECT_ID, START_WORK, END_WORK);

-- 28
desc user_tables;
SELECT table_name from user_tables;

-- 29
desc cols;
SELECT column_name, data_type
FROM COLS
    where table_name = 'DEPARTAMENT_IUGA';

-- 30
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, DELETE_RULE, STATUS, VALIDATED, INDEX_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('SALARIAT_IUGA', 'DEPARTAMENT_IUGA')
ORDER BY TABLE_NAME;

-- 31
SELECT B.*,
       A.CONSTRAINT_NAME,
       A.CONSTRAINT_TYPE,
       A.TABLE_NAME,
       A.DELETE_RULE,
       A.STATUS,
       A.VALIDATED,
       A.INDEX_NAME
FROM USER_CONS_COLUMNS B,
     USER_CONSTRAINTS A
WHERE B.CONSTRAINT_NAME = 'FK2_IUGA'
  AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME;

