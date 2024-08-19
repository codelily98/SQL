 --[SQL 문제]
--형변환 사용
select
    sum(price) as 판매액
from sellings
where to_char(created_at, 'YYYY-MM') = '2016-11';

--like 사용
select
    sum(price) as 판매액
from sellings
where created_at like '%11%';

--1. 유공과와 생물과, 식영과 학생을 검색하고 오름차순으로 정렬하시오(in)
--테이블 : STUDENT
select
    sname as 이름,
    major as 학과
from student
where major in('유공', '생물', '식영')
order by major;

--2. 평점이 2.0에서 3.0사이인 학생을 검색하시오 (BETWEEN ~ AND 사용)
--테이블 : STUDENT
select
    sname as 이름,
    major as 학과,
    avr as 평점
from student
where avr between 2.0 and 3.0;

--3. 성과 이름이 각각 1글자인 교수를 검색하라
--테이블 : PROFESSOR
select
    pno as 교수번호,
    pname as 이름,
    section as 학과,
    orders as 직함,
    hiredate as 고용일
from professor
where pname like '__';
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--GROUP BY / HAVING
--문제1) 화학과를 제외하고 학과별로 학생들의 평점 평균을 검색하시오 (GROUP, HAVING)
--평균을 소수이하 2째 자리에서 반올림
--테이블 : STUDENT
select
    major as 학과,
    to_char(round(avg(avr), 2)) as "평균 학점"
from student
group by major
having major != '화학';

--문제2) 화학과를 제외한 각 학과별 평균 평점 중에 평점이 2.0 미만인 정보를 검색하시오
--테이블 : STUDENT
select
    major as 학과,
    to_char(round(avg(avr), 2)) as "평균 학점"
from student
group by major
having major != '화학' and round(avg(avr), 2) < 2.0;

--JOIN
--문제1) 화학과 1학년 학생의 기말고사 성적을 검색하시오
--테이블 : STUDENT ST, SCORE SC, COURSE CO
--컬럼 : SNO, SNAME, MAJOR, SYEAR, CNO, CNAME, RESULT
select * from student;
select * from score;
select * from course;

select
    sno as 학번,
    sname as 이름,
    sex as 성별,
    syear as 학년,
    cno as 과목번호,
    cname as 과목명,
    result as "기말고사 성적"
from score
join student using(sno)
join course using(cno)
where syear = '1' and major = '화학';

--문제2) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색하시오
--테이블 : STUDENT ST, SCORE SC, COURSE CO
--컬럼 : SNO, SNAME, MAJOR, SYEAR, CNO, CNAME, RESULT
select
    sno as 학번,
    sname as 이름,
    major as  학과,
    syear as 학년,
    cno as 과목번호,
    cname as 과목명,
    result as "기말고사 성적"
from score
join student using(sno)
join course using(cno)
where syear = '1' and major = '화학' and cname = '일반화학';

--문제3) 학생중에 동명이인을 검색하여 이름으로 오름차순하고, 만약 같은 이름은 번호로 오름차순하시오
--테이블 : STUDENT
select distinct
    s.sno as 학번,
    s.sname as 이름
from student s
join student c on(s.sno != c.sno) and (s.sname = c.sname)
order by 2, 1;
    
    
