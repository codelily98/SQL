--inner join(같은 것끼리만 조인)
--사원테이블과 부서테이블에서 부서가 같을 경우 사원번호, 부서번호, 부서이름을 출력하시오

select * from departments;

select * from employees;

--Oracle 전용 일반 구문
select
employees_id,
employees.department_id,
departmen_name
form employees, departments
where employees.department_id = departments.department_id;

--Oracle 전용 단축 구문
select
employee_id,
e.department_id,
department_name
from employees e, departments d
where e.department_id = d.department_id;

--Ansi 표준 (가장 선호됨)
select
employee_id, department_id, department_name
from employees
join departments using(department_id);

--[문제2] 부서테이블(DEPARTMENTS d)과 위치테이블(LOCATIONS l)을 연결하여 부서가 
--위치한 도시를 알아내시오

--department_id     
--city---------------------------------
--10                
--Seattle

select department_id, city
from departments, locations
where departments.location_id = locations.location_id;

select department_id, city
from departments d, location l
where d.location_id = l.loction_id;

select department_id, city
from departments
join locations using(location_id);

--문제1) 송강 교수가 강의하는 과목을 검색하시오.
--테이블 : PROFESSOR P, COURSE C
--컬럼 : PNO, PNAME, CNO, CNAME

select * from professor p;
select * from course c;

select p.pno, pname, cno, cname
from professor p, course c
where p.pno = c.pno and pname = '송강';

select pname, cno, cname
from PROFESSOR
join COURSE using(pno)
where pname = '송강';

--가져올 컬럼 select 어디서? from professor
--같은 정보 있는 테이블 course 무엇이? using(pno)  둘다 존재
--송강 교수의 과목 where pname = '송강'


--문제2) 화학 관련 과목을 강의하는 교수의 명단을 검색하시오
--테이블 : PROFESSOR P, COURSE C
--컬럼 : PNO, PNAME, CNO, CNAME

select * from professor p;
select * from course c;

--where에서 pno가 같을 때 and로 원하는 조건 설정
select p.pno, p.pname, c.cno, c.cname
from professor p, course c
where p.pno = c.pno and c.cname like '%화학';

--pno를 사용해 join이 되어 있으므로 where 조건 설정이 바로 가능
select pno, pname, cno, cname
from professor
join course using(pno)
where cname like '%화학';
