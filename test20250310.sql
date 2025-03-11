-- 1. 학년의 평균 몸무게가 70보다 큰 학년의 학년와 평균 몸무게 출력하기
SELECT grade, AVG(weight) FROM student 
GROUP BY grade 
HAVING AVG(weight) > 70

-- 2. 학년별로 평균체중이 가장 적은 학년의   학년과 평균 체중을 출력하기
SELECT grade, avg(weight) FROM student GROUP BY grade
HAVING avg(weight) <=ALL 
(SELECT avg(weight) FROM student GROUP BY grade)

-- 3. 전공테이블(major)에서 공과대학(deptno=10)에 소속된  학과이름을 출력하기
SELECT code,NAME,part FROM major
WHERE part IN 
(SELECT m1.CODE FROM major m1, major m2 WHERE m1.part = m2.CODE
                and m2.name='공과대학')
-- m1.CODE : 공과대학의 하위 학부코드값

-- 4. 자신의 학과 학생들의 평균 몸무게 보다 
-- 몸무게가 적은 학생의 학번과,이름과, 학과번호, 몸무게를 출력하기

SELECT studno,NAME, major1, weight
FROM student s1
WHERE weight < 
 (SELECT AVG(weight) FROM student s2 WHERE s2.major1 = s1.major1)

 
-- 5. 학번이 220212학생과 학년이 같고 키는 
--  210115학생보다 큰 학생의 이름, 학년, 키를 출력하기
SELECT NAME, grade, height
FROM student
WHERE grade = (SELECT grade FROM student WHERE studno=220212)
 AND height > (SELECT height FROM student where studno = 210115)

-- 6. 컴퓨터정보학부에 소속된 모든 학생의 학번,이름, 학과번호, 학과명 출력하기
SELECT s.studno, s.name, s.major1, m.name
FROM student s, major m
WHERE s.major1 = m.code
 AND s.major1 IN (SELECT CODE FROM major WHERE part = 100)

SELECT s.studno, s.name, s.major1, m.name
FROM student s, major m
WHERE s.major1 = m.code
 AND s.major1 IN
  (SELECT m1.CODE FROM major m1, major m2 
   WHERE m1.part = m2.code AND  m2.name='컴퓨터정보학부')

-- 7. 4학년학생 중 키가 제일 작은 학생보다  키가 큰 학생의 학번,이름,키를 출력하기
SELECT studno, NAME, height FROM student
WHERE height > (SELECT MIN(height) FROM student WHERE grade = 4)

SELECT studno, NAME, height FROM student
WHERE height >ANY (SELECT height FROM student WHERE grade = 4)


-- 8. 학생 중에서 생년월일이 가장 빠른 학생의  학번, 이름, 생년월일을 출력하기
SELECT studno, NAME, birthday FROM student
WHERE birthday = (SELECT MIN(birthday) FROM student)

-- 9. 학년별  생년월일이 가장 빠른 학생의 학번, 이름, 생년월일,학과명을 출력하기
SELECT s.studno,s.NAME,s.birthday, m.NAME 
FROM student s, major m
WHERE s.major1 = m.code
AND (s.grade,s.birthday) IN (SELECT grade , MIN(birthday) FROM student GROUP BY grade)

-- 10. 학과별 입사일 가장 오래된 교수의 교수번호,이름,입사일,학과명 조회하기
SELECT p.no,p.name, p.hiredate,m.name FROM professor p, major m
WHERE p.deptno = m.code
AND (p.deptno,p.hiredate) IN (SELECT deptno, mIN(hiredate) FROM professor GROUP BY deptno)

-- 11. 4학년학생 중 키가 제일 작은 학생보다  키가 큰 학생의 학번,이름,키를 출력하기

select studno, name, height from student 
where height>(select min(height) from student where grade=4)
order by studno

select studno, name, height from student 
where height >any (select height from student where grade=4)
order by studno

-- 12. 학년별로 평균키가 가장 적은 학년의  학년과 평균키를 출력하기
SELECT grade, avg(height) FROM student GROUP BY grade
HAVING avg(height) <=ALL 
(SELECT avg(height) FROM student GROUP BY grade)

-- 13. 학생의 학번,이름,학년,키,몸무게,학년의 최대키, 최대몸무게 조회하기
SELECT s.studno,s.name,s.grade, s.height,s.weight,
 (SELECT MAX(height) FROM student s2 WHERE s.grade = s2.grade) 최대키,
 (SELECT MAX(weight) FROM student s2 WHERE s.grade = s2.grade) 최대몸무게
FROM student s
 
-- 14. 교수번호,이름,부서코드,부서명,자기부서의 평균급여, 평균보너스 조회하기
--    보너스가 없으면 0으로 처리한다.
SELECT p.no,p.name, p.deptno,m.name, 
  (SELECT AVG(salary) FROM professor p2 WHERE p2.deptno = p.deptno) 평균급여,
  (SELECT AVG(IFNULL(bonus,0)) FROM professor p2 WHERE p2.deptno = p.deptno) 평균보너스
FROM professor p , major m
where p.deptno = m.code 

SELECT p.no,p.name, p.deptno,
  (SELECT NAME FROM major m WHERE m.code = p.deptno) 부서명,
  (SELECT AVG(salary) FROM professor p2 WHERE p2.deptno = p.deptno) 평균급여,
  (SELECT AVG(IFNULL(bonus,0)) FROM professor p2 WHERE p2.deptno = p.deptno) 평균보너스
FROM professor p

-- 15. test6 테이블 생성하기
-- 컬럼 : seq : 숫자,기본키,자동증가
--        name : 문자형 20문자
--        birthday : 날짜만

CREATE TABLE test6(
  seq INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(20),
  birthday date
)
DESC test6








