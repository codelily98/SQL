--create table member(
--name varchar2(15) not null, -- 중복가능
--id varchar2(30) primary key, -- 중복안됨(무결성 제약조건), not null
--pwd varchar2(50) not null, 
--phone varchar2(20) unique  -- 중복안됨
--primary key, unique
--ORA-00001: 무결성 제약 조건(C##JAVA.SYS_C008351) 



commit;

select * from member;

select * from school;

delete member;

drop table member PURGE;

update member set name = '111', pwd = '111', phone = '010-1212-1212' where id = 'hong';

--school 테이블 생성
create table school (
name varchar2(15)  not  null, -- 이름
value varchar2(15),  -- 학번 or 과목 or 부서
code number -- 1이면 학생, 2이면 교수, 3이면 관리자
);

--1부터 1씩 증가는 board_java_seq 시퀀스 생성
create sequence board_java_seq nocache;

create table board_java (
seq number,
id varchar2(30), -- 아이디
name varchar2(15)  not  null, -- 이름
subject varchar2(100) unique,  -- 제목
content varchar2(500), -- 내용
logtime date -- 날짜
);

select * from board_java;

commit;