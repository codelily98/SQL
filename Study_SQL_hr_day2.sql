--ex18) count(컬럼명), max(컬럼명), min(컬럼명), avg(컬럼명), sum(컬럼명) 함수 employees테이블에서
 --급여의 초대, 최소, 평균, 합을 구하시오
 --조건) 평균은 소수이하절삭, 합은 세자리마다 콤마 찍고 \표시
 select 
    max(salary),
    min(salary),
    trunc(avg(salary), 0),
    to_char(sum(salary), 'L9,999,999') 
from employees;

--[문제5] 커미션(commission_pct)을 받지 않은 사원의 인원수를 구하시오
select
    count(*) - count(commission_pct)
from employees;

--ex19) employees테이블에서 없는 부서 포함해서 총 부서의 수를 구하시오
select department_id from employees; -- 107
select count(department_id) from employees; -- 106
select count(*) from employees; -- 107
select count(distinct department_id) from employees; -- 11
select count(distinct nvl(department_id, 0)) from employees; -- 12
select distinct nvl(department_id, 0) from employees; -- nvl은 null값을 0으로 대치

--ex20) ① decode(표현식, 검색1,결과1, 검색2,결과2....[default])
-- : 표현식과 검색을 비교하여 결과 값을 반환 다르면 default
-- ② case  value  when  표현식  then  구문1
-- when  표현식  then  구문2
-- else  구문3
-- end case

--업무 id가 'SA_MAN' 또는 ‘SA_REP'이면 'Sales Dept' 그 외 부서이면 'Another'로 표시
--조건) 분류별로 오름차순 정렬
select job_id, decode(job_id, 
                     'SA_MAN', 'Sales Dept',
                     'SA_REP', 'Sales Dept',
                     'Another') "분류"
 from employees
 order by 2;
 ------------------------------------------------------------------------------------
select job_id, case job_id
                    when 'SA_MAN' then 'Sales Dept'
                    when 'SA_REP' then 'Sales Dept'
                    else 'Another'
              end "분류"
 from employees
 order by 2;       
 ------------------------------------------------------------------------------------
select job_id, case 
                    when job_id='SA_MAN' then 'Sales Dept'
                    when job_id='SA_REP' then 'Sales Dept'
                    else 'Another'
              end "분류"
 from employees
 order by 2;       
 ------------------------------------------------------------------------------------
-- [문제6] 급여가 10000 미만이면 초급, 20000 미만이면 중급 그 외면 고급을 출력하시오
-- 조건1) 제목은 사원번호, 사원명, 구분으로 표시하시오
-- 조건2) 구분 컬럼으로 오름차순 정렬하고, 같으면 사원명 컬럼으로 오름차순 하시오 
-- 조건3) case 사용하시오
select
    employee_id as 사원번호,
    last_name as 사원명,
    case
        when salary < 10000 then  '초급'
        when salary < 20000 then '중급'
        else '고급'
    end "구분"
from employees
order by 3, 2 asc;

--[문제7] 사원테이블에서 사원번호, 이름, 급여, 커미션, 연봉을 출력하시오
--조건1) 연봉은 $ 표시와 세자리마다 콤마를 사용하시오
--조건2) 연봉 = 급여 * 12 + (급여 * 12 * 커미션)
--조건3) 커미션을 받지 않는 사원도 포함해서 출력하시오
--case 사용
select
    employee_id as 사원번호,
    last_name as 이름,
    salary as 급여,
    commission_pct as 커미션,
    case
        when commission_pct 
            is null then to_char((salary * 12), '$999,999')
        when commission_pct 
            is not null then to_char((salary * 12) + (salary * 12 * commission_pct), '$999,999')
    end "연봉"
from employees;

--nvl 사용
select
    employee_id as 사원번호,
    last_name as 이름,
    salary as 급여,
    commission_pct as 커미션,
    to_char((salary * 12) + (salary * 12 * nvl(commission_pct, 0)), '$999,999') as 연봉
from employees;

--[문제8] 매니저가 없는 사원의 MANAGER_ID를 1000번으로 표시
--조건1) 제목은 사원번호, 이름, 매니저ID
--조건2) 모든 사원을 표시하시오
 select
    employee_id as 사원번호,
    first_name || ' ' || last_name as 이름,
    case
        when manager_id is null then 1000
        else manager_id
    end "매니저ID"
from employees;
 
select * from employees;

select 
    employee_id as 사원번호,
    last_name as 이름,
decode(manager_id, 
    null, 1000, 
    manager_id)
    "매니저ID"
from employees;
