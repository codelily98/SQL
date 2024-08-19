--[문제1] job_id별 급여의 합계를 구해서 job_id, 급여합계를 출력하시오
select
    job_id,
    sum(salary)
from employees
group by job_id;

--[문제2] 부서테이블(DEPARTMENTS d)과 위치테이블(LOCATIONS l)을 연결하여 부서가 
--위치한 도시를 알아내시오
select 
    department_id,
    city
from LOCATIONS
join DEPARTMENTS using(location_id);

create table  locations2 as select * from locations;
select * from locations;
select * from locations2;
alter table locations2 rename column location_id to loc_id;
select * from locations2;

select department_id, city
from departments
join locations2 on(location_id = loc_id);

--[문제3] 위치ID, 부서ID을 연결해서 사원이름, 도시, 부서이름을 출력하시오
--관련 테이블 : EMPLOYEES, LOCATIONS2, DEPARTMENTS
--조건1) 사원이름, 도시, 부서이름으로 제목을 표시
--조건2) Seattle 또는 Oxford에서 근무하는 사원
--조건3) 도시 순으로 오름차순 정렬하시오
select
    last_name as 사원이름,
    city as 도시,
    department_name as 부서이름
from employees
join departments using(department_id)
join locations2 on(location_id = loc_id)
where city = 'Seattle' or city = 'Oxford'
order by city asc;

-- [문제4] 부서ID, 위치ID, 국가ID를 연결해서 다음과 같이 완성하시오
--(관련 테이블 : EMPLOYEES, LOCATIONS2, DEPARTMENTS, COUNTRIES)
--조건1 : 사원번호, 사원이름, 부서이름, 도시, 도시주소, 나라이름으로 제목을 표시하시오
--조건2 : 도시주소에 Ch 또는 Sh 또는 Rd가 포함되어 있는 데이터만 표시하시오
--조건3 : 나라이름, 도시별로 오름차순 정렬하시오
--조건4 : 모든 사원을 포함한다.
select * from employees;
select * from locations2;
select * from departments;
select * from COUNTRIES;

select
    employee_id as 사원번호,
    last_name as 사원이름,
    department_name as 부서이름,
    city as 도시,
        case
            when street_address like '%Ch%' 
            or street_address like '%Sh%' 
            or street_address like '%Rd%' 
            then street_address
            else null
            end as "도시이름",
    country_name as 나라이름   
from employees
left join departments using(department_id)
left join locations2 on(location_id = loc_id)
join countries using(country_id)    
order by country_name, city asc;