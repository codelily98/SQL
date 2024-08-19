select * from tab;
select * from  user_sequences;
desc employees;

--SQL문
--1. 데이터 조작어(DML : Data Manipulation Language)
-- : insert, update, delete, merge

--2. 데이터 정의어(DDL : Data Definition Language)
-- : create, alter, drop, rename, truncate

--3. 데이터 검색 : Select (매우 중요)

--4. 트랜젝션 제어 : Commit, Rollback, Savepoint
-- : SQL의 모음집(Commit 전까지)

--5. 데이터 제어어 (DCL : Data Control Language)
-- : grant(권한 부여), revoke(권한 해제)

--[문제1] 다음과 같이 출력
-- 사원번호, 이름, 연봉
select 
    employee_id as "사원번호", 
    first_name || ' ' || last_name as "이 름", 
    salary * 12 || ' 달러' as  "연 봉" 
from employees;

--[문제2] 다음과 같이 출력
--다음처럼 출력하시오 (last_name, job_id)
select 
    last_name || ' is a ' || job_id 
    as "Employee Detail" 
from employees;

--[문제3] 급여가 2500이하 이거나 3000이상이면서 90번 부서인
--사원의 이름, 급여, 부서ID를 출력하시오.
--조건1) 제목은 사원명, 월급, 부서코드
--조건2) 급여 앞에 $를 붙이시오
--조건3) 사원명은 first_name과 last_name을 연결해서 출력
select
    first_name || ' ' || last_name as "사원명",
    '$' || salary as "월급",
    department_id as "부서코드"
from employees
where (salary <= 2500 or salary >= 3000) and department_id = 90; 

--[문제4] 업무ID가 'SA_REP' 이거나 'AD_PRES' 이면서 급여가 10,000를 초과하는 사원들의 
--이름, 업무ID, 급여를 출력하시오
select
    last_name as "이름",
    job_id as "업무ID",
    salary || ' 원' as "급 여"
from employees
where job_id in('SA_REP', 'AD_PRES') and salary > 10000;

--[문제5] Employees테이블의 업무ID가 중복되지 않게 표시하는 질의를 작성하시오
select distinct
    job_id
from employees;

--[문제6] 입사일이 2005년인 사원들의 사원번호, 이름, 입사일을 표시하시오
select
    employee_id as "사원번호",
    first_name || ' ' || last_name as "이름",
    hire_date as "입사일"   
from employees
where hire_date like '05%';

-------------------------------------------------------------------------------------------
--[문제1] 사원들의 연봉을 구한 후 연봉 순으로 내림차순 정렬하시오
select 
    last_name as 이름,
    salary * 12 as 연봉
from employees
order by 2 desc, 1;
---------------------------------------------------------------------------------------------
--[문제2] 사원의 레코드를 검색하시오 (concat, length)
--조건1) 성과 이름을 연결하시오 (concat)
--조건2) 구해진 이름의 길이를 구하시오 (length)
--조건3) 이름이 n으로 끝나는 사원(substr)
select
    employee_id as "사원 번호",
    concat(first_name, ' ' || last_name) as "이름",
    length(concat(first_name, ' ' || last_name)) as "길이"
from employees
where substr(last_name, 1) like '%n';

--ex10) (찾을 위치, 최소, 최대, 구간 수)
select width_bucket(74, 0, 100, 10) from dual;
 
 --ex11) 공백제거 : ltrim(왼쪽), rtrim(오른쪽), trim(양쪽)
 select rtrim('test   ') || 'exam' from dual;
 
 --ex12) sysdate : 시스템에 설정된 시간표시
 select sysdate from dual;
 select to_char(sysdate, 'YYYY"년" MM"월" DD"일"') as 오늘날짜 from dual;
 select to_char(sysdate, 'HH"시" MI"분" SS"초"') as 오늘날짜 from dual;
 select to_char(sysdate, 'HH24"시" MI"분" SS"초"') as 오늘날짜 from dual;

--ex13) add_months(date, 달수) : 날짜에 달수 더하기
select add_months(sysdate, 7) from dual;

--ex14) last_day(date) : 해당달의 마지막 날
select last_day(sysdate) from dual;
select last_day('2004-02-01') from dual;
select last_day('2005-02-01') from dual;

--[문제3] 오늘부터 이번 달 말까지 총 남은 날수를 구하시오
select
    last_day(sysdate) - sysdate as "월말까지 남은 일수"
from dual;

--ex15) months_between(date1, date2) : 두 날짜 사이의 달 수 
select round(months_between('95-10-21', '94-10-20'), 0) as "두 날짜 사이의 달 수" from dual;
--날짜자체는 초단위로 계산 -> 값을 정수형으로 반올림 해서 출력 됨

--명시적인 변환(강제)
select last_name, to_char(salary, 'L99,999.00')
from employees
where last_name='King';

--ex16) 년도의 앞의 2자리는 시스템의 날짜로 부터 가져온다.
select to_char(to_date('97/9/30', 'YY-MM-DD') , 'YYYY-MON-DD') from dual; --← 2097
select to_char(to_date('97/9/30', 'RR-MM-DD') , 'RRRR-MON-DD') from dual; --← 1997

select to_char(to_date('17/9/30', 'YY-MM-DD') , 'YYYY-MON-DD') from dual; --← 2017 
select to_char(to_date('17/9/30', 'RR-MM-DD') , 'RRRR-MON-DD') from dual; --← 2017

--[문제4] 2005년 이전에 고용된 사원을 찾으시오
select * from employees;

select
    last_name as "이름",
    to_char(to_date(hire_date, 'YY-MM-DD') , 'DD-MON-YYYY') as "고용일"
from employees
where to_char(hire_date, 'YYYY') < 2005;

--ex17) fm형식 : 형식과 데이터가 반드시 일치해야함(fm - fm 사이 값만 일치)
--fm를 표시하면 숫자 앞의 0이 나타나지 않는다.
 select last_name, hire_date from employees where hire_date='05/09/30';
 select last_name, hire_date from employees where hire_date='05/9/30';
 
 -- 2011-03-01
 select to_char(to_date('2011-03-01','YYYY-MM-DD'), 'YYYY-MM-DD') from dual;
 -- 2011-3-1
 select to_char(to_date('2011-03-01','YYYY-MM-DD'), 'YYYY-fmMM-DD') from dual;
 -- 2011-3-01
 select to_char(to_date('2011-03-01','YYYY-MM-DD'), 'YYYY-fmMM-fmDD') from dual;
  
 