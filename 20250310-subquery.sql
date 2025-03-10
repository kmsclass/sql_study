/*
   join 구문 : 여러개의 테이블을 연결하여 데이터 조회.
     cross join : m*n개수로 레코드 생성. 사용시 주의요함
     등가조인 (euqi join) : 조인컬럼을 이용하여 조건에 맞는 레코드만
                            선택. 조인컬럼의 조건문이 = 인 경우
     비등가조인 (non euqi join) : 조인컬럼을 이용하여 조건에 맞는 레코드만
                            선택. 조인컬럼의 조건문이 = 이 아니 경우
     self join(자기조인) : 같은 테이블을 join 하는 경우
	                        테이블의 별명설정, 컬럼 조회시 별명 설정

     inner join : 조인컬럼을 이용하여 조건에 맞는 레코드만 선택	                        
     outer join : 조인컬럼을 이용하여 조건에 맞는 레코드만 선택. 
                  한쪽 또는 양쪽테이블에서 조건 맞지 않아도 선택
         left outer join : 왼쪽 테이블의 내용은 전부 조회
                            left join 예약어
         right outer join: 오른쪽 테이블의 내용은 전부 조회         
                            right join 예약어
         full outer join : 양쪽 테이블의 내용은 전부 조회        
                            union 사용하여 구현
*/
/*
    subquery : select 구문 내부에 select 구문이 존재함
               where 조건문에서 사용되는 select 구문
    subquery 가능 부분
	    where 조건문 : subquery
		 from         : inline 뷰
		 컬럼부분     : 스칼라 subquery           
*/
-- emp 테이블에서 김지애 사원보다 많은 급여를 받는 직원의 정보 조회하기
-- 1. 김지애 직원의 급여 조회하기
SELECT salary FROM emp WHERE ename='김지애'
-- 2. 550보다 많은 급여를 받는 직원의 정보 조회하기
SELECT * FROM emp WHERE salary > 550
-- 1,2 동시에 가능
SELECT * FROM emp 
WHERE salary > (SELECT salary FROM emp WHERE ename='김지애')
--문제 
-- 김종연 학생보다 윗학년의 이름과, 학년, 전공번호1, 학과명 출력하기
