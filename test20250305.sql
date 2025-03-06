-- 1. 교수테이블(professor)급여가 300 이상이면서 보너스(bonus)을 받거나 
--    급여가 450 이상인 교수 이름, 급여, 보너스을 출력하기.
SELECT NAME, salary, bonus FROM professor 
WHERE salary >= 300  AND bonus IS NOT NULL 
UNION
SELECT NAME, salary, bonus FROM professor 
WHERE salary >= 450

SELECT NAME, salary, bonus FROM professor 
WHERE (salary >= 300  AND bonus IS NOT NULL) OR  salary >= 450


-- 2. 교수테이블에서 보너스가 없는 교수의 교수번호, 이름, 급여,  10% 인상급여를 출력하고
--    보너스가 있는 교수는 의 급여는 인상되지 않도록 인상 예상급여를 출력하기
--     단 인상급여의 내림차순으로 정렬하기
SELECT NO,NAME,salary,salary * 1.1 인상급여 FROM professor
WHERE bonus IS NULL
UNION
SELECT NO, NAME, salary, salary FROM professor
WHERE bonus IS NOT NULL
ORDER BY 4 desc


-- 3. 학생의 생일이 97년 이후인 학생의 학번, 이름, 생일을 출력하기
SELECT studno,NAME,birthday FROM student WHERE birthday > '1996-12-31'
SELECT studno,NAME,birthday FROM student WHERE year(birthday) > 1996


-- 4. 학생 테이블을 읽어 '학생이름의 생일은 yyyy-mm-dd  입니다. 축하합니다' 형태로 출력하기
SELECT CONCAT(NAME,'의 생일은 ',birthday,' 입니다. 축하합니다')
  FROM student

-- 5. 학생 테이블에서 학생 이름과키,몸무게, 표준체중을 출력하기
--    표준 체중은 키에서 100을 뺀 값에 0.9를 곱한 값이다.
SELECT NAME,height,weight, (height-100)*0.9 표준체중 FROM student

-- 6. 101 번 학과 학생 중에서 3학년 이상인 학생의  이름, 아이디, 학년을 출력하기
SELECT NAME,id,grade FROM student WHERE major1 = 101 AND grade >= 3


-- 7. EMP 테이블에서 급여가 600에서 700 사이인 사원의  성명, 업무(job), 급여(salary), 부서번호(deptno)를 출력하여라.
SELECT ename,job,salary,deptno FROM emp
WHERE salary BETWEEN 600 AND 700


-- 8. EMP테이블에서 사원번호(empno)가 2001, 2005, 2008 인 사원의 사원번호, 성명, 업무(job), 급여, 입사일자(hiredate)를 출력하여라.
SELECT empno,ename, job,salary,hiredate FROM emp
WHERE empno IN (2001,2005,2008)


-- 9. EMP 테이블에서 사원이름의 첫 글자가 ‘주’인 사원의 이름, 급여를 조회하라.
SELECT ename,salary FROM emp WHERE ename LIKE '주%'
SELECT ename,salary FROM emp WHERE left(ename,1) = '주'
SELECT ename,salary FROM emp WHERE substr(ename,1,1) = '주'

-- 10. EMP 테이블에서 급여가 800 이상이고, 담당업무(JOB)이 차장인 
--    사원의 사원번호, 성명, 담당업무, 급여, 입사일자, 부서번호를 출력하여라.
SELECT empno,ename,job,salary,hiredate,deptno FROM emp
WHERE salary >= 800 AND  job = '차장'


-- 11. 교수테이블에서 이메일이 있는 교수의 이름, 직책,   email, emailid 를  출력하기
--     emailid는 email의 @ 앞의 문자를 의미한다
select name, position,email, substr(email,1,instr(email,'@')-1) emailid 
from professor
select name, position,email, left(email,instr(email,'@')-1) emailid 
from professor

-- 12. 101번 학과 학생의 이름 중 두번째 글자만 '#'으로 치환하여 출력하기
select name, replace(name,substr(name,2,1),'#')
from student where major1 = '101'

-- 13. 102번 학과 학생의 이름과 전화번호, 전화번호의 국번부분만#으로 치환하여 출력하기(단 국번은 3자리로 간주함.)
--     02-1234-5678 : 1234가 국번  => 02-###4-5678
select name, tel, replace(tel,substr(tel,instr(tel,')')+1,3),'###') from student
where major1 = 102

-- 13-1. 102번 학과 학생의 이름과 전화번호, 전화번호의 국번부분만 ###으로 치환하여 출력하기
--     02-1234-5678 : 1234가 국번  => 02-###-5678

SELECT NAME, tel, 
 replace(tel,substr(substr(tel,INSTR(tel,')')+1),1,INSTR(substr(tel,INSTR(tel,')')+1),'-')-1),'###')  
 FROM student
where major1 = 102



-- 14. 교수테이블의의  email 주소의 @다음의 3자리를 ###으로 치환하여 출력하기  교수의 이름, email, #mail을 출력하기
select name, position,email, 
      replace(email,substr(email,instr(email,'@')+1,3),'###') "#mail"
from professor


-- 15. 교수테이블의  email 주소의 @앞의 3자리를 ###으로 치환하여 출력하기  교수의 이름, email, #mail을 출력하기

select name, position,email, 
      replace(email,substr(email,instr(email,'@')-3,3),'###') "#mail"
from professor

-- 16. 사원테이블에서 사원이름에 *를 왼쪽에 채운 6자리수 이름과, 업무와 급여를 출력한다.
select lpad(ename,6,'*'), job,salary from emp

-- 16-1. 사원테이블에서 사원이름에 양쪽에 ** 채운  7자리수 이름과, 업무와 급여를 출력한다.
SELECT rpad(lpad(ename,5,'*'),7,'*'), job,salary from emp

-- 17. 교수들의 이름과 근무 개월 수를 출력하기
--     근무개월수는 현재 일을 기준으로  일자를 계산하여 30으로 나눈 후 개월 수는 절삭하여 정수로 출력하기
--     근무 개월 순으로 정렬하여 출력하기.  
select name,hiredate, truncate(datediff(NOW(),hiredate)/30,0) 근무개월 
from professor order by 근무개월;

-- 18. 사용자 아이디에서 문자열의 길이가 7이상인   학생의 이름과  사용자 아이디를 출력 하여라
SELECT NAME,id FROM student WHERE CHAR_LENGTH(id) >= 7


-- 19. 교수테이블에서 이름과, 교수가 사용하는 email  서버의 이름을    출력하라.  이메일 서버는 @이후의 문자를 말한다.
SELECT NAME, SUBSTR(email,INSTR(email,"@")+1) email서버 
FROM professor

-- 20. 101번학과, 201번, 301번 학과 교수의 이름과  id를 출력하는데, id는 오른쪽을 $로 채운 후 
--       20자리로 출력하고  동일한 학과의 학생의   이름과 id를 출력하는데,  학생의 id는 왼쪽#으로 채운 후 20자리로 출력하라.
select name,rpad(id,20,'$') from professor 
where deptno in (101,201,301)
union
select name,lpad(id,20,'#') from student
 where major1 in (101,201,301)

-- 20-1. 101번학과, 201번, 301번 학과 교수문자를 붙인 교수의 이름과  id를 출력하는데, id는 오른쪽을 $로 채운 후 
--       20자리로 출력하고  동일한 학과의 학생문자를 붙인학생의 이름과 id를 출력하는데,  학생의 id는 왼쪽#으로 채운 후 20자리로 출력하라.
select concat(NAME,"교수") NAME ,rpad(id,20,'$') from professor 
where deptno in (101,201,301)
union
select concat(NAME,"학생"),lpad(id,20,'#') from student
 where major1 in (101,201,301)

-- 21. 2025년 1월 10일 부터 2025년 5월 20일까지 개월수를 반올림해서 정수 출력하기
select round(DATEDIFF('2025-05-20','2025-01-10')/30)

-- 22. EMP 테이블에서 10번 부서 직원의  이름, 입사일, 현재까지의 근무 월수를 계산하여   출력하기.  
--     근무월수 : 근무일수/30 반올림하여 정수로 출력하기
select ename, hiredate, round(datediff(NOW(),hiredate)/30) 근무월수 from emp
where deptno=10
