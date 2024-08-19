--휴지통 비우기
PURGE RECYCLEBIN;

--SELECT
--INSERT
--DELETE
--UPDATE
--COMMIT → 트렌젝션
--SELECT
--INSERT
--DELETE
--UPDATE
--ROLLBACK → COMMIT 이전으로 복구

drop table 연산;

--휴지통 확인
select * from tab;
select * from recyclebin;

--table 복구 
flashback table 연산 to before drop;
select * from 연산;

--table 완전 삭제(휴지통 x)
drop table dbtest purge;

create sequence test ;
drop sequence test;

--1부터 9까지 2씩 증가하고 cache 사이즈가 없는 테스트 시퀀스 만들기
create sequence test increment by 2 start with 1 maxvalue 9 cycle nocache;
select test.nextval from dual;
select test.currval from dual;
select * from user_sequences;

delete dbtest;
commit;

select * from dbtest;

update dbtest set age = age + 1 where name like '%김%';
--틀린정보 업데이트 시 LOCK
--LOCK 해제 commit
commit;


