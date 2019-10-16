--  1 a
--  2 b
--  3 b
--  4 d
--  5 d
--  6 a
--  7 a
--  8 c
--  9 c
-- 10 b
-- 11
create table emp_iuga as select * from employees;
create table dept_iuga as select * from departments;
comment on table emp_iuga is 'Informatii despre angajati';
comment on column emp_iuga.salary is 'Salariul angajatului';
-- 12
select * from user_tab_comments where upper(table_name) like upper('%_IUGA');
comment on table emp_iuga is '';
select * from user_col_comments where upper(table_name) like upper('%_IUGA') and comments is not null;
-- 13
select sysdate from dual;
ALTER SESSION SET NLS_DATE_FORMAT = 'dd.mm.yyyy hh24:mi:ss';
-- 14
select extract(year from sysdate)
from dual;
-- 15
select extract(day from sysdate)||'.'|| extract(month from sysdate) as "ziua.luna"
from dual;
-- 16
select table_name from user_tables where table_name like upper('%iuga');
-- 17
spool sterg_tabele.sql
select upper('drop table ' || table_name ||' cascade constraint;') from user_tables where table_name like upper('%iuga');
spool off
-- tema 23
