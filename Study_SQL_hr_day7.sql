--ex1) 사원테이블에서 부서가 90인 사원들을 v_view1으로 뷰 테이블을 만드시오
--(사원ID, 사원이름, 급여, 부서ID만 추가)
create or replace view v_view1
as select
    employee_id as 사원ID,
    last_name as 사원이름,
    salary as 급여,
    department_id as 부서ID
from employees
where department_id=90;

select * from v_view1;

delete from v_view1;
--무결성 제약조건(HR.DEPT_MGR_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다

---[문제1]사원테이블에서 급여가 5000 이상 10000 이하인 사원들만 v_view2으로 뷰를 만드시오.
 --(사원ID, 사원이름, 급여, 부서ID)
 create or replace view v_view2
 as select
    employee_id as 사원ID,
    last_name as 사원이름,
    salary as 급여,
    department_id as 부서ID
from employees
where salary >= 5000 and salary <= 10000;

select * from v_view2;

--ex2) v_view2 테이블에서 103사원의 급여를 9000.00에서 12000.00으로 수정하시오
update v_view2 set 급여=12000 where 사원ID=103;
--v_view2의 103사원의 급여를 바꾸면 조건에 맞지 않아서 빠져나간 것을 확인할 수 있다.
select * from employees where 사원ID=103;
--원본이 바뀌면 view도 같이 바뀐다.
update employees set 급여=9000 where 사원ID=103;
--원본을 다시 9000으로 변경하면 v_view2의 내용도 바뀌어서 103사원이 다시 들어온 것을 확인 할 수 있다

--[문제2] 사원테이블과 부서테이블에서 사원번호, 사원명, 부서명을 v_view3로 뷰 테이블을 만드시오
--조건1) 부서가 10, 90인 사원만 표시하시오
--조건2) 타이틀은 사원번호, 사원명, 부서명으로 출력하시오
--조건3) 사원번호로 오름차순 정렬하시오
create or replace view v_view3
as select
    employee_id as 사원번호,
    last_name as 사원명,
    department_name as 부서명
from employees
join departments using(department_id)
where department_id=10 or department_id=90
order by 1 asc;

select * from v_view3;
--[문제3] 부서ID가 10, 90번 부서인 모든 사원들의 부서위치를 표시하시오
--조건1) v_view4로 뷰 테이블을 만드시오
--조건2) 타이틀을 사원번호, 사원명, 급여, 입사일, 부서명, 부서위치(city)로 표시하시오
--조건3) 사원번호 순으로 오름차순 정렬하시오
--조건4) 급여는 백 단위 절삭하고, 3자리 마다 콤마와 '원'을 표시하시오
--조건5) 입사일은  '2004년 10월 02일' 형식으로 표시하시오
create or replace view v_view4
as select
    employee_id as 사원번호,
    last_name as 사원명,
    to_char(trunc(salary * 1365, -3), '999,999,999') || '원' as 급여,
    to_char(hire_date, 'YYYY"년" mm"월" dd"일"') as 입사일,
    department_name as 부서명,
    city as 부서위치
from employees
join departments using(department_id)
join locations using(location_id)
order by 1 asc;
select * from v_view4;
select * from employees;
select * from departments;
select * from locations;

--ex3) 뷰에 제약조건 달기
--사원테이블에서 업무ID  'IT_PROG'인 사원들의 사원번호, 이름, 업무ID만 v_view5 뷰 테이블을
--단, 수정 불가의 제약조건을 추가 하시오
create or replace view v_view5
as select 
	employee_id, 
	last_name, 
	job_id
from employees
where job_id='IT_PROG'
with read only;

delete from v_view5;
--SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.

update v_view5 set last_name='홍길동' where employee_id=103;
--SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.

--ex4) 사원테이블에서 업무ID 'IT_PROG'인 사원들의 사원번호, 이름, 이메일, 입사일, 업무ID만 v_view6 뷰 테이블을 작성하시오
--단, 업무ID가 'IT_PROG'인 사원들만 추가, 수정할 수 있는 제약조건을 추가하시오
create or replace view v_view6
as select
	employee_id, 
	last_name, 
	email,
	hire_date,
	job_id
from employees
where job_id='IT_PROG'
with check option;

insert into v_view6(employee_id, last_name, email, hire_date, job_id)
values(500,'kim','candy','2004-01-01','Sales'); 
--with check option제약조건에 위배

update v_view6 set job_id='Sales' where employee_id=103;
--에러:with check option제약조건에 위배

insert into v_view6(employee_id, last_name, email, hire_date, job_id)
values(500,'kim','candy','2004-01-01','IT_PROG');

select * from v_view6;

delete from v_view6;
--ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found

--[문제4] 다음의 조건에 맞게 테이블, 시퀀스, 뷰 객체를 작성하시오
--1) bookshop 테이블 작성한 후 데이터를 입력하시오
create table bookshop(
    isbn varchar2(10) constraint PISBN primary key,
    title varchar2(50) constraint CTIT not null,
    author varchar2(50),
    price number,
    company varchar2(30)
);
select * from bookshop;
insert into bookshop values(
    'is001',
    '자바3일완성',
    '김자바',
    '25000',
    '야메루출판사'
);
insert into bookshop values(
    'pa002',
    'JSP달인되기',
    '이달인',
    '28000',
    '공갈닷컴'
);
insert into bookshop values(
    'or003',
    '오라클무작정따라하기',
    '박따라',
    '23500',
    '아메루출판사'
);
select constraint_name, constraint_type, table_name
from user_constraints
where table_name = 'BOOKSHOP';
--2) bookorder 테이블 작성하시오 
create table bookorder (
    idx number primary key,
    isbn varchar2(10),
    constraint FKISBN FOREIGN KEY(isbn) REFERENCES bookshop,
    qty number
);
select constraint_name, constraint_type, table_name
from user_constraints
where table_name = 'BOOKORDER';
--3) 시퀀스 객체 작성하기
CREATE SEQUENCE idx_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;
--4) bookorder 테이블에 데이터를 입력하시오 
select * from bookorder;
insert into bookorder values(
    idx_seq.NEXTVAL,
    'is001',
    '2'
);
insert into bookorder values(
    idx_seq.NEXTVAL,
    'or003',
    '3'
);
insert into bookorder values(
    idx_seq.NEXTVAL,
    'pa002',
    '5'
);
insert into bookorder values(
    idx_seq.NEXTVAL,
    'is001',
    '3'
);
insert into bookorder values(
    idx_seq.NEXTVAL,
    'or003',
    '10'
);
--5) 뷰 객체를 작성하시오
--조건1) 컬럼명 지정 (책제목, 저자, 총판매금액)
--조건2) 총판매금액은 qty * price로 하시오
--조건3) 수정불가의 제약조건을 추가하시오
--조건4) 책제목이 같은 것은 묶어서 출력하시오
--조건5) 총판매금액은 3자리마다 ,를 넣으시오
select * from bookshop;
select * from bookorder;

create or replace view bs_view
as select
    title 책제목,
    author 저자,
    to_char(sum(price * qty), '999,999,999') || '원' 총판매금액
from bookshop
join bookorder using(isbn)
group by title, author
with read only;

select * from bs_view;

--ex5) 뷰 - 인라인
--사원테이블을 가지고 부서별 평균급여를 뷰(v_view7)로 작성하시오
--조건1) 반올림해서 100단위까지 구하시오
--타이틀은 부서ID, 부서평균
--부서별로 오름차순 정렬 하시오
--부서ID가 없는 경우 5000으로 표시하시오
create or replace view v_view7("부서ID", "부서평균")
as select
	nvl(department_id, 5000),
	round(avg(salary), -3)
from employees
group by department_id
order by department_id asc;

select * from v_view7;

select 부서ID, 부서평균
from 
	(select nvl(department_id, 5000) "부서ID", 
    round( avg(salary), -3) "부서평균"
from employees
group by department_id
order by department_id asc);

--[문제5] 
--5-1. 부서별 최대급여를 받는 사원의 부서명, 최대급여를 출력하시오

as select
    department_name as 부서명,
    max(salary) as 최대급여
from employees
join departments using(department_id)
group by department_name;
--5-2. 1번 문제에 최대급여를 받는 사원의 이름도 구하시오
select * from employees;
select * from departments;

select
    department_name as 부서명,
    max(salary) as 최대급여
from employees
join departments using(department_id)
group by department_name
union
select
    last_name as 이름,
    null
from employees;

--[문제5] 
--5-1. 부서별 최대급여를 받는 사원의 부서명, 최대급여를 출력하시오
--5-2. 1번 문제에 최대급여를 받는 사원의 이름도 구하시오
select
    이름,
    부서명,
    최대급여
from (select 
            last_name as 이름,
            department_name  as 부서명,
            salary as 최대급여
        from employees
        join departments using(department_id)
        where (department_id, salary) 
        in(select department_id, max(salary) from employees 
        group by department_id));
        
--[문제6] 사원들의 연봉을 구한 후 최하위 연봉자 5명을 추출하시오
--조건1) 연봉 = 급여*12+(급여*12*커미션)
--조건2) 타이틀은 사원이름, 부서명, 연봉
--연봉은 ￦25,000 형식으로 하시오
select * from
(select rownum rn, tt.* from
(select 
    last_name as 사원이름,
    department_name as 부서명,
    to_char((salary * 12 + (salary * 12 * nvl(commission_pct, 0))), 'L999,999') as 연봉 
    from employees 
    join departments using(department_id)
    order by 3 asc)tt
) where rn <= 5;

select 
    사원이름,
    부서명,
    연봉
from
(select rownum, ceil(rownum/5) as page, tt.* from
(select
    last_name as 사원이름,
    department_name as 부서명,
    to_char((salary * 12 + (salary * 12 * nvl(commission_pct, 0))), 'L999,999') as 연봉 
    from employees 
    join departments using(department_id)
    order by 3 asc)tt
) where page = 1;