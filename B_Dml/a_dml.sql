# DML(Data manipulation language) : 데이터 조작어
# 테이블에 데이터를 추가(insert), 수정(update), 삭제(delete)

# insert
# 테이블에 새로운 행을 추가하는 구문
# insert into 테이블명(컬러명...) values(값...);
# 명시되지 않은 컬럼에는 null이 들어가게 된다.
# 만약 모든 컬럼에 값을 넣는다면, 컬럼명 작성은 생략할 수 있다.
#    insert into 테이블명 values(모든 컬럼에 대한 값...);

# 인턴 직급을 추가해보자.
# job_code : 'J8', job_name : '인턴'
insert into job(job_code, job_name) values('J8', '인턴');

# job_code : 'J9', job_name : '알바'
insert into job values('J9', '알바');
select * from job;

# 서브쿼리로 데이터 추가
CREATE TABLE EMP_DEPT(
   EMP_ID VARCHAR(3)
    ,EMP_NAME VARCHAR(20)
    ,DEPT_TITLE VARCHAR(25)
);

# 직급이 'J5' 인 사원의 사번, 이름, 부서명을 EMP_DEPT 테이블에 추가
INSERT INTO EMP_DEPT(
   SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE 
    JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
    WHERE JOB_CODE = 'J5'
);

SELECT * FROM EMP_DEPT;

# INSERT문으로 여러 행 집어넣기
# EMP_ID : 230, EMP_NAME : 강유리, DEPT_TITLE : 개발팀
# EMP_ID : 231, EMP_NAME : 경제원, DEPT_TITLE : 개발팀
INSERT INTO EMP_DEPT VALUES('230', '강유리', '개발팀'),('231', '경제원', '개발팀');
COMMIT;

#############################################################################
# UPDATE
# 테이블에 저장된 데이터를 수정하는 구문
# [] : OPTIONAL
# UPDATE 테이블명 SET 컬럼명=변경값[,컬럼명=변경값...] [WHERE절]
# UPDATE : 1. 먼저 변경할 데이터를 SELECT문을 사용해 확인한다. 2. UPDATE문 작성이후 WHERE절 유심히 본다. 3. 개발디비에 먼저 실행해본다.
UPDATE EMP_DEPT
SET EMP_NAME = '대형사고'
WHERE EMP_ID = 207;
COMMIT;

SELECT * FROM EMP_DEPT;
ROLLBACK;

# EMPLOYEE 테이블에서 아시아지역에 근무하는 직원의 보너스를 0.3으로 조정하시오.
# ROLLBACK 처리 합니다.
update employee 
set bonus = 0.3
where dept_Code in 
(select dept_id
from department
join location on (local_code = location_id)
where LOCAL_NAME like 'ASIA%');

rollback;
select * from employee;
select * from dmp_dept;
