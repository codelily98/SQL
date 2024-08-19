set serveroutput on;
begin
    dbms_output.put_line('Hello PL/SQL!!');
end;
/
DECLARE
    V_NO DEPARTMENTS.DEPARTMENT_ID%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_NO : ' || V_NO);
END;
/

declare
    v_dept departments%rowtype;
begin
    select department_id, 
           department_name,
           manager_id,
           location_id
    into v_dept
    from departments 
    where department_id = 50;
    
    dbms_output.put_line('department_id : ' || v_dept.department_id);
    dbms_output.put_line('department_name : ' || v_dept.department_name);
    dbms_output.put_line('manager_id : ' || v_dept.manager_id);
    dbms_output.put_line('location_id : ' || v_dept.location_id);
end;
/

select * from departments;
/

declare
    pi constant number := 3.141592;
    apple varchar2(10) default '사과';
    id varchar2(10) not null := 'hong';
    pwd varchar2(10) not null default '1234';
begin
    dbms_output.put_line('pi : ' || pi);
    dbms_output.put_line('apple : ' || apple);
    dbms_output.put_line('id : ' || id);
    dbms_output.put_line('pwd : ' || pwd);
end;
/

declare
    num number := 15;
begin
    if mod(num, 2) = 1 then
        dbms_output.put_line(num || '는 홀수이다.');
    end if;
end;
/

declare
    num number := 16;
begin
    if mod(num, 2) = 0 then
        dbms_output.put_line(num || '는 짝수이다.');
    else
        dbms_output.put_line(num || '는 홀수이다.');
    end if;
end;
/

declare
    score number := 87;
begin
    if score >= 90 then
        dbms_output.put_line('A 학점');
    elsif score >= 80 then
        dbms_output.put_line('B 학점');
    elsif score >= 70 then
        dbms_output.put_line('C 학점');
    elsif score >= 60 then
        dbms_output.put_line('D 학점');
    else
        dbms_output.put_line('F 학점');
    end if;
end;
/

declare
    score number := 87;
begin
    case trunc(score/10)
        when 9 then dbms_output.put_line('A 학점');
        when 8 then dbms_output.put_line('B 학점');
        when 7 then dbms_output.put_line('C 학점');
        when 6 then dbms_output.put_line('D 학점');
        else dbms_output.put_line('F 학점');
    end case;
end;
/

declare
    score number := 87;
begin
    case
        when score >= 90 then dbms_output.put_line('A 학점');
        when score >= 80 then dbms_output.put_line('B 학점');
        when score >= 70 then dbms_output.put_line('C 학점');
        when score >= 60 then dbms_output.put_line('D 학점');
        else dbms_output.put_line('F 학점');
    end case;
end;
/

declare
	num number := 0;
begin
	loop
			dbms_output.put_line(num);
			num := num + 1;
			exit when num > 4;
		end loop;
end;
/

declare
    num number := 0;
begin
    while num < 4 loop
        dbms_output.put_line(num);
        num := num + 1;
        exit when num > 4;
    end loop;
end;
/

begin
    for i in 0..4 loop
        dbms_output.put_line(i);
    end loop;
end;
/

begin
    for i in reverse 0..4 loop
        dbms_output.put_line(i);
    end loop;
end;
/

begin
    for i in 0..4 loop
        continue when mod(i, 2) = 1;
        dbms_output.put_line(i);
    end loop;
end;
/

--[문제] 1~10 까지의 숫자 중에서 홀수만 출력하고, 홀수의 합을 구하시오
declare
    sum_i number := 0;
begin
    for i in 1..10 loop
        if mod(i, 2) = 1 then
            dbms_output.put_line(i);
            sum_i := sum_i + i;
        end if;
    end loop;
    dbms_output.put_line(sum_i);
end;
/