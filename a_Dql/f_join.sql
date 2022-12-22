#join
#관계형 데이터베이스에서는 데이터의 중복을 최소화하고, 이상현상을 방지하기 위해
#연관된 데이터들을 분리하여 저장하도록 설계한다.
#필요할때 테이블간 join 을통해 원하는 형태의 데이터를 조회한다.

#모든 직원 직원번호, 이름  , 부서코드, 부서명을 조회
select EMP_NAME, emp_id, DEPT_CODE ,(select DEPT_TITLE from department where DEPT_ID =e.DEPT_CODE) as 부서명
from employee e;

select *
from employee e
join department d on (e.DEPT_CODE = d.DEPT_id);

#join
# cross join, inner join, outer join(left join, right join, full outer join)
#cross join: join 조건절의 결과가 무조건 참인 join

select * 
from employee cross join department
order by emp_id;

#inner join(equals join, 등가 조인)
#사번,이름,직급코드,직급명을 출력하시오
select emp_id, emp_name, e.job_code, job_name
from employee e
join job j on(e.JOB_CODE = j.JOB_CODE);

select *
from employee
join job using(JOB_CODE);

#여러 테이블 join 하기
#모든 사원들의 사번, 이름, 부서명, 근무지이름을 출력하시오
select emp_id, emp_name, dept_title, local_name
from employee
join department on(DEPT_CODE = DEPT_ID)
join location on(LOCATION_ID = LOCAL_CODE);

#asia 지역에서 근무하는 급여 500만원 미만의 직원들을 조회.
#asia지역: asia1, asia2, asia3
select emp_name, salary, local_name
from employee
join department on(DEPT_CODE = DEPT_ID)
join location on(LOCATION_ID = local_code)
where SALARY < 5000000 and
LOCAL_NAME like 'ASIA%';

#outer join
#특정 테이블을 기준으로 join을 수행
#특정 테이블을 기준으로 join 조건절이 false를 반환하더라도 특정 테이블의 컬럼은 result set에 포함시킨다.
# left join, right join, full outer join
# 부서별 사원수를 조회해보자.
select dept_id, dept_title,count(EMP_ID)
from department
left join employee on(DEPT_CODE = DEPT_ID)
group by DEPT_id, DEPT_TITLE
order by DEPT_id;

#full outer join
#union 합집합
select dept_id, dept_title,count(EMP_ID)
from department
left join employee on(DEPT_CODE = DEPT_ID)
group by DEPT_id, DEPT_TITLE
union
select dept_id, dept_title,count(EMP_ID)
from department
right join employee on(DEPT_CODE = DEPT_ID)
group by DEPT_id, DEPT_TITLE
order by DEPT_id;

#self join : 자기 자신과 join
#employee 테이블에서 이름, 부서코드, 관리자 사번, 관리자 이름을 출력하세요
select E.emp_name, dept_code, manager_id
,(select emp_name from employee where emp_id = E.manager_id)
from employee E;

select E.emp_name, e.dept_code, e.manager_id, e2.emp_name
from employee e
left join employee e2 on(E2.EMP_ID = E.MANAGER_ID)
order by e2.emp_name 

