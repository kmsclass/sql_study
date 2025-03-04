-- desc : 테이블의 구조(스키마) 조회
-- desc 테이블명
DESC dept

-- SQL : Structured Query Language : 관계형 데이터베이스(RDBMS)에서
--       데이터 처리를 위한 언어.
-- select : 데이터 조회를 위한 언어
-- emp 테이블의 모든 데이터를 조회하기
SELECT * FROM emp;
-- emp 테이블의 empno,ename,deptno 컬럼의 모든 레코드를 조회하기
SELECT empno,ename,deptno FROM emp; 

-- 리터널 컬럼 사용하기 : 상수값을 사용하기
-- 학생(student)의 이름 뒤에 학생 문자열을 붙여서 조회하기
SELECT NAME,'학생'
FROM student
/*
  1. 교수테이블(professor)의 구조 조회하기
*/
DESC professor
/*
  2. 교수테이블(professor)에서 교수번호(no),교수이름(name), '교수' 문자열을 붙여서
     조회하기
*/
/*
  문자열형 상수 : 작은따옴표, 큰따옴표 동일함.
  오라클db에서는 작은따옴표만 가능함.
*/
SELECT NO,NAME,'교수' FROM professor;  
SELECT NO,NAME,"교수" FROM professor;

-- 컬럼에 별명(alias)설정하기 : 조회되는 컬러명을 변경하기
SELECT NO 교수번호,NAME 교수이름 ,'교수' FROM professor;  
SELECT NO '교수번호',NAME 교수이름 ,'교수' FROM professor;  
SELECT NO '교수 번호',NAME '교수 이름' ,'교수' FROM professor;  
SELECT NO AS '교수 번호',NAME AS '교수 이름' ,'교수' FROM professor;  

-- 컬럼에 연산자(+,-,*,/) 사용하기
-- emp 테이블에서 사원이름(ename),현재급여(salary),10%인상예상급여 조회하기
SELECT ename,salary, salary*1.1 FROM emp

-- distinct : 중복을 제거하고 하나만 조회
--            컬럼의 처음에 한번만 구현해야 함
-- 교수(professor)테이블에서 교수가 속한 부서코드(deptno)를 조회하기
SELECT distinct deptno FROM professor;
-- 교수(professor)테이블에서 교수가 속한 직급(position)를 조회하기
SELECT distinct POSITION FROM professor;
-- 교수(professor)테이블에서 부서별 교수가 속한 직급(position)를 조회하기
--  여러개의 컬럼앞의 distinct는 기술된 컬럼의 값들이 중복되지 않도록 조회함
SELECT DISTINCT deptno,DISTINCT POSITION FROM professor  -- 오류발생
SELECT DISTINCT deptno,POSITION FROM professor
/*
   select 컬럼명(컬럼,리터널컬럼,연산된컬럼,*, 별명, distinct)
   from   테이블명
   where 레코드 선택 조건. 
         조건문이 없는 경우 : 모든 레코드를 조회
         조건문이 있는 경우 : 조건문의 결과가 참인 레코드만 조회
*/
-- 학생테이블(student)에서 1학년 학생의 모든 컬럼을 조회하기
SELECT * FROM student WHERE grade = 1;
-- 학생테이블(student)에서 3학년 학생 중 전공1코드(major1)가 101인 학생의
-- 학번(studno),이름(name),학년(grade),전공1학과(major1) 컬럼 조회하기
-- 논리연산 : and, or
SELECT studno,NAME,grade,major1 
FROM student
WHERE grade=3 AND major1 = 101

-- 학생테이블(student)에서 3학년 학생 이거나 전공1코드(major1)가 101인 학생의
-- 학번(studno),이름(name),학년(grade),전공1학과(major1) 컬럼 조회하기
SELECT studno,NAME,grade,major1 FROM student
WHERE grade = 3 OR major1=101
/*
 문제
 1.emp테이블에서 부서코드가 10인 
  사원의 이름(ename),급여(salary), 부서코드(deptno) 를 결과와 같이 출력하기
*/
SELECT ename,salary,deptno
FROM emp
WHERE deptno = 10
/*
2.emp테이블에서 급여가 800보다 큰사람의 이름과 급여를 결과와 같이 출력하기
*/
SELECT ename, salary FROM emp
WHERE salary > 800
/*
3.professor 테이블에서 직급이 정교수인 교수의 
 이름과 부서코드, 직급을 결과와 같이 출력하기
*/
SELECT NAME,deptno,POSITION FROM professor
WHERE POSITION = '정교수'

-- where 조건문에 연산처리하기
-- emp테이블에서 모든 사원의 급여를 10%인상할때, 인상 예정 급여가 1000이상인
-- 사원의 이름,현재급여, 인상예정급여, 부서코드 조회하기
SELECT ename, salary,salary*1.1, deptno 
FROM emp
WHERE salary*1.1 >= 1000

--- where 조건문에서 사용되는 연산자 ---
-- between : 범위 지정 연산자
-- where 컬럼명 between A and B => 컬럼의 값이 A이상B이하인 레코드 선택
-- 학생 중 1,2 학생의 모든 컬럼을 조회하기
SELECT * FROM student WHERE grade = 1 OR grade =2;
SELECT * FROM student WHERE grade >= 1 AND grade <=2;
SELECT * FROM student WHERE grade BETWEEN 1 AND 2;

-- 문제
-- 1학년 학생 중 몸무게(weight)가 70이상 80이하인 학생의
-- 이름(name),학년(grade),몸무게(weight), 전공1학과(major1) 조회하기
-- 관계연산자 이용
SELECT NAME,grade,weight,major1 FROM student
WHERE grade = 1 AND weight >= 70 AND weight <= 80
-- between 연산자 이용
SELECT NAME,grade,weight,major1 FROM student
WHERE grade = 1 AND weight BETWEEN 70 AND 80

-- 제1 전공학과가 101번 학생 중 몸무게가 50이상 80이하인 
-- 학생의 이름(name), 몸무게(weight), 1전공학과코드(major1)를 출력하기
SELECT NAME,weight,major1 FROM student
WHERE major1 = 101 AND weight >= 50 AND weight <= 80
SELECT NAME,weight,major1 FROM student
WHERE major1 = 101 AND weight between 50 AND 80
/*
  where 조건문의 연산자 :  in 
                           or 조건문으로 표현이 가능
*/
전공1학과가 101,201 학과에 속한 학생의 모든 정보 조회하기
SELECT * FROM student WHERE major1 = 101 OR major1 = 201 
SELECT * FROM student WHERE major1 IN (101,201)

-- 교수 중 학과코드가 101,201 학과에 속한 교수의 교수번호(no),
-- 교수이름(name),학과코드(deptno),입사일(hiredate) 조회하기
SELECT NO,NAME,deptno,hiredate
FROM professor
WHERE deptno IN (101,201)

SELECT NO,NAME,deptno,hiredate
FROM professor
WHERE deptno = 101 or deptno =201

-- 101,201전공학과1 학생 중 키가 170이상인 학생의 
-- 학번(studno), 이름(name), 몸무게(weight), 키(height), 학과코드(major1) 조회하기
SELECT studno, NAME,weight,height,major1
FROM student
WHERE major1 IN (101,201) AND height >= 170

-- not in 연산자
-- 101,201전공학과1 속한  학생이 아닌 학생  중 키가 170이상인 학생의 
-- 학번(studno), 이름(name), 몸무게(weight), 키(height), 학과코드(major1) 조회하기
SELECT studno, NAME,weight,height,major1
FROM student
WHERE major1 not IN (101,201) AND height >= 170

/*
  like 연산자 : 일부분 일치
    % : 0개이상 임의의 문자
    _ : 1개의 임의의 문자
*/
-- 학생의 성이 김씨인 학생의 학번,이름,학과코드1 조회하기
SELECT studno, NAME,major1 FROM student
WHERE NAME LIKE '김%';

-- 학생의 이름 중 '진'을 가진 학생의 학번,이름,학과코드1 조회하기
SELECT studno, NAME,major1 FROM student
WHERE NAME LIKE '%진%';

-- 학생 중 이름이 2자인 학생의 학번,이름,학과코드1 조회하기
SELECT studno, NAME,major1 FROM student
WHERE NAME LIKE '__';
/*
문제
   1.학생 중 이름의 끝자가 '훈'인 학생의 학번, 이름, 전공코드1 출력하기
   2.학생 중 전화번호(tel)가 서울지역(02)인 학생의 이름, 학번, 전화번호 출력하기
*/
-- 1
SELECT studno,NAME,major1 FROM student
WHERE NAME LIKE '%훈';
-- 2
SELECT NAME,studno,tel FROM student
WHERE tel LIKE '02%'

-- 교수테이블에id 내용에 k 문자를 가지고 있는 교수의 이름,id,직급조회하기
-- like에서 대소문자 구분 안함. 오라클은 대소문자 구분함.
SELECT NAME,id,POSITION FROM professor
WHERE id LIKE '%k%'
SELECT NAME,id,POSITION FROM professor
WHERE id LIKE '%K%'
-- 대소문자 구분을 위해서는 binary 예약어를 사용함
SELECT NAME,id,POSITION FROM professor
WHERE id LIKE BINARY '%K%'
SELECT NAME,id,POSITION FROM professor
WHERE id LIKE BINARY '%k%'

-- not like 연산자 : like 반대.
-- 학생 중 성이 이씨가 아닌 학생의 학번,이름,전공코드1을 조회하기
SELECT studno,NAME,major1
FROM student
WHERE NAME NOT LIKE '이%'

/*
1. 학생의 이름 중 성이 김씨가 아닌 학생의 이름,학년, 전공1학과 조회하기
2. 교수 테이블 에서 101,201 학과에 속한 교수가 아닌 교수 중 성이 김씨가 아닌 교수의
   이름, 학과코드,직급을 조회하기
*/
-- 1
SELECT NAME, grade, major1  FROM student
WHERE NAME not LIKE '김%'
-- 2
SELECT NAME,deptno,position FROM professor
WHERE deptno not iN (101,201) AND NAME not LIKE '김%'
/*
   null 의미 : 값이 없다. 비교 대상이 안됨.
   is null     : 컬럼의 값이 null 인경우
   is not null : 컬럼의 값이 null 이 아닌경우
*/
-- 교수 중 보너스가 없는 교수의 이름(name),급여(salary),보너스(bonus) 조회하기
SELECT NAME,salary,bonus FROM professor
WHERE bonus = NULL  -- null은 비교 대상이 아님.

SELECT NAME,salary,bonus FROM professor
WHERE bonus is NULL
-- 교수 중 보너스가 있는 교수의 이름(name),급여(salary),보너스(bonus) 조회하기
SELECT NAME,salary,bonus FROM professor
WHERE bonus is not NULL
/*
  학생 중 지도교수가 없는 학생의 학번(studno),이름(name),전공학과1(major1),
  지도교수번호(profno)를 조회하기
*/
SELECT studno,NAME,major1,profno
FROM student
WHERE profno IS NULL
/*
  학생 중 지도교수가 있는 학생의 학번(studno),이름(name),전공학과1(major1),
  지도교수번호(profno)를 조회하기
*/
SELECT studno,NAME,major1,profno
FROM student
WHERE profno IS NOT  NULL
