# subquery
# sql query 안에 포함된 또다른 select 문
# subquery의 분류
# 1.사용 위치에 따른 분류
# select절 :스칼라(단일값) 서브쿼리
# from 절  : inline view
# where, having :subquery

# 2. 서브쿼리의 결과에 따른 분류
# 단일행, 단일열, 다중행, 다중열

#부서코드가 노옹철사원과 같은 직원명단을 조회하시오
# 쿼리를 여러개 작성해도 무방

select  emp_name
from employee
where DEPT_CODE = (select dept_code from employee where emp_name = '노옹철');

#단일행, 단일열 서브쿼리
#비교 연산자 사용
select emp_name,(select dept_code from employee where EMP_NAME = '노옹철')
from employee;
#다중행 서브쿼리
#서브쿼리의 조회결과 행이 여러개인 서브쿼리
#비교연산자 + in, any, all, exists 연산자와 조합해 사용

#IN
# 최대 급여가 4999999보다 적은급여등급을 가지고 있는 직원을 조회
select sal_level from sal_grade where max_Sal < 4999999;
select emp_name, sal_level
from employee
where sal_level in  (select sal_level from sal_grade where max_Sal < 4999999);

#ANY
#서브쿼리의 결과값과 컬럼값간의 비교연산 결과가 하나라도 true가 된다면 true
#박나라가 속한 부서 사람들의 급여 레벨에 속하는 사원들의 정보를 출력해보자
# where 1 > any ( 0.1, 100, 200 , 300) ==true
select distinct sal_level from employee 
where dept_code = (select dept_Code from employee where emp_name = '박나라');
select emp_name, sal_level
from employee
where sal_level = any(select distinct sal_level from employee 
where dept_code = (select dept_Code from employee where emp_name = '박나라'));


#박나라보다 속한 부서의 사람들 중 가장 많은 연봉을 받는 사람보다 많은 연봉을 받는 사람을 구해보자
select emp_name, emp_id
from employee
where salary > any(select SALARY from employee where dept_code = (select dept_Code from employee where emp_name = '박나라'));

#ALL
#서브쿼리의 결과값들과 컬럼값을 비교연산 했을 때 모두 true 면 true
select emp_name, salary
from employee
where salary > all(select SALARY from employee where dept_code = (select dept_Code from employee where emp_name = '박나라'));
#exists : subquery 의 결과가 있으면 true 없으먄 false
#선동일을 매니저로 두고있는 사원을 조회
select emp_id, emp_name, manager_id
from employee E
where exists (select emp_id from employee where MANAGER_ID = E.EMP_ID);



#상관쿼리(상호연관쿼리)
#메인쿼리에서 사용한 컬럼값을 서브쿼리 에서도 사용하는 쿼리
#메인 쿼리의 컬럼값이 변경이 되면 서브쿼리의 결과값도 바뀐다
#상관쿼리를 사용하려면 참조를 위한 레퍼런스가 필요하다.메인 쿼리의 from 절에 별칭을 지정한다.

select emp_id, emp_name, manager_id
from employee E
where exists (select emp_id from employee where MANAGER_ID = e.EMP_ID);

# IN을 사용해서 위와 같은 결과를 반환하는 쿼리를 작성
select emp_id, emp_name, manager_id
from employee E
where emp_id in (select manager_id from employee );

#퇴사한 직원이 존재하는 부서의 사원 중에서
#퇴사한 사원과 같은 직급인 사원의 이름, 직급, 부서를 조회
select DEPT_CODE, emp_name, job_code
from employee
where DEPT_CODE in (select DEPT_CODE
from employee
where ENT_YN = 'Y')
 and job_code in (select job_code
from employee
where ENT_YN = 'Y')  ;

#다중열 서브쿼리
#서브쿼리의 열이 여러개인 경우
select emp_name, job_code, dept_code
from employee
where JOB_CODE(dept_code,job_code) in(select dept_code,JOB_CODE from employee where ent_yn = 'Y');

# 인라인뷰
#from 절에서 사용하는 서브쿼리
#mysql에서는 인라인뷰에 반드시 별칭을 붙여야함
select *
from (select emp_id, emp_name, dept_code,JOB_CODE
from employee where JOB_CODE ='J6')a;