--[문제1] 각 과목의 과목명과 담당 교수의 교수명을 검색하고, 과목번호로 오름차순하시오
--테이블 : COURSE, PROFESSOR
--컬럼 : CNO, CNAME, PNO, PNAME
select
    cno as 과목번호,
    cname as 과목명,
    pno as 교수번호,
    pname as 담당교수
from course
join professor using(pno)
order by cno;

--[문제2] 모든 교수의 명단과 담당 과목을 검색하시오
--테이블 : COURSE, PROFESSOR
--컬럼 : CNO, CNAME, PNO, PNAME, SECTION
SELECT
    pno AS 교수번호,
    pname AS 교수명,
    cno AS 과목번호,
    cname AS 과목명,
    section AS 학과
FROM professor
LEFT JOIN course using(pno);

--[문제3] 모든 교수의 명단과 담당 과목을 검색한다(단 모든 과목도 같이 검색한다) => UNOIN 도 사용
--테이블 : COURSE, PROFESSOR
--컬럼 : CNO, CNAME, PNO, PNAME, SECTION
select * from course;
SELECT 
    cno AS 과목번호,
    cname AS 과목명,
    pno AS 교수번호,
    pname AS 교수명,
    section AS 학과
FROM 
    professor
LEFT JOIN 
    course using(pno)
UNION
SELECT 
    cno AS 과목번호,
    cname AS 과목명,
    pno AS 교수번호,
    NULL AS 교수명,
    NULL AS 학과
FROM 
    course
WHERE 
    pno IS NULL;

--[문제4] 근무 중인 직원이 4명 이상인 부서를 검색하세요
--테이블 : DEPT, EMP
--컬럼 : DNO, DNAME, 직원수
select * from emp;
select * from dept;
SELECT 
    DNO AS 부서번호,
    DNAME AS 부서명,
    COUNT(ENO) AS 직원수
FROM 
    DEPT
JOIN 
    EMP using(dno)
GROUP BY 
    DNO, DNAME
HAVING 
    COUNT(ENO) >= 4;

--[문제5] 강의 학점이 3학점 이상인 교수의 정보를 검색하세요
--테이블 : PROFESSOR, COURSE 
--컬럼 : PNO, A.PNAME, SUM(B.ST_NUM)
select * from professor;
select * from course;
SELECT 
    PNO AS 교수번호,
    PNAME AS 교수명,
    SUM(ST_NUM) AS 총학점
FROM 
    PROFESSOR
JOIN 
    COURSE using(pno)
WHERE 
    ST_NUM >= 3
GROUP BY 
    PNO, PNAME;