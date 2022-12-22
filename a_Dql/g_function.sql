#function
#1.문자 관련 함수
#length, char_length, substr, instr, concat, replace, trim, lpad, rpad
select length('멀티캠퍼스'), length('multicampus'),
char_length('멀티캠퍼스'), char_length('multicampus')
from dual;

#substr
select substr('multicampus',2);
select substr('multicampus',2,4);
select substr('multicampus',-5);
select substr('multicampus',-5,4);
select substr('multicampus'From 1 for 7);

#employee 테이블에서 성별이 남자인 직원들만 조회하세요
select emp_name
from employee
where substr(emp_no,8,1)in(1,3) ; 
#60년대생
select emp_name
from employee
where substr(emp_no,1,2) like '6%';

#instr
select instr('multicampus mysql', 'A');

#employee 테이블에서 사원들의 이름, 이메일,이메일 아이디를 조회하세요
select emp_name,email, substr(email,1,instr(email,'@')-1)
from employee;

#concat
select concat('multicampus ', 'mysql ', 'easy');

#replace
select replace('MultiCampus MySQL','M','AGG');

#trim
select trim(' multicampus  ');
select trim('z' from 'zzzzzzzzzzzzzzmulticampuszzzzz');
select trim(leading 'z' from 'zzzzzzzzzzzzzzmulticampuszzzzz');
select trim(trailing 'z' from 'zzzzzzzzzzzzzzmulticampuszzzzz');
select trim(both 'z' from 'zzzzzzzzzzzzzzmulticampuszzzzz');

#lpad, rpad
select lpad('multicampus', 20, '#');
select rpad('multicampus', 20, '#');
select rpad(email, 30, '#') from employee;

#EMPLOYEE 테이블에서 사원명과 주민번호를 조회하시오
#단 주민번호는 생년월일까지만 표시하고 '-'  다음 자리수는 모두 '*'로 바꿔 출력하시오
# EX) 001111-1111111 => 001111-*******
# 3가지 방법으로 풀어보십시오
select emp_name,  rpad(substr(emp_no,1,instr(emp_no,'-')), 14, '*') from employee;
select emp_name , rpad(substr(emp_no From 1 for 7 ) ,14, '*') from employee;
select emp_name, replace(emp_no, substr(emp_no,8),'*******') from employee;
select emp_name, concat(substr(emp_no,1,7),'*******')from employee;

#2. 숫자관련 함수
#abs, mod, floor, round, ceil, truncate

#abs
select abs(-100);
#mod
select mod(10, 3);
#floor
select floor(10.55);
#round
select round(10.55);
select round(10.55,1);
select round(15.55,-1);
#ceil
select ceil(10.15);
#truncate
select truncate(10.55,1);
select truncate(15.55,-1);

#3.날짜 관련 함수
#now, datediff, date_add, date_sub, timestampdiff, date, month, year
#now
select now();
#date_add
select date_add(now(), interval'1 1:1:1' day_second);
#date_sub
select date_sub(now(), interval'1 1:1:1' day_second);
#employee 테이블에서 사원들의 입사일로부터 30개월 이후의 날짜를 조회하시오
select emp_name , hire_Date, date_add(hire_date, INTERVAL 30 month) from employee;
#datediff
#employee 테이블에 사람들의 근무일자를 구해보자
#퇴사한 사람빼고
select emp_name, datediff(now(),hire_date)
from employee
where ENT_YN = 'N';
#employee 테이블에 사람들의 근무년수를 구해보자
#퇴사한 사람빼고
select emp_name, timestampdiff(year, hire_Date, now())
from employee
where ENT_YN = 'N';
#year, month, day, hour, minute, second
select
year(now())
,month(now())
,day(now())
,hour(now())
,minute(now())
,second(now());

#형변환 함수
#cast
select cast(now() as date);
select cast(now() as year);
select cast(cast('2022-12-21' as datetime) as time);

#null 처리함수
#ifnull
select emp_name, salary*12 as 연봉, salary * (1+bonus) *12 '총 연봉'
from employee
where DEPT_CODE = 'D5' and SALARY >=3000000;

#case-when-then
#표현식
#case when 조건식 then 결과값
#     when 조건식 then 결과값
#     when 조건식 then 결과값
#     when 조건식 then 결과값
#else
#end
select emp_name, sal_level
, case when salary >= 6000000 and salary <= 10000000 then 'S1'
	when salary >= 5000000 then 'S2'
    when salary >= 4000000 then 'S3'
    when salary >= 3000000 then 'S4'
    when salary >= 2000000 then 'S5'
    when salary >= 1000000 then 'S6'
    else 'S7'
end as sal_level2
from employee;
