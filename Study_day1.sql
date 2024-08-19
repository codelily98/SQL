create table 연산 (x int, y number, z number(10,3)); --연산 테이블 생성
select * from 연산; --연산 테이블 선택 출력

insert into 연산(x, y, z)  values(25, 36, 12.34567); --연산 테이블 변수에 값 대입
insert into 연산(x, y, z)  values(25.34567, 36.34567, 12.34567);
insert into 연산(x, y) values(25.666, 36.88888); --integer형 출력시 반올림
insert into 연산(z, y, x) values(1, 2, 3); --순서가 바뀌어도 잘 들어간다.

--필드명 생략 가능하게 되면 필드를 빠짐없이 순서대로 입력해야한다.
insert into 연산 values(25, 36, 12.34567);
insert into 연산 values(25, 36, 1234567.3456);
insert into 연산 values(25, 36, 12345678.3456); --error

COMMIT;

rollback;

drop table dbtest;

create table dbtest(
name varchar2(15), -- VARCHAR2 → char, String
-- char(고정형) 메모리 고정
-- VARCHAR2(가변형) 남는 메모리 반환
age number(10, 2),
height number(10, 2),   
logtime date);

select * from dbtest;

insert into dbtest(name, age, height, logtime) values('홍길동' , 25, 185.567, sysdate);
insert into dbtest(name, age, height, logtime) values('Hong' , 30, 175.56, sysdate);
insert into dbtest(name, age) values('희동이', 3);
insert into dbtest(name, height) values('홍당무', 168.89);
insert into dbtest values('분홍신', 5, 123.4, sysdate);
insert into dbtest(name) values('진분홍');

select name, age, height, logtime from dbtest;
-- * 은 모든 필드를 뜻한다.
select * from dbtest where name = '홍길동';
-- 나이가 20세 이상인 레코드를 검색해라
select * from dbtest where age >= 20;
-- 이름이 'Hong'인 레코드 검색
select * from dbtest where name = 'Hong'; --명령어는 대소문자가 없지만, 데이터는 구분한다.
-- upper(), lower(); 대문자, 소문자로 변경
select * from dbtest where lower(name) = 'hong';
-- 데이터가 비어있는 레코드 검색 is null, 반대 is not null
select * from dbtest where age is null;

-- 나이가 20살 이하이면서(and) 현재 날짜가 비어있는거 
select * from dbtest where age <= 20 and logtime is null;
-- (like) 홍(%홍%)이 들어가는 이름(name) 검색 
select * from dbtest where name like '%홍%';
-- (like) 홍이 앞을 제외(_홍%)하고 들어가는 이름(name) 검색 
select * from dbtest where name like '_홍%';
-- (like) 홍이 앞에 2자리 제외(__홍%)하고 들어가는 이름(name) 검색 
select * from dbtest where name like '__홍%';

-- 이름을 기준(order by name)으로 오름차순(asc) 정렬
select * from dbtest order by name asc;
-- 이름을 기준(order by name)으로 내림차순(desc) 정렬
select * from dbtest order by name desc;
-- 현재 키가 150 이상인 레코드를 내림차순으로 검색
select * from dbtest where height >= 150 order by height desc;

-- dbtest에서 age의 값이 없는 것들을 0으로 업데이트
update dbtest set age = 0 where age is null;
select * from dbtest;
-- 날짜 데이터가 없는 컬럼을 제거해라
delete dbtest where logtime is null;

-- dbtest 제거
delete dbtest;
-- commit 이전으로 복구
rollback;

select name from dbtest;
-- name 필드 이름 지정
select name as 이름 from dbtest;
-- 같은 의미
select name 이름 from dbtest;
-- 띄어쓰기가 있을 때 "" 을 넣어준다.
select name "이 름" from dbtest;

