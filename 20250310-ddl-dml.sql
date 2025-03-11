/*
 단일행 서브쿼리 : 서브쿼리의 결과가 1개 행인 경우
         사용가능한 연산자 : =, >, <, >=,<= 

 복수행(다중행) 서브쿼리에서 사용가능한 연산자 : in,any,all 
        in : 같은 경우
        any : 결과 중 한개만 조건  만족
        all : 모두 결과가  조건 만족

 다중 컬럼 서브쿼리 : 비교 대상 컬럼이 2개인 경우

 상호연관 서브쿼리 : 외부query의 컬럼이 subquery에 영향을 주는 query
                      성능이 안좋다.

DDL : Data Definition Language (데이터 정의어)
        객체의 구조를 생성,수정,제거하는 명령어
      create : 객체 생성 명령어
		   table 생성 : create table  
		   user 생성  : create user
		   index 생성  : create index
		   ....
		alter : 객체 수정 명령어. 컬럼 추가, 컬럼제거, 컬럼크기변경...
		   컬럼 추가 : alter table 테이블명 add 컬럼명 자료형
		   컬럼 크기 변경 : alter table 테이블명 modify 컬럼명 자료형
		   컬럼 이름 변경 : alter table 테이블명 change 원본컬럼명 새로운컬럼명 자료형
		   컬럼 제거 : alter table 테이블명 drop 컬럼명
		   제약조건 추가: alter table 테이블명 add constraint .... 
		   제약조건 제거: alter table 테이블명 drop constraint 제약조건 이름
		   
		제약조건 조회
		  information_schema 데이터베이스 선택
		  table_constraints 테이블 조회하기
*/
USE information_schema
SELECT * FROM table_constraints
WHERE TABLE_NAME = "professor_101"
USE gdjdb
-- 제약조건 제거하기
-- 외래키 제거
ALTER TABLE professor_101 DROP FOREIGN KEY professor_101_ibfk_1
ALTER TABLE professor_101 DROP FOREIGN KEY professor_101_ibfk_2
-- 기본키 제거
ALTER TABLE professor_101 DROP PRIMARY KEY

/*
   drop 명령어 : 객체 제거
*/
SHOW tables
DESC test1
-- test1 테이블을 제거하기
DROP TABLE test1
DESC test1

/*
   truncate : 테이블과 데이터 분리
*/
SELECT * FROM professor_101
-- delete 명령문 비교 : autocommit false 설정
SET autocommit=FALSE -- 자동 commit 안함
SHOW VARIABLES LIKE 'autocommit%'
SELECT * FROM professor_101
-- delete 명령어로 데이터 제거 : rollback 가능
DELETE FROM professor_101
SELECT * FROM professor_101
ROLLBACK  -- TCL 트랜젝션 실행 취소
SELECT * FROM professor_101

-- truncate로 데이터 제거


