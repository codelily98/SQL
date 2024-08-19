--[문제1] 기말고사 평균이 60점 이상인 학생의 정보를 검색하시오       
--평균은 반올림하여 소수이하 둘째자리까지 출력하시오 
--테이블 : STUDENT, SCORE 
--컬럼 : SNO, SNAME, RESULT
select * from student;
select * from score;
select
    sno as 학번,
    sname as 이름,
    result as 학점
from student
join score using(sno);
--[문제2] 기말고사 평균 성적이 핵 화학과목보다 우수한 과목의 과목명과 담당 교수명을 검색하시오 
--테이블 : STUDENT, SCORE, COURSE, PROFESSOR 
--컬럼 : CNO, CNAME, RESULT, PNO, PNAME
select * from student, score, course, professor;