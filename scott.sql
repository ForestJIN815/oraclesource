-- SQL 쿼리문은 대소문자를 구별하지 않음
-- 단, 비밀번호는 구별함
-- DML(CRUD - Create / Read / Update / Delete)

-- 1) 조회
-- SELECT 컬럼명 ---------------- ⑤  
-- FROM 테이블명 ----------------- ⓛ
-- WHERE 조건절 ----------------- ②
-- GROUP BY 컬럼명 -------------- ③
-- HAVING 집계함수 조건절 ---------- ④
-- ORDER BY 컬럼명.. ------------ ⑥ 


-- EMP(employee - 사원테이블)
-- DEPT(department - 부서테이블)
-- SALGRADE (급여테이블)

-- 전체 조회
SELECT * FROM EMP e; -- e 는 별칭

-- 선택 조회
-- 1) 컬럼 지정
SELECT
	EMPNO,
	ENAME,
	MGR
FROM
	EMP e;

-- 중복 조회 : distinct
SELECT DISTINCT DEPTNO 
FROM EMP e;

-- 별칭
SELECT EMPNO AS "사원번호"
FROM EMP e;


SELECT EMPNO "사원번호"
FROM EMP e;

SELECT EMPNO AS "사원 번호"
FROM EMP e;

SELECT EMPNO, ENAME, SAL, COMM, SAL*12+COMM AS "연봉"
FROM EMP e;

-- 조회 후 정렬(오름차순-asc, 내림차순-desc)
-- sal 내림차순
SELECT ENAME, SAL
FROM EMP e 
ORDER BY SAL DESC;

-- sal 오름차순(asc 생략 가능)
SELECT ENAME, SAL
FROM EMP e 
ORDER BY SAL;

-- empno 내림차순
SELECT * FROM emp ORDER BY empno DESC;

-- deptno 오름차순, sal 내림차순
SELECT * 
FROM EMP e 
ORDER BY DEPTNO ASC, sal DESC;

SELECT EMPNO AS employee_no, ENAME employee_name, mgr AS manager, sal AS salary, comm AS commission, deptno AS department_no
FROM emp e
ORDER BY DEPTNO DESC, ENAME ASC;

-- 선택 조회
-- 2) 조건 지정
-- SELECT 칼럼나열,... FROM 테이블명 WHERE 조건 나열;

-- 부서번호가 30번인 사원 전체 조회
-- = : 동일하다
SELECT * FROM emp WHERE deptno = 30;
 
-- 사원번호가 7839 인 사원 조회
-- 사원번호 중복되지 않음
-- where 조건으로 중복되지 않은 값이 사용된다면 결과는 하나만 조회됨
SELECT * FROM EMP e WHERE EMPNO =7839;

-- 부서번호가 30 이고(and) 직책이 salesman 인 사원 조회
-- 문자열은 홑따옴표만 사용

SELECT * FROM EMP e WHERE DEPTNO = 30 AND job = 'SALESMAN';

-- 사원번호가 7698 이고 부서번호가 30 인 사원조회
SELECT * FROM EMP e WHERE EMPNO = 7698 AND DEPTNO = 30;

-- 부서번호가 30 이거나(OR) 직책이 CLERK 인 사원 조회
SELECT * FROM EMP e WHERE DEPTNO = 30 OR JOB = 'CLERK';

-- 연봉이 36000 인 사원조회
-- sal(월급) * 12 = 36000
SELECT * FROM EMP e WHERE e.SAL * 12 = 36000; 

-- 급여가 3000 보다 큰 사원 조회
SELECT * FROM EMP e WHERE e.SAL > 3000; 

-- 급여가 3000 이상인 큰 사원 조회
SELECT * FROM EMP e WHERE e.SAL >= 3000;

-- ename 이 f 이후의 문자열로 시작하는 사원 조회
SELECT * FROM EMP e WHERE e.ENAME >= 'F';

-- 급여가 2500 이상이고 직업이 analyst 인 사원 조회
SELECT * FROM EMP e WHERE e.SAL >= 2500 AND e.JOB = 'ANALYST';

-- job 이 manager, salesman, clerk 인 사원 조회
SELECT * FROM EMP e WHERE e.JOB = 'MANAGER' OR e.JOB = 'SALESMAN' OR e.JOB = 'CLERK';

-- SAL 이 3000 이 아닌 사원 조회
-- !=, <>, ^=
SELECT * FROM EMP e WHERE e.SAL != 3000;

SELECT * FROM EMP e WHERE e.SAL <> 3000;

SELECT * FROM EMP e WHERE e.SAL ^= 3000;

-- IN
SELECT * FROM EMP e WHERE e.JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- job 이 manager, salesman, clerk 이 아닌 사원 조회
SELECT * FROM EMP e WHERE e.JOB <> 'MANAGER' AND e.JOB != 'SALESMAN' AND e.JOB ^= 'CLERK';
SELECT * FROM EMP e WHERE e.JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- 부서번호가 10번 이거나 20번인 사원 조회
SELECT * FROM EMP e WHERE e.DEPTNO = 20 OR E.DEPTNO = 10;
SELECT * FROM EMP e WHERE e.DEPTNO IN (10,20);

-- BETWEEN A AND B : 일정 범위 내의 데이터 조회 시 사용
-- 급여가 2000 이상이고 3000 이하인 조회
SELECT *
FROM EMP e 
WHERE E.SAL >= 2000 AND E.SAL <= 3000;

SELECT *
FROM EMP e 
WHERE E.SAL BETWEEN 2000 AND 3000;

-- NOT BETWEEN A AND B : 일정 범위가 아닌 데이터 조회 시 사용
-- 급여가 2000 이상이고 3000 이하가 아닌 조회
SELECT *
FROM EMP e 
WHERE E.SAL NOT BETWEEN 2000 AND 3000;

-- LIKE 연산자와 와일드 카드(%, _)
-- ENAME = 'JONES' : 전체 일치
-- ENAME 이 J 로 시작하는 OR A 가 들어간.. : 부분 일치(LIKE)

-- J% : J로 시작하면 그 뒤에 어떤 문자가 몇 개가 오던지 상관 없음
SELECT * FROM EMP WHERE ENAME LIKE 'J%';

-- _J% : 어떤 문자로 시작해도 상관없으나 개수는 하나 / 두번째 문자는 J / 그 뒤에 어떤 문자가 몇 개가 오던지 상관 없음
SELECT * FROM EMP WHERE ENAME LIKE '_J%';

SELECT * FROM EMP WHERE ENAME LIKE '_L%';

-- 사원명에 AM 문자가 포함된 사원 조회
SELECT * FROM EMP WHERE ENAME LIKE '%AM%'

-- 사원명에 AM 문자가 포함되지 않는 사원 조회
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%'

-- IS NULL 
-- SELECT * FROM EMP WHERE COMM = NULL; (X)

SELECT * FROM EMP WHERE COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;


-- [집합 연산자] --
-- UNION : 합집합(결과 값의 중복 제거)
-- UNION ALL : 합집합(중복)
-- MINUS : 차집합
-- INTERSECT : 교집합


-- UNION
-- 부서번호가 10번인 사원 조회(사번,이름,급여,부서번호)
-- 부서번호가 20번인 사원 조회(사번,이름,급여) => (( 에러 )) 컬럼이 동일해야 함 / 타입도 동일해야 함

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO 
FROM EMP e 
WHERE E.DEPTNO = 10
UNION
SELECT E.EMPNO, E.ENAME, E.SAL ------------ (( 에러 )) -- 컬럼 동일 X (1-1)
FROM EMP e 
WHERE E.DEPTNO = 20;

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO 
FROM EMP e 
WHERE E.DEPTNO = 10
UNION
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO ------------------------ (1-3)
FROM EMP e 
WHERE E.DEPTNO = 20;

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO 
FROM EMP e 
WHERE E.DEPTNO = 10
UNION
SELECT E.ENAME, E.EMPNO, E.DEPTNO, E.SAL -- (( 에러 )) -- 타입 동일 X (1-2)
FROM EMP e 
WHERE E.DEPTNO = 20;


SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO ----------------- UNION ALL
FROM EMP e 
WHERE E.DEPTNO = 10
UNION ALL 
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e 
WHERE E.DEPTNO = 10;


SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO ----------------- MINUS
FROM EMP e 
MINUS
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e 
WHERE E.DEPTNO = 10;


SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO ----------------- INTERSECT
FROM EMP e 
INTERSECT
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e 
WHERE E.DEPTNO = 10;


-- ##################################################################
-- [함수] --------
-- 1. 오라클 내장 함수
-- 2. 사용자 정의 함수(PL/SQL)

-- 오라클 내장 함수 
-- 1. 단일행 함수 : 데이터가 한 행 씩 입력되고 입력된 한 행당 결과가 하나씩 나오는 함수
-- 2. 다중행 함수 : 여러 행이 입력되고 결과가 하나의 행으로 반환되는 함수

-- 1. 문자 함수
-- UPPER(문자열) : 괄호 안 문자열을 모두 대문자로 
-- LOWER(문자열) : 괄호 안 문자열을 모두 소문자로 
-- INITCAP(문자열) : 괄호 안 문자 데이터 중 첫문자만 대문자, 나머지는 소문자로
-- LENGHT(문자열) : 문자열 길이
-- LENGTHB(문자열) : 문자열 바이트 수
-- SUBSTR(문자열, 시작 위치) / SUBSTR(문자열, 시작 위치, 추출 길이) : 문자열 일부 추출
-- INSTR(문자열, 찾으려는 문자) : 특정 문자나 문자열이 어디에 포함되어 있는지
-- INSTR(문자열, 찾으려는 문자, 위치 찾기를 시작할 대상 문자열 데이터 위치, 시작위치에서 찾으려는 문자가 몇 번째인지)
-- REPLACE(문자열, 찾는 문자, 대체 문자)
-- CONCAT(문자열1, 문자열2) : 문자열 연결
-- TRIM / LTRIM / RTRIM : 특정 문자를 제거(주로 공백 제거 사용)

-- 데이터는 대소문자 구분 함
-- ORACLE = oracle
SELECT E.ENAME, UPPER(E.ENAME), LOWER(E.ENAME), INITCAP(E.ENAME)
FROM EMP e;

-- smith
SELECT *
FROM EMP e
WHERE UPPER(E.ENAME) = UPPER('smith');

SELECT *
FROM EMP e
WHERE UPPER(E.ENAME) LIKE UPPER('%smith%');


-- DUAL : 오라클에서 제공하는 기본 테이블(함수 적용 결과 보기)
-- LENGTH / LENGTHB
SELECT LENGTH ('한글'), LENGTHB('한글'), LENGTH ('AB'), LENGTHB('AB')
FROM DUAL;


SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5)
FROM EMP;


-- ( - ) : 오른쪽 끝을 의미
SELECT JOB, SUBSTR(JOB,-LENGTH(JOB)), SUBSTR(JOB,-LENGTH(JOB),2), SUBSTR(JOB,-3)
FROM EMP;

SELECT 
	INSTR('HELLO, ORACLE!','L') AS INSTR_1, 
	INSTR('HELLO, ORACLE!','L',5) AS INSTR_2,
	INSTR('HELLO, ORACLE!','L',2,2) AS INSTR_3
FROM DUAL;	   


-- 사원 이름에 S 가 있는 행 구하기
-- LIKE
SELECT * 
FROM EMP 
WHERE ENAME LIKE '%S%';

-- INSTR
SELECT *
FROM EMP
WHERE INSTR(ENAME,'S') > 0;

-- 010-1234-1535
SELECT '010-1234-1535' AS REPLACE_BEFORE, 
	REPLACE('010-1234-1535','-',' ') AS REPLACE_1, 
	REPLACE('010-1234-1535','-') AS REPLACE_2
FROM DUAL;

-- EMPNO, ENAME 연결 조회
-- CONCAT(EMPNO,CONCAT(':',ENAME))
SELECT CONCAT(EMPNO,ENAME),CONCAT(EMPNO,CONCAT(':',ENAME))
FROM EMP e;

-- || == concat (이 방법이 좀 더 편하다)
SELECT EMPNO || ENAME, EMPNO || ':' || ENAME
FROM EMP e;


SELECT
	'[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
	'[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
	'[' || LTRIM('<_Oracle_>','_<') || ']' AS LTRIM2, -- _< ?
	'[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
	'[' || RTRIM('<_Oracle_>','>_') || ']' AS RTRIM2 -- >_ ?
FROM DUAL;


-- [숫자 함수] --
-- ROUND(숫자,[반올림위치])
-- TRUNC(숫자,[버림위치])
-- CEIL(숫자) : 지정한 숫자와 가장 가까운 큰 정수 찾기
-- FLOOR(숫자) : 지정한 숫자와 가장 가까운 작은 정수 찾기
-- MOD(숫자,나눌숫자) == %(Java)

SELECT 
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND_0,
	ROUND(1234.5678, 1) AS ROUND_1,
	ROUND(1234.5678, 2) AS ROUND_2,
	ROUND(1234.5678, -1) AS ROUND_MINUS1,
	ROUND(1234.5678, -2) AS ROUND_MINUS2
FROM 
	DUAL;


SELECT 
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC_0,
	TRUNC(1234.5678, 1) AS TRUNC_1,
	TRUNC(1234.5678, 2) AS TRUNC_2,
	TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
	TRUNC(1234.5678, -2) AS TRUNC_MINUS2
FROM 
	DUAL;

SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14,), FLOOR(-3.14) -- 안되지?
FROM DUAL;

SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14) 
FROM DUAL;

SELECT MOD(15,6)
FROM DUAL;


-- [날짜 함수] --
-- SYSDATE : 오라클 서버가 설치된 os 의 현재날짜와 시간 사용
-- 날짜데이터 + 숫자 : 날짜 데이터와 숫자만큼 일수 이후의 날짜
-- 날짜데이터 - 날짜데이터 : 일수 차이
-- 날짜데이터 + 날짜데이터 : 안됨 (숫자로 해야함?)
-- ADD_MONTHS(날짜데이터, 더할 개월수)
-- MONTHS_BETWEEN(날짜데이터, 날짜데이터) : 두 날짜데이터 간의 차이를 개월 수로 계산
-- NEXT_DAY(날짜데이터, 요일문자) : 날짜데이터에서 돌아오는 요일의 날짜 반환
-- LAST_DAY(날짜데이터) : 특정 날짜가 속한 달의 마지막 날자 조회


SELECT SYSDATE FROM DUAL;

SELECT SYSDATE, SYSDATE-1, SYSDATE+1 FROM DUAL;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) FROM DUAL;

-- 입사 20주년 조회
SELECT E.EMPNO, E.ENAME, E.HIREDATE, ADD_MONTHS(E.HIREDATE, 240) 
FROM EMP e;


SELECT
	EMPNO,
	ENAME,
	HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(E.HIREDATE,SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE,E.HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(SYSDATE,E.HIREDATE)) AS MONTH3
FROM
	EMP e; 


SELECT SYSDATE, NEXT_DAY(SYSDATE,'월요일'), LAST_DAY(SYSDATE) FROM DUAL;



-- [형변환 함수] --
-- TO_CHAR(날짜데이터, '출력되길 원하는 문자 형태')
-- TO_NUMBER(문자데이터, '인식되길 원하는 숫자 형태')
-- TO_DATE(문자데이터, '인식되길 원하는 날짜 형태')

-- NUMBER + '문자숫자' : 연산해줌
SELECT E.EMPNO, E.ENAME, E.EMPNO + '500' 
FROM EMP e;

-- 수치가 부적합합니다
-- SELECT E.EMPNO, E.ENAME, E.EMPNO + 'abcd'
-- FROM EMP e; 

-- 날짜 데이터 => 문자 데이터
-- 자바 월 mm / 분 MM
-- 오라클 월 MM / 분 MI
SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY/MM/DD') AS 현재날짜
FROM DUAL;

SELECT TO_CHAR(SYSDATE,'MM') AS 현재월, TO_CHAR(SYSDATE,'MON') AS 현재월2, TO_CHAR(SYSDATE,'MONTH') AS 현재월3
FROM DUAL;

-- DD, DDD, DAY
SELECT TO_CHAR(SYSDATE,'DD') AS 일자, TO_CHAR(SYSDATE,'DAY') AS 일자2
FROM DUAL;

SELECT
	SYSDATE, 
	TO_CHAR(SYSDATE, 'HH:MI:SS') AS 현재시간,
	TO_CHAR(SYSDATE, 'HH12:MI:SS') AS 현재시간2, -- ?
	TO_CHAR(SYSDATE, 'HH24:MI:SS') AS 현재시간3, -- ?
	TO_CHAR(SYSDATE, 'HH24:MI:SS AM') AS 현재시간4
FROM
	DUAL;


-- 문자 데이터 => 숫자 데이터
SELECT 1300 - '1500', '1300' + 1500 
FROM DUAL;

SELECT '1300' + '1500' 
FROM DUAL;

-- 수치가 부적합합니다(, 가 포함되면 문자로 처리)
-- SELECT '1,300' + '1,500' 
-- FROM DUAL;

-- 9(숫자 한자리를 의미: 빈자리는 채우지 않음) or 0(숫자 한자리: 빈자리를 채움)
SELECT TO_NUMBER('1,300','999,999') + TO_NUMBER('1,500','999,999') 
FROM DUAL;


-- 문자 데이터 => 날짜 데이터 
SELECT TO_DATE('2024-09-05', 'YYYY-MM-DD') AS TODATE1, TO_DATE('20240905', 'YYYY-MM-DD') AS TODATE2
FROM DUAL;


-- EMP 테이블에서 1981-06-01 이후에 입사한 사원 조회
SELECT * 
FROM EMP e 
WHERE E.HIREDATE >= '1981-06-01';

SELECT * 
FROM EMP e 
WHERE E.HIREDATE >= TO_DATE('1981-06-01', 'YYYY-MM-DD');


-- 날짜데이터 + 날짜데이터

-- 수치가 부적합합니다
-- SELECT '2024-09-05' - '2024-01-02'
-- FROM dual;

-- 날짜와 날짜의 가산은 할 수 없습니다
-- SELECT TO_DATE('2024-09-05') + TO_DATE('2024-01-02')
-- FROM dual;

SELECT TO_DATE('2024-09-05') - TO_DATE('2024-01-02')
FROM dual;


-- NULL 처리 함수
-- NULL 과 산술연산이 안됨 => NULL 을 다른 값으로 변경
-- NVL(널값, 대체할값)
-- NVL(널값, 널이 아닌경우 반환값, 널인 경우 반환값)
-- SAL = NULL(x) IS(o)

SELECT E.EMPNO, E.ENAME, E.SAL, E.COMM, E.SAL + E.COMM, E.SAL + NVL(E.COMM, 0) -- ?
FROM EMP e;

-- 널이 아니면 SAL*12+COMM
-- 널이면 SAL*12
SELECT E.EMPNO, E.ENAME, E.SAL, E.COMM, NVL2(E.COMM, 'O','X'), NVL2(E.COMM, E.SAL * 12 + E.COMM, E.SAL * 12) -- ?
FROM EMP e;



-- [ DECODE 함수 / CASE 문 ] --
DECODE(테이터,
		조건1, 조건1을 만족할 때 해야할 것,
		조건2, 조건2을 만족할 때 해야할 것,
		) AS 별칭
		
		
-- JOB 이 MANAGER 라면 SAL * 1.1
-- JOB 이 SALESAMN 라면 SAL * 1.5
-- JOB 이 ANALYST 라면 SAL
		 그 외 라면 SAL * 1.03
		  
SELECT ------------------------------ (1-1) ---- 식이 맞는지 확인하기
	E.EMPNO,
	E.ENAME,
	E.JOB,
	E.SAL,
	DECODE(JOB, 
		   'MANAGER', E.SAL * 1.1, 
		   'SALESAMN', E.SAL * 1.5, 
		   'ANALYST', E.SAL,
		   E.SAL * 1.03) AS UPSAL
FROM
	EMP e; 


SELECT ------------------------------ (1-2)
	E.EMPNO,
	E.ENAME,
	E.JOB,
	E.SAL,
	CASE 
		JOB 
	 WHEN 'MANAGER' THEN E.SAL * 1.1
	    WHEN 'SALESAMN' THEN E.SAL * 1.5
	    WHEN 'ANALYST' THEN E.SAL
	    ELSE E.SAL * 1.03
	 END AS UPSAL
FROM
	EMP e; 
		

-- COMM 널일때 '해당사항없음'
-- COMM = 0 일때 '수당없음'
-- COMM > 0 일때 '수당 : COMM'

SELECT
	E.EMPNO,
	E.ENAME,
	E.JOB,
	E.SAL,
	CASE  
	    WHEN E.COMM IS NULL THEN '해당사항 없음'
	    WHEN E.COMM = 0 THEN '수당 없음'
	    WHEN E.COMM > 0 THEN '수당 : ' || E.COMM   
	END AS COMM_TEXT
FROM
	EMP e; 


-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다. 하루 근무시간을 8시간으로 봤을 때
-- 사원들의 하루급여(DAY_PAY)와 시급(TIME_PAY)를 계산하여 결과를 출력한다
-- 사번, 이름, SAL, DAY_PAY, TIME_PAY 출력
-- 단, 하루급여는 소수점 셋째자리에서 버리고, 시급은 두번째 소수점에서 반올림하기

SELECT
	E.EMPNO,
	E.ENAME,
	E.SAL,
	TRUNC(E.SAL/21.5,2) AS DAY_PAY,
	ROUND(E.SAL/21.5/8, 1) AS TIME_PAY
FROM
	EMP e; 	


-- EMP 테이블에서 사원들은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원들의 정직원이 되는 날짜(R_JOB) 를 YYYY-MM-DD 형식으로 출력한다.
-- 사번, 이름, 고용일, R_JOB 출력
SELECT
	E.EMPNO,
	E.ENAME,
	E.HIREDATE, 
	NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3), '월요일') AS R_JOB
FROM
	EMP e; 	

-- + 추가수당
-- COMM 이 없으면 'N/A', 있으면 COMM 출력
SELECT
	E.EMPNO,
	E.ENAME,
	E.HIREDATE,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3), '월요일') AS R_JOB,
	CASE 
		WHEN E.COMM IS NULL THEN 'N/A'
		WHEN E.COMM IS NOT NULL THEN E.COMM || ''
	END AS COMM	
FROM EMP e; 


-- ORA-01722: 수치가 부적합합니다
-- SELECT COMM, NVL(COMM, 'N/A') --------------------------- 작성하기
-- FROM EMP;


-- NVL
SELECT 
	E.EMPNO,
	E.ENAME,
	E.HIREDATE,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3), '월요일') AS R_JOB,
	NVL(TO_CHAR(E.COMM),'N/A') AS COMM
FROM EMP e; 

 
-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR) 를 변환해서 CHG_MGR 에 출력
-- 사번, 이름, MGR, CHG_MGR 출력
-- CHG_MGR 조건
-- MGR 이 널이면 '0000'/ MGR 의 앞 두자리가 75 이면 '5555' / 76 이면 '6666' / 77 이면 '7777' / 78 이면 '8888' / 79 이면 MGR 그대로 출력
SELECT
	E.EMPNO,
	E.ENAME,
	E.MGR,
    DECODE(SUBSTR(TO_CHAR(E.MGR, 1,2), -------------- (1-1) 안되지?
    	NULL, '0000',
    	'75', '5555',
    	'76', '6666',
    	'77', '7777',
    	'78', '8888',
    	SUBSTR(TO_CHAR(E.MGR), 1) 
        ) AS CHG_MGR
FROM
	EMP E;
	

SELECT 
	E.EMPNO,
	E.ENAME,
	E.MGR,
	CASE
		WHEN E.MGR IS NULL THEN '0000'
		WHEN E.MGR LIKE '75%' THEN '5555' -------------- (1-2)
		WHEN E.MGR LIKE '76%' THEN '6666'
		WHEN E.MGR LIKE '77%' THEN '7777'
		WHEN E.MGR LIKE '78%' THEN '8888'
		ELSE SUBSTR(TO_CHAR(E.MGR), 1)
	END AS CHG_MGR	
FROM
	EMP;
	
	
	
-- [다중행 함수] --
-- SUM(합계를 낼 열), COUNT(), MAX(), MIN(), AVG()
-- DISTINCT : 중복 제거

SELECT
	SUM(SAL)
FROM
	EMP;

SELECT
	SUM(DISTINCT SAL),
	SUM(ALL SAL),
	SUM(SAL)
FROM
	EMP;

SELECT
	COUNT(DISTINCT SAL),
	COUNT(ALL SAL),
	COUNT(SAL)
FROM
	EMP;

SELECT
	MAX(SAL),
	MIN(SAL)
FROM
	EMP;

SELECT
	MAX(SAL),
	MIN(SAL)
FROM
	EMP
WHERE
	DEPTNO = 10;

-- 부서번호가 20번인 사원의 최근 입사일 조회
SELECT
	MAX(HIREDATE)
FROM
	EMP
WHERE
	DEPTNO = 20;

SELECT
	MIN(HIREDATE)
FROM
	EMP
WHERE
	DEPTNO = 20;

SELECT
	AVG(DISTINCT SAL),
	AVG(ALL SAL),
	AVG(SAL)
FROM
	EMP;

-- 부서번호가 30번인 사원들의 평균 추가 수당
SELECT
	AVG(COMM)
FROM
	EMP e
WHERE
	DEPTNO = 30;


-- GROUP BY : 결과 값을 원하는 열로 묶어 출력
-- GROUP BY 그룹화 할 열


-- 각 부서별 평균 급여 출력
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 각 부서별, 직책별 평균 급여 출력
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB 
ORDER BY DEPTNO, JOB;

-- GROUP BY 표현식이 아닙니다.(GROUP BY 절을 사용할 때에는 SELECT 절에서 사용할 수 있는 열이 제한됨)
-- SELECT 가능 : GROUP BY 쓰여진 열, 다중행 함수
---- SELECT ENAME, AVG(SAL) -> ENAME 때문에 안됨?
---- FROM EMP
---- GROUP BY DEPTNO; 


-- GROUP BY ~ HAVING : 그룹바이 절에 조건을 줄 때 사용
-- 각 부서의 직책별 평균 급여(평균 급여가 2000 이상인 그룹만 조회)
SELECT
	DEPTNO,
	JOB,
	AVG(SAL)
FROM
	EMP
GROUP BY
	DEPTNO,
	JOB
HAVING
	AVG(SAL) >= 2000
ORDER BY
	DEPTNO,
	JOB;


------------------ ORA-00934: 그룹 함수는 허가되지 않습니다
-- SELECT
--	 DEPTNO,
--	 JOB,
--	 AVG(SAL)
-- FROM
--	 EMP
-- WHERE 
--	 AGV(SAL) >= 2000
-- GROUP BY
--	 DEPTNO,
--	 JOB
-- ORDER BY
--	 DEPTNO,
--	 JOB;





-- <부서별>, 평균급여, 최고급여, 최저급여, 사원 수 출력
-- 평균급여 출력 시 소수점을 제외하고 출력
SELECT DEPTNO,
	   FLOOR(AVG(SAL)), -- 가장 가까운 정수 중 작은 수
	   MAX(SAL),
	   MIN(SAL),
	   COUNT(DEPTNO)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;


-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
SELECT JOB, COUNT(*) -- COUNT(JOB) 으로 작성해도 됨
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- 사원들의 입사년도를 기준으로 부서별로 몇 명의 입사인원이 있는지 출력
-- 1987 20 2 (1987년도 20번 부서에 2명 입사)
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR, DEPTNO, COUNT(*) AS CNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY DEPTNO;



-- [ JOIN(조인) ] : 2개 이상의 테이블을 연결하여 하나의 테이블처럼 출력 --
-- 내부조인(Inner join)
--  등가조인(★) : 테이블 연결 후 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정
--  비등가조인
--  자체조인
-- 외부조인(Outer join)
--   왼쪽외부조인(Left Outer Join) : 오른쪽 테이블에 + 기호
--   오른쪽외부조인(Right Outer Join) : 왼쪽 테이블에 + 기호
--   전체외부조인(Full Outer Join) : X

-- SELECT * FROM EMP, DEPT;


-- 1) 내부조인
-- [등가조인] : EMP 테이블의 DEPTNO 와 DEPT 테이블의 DEPTNO 가 일치 시 연결

-- 열의 정의가 애매합니다(조인 시 동일한 필드명을 가지고 있을 때)
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC 
FROM EMP e , DEPT d 
WHERE E.DEPTNO = D.DEPTNO;


-- + sal 3000 이상인 사원 조회
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC 
FROM EMP e , DEPT d 
WHERE E.DEPTNO = D.DEPTNO AND e.SAL >= 3000;

-- [비등가조인] : 등가조인 이외의 방식
-- EMP / SALGRADE
SELECT * 
FROM EMP e, SALGRADE s
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- [자체조인]
-- MGR 의 이름 조회 
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME
FROM EMP e1, EMP e2
WHERE E1.MGR = E2.EMPNO;


-- [외부조인] --

-- left outer join
SELECT e1.empno, e1.ename, e1.mgr, e2.EMPNO AS mgr_empno, e2.ename AS mgr_ename
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO(+); 

-- right outer join
SELECT e1.empno, e1.ename, e1.mgr, e2.EMPNO AS mgr_empno, e2.ename AS mgr_ename
FROM EMP e1, EMP e2
WHERE e1.MGR(+) = e2.EMPNO; 



-- [ 쿼리문 변화 ] --
-- 내부조인 : join ~ on
-- 외부조인 : (left) outer join ~ on / right outer join ~ on


SELECT
	e.EMPNO,
	e.ENAME,
	d.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e
JOIN DEPT d
ON
	e.DEPTNO = d.DEPTNO;


SELECT
	E.EMPNO,
	E.ENAME,
	D.DEPTNO,
	D.DNAME,
	D.LOC
FROM
	EMP e
JOIN DEPT d 
ON
	E.DEPTNO = D.DEPTNO
WHERE
	e.SAL >= 3000;



-- [ Left outer join ]
-- SELECT
--	   e1.empno,
--	   e1.ename,
--	   e1.mgr,
--	   e2.EMPNO AS mgr_empno,
--	   e2.ename AS mgr_ename
-- FROM EMP e1, EMP e2
-- WHERE e1.MGR = e2.EMPNO(+); ==> (+)는 교집합만 추가된다는 의미 -- 옛날 방식 

SELECT
	e1.empno,
	e1.ename,
	e1.mgr,
	e2.EMPNO AS mgr_empno,
	e2.ename AS mgr_ename
FROM EMP e1 LEFT OUTER JOIN EMP e2	-- [EMP e1] <기준> <== [JOIN EMP e2]의 교집합 값이 추가된다는 의미 
ON e1.MGR = e2.EMPNO;


-- [ Right outer join ]
--SELECT
--	  e1.empno,
--	  e1.ename,
--	  e1.mgr,
--	  e2.EMPNO AS mgr_empno,
--	  e2.ename AS mgr_ename
--FROM EMP e1, EMP e2
--WHERE e1.MGR(+) = e2.EMPNO;

SELECT
	e1.empno,
	e1.ename,
	e1.mgr,
	e2.EMPNO AS mgr_empno,
	e2.ename AS mgr_ename
FROM EMP e1 RIGHT OUTER JOIN EMP e2
ON e1.MGR = e2.EMPNO; 



-- table 3개 조인
-- SELECT *
-- FROM EMP e1 JOIN EMP e2 ON e1.mgr = e2.EMPNO JOIN emp e3 ON e1.mgr = e3.EMPNO;


-- 각 부서별 평균급여, 최대급여, 최소급여, 사원수를 조회
-- 부서번호, 부서명, 평균급여(AVG_SAL), 최대급여(MAX_SAL), 최소급여(MIN_SAL), 사원수(CNT)

SELECT E.DEPTNO, D.DNAME, AVG(E.SAL) AS AVG_SAL, MAX(E.SAL) AS MAX_SAL, MIN(E.SAL) AS MIN_SAL, COUNT(*) AS CNT
FROM EMP e JOIN DEPT d ON E.DEPTNO = D.DEPTNO 
GROUP BY E.DEPTNO, D.DNAME -- 무조건 그룹바이 에서 잡아줘야 함 (select 에서 dname 보고 싶으면) 
ORDER BY E.DEPTNO; 


-- 모든 부서정보 와 사원정보 를 조회
-- 부서번호, 부서명, 사원번호, 사원명, 직무(JOB), 급여

SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM DEPT d LEFT OUTER JOIN EMP e ON D.DEPTNO = E.DEPTNO 
ORDER BY D.DEPTNO, E.EMPNO; 



-- [서브쿼리] : 쿼리문 안에 또 다른 쿼리문(select, update, delete, insert)이 포함 --

-- SELECT (SELECT FROM WHERE) 
-- FROM
-- WHERE 

-- SELECT 
-- FROM (SELECT FROM WHERE)
-- WHERE 

-- SELECT  
-- FROM
-- WHERE (SELECT FROM WHERE)


-- jones 의 월급보다 많은 월급을 받는 사원 조회

SELECT *
FROM EMP e
WHERE e.SAL > 2975;

SELECT *
FROM EMP e
WHERE e.SAL > (SELECT E2.SAL FROM EMP e2 WHERE e2.ename = 'JONES')
-- ~~ 서브쿼리 작성할때 (괄호) 표시 무조건 해야한다   --------- e 그리고 e2 ? 같은거??

-- 실행 결과가 하나인 단일행 서브쿼리
-- >, >=, =, <, <=, <>, !=, ^=


-- KING 보다 빠른 입사자 조회
--SELECT *
--FROM EMP e
--WHERE E.HIREDATE < '1981-11-17';
SELECT *
FROM EMP e
WHERE E.HIREDATE < (SELECT E2.HIREDATE FROM EMP E2 WHERE E2.ENAME = 'KING');


-- ALLEN 보다 추가수당 많이 받는 사원 조회
SELECT *
FROM EMP e
WHERE E.COMM > (SELECT E2.COMM FROM EMP E2 WHERE E2.ENAME = 'ALLEN');


-- 20번 부서에 근무하는 사원 중 전체 사원의 평균 급여보다 높은 급여를 받은 사원 조회
SELECT *
FROM EMP E
WHERE E.DEPTNO = 20 AND E.SAL > (SELECT AVG(E2.SAL) FROM EMP E2);


-- 20번 부서에 근무하는 사원 중 전체 사원의 평균 급여보다 높은 급여를 받은 사원 조회 + 부서명, 부서위치
SELECT *
FROM EMP E JOIN DEPT d ON E.DEPTNO = D.DEPTNO 
WHERE E.DEPTNO = 20 AND E.SAL > (SELECT AVG(E2.SAL) FROM EMP E2);

SELECT E.*, D.DNAME, D.LOC -- (E는 전부 다 뽑고, D는 선별해서 뽑기)
FROM EMP E JOIN DEPT d ON E.DEPTNO = D.DEPTNO 
WHERE E.DEPTNO = 20 AND E.SAL > (SELECT AVG(E2.SAL) FROM EMP E2);



-- 실행 결과가 여러개인 [다중행] 서브 쿼리 --
-- IN : 메인 쿼리의 데이터가 서브 쿼리의 결과 중 하나라도 일치한 데이터가 있다면 true
-- ANY(SOME) : 메인 쿼리의 조건식을 만족하는 서브 쿼리의 결과가 하나 이상이면 true
-- ALL : 메인 쿼리의 조건식을 서브 쿼리의 결과 모두가 만족하면 true
-- EXISTS : 서브 쿼리의 결과가 존재하면(즉, 행이 1개 이상일 경우) true


-- 각 부서별 최고 급여와 동일하거나 큰 급여를 받는 사원 조회
-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
SELECT *
FROM EMP e
WHERE e.SAL >= IN (SELECT MAX(e2.sal) FROM EMP e2 GROUP BY e2.deptno);-- 오류남 ? 


-- IN == =ANY
SELECT *
FROM EMP e
WHERE e.sal >= ANY (SELECT MAX(e2.sal) FROM EMP e2 GROUP BY e2.deptno); 

SELECT *
FROM EMP e
WHERE e.sal >= SOME (SELECT MAX(e2.sal) FROM EMP e2 GROUP BY e2.deptno); 


-- 30번 부서의 급여 보다 적은 급여를 받는 사원 조회
-- 30번 부서의 최대급여 보다 적은 사원 조회하는 결과와 같아짐
-- [다중행 서브쿼리]로 할때
SELECT *
FROM EMP e
WHERE e.sal < ANY (SELECT e2.sal FROM EMP e2 WHERE e2.deptno = 30)
ORDER BY E.SAL, E.EMPNO;

-- [단일행 서브쿼리]로 할때
SELECT *
FROM EMP e
WHERE e.sal < (SELECT MAX(e2.sal) FROM EMP e2 WHERE e2.deptno = 30)
ORDER BY E.SAL, E.EMPNO;


-- 30번 부서의 급여 보다 많은 급여를 받는 사원 조회
-- 30번 부서의 급여 보다 적은 사원 조회하는 결과와 같아짐
-- [다중행 서브쿼리]로 할때 ------------------------------- ??
SELECT *
FROM EMP e
WHERE e.sal < ANY (SELECT e2.sal FROM EMP e2 WHERE e2.deptno = 30)
ORDER BY E.SAL, E.EMPNO;

-- [단일행 서브쿼리]로 할때
SELECT *
FROM EMP e
WHERE e.sal < (SELECT MIN(e2.sal) FROM EMP e2 WHERE e2.deptno = 30)
ORDER BY E.SAL, E.EMPNO;


-- 30번 부서의 급여 보다  사원들의 최소급여 보다 더 작은 사원 조회  ------ ?
-- ALL
SELECT *
FROM EMP e
WHERE e.sal < ALL (SELECT e2.sal FROM EMP e2 WHERE e2.deptno = 30)
ORDER BY E.SAL, E.EMPNO;


-- EXISTS
SELECT *
FROM EMP e
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 10);

SELECT *
FROM EMP e
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 50);

-- [비교할 열이 여러 개인 다중열 서브 쿼리] --
SELECT *
FROM EMP e
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP e2 GROUP BY DEPTNO);
-- 2개가 들어오기 시작하면 반드시 (괄호) 를 붙인다


-- FROM 절에 작성하는 서브쿼리(== 인라인뷰) 작성
	 
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10, (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;


-- SELECT 절에 작성하는 서브쿼리(== 스칼라 서브쿼리)
-- SELECT 절에 사용하는 서브쿼리는 단 하나의 결과만 반환해야 함

SELECT
	E.EMPNO,
	E.JOB,
	E.SAL,
	(
	SELECT
		GRADE
	FROM
		SALGRADE s
	WHERE
		E.SAL BETWEEN S.LOSAL AND S.HISAL) AS SALGRADE,
	E.DEPTNO,
	(
	SELECT
		DNAME
	FROM
		DEPT D
	WHERE
		E.DEPTNO = D.DEPTNO) AS DNAME
FROM
	EMP e;



-- [NSERT(삽입)] --

-- 테이블 복사 
CREATE TABLE dept_temp AS SELECT * FROM DEPT; -- 왜 안되? => F5 를 누르고 <새로고침> 하기 / 안 되는 이유는 '기존의 객체가 이름을 사용하고 있습니다.' 이므로 명칭을 달리 해줘야 함!
											  -- 왼쪽 테이블 보면 어떤 명칭?으로 만들어졌는지 뜬다

SELECT * FROM dept_temp;

-- 열 이름 나열 하는 부분은 생략 가능 : 전체 필드에 값 삽입 시
-- INSERT INTO 테이블명(열이름1, 열이름2....)
-- VALUES (열 이름에 맞춰 값 나열)

INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
VALUES (50, 'DATABASE', 'SEOUL');

INSERT INTO DEPT_TEMP
VALUES (60, 'DATABASE', 'SEOUL');

-- SQL Error [947] [42000]: ORA-00947: 값의 수가 충분하지 않습니다
INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
VALUES (70, 'DATABASE', NULL);

INSERT INTO DEPT_TEMP(DEPTNO,DNAME)
VALUES (80, 'DATABASE');


CREATE TABLE EMP_TEMP AS SELECT * FROM EMP; -- 왜 안됨..?
SELECT * FROM EMP_TEMP;

-- 전체 필드에 값을 추가할 때
INSERT INTO EMP_TEMP VALUES(9999, '홍길동', 'PRESIDENT', NULL, '2001-01-01', 5000, 1000, 10);

-- 부분적으로 값을 추가 시
INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO)
VALUES(8888,'성춘향','SALESMAN',SYSDATE,3000,20);

-- 날짜 년/월/일 ==> 일/월/년 순으로 입력?
INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO)
VALUES(7777,'이순신','SALESMAN','07/08/2023',3000,20); -- 외국 형식의 날짜라 오류남

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO)
VALUES(7777,'이순신','SALESMAN',TO_DATE('07/08/2023','DD/MM/YYYY'),3000,20);

-- 테이블 복사 시 테이블의 구조만 복사하고 데이터는 복사하지 않을 때

-- 테이블 제거
DROP TABLE EMP_TEMP;

-- 테이블 복사 시 테이블의 구조만 복사하고 데이터는 복사하지 않을 때
CREATE TABLE EMP_TEMP AS SELECT * FROM EMP WHERE 1<>1;

-- EMP 테이블과 SALGRADE 조인 후 급여 등급이 1인 사원들만 EMP_TEMP 에 삽입(서브쿼리)
-- 데이터가 추가되는 테이블 열 개수와 서브쿼리 열 개수와 자료형 일치
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO 
FROM EMP e JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL 
WHERE s.GRADE = 1;


-- [UPDATE(수정)] --

-- UPDATE 변경 테이블명
-- SET 변경할 열 = 값, 변경할 열 = 값 ....
-- WHERE 변경할 대상 행 조건

SELECT * FROM DEPT_TEMP;

-- 모든 행의 LOC 를 SEOUL 로 변경
UPDATE DEPT_TEMP
SET LOC = 'SEOUL'; 


CREATE TABLE dept_temp2 AS SELECT * FROM DEPT;

-- 40번 부서의 부서명 DNAME DATABASE, LOC SEOUL 로 변경
UPDATE DEPT_TEMP2
SET DNAME='DATABASE', LOC='SEOUL'
WHERE DEPTNO=40;

-- EMP_TEMP 의 사원들 중에서 급여가 2500 이하인 사원들의 추가수당을 50으로 수정
UPDATE EMP_TEMP
SET COMM = 50
WHERE SAL <= 2500;

-- DEPT 테이블의 DEPTNO=40 부서의 DNAME, LOC 를 추출해서 DEPT_TEMP2 의 DNAME, LOC 수정

UPDATE
	DEPT_TEMP2
SET
	(DNAME,
	LOC) = 
(
	SELECT
		DNAEM,
		LOC
	FROM
		DEPT
	WHERE
		DEPTNO = 40)
WHERE
	DEPTNO = 40;


-- [DELETE : 데이터 삭제] --
-- DELETE 테이블명 WHERE 삭제할 조건;
-- DELETE FROM 테이블명 WHERE 삭제할 조건
-- DELETE 테이블명; 전체 데이터 삭제

CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP2;

-- JOB = 'MANAGER' 인 사원 삭제
DELETE EMP_TEMP2 WHERE JOB = 'MANAGER';

DELETE FROM EMP_TEMP2;

-- EMP 테이블 행 전부 추출 후 EMP_TEMP2 에 삽입
INSERT INTO EMP_TEMP2(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO 
FROM EMP e;


-- 서브쿼리
-- 급여 등급이 3등급이고, 부서번호가 30번인 사원 삭제

DELETE
FROM
	EMP_TEMP2
WHERE
	EMPNO IN (
	SELECT
		E.EMPNO
FROM
	EMP_TEMP2 E
JOIN SALGRADE s ON
	E.SAL BETWEEN S.LOSAL AND S.HISAL
	AND S.GRADE = 3
	AND E.DEPTNO = 30); 


-- 테이블 복사
-- emp, dept, salgrade 테이블 복사
-- exam_emp, exam_dept, exam_salgrade 로 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;


-- insert
-- exam_dept 테이블에 50,60,70,80 부서 등록
-- 50:ORACLE,BUSAN / 60:SQL,ILSAN / 70:SELECT,INCHEON / 80:DML,BUNDANG
INSERT INTO EXAM_DEPT(deptno,dname,loc) VALUES (50,'ORACLE','BUSAN');
INSERT INTO EXAM_DEPT(deptno,dname,loc) VALUES (60,'SQL','ILSAN');
INSERT INTO EXAM_DEPT(deptno,dname,loc) VALUES (70,'SELECT','INCHEON');
INSERT INTO EXAM_DEPT(deptno,dname,loc) VALUES (80,'DML','BUNDANG');


-- exam_emp 사원등록
-- 7201, TEST_USER1, MANAGER, 7788, 2016-01-02,4500,NULL,50
INSERT INTO EXAM_EMP VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, '2016-01-02',4500,NULL,50);
-- 7202, TEST_USER2, CLERK, 7201, 2016-02-21,1800,NULL,50
INSERT INTO EXAM_EMP VALUES(7202, 'TEST_USER2', 'CLERK', 7201, '2016-02-21',1800,NULL,50);
-- 7203, TEST_USER3, ANALYST, 7201, 2016-04-11,3400,NULL,60
INSERT INTO EXAM_EMP VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, '2016-04-11',3400,NULL,60);
-- 7204, TEST_USER4, SALESMAN, 7201, 2016-05-31,2700,300,60
INSERT INTO EXAM_EMP VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, '2016-05-31',2700,300,60);
-- 7205, TEST_USER5, CLERK, 7201, 2016-07-20,2600,NULL,70
INSERT INTO EXAM_EMP VALUES(7205, 'TEST_USER5', 'CLERK', 7201, '2016-07-20',2600,NULL,70);
-- 7206, TEST_USER6, CLERK, 7201, 2016-09-08,2300,NULL,70
INSERT INTO EXAM_EMP VALUES(7206, 'TEST_USER6', 'CLERK', 7201, '2016-09-08',2300,NULL,70);
-- 7207, TEST_USER7, LECTURER, 7201, 2016-10-28,4500,NULL,80
INSERT INTO EXAM_EMP VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, '2016-10-28',4500,NULL,80);

-- UPDATE
-- exam_emp 에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를
-- 받고 있는 사원들을 70번 부서로 변경
UPDATE EXAM_EMP
SET DEPTNO=70
WHERE SAL >= (SELECT MAX(SAL) FROM EXAM_EMP WHERE DEPTNO=50);


-- exam_emp 에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게
-- 입사한 사원의 급여를 10% 인상하고 80번 부서로 변경
UPDATE EXAM_EMP
SET SAL = SAL * 1.1, DEPTNO = 80
WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM EXAM_EMP WHERE DEPTNO=60);


-- DELETE
-- exam_emp 에 속한 사원 중 급여 등급이 5인 사원 삭제
DELETE
FROM
	EXAM_EMP
WHERE
	EMPNO IN(
	SELECT
		EMPNO
	FROM
		EXAM_EMP E
	JOIN SALGRADE S
	WHERE
		E.SAL BETWEEN S.LOSAL AND S.HISAL
		AND S.GRADE = 5);


	
-- [트랜잭션] : 최소수행단위
--		     은행계좌이체
		     commit(반영), rollback(취소)
-- insert, delete, update => 데이터 변화
		   
-- AUTO-COMMIT : 자동 반영

-- 취소 불가한 트랜잭션 시작		     
CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
-- 트랜잭션 종료

-- 트랜잭션 시작
INSERT INTO DEPT_TCL VALUES(50,'DATABASE','SEOUL');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
SELECT * FROM DEPT_TCL;
-- 트랜잭션 종료

-- 트랜잭션 취소
ROLLBACK;

SELECT * FROM DEPT_TCL;

-- 트랜잭션 시작
INSERT INTO DEPT_TCL VALUES(50,'DATABASE','SEOUL');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';

SELECT * FROM DEPT_TCL;

-- 트랜잭션 반영
COMMIT;

-- 트랜잭션 종료

SELECT * FROM DEPT_TCL;

DELETE FROM DEPT_TCL WHERE DEPTNO = 50;
COMMIT;

UPDATE DEPT_TCL SET LOC='SEOUL' WHERE DEPTNO = 30;
COMMIT;


-- DDL(데이터 정의어)
-- 데이터베이스 데이터를 보관하고 관리하기 위해 제공되는 여러 객체의 생성/변경/삭제 관련 기능
-- CREATE(생성) / ALTER(생성된 객체 변경) / DROP(생성된 객체 삭제)

-- 1. 테이블 정의어
-- CREATE TABLE 테이블이름(
--	 열이름1 자료형,
--   열이름2 자료형,
--	 열이름3 자료형,
--	 열이름4 자료형,
--)

-- 테이블 이름 작성 규칙
-- 1) 문자로 시작(한글 가능하나 사용하지 않음 - 숫자로 시작 못함)
-- 2) 테이블 이름은 길이의 제한이 있음
-- 3) 같은 소유자 소유의 테이블 이름은 중복이 불가능함
-- 4) SQL 키워드는 사용 불가(SELECT, INSERT 등)

-- 열이름 생성 규칙
-- 1) 문자로 시작
-- 2) 길이의 제한이 있음(30byte)
-- 3) 한 테이블에 열 이름 중복 불가
-- 4) 열 이름은 영문자, 숫자, 특수문자(_, #, $) 사용 가능
-- 5) SQL 키워드는 사용 불가(SELECT, INSERT 등)

-- 자료형
-- 문자 : varchar2(길이), nvarchar2(길이), char(길이), nchar(길이)
-- 	     var : 가변(저장된 값의 길이만큼만 사용) ~~~~~~~~~~~~~~~~~~~~ 길이만큼 잡은게 움직인다(동적이라는 뜻)
-- 		 name varchar2(10) : 홍길동(9byte)
-- 		 name char(10) : 홍길동(10byte) - 고정길이
-- 		 db 버전에 따라 한글 문자 하나당 2byte 할당 or 3byte 할당
-- 		 name varchar2(10) : 홍길동전 => 들어갈 값의 크기가 크다고 오류 남
--			 nvarchar2(10), nchar() : 10 이 바이트 개념이 아니라 문자 길이 자체를 의미
-- 숫자 : number(전체자릿수, 소수점자릿수)
-- 날짜 : date
-- BLOB : 대용량 이진 데이터 저장
-- CLOB : 대용량 텍스트 데이터 저장


CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4,0),
	ENAME VARCHAR2(10), -- 영어 10자 까지 가능 / 한글 3자 까지 가능
	JOB VARCHAR2(9),
	MRG NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0)
);

-- DEPT 테이블의 열구조와 데이터 복사하여 새 테이블 생성
CREATE TABLE DEPT_DDL AS SELECT * FROM DEPT;

-- DEPT 테이블의 열구조만 복사하여 새 테이블 생성
CREATE TABLE DEPT_DDL2 AS SELECT * FROM DEPT WHERE 1<>1;


-- ALTER : 변경
-- 새로운 열 추가 / 열 이름 변경 / 열 삭제 / 열 자료형 변경
-- EMP_DDL 에 새로운 열(HP : 010-1234-5637) 추가
ALTER TABLE EMP_DDL ADD HP VARCHAR2(20);
SELECT * FROM EMP_DDL ed;

-- HP => TEL 
ALTER TABLE EMP_DDL RENAME COLUMN HP TO TEL;

-- EMPNO NUMBER(5) 로 변경
ALTER TABLE EMP_MODIFY EMPNO NUMBER(5);

-- TEL 삭제
ALTER TABLE EMP_DDL DROP COLUMN TEL;

-- 테이블 이름 변경
RENAME EMP_DDL TO EMP_RENAME;

-- DROP : 삭제
DROP TABLE EMP_RENAME;

CREATE TABLE MEMBERTBL(
	ID CHAR2(8),
	NAME VARCHAR2(10), -- NVARCHAR2(10)
	ADDR VARCHAR2(50), -- NVARCHAR2(50)
	NATION CHAR2(4), -- NCHAR(4)
	EMAIL VARCHAR2(50), -- NVARCHAR2(50)
	AGE NUMBER(7,2)
);

--DROP TABLE MEMBERTBL;  

-- member 테이블에 BIGO 열 추가하기
-- [조건] 가변형 문자열, 길이는 20
ALTER TABLE MEMBERBL AND BIGO BARCHAR2(20);

-- BIGO 열 크기를 30으로 변경하기
ALTER TABLE MEMBERBL MODIFY BIGO BARCHAR2(30);

ALTER TABLE MEMBERBL MODIFY NATION NATION(4);

-- BIGO 열 이름을 REMARK 로 변경하기
ALTER TABLE MEMBERTBL RENAME COLUMN BIGO TO REMARK;

-- "SCOTT"."MEMBERTBL"."NATION" 열에 대한 값이 너무 큼(실제: 12, 최대값: 4)
INSERT INTO MEMBERTBL(ID, NAME, ADDR, NATION, EMAIL, AGE)
VALUES('hong1234', '홍길동', '서울시 구로구 개봉동', '대한민국', ' hong123@naver.com', 25);

SELECT * FROM MEMBERTBL;


-- 오라클 객체
-- 인덱스 / 뷰 / 시퀀스(★) / 동의어 / ROWNUM

-- 인덱스 : 빠른 검색
-- 1) 자동 생성 : 기본키를 설정 시 인데스로 자동 설정 됨
-- 2) 직접 인덱스 생성
-- CREATE INDEX 인덱스명 ON 테이블명(열이름1 ASC OR DESC, 열이름2 ASC OR DESC..)
-- EMP 테이블의 SAL 칼럼을 index 로 지정
CREATE INDEX idx_emp_sal ON emp(sal);

DROP INDEX idx_emp_sal;

-- 뷰 : 가상 테이블
-- 1. 편리성 : 복잡한 select 문의 복잡도를 완화하기 위해
--             자주 활용하는 select 문을 뷰로 저장해 놓은 후 다른 sql 구문에서 활용
-- 2. 보안성 : 노출되면 안되는 컬럼을 제외하여 접근 허용

-- 뷰 생성 할 수 있는 권한 부여 받기
-- CREATE [OR REPLACE] VIEW 뷰이름(열이름1, 열이름2...) AS (SELECT 구문)

-- emp 테이블의 20번 부서에 해당하는 사원들의  뷰 생성
CREATE VIEW vw_emp_20 AS (SELECT empno, ename, job, deptno FROM emp WHERE deptno = 20);
DROP VIEW vw_emp_20;


CREATE VIEW vw_emp_20 AS (SELECT * FROM emp WHERE deptno = 20);

-- 뷰에 데이터 삽입 시 원본 테이블에 삽입이 일어남
INSERT INTO vw_emp_20 VALUES(6666,'홍길동','MANAGER',7899,'2012-08-01',1200,0,20);
SELECT * FROM VW_EMP_20;

SELECT * FROM EMP;


-- 뷰를 통해 SELECT 만 가능하도록 제한
CREATE VIEW vw_emp_30 AS (
SELECT
	empno,
	ename,
	job,
	deptno
FROM
	emp
WHERE
	deptno = 30) WITH READ ONLY;


-- ROWNUM : 특수 컬럼(조회된 순서대로 일련번호 부여)
-- ORDER BY 기준이 PK(기본키) 가 아니면 번호 부여가 이상하게 나옴
SELECT ROWNUM, E.*
FROM EMP E
ORDER BY SAL DESC;


-- 정렬의 기준이 PK 가 아니라면 인라인 뷰에서 정렬 후
-- ROWNUM 번호를 부여 해야 함
SELECT ROWNUM, E.*
FROM (SELECT * FROM EMP ORDER BY SAL DESC) E;


-- 급여 높은 순으로 top-n 추출
SELECT ROWNUM, E.*
FROM (SELECT * FROM EMP ORDER BY SAL DESC) E
WHERE rownum <= 3;


-- 시퀀스 : 규칙에 따라 순번을 생성
-- CREATE SEQUENCE 시퀀스명;
CREATE SEQUENCE dept_seq;


--CREATE SEQUENCE SCOTT.DEPT_SEQ
--INCREMENT BY 1 (기본값은 1 - 증가를 얼마씩 할 것인가?)
--MINVALUE 1 (시퀀스에서 생성할 최소값)
--MAXVALUE 99999999999999999999 (시퀀스에서 생성할 최대값)
--NOCYCLE (최대값에 도달 후 다시 시작값부터 시작할 것인지 여부)
--CACHE 20 (시퀀스에서 생성할 번호를 메모리에 미리 할당해 놓은 수)
--NOORDER;

CREATE TABLE dept_sequence AS SELECT * FROM dept WHERE 1<>1;

SELECT * FROM dept_sequence;
INSERT INTO DEPT_SEQUENCE(DEPTNO, DNAME, LOC)
VALUES (dept_seq.nextval, 'DATABASE', 'SEOUL');

INSERT INTO DEPT_SEQUENCE(DEPTNO, DNAME, LOC)
VALUES (dept_seq.nextval, 'NETWORK', 'BUSAN');


-- 가장 마지막으로 생성된 시퀀스 확인
SELECT dept_seq.CURRVAL
FROM DUAL;

DROP SEQUENCE dept_seq;


-- 부서번호가 10 씩 증가 / 부서번호 90 까지 존재
CREATE SEQUENCE DEPT_SEQ
INCREMENT BY 10
START WITH 10
MINVALUE 0
MAXVALUE 90 
NOCYCLE 
CACHE 2;


DELETE FROM DEPT_SEQUENCE;
SELECT * FROM DEPT_SEQUENCE ORDER BY DEPTNO;

INSERT INTO DEPT_SEQUENCE(DEPTNO, DNAME, LOC)
VALUES (dept_seq.nextval, 'DATABASE', 'SEOUL');

-- 시퀀스 MAXVALUE 를 넘어가는 실행을 하는 경우
-- 시퀀스 DEPT_SEQ.NEXTVAL exceeds MAXVALUE 위반

-- 시퀀스 수정
ALTER SEQUENCE DEPT_SEQ
INCREMENT BY 3
MAXVALUE 99
CYCLE;

INSERT INTO DEPT_SEQUENCE(DEPTNO, DNAME, LOC)
VALUES (dept_seq.nextval, 'DATABASE', 'SEOUL');


-- 동의어 : 테이블, 뷰, 시퀀스 와 같은 객체에 대신 사용할 수 있는 이름 부여
-- CREATE SYNONYM 동의어이름 FOR 테이블명

-- EMP 테이블에 동의어 지정

CREATE SYNONYM E FOR EMP;

SELECT * FROM E;

DROP SYNONYM E;



-- ============ << 오라클 객체 생성 >> 위 내용 관련 =======================

-- SQL Error [942] [42000]: ORA-00942: 테이블 또는 뷰가 존재하지 않습니다.
-- => 처음 설정할때 Ctrl + Enter <실행> 해줘야 함, 순차적으로 <실행> 해주지 않을때 이런 오류가 발생함
-- SQL Error [955] [42000]: ORA-00955: 기존의 객체가 이름을 사용하고 있습니다.
-- => 만약 이미 한번 Ctrl + Enter <실행> 해주었다면, 두번 반복될때 이런 오류가 발생함



-- 제약조건 : 특정 열에 지정
-- 1) NOT NULL : 지정한 열에 NULL 을 허용하지 않음
-- 2) UNIQUE : 지정한 열이 유일한 값을 가져야 함
-- 3) PRIMARY KEY : 지정한 열이 유일한 값이면서 NULL 허용하지 않음(테이블 당 하나만 지정 가능)
-- 4) FOREIGN KEY : 다른 테이블의 열을 참조하여 존재하는 값만 입력
-- 5) CHECK : 설정한 조건식을 만족한느 데이터만 입력 가능

CREATE TABLE TABLE_NOTNULL(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

-- NULL을 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
-- INSERT INTO TABLE_NOTNULL VALUES ('TEST_ID_01', NULL, '010-1234-5678');
INSERT INTO TABLE_NOTNULL VALUES ('TEST_ID_01', 'TEST_PWD_01', NULL);

-- NULL을 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PWD")을 업데이트 할 수 없습니다
UPDATE TABLE_NOTNULL 
SET LOGIN_PWD = NULL 
WHERE LOGIN_ID = 'TEST_ID_01';

SELECT * FROM TABLE_NOTNULL tn;

-- 제약조건 지정 시 이름 부여
CREATE TABLE TABLE_NOTNULL2(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN2_LGNID_NN NOT NULL,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN2_LGNPWD_NN NOT NULL,
	TEL VARCHAR2(20)
);

UPDATE TABLE_NOTNULL 
SET TEL = '010-5678-9358'
WHERE LOGIN_ID = 'TEST_ID_01'

-- 기존 테이블에 제약조건 추가(TABLE_NOTNULL TEL 컬럼에 NOT NULL 제약조건 추가)
ALTER TABLE TABLE_NOTNULL MODIFY(TEL NOT NULL);

ALTER TABLE TABLE_NOTNULL2 MODIFY(TEL CONSTRAINT TBLNN_TEL_NN NOT NULL);

-- 생성한 제약조건 이름 변경
ALTER TABLE TABLE_NOTNULL2 RENAME CONSTRAINT TBLNN_TEL_NN TO TBLNN2_TEL_NN;

-- 제약조건 삭제
ALTER TABLE TABLE_NOTNULL2 DROP CONSTRAINT TBLNN2_TEL_NN;


-- -- -- [메모장] 변수명 지정 Naming Rule -- -- -- -- -- -- --

-- 헝가리안 표기법
-- intNum;
-- strNum;

-- 자바 : 카멜 표기법(단어와 단어 사이를 대문자로 구분)
-- 변수 : 소문자 maxSpeed

-- 데이터베이스 : snake 표기법(단어와 단어 사이를 언더바로 구분)
-- LOGIN_ID -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


-- 2) UNIQUE : 데이터 중복을 허용하지 않음
CREATE TABLE TABLE_UNIQUE(
	LOGIN_ID VARCHAR2(20) UNIQUE,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);


INSERT INTO TABLE_UNIQUE VALUES ('TEST_ID_01','TEST_PW_01','010-1234-5678');
SELECT * FROM TABLE_UNIQUE tu;


-- 무결성 제약 조건(SCOTT.SYS_C008393)에 위배됩니다
-- 무결성 : 데이터 정확성과 일관성

-- 중복여부만 확인(NULL 을 확인하지는 않음)
INSERT INTO TABLE_UNIQUE VALUES (NULL,'TEST_PW_01','010-1234-5678');

CREATE TABLE TABLE_UNIQUE2(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBLUNQ2_LGN_UNQ UNIQUE,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLUNQ2_LGNPW_NN NOT NULL,
	TEL VARCHAR2(20)
);


UPDATE TABLE_UNIQUE
SET TEL = '010-4567-5896'
WHERE LOGIN_ID = 'TEST_ID_01';

ALTER TABLE TABLE_UNIQUE MODIFY(TEL UNIQUE);

-- TABLE_UNIQUE2 TEL UNIQUE제약 조건 추가 : 이름(TBLUNQ_TEL_UNQ) 부여
ALTER TABLE TABLE_UNIQUE2 MODIFY(TEL CONSTRAINT TBLUNQ_TEL_UNQ  UNIQUE);

-- 제약 조건 이름 변경 TBLUNQ_TEL_UNQ => TBLUNQ2_TEL_UNQ 
ALTER TABLE TABLE_UNIQUE2 RENAME CONSTRAINT TBLUNQ_TEL_UNQ TO TBLUNQ2_TEL_UNQ;

-- 제약 조건 삭제
ALTER TABLE TABLE_UNIQUE2 DROP CONSTRAINT TBLUNQ2_TEL_UNQ;


-- 3) PRIMARY KEY(PK - 기본키) : NOT NULL + UNIQUE
-- 기본키 : 주민등록번호, 사원번호, 아이디
-- 하나의 컬럼만 지정 가능

CREATE TABLE TABLE_PK(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);


INSERT INTO TABLE_PK VALUES ('TEST_ID_01','TEST_PW_01','010-1234-5678');

-- 제약 조건을 테이블 닫는 괄호 앞 쪽에 선언
CREATE TABLE TABLE_PK2(
	LOGIN_ID VARCHAR2(20),
	LOGIN_PWD VARCHAR2(20),
	TEL VARCHAR2(20),
	PRIMARY KEY(LOGIN_ID),
--	UNIQUE(LOGIN_PWD)
	CONSTRAINT TBL_UNQ UNIQUE(LOGIN_PWD)
);

-- 4) FOREIGN KEY(외래 키)

-- 무결성 제약조건(SCOTT.FK_DEPTNO)이 위배되었습니다- 부모 키가 없습니다
-- DEPT 테이블의 DEPTNO 의 값을 기반으로 EMP 테이블의 DEPTNO 값 삽입
INSERT INTO EMP
VALUES(9999,'테스트','CLERK','7788','2017-04-30',1200,NULL,50);

-- 외래키 제약조건 테이블 생성
-- 부모테이블 생성
CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2) PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);


CREATE TABLE EMP_FK(
	EMPNO NUMBER(4,0) PRIMARY KEY,
	ENAME VARCHAR2(10),  
	JOB VARCHAR2(9),
	MRG NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
);

-- 무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO DEPT_FK VALUES(50,'DATABASE','SEOUL');
INSERT INTO DEPT_FK VALUES(10,'NETWORK','BUSAN');
INSERT INTO EMP_FK VALUES(9999,'테스트','CLERK','7788','2017-04-30',1200,NULL,50); 


-- 무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM DEPT_FK WHERE DEPTNO = 50;

DELETE EMP_FK WHERE EMPNO=9999;


-- 외래 키 제약조건이 걸린 테이블 규칙
-- 1) 삽입 시 부모 부터 데이터 삽입
-- 2) 삭제 시 자식 데이터부터 삭제

-- ON DELETE CASCADE : 부모 데이터 삭제 시 참조하고 있는 자식 데이터 같이 삭제
-- ON DELETE SET NULL : 부모 데이터 삭제 시 참조하고 있는 자식 데이터의 값을 NULL 로 변경

CREATE TABLE EMP_FK2(
	EMPNO NUMBER(4,0) PRIMARY KEY,
	ENAME VARCHAR2(10),  
	JOB VARCHAR2(9),
	MRG NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0) CONSTRAINT EMPFK2_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE CASCADE
);

INSERT INTO DEPT_FK VALUES(50,'DATABASE','SEOUL');
INSERT INTO EMP_FK2 VALUES(9999,'테스트','CLERK','7788','2017-04-30',1200,NULL,50);

DELETE FROM DEPT_FK WHERE DEPTNO = 50;


CREATE TABLE EMP_FK3(
	EMPNO NUMBER(4,0) PRIMARY KEY,
	ENAME VARCHAR2(10),  
	JOB VARCHAR2(9),
	MRG NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0) CONSTRAINT EMPFK3_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE SET NULL
);

INSERT INTO DEPT_FK VALUES(50,'DATABASE','SEOUL');
INSERT INTO EMP_FK3 VALUES(9999,'테스트','CLERK','7788','2017-04-30',1200,NULL,50);

SELECT * FROM DEPT_FK df;
SELECT * FROM EMP_FK3;

DELETE FROM DEPT_FK WHERE DEPTNO = 50;

-- 5) CHECK : 값의 범위 또는 패턴 정의

CREATE TABLE TABLE_CHECK(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_LGNPW_CK CHECK (LENGTH(LOGIN_PWD) >= 3),   -- 길이가 3 이상
	TEL VARCHAR2(20)
);

-- 체크 제약조건(SCOTT.TBLCK_LGNPW_CK)이 위배되었습니다
INSERT INTO TABLE_CHECK VALUES('TEST_ID_01','12',NULL);

-- 6) DEFALUT : 기본값 정의

CREATE TABLE TABLE_DEFAULT(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) DEFAULT '1234',   
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT VALUES('TEST_ID_01',NULL,NULL);
INSERT INTO TABLE_DEFAULT(LOGIN_ID, TEL) VALUES('TEST_ID_02',NULL);
SELECT * FROM TABLE_DEFAULT;

-- BOARD 테이블 정의
-- bno(숫자), name, password, title, content, readcnt(숫자 - default 0), regdate(날짜 - default 현재시스템 날짜)
-- 기본키 : bno, 
-- not null : name, password, title, content
CREATE TABLE board(
	bno number(8) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	title varchar2(20) NOT NULL,
	content varchar2(20) NOT NULL,
	readcnt number(8) DEFAULT 0,
	regdate DATE DEFAULT sysdate
);

-- 시퀀스 생성 : 1씩 증가 board_seq
CREATE SEQUENCE board_seq;

INSERT INTO board(bno,name,password,title,content)
VALUES(board_seq.nextval,'hong','1111','게시판','게시글 작성');

SELECT * FROM board;



-- PL/SQL : 데이터베이스 관련 특정 작업을 수행하는 명령어 / 선언문을 모아둔 블럭
-- sql + 프로그래밍

-- 블록 
-- DECLARE 
	  변수 선언(선언)
-- BEGIN
-- 	  조건문, 반복문, SELECT, DML, 함수
-- EXCEPTION
--    오류 처리
-- END;
	  
-- 실행결과를 화면에 출력	 
SET SERVEROUTPUT ON;

BEGIN
	DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL');
END;
/


-- 변수
-- 테이블 / 컬럼명 짓는 규칙과 같음
-- 숫자 : NUMBER / 문자 : VARCHAR2 / 날짜 : DATE / 논리 : BOOLEAN

DECLARE
	V_EMPNO NUMBER(4) := 7788;
	V_ENAME VARCHAR2(10);
BEGIN
	V_ENAME := 'SCOTT';
--  DBMS_OUTPUT.PUT_LINE('V_EMPNO : '|| V_EMPNO);
	DBMS_OUTPUT.PUT_LINE('V_EMPNO : '|| V_ENAME);
END;
/

-- 상수
DECLARE
	V_TAX CONSTANT NUMBER(1) := 7;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_TAX : '|| V_TAX);
END;
/

-- 변수의 기본값 지정
DECLARE
	V_TAX NUMBER(2) DEFAULT 10;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_TAX : '|| V_TAX);
END;
/

-- 변수의 null 값 저장 막기
DECLARE
--  V_TAX NUMBER(2) NOT NULL DEFAULT 10;
    V_TAX NUMBER(2) NOT NULL DEFAULT := 20;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_TAX : '|| V_TAX);
END;
/

-- 참조형(특정 테이블 열의 자료형, 행 하나의 자료 구조 참조)
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 20;
BEGIN
	DBMS_OUTPUT.PUT_LINE('V_TAX : '|| V_DEPTNO);
END;
/


DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
	SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
	FROM DEPT
	WHERE DEPTNO = 40;
	DBMS_OUTPUT.PUT_LINE('DEPTNO : '|| V_DEPT_ROW.DEPTNO);
	DBMS_OUTPUT.PUT_LINE('DNAME : '|| V_DEPT_ROW.DNAME);
	DBMS_OUTPUT.PUT_LINE('LOC : '|| V_DEPT_ROW.LOC);
END;
/


-- 조건 제어문
-- IF ~ THEN
-- IF ~ THEN ~ ELSE
-- IF ~ THEN ~ ELSIF ~ ELSE -- (ELSEIF 아님)


-- 변수의 값이 홀/짝수 구분
DECLARE
    V_NUMBER NUMBER := 15;
BEGIN
	IF MOD(V_NUMBER,2) = 1 THEN  
		DBMS_OUTPUT.PUT_LINE('V_NUMBER : '|| V_DEPTNO || ' 홀수');
	END IF;
END;
/


DECLARE
    V_NUMBER NUMBER := 18;
BEGIN
	IF MOD(V_NUMBER,2) = 1 THEN  
		DBMS_OUTPUT.PUT_LINE('V_NUMBER : '|| V_DEPTNO || ' 홀수');
	ELSE
	    DBMS_OUTPUT.PUT_LINE('V_NUMBER : '|| V_DEPTNO || ' 홀수');
	END IF;
END;
/

-- >=90, A, >=80, >=70 C, >=60 D, F
DECLARE
    V_NUMBER NUMBER := 77;
BEGIN
	IF V_NUMBER >= 90 THEN  
	   DBMS_OUTPUT.PUT_LINE('A');
	ELSIF V_NUMBER >= 80 THEN  
	   DBMS_OUTPUT.PUT_LINE('B');
	ELSIF V_NUMBER >= 70 THEN  
	   DBMS_OUTPUT.PUT_LINE('C');	
	ELSIF V_NUMBER >= 60 THEN  
	   DBMS_OUTPUT.PUT_LINE('D');
	ELSE 
	   DBMS_OUTPUT.PUT_LINE('F');
	END IF;
END;
/


DECLARE
    V_NUMBER NUMBER := 77;
BEGIN
	CASE TRUNC(V_NUMBER/10)
		WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A');
		WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('A');
		WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('B');
		WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('C');
		WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('D');
		ELSE DBMS_OUTPUT.PUT_LINE('F');
	END CASE;
END;
/

-- 반복문
--LOOP ~ END LOOP;
--WHILE ~ LOOP ~ END LOOP;
--FOR IN LOOP ~ END LOOP;

-- 종료
-- EXIT WHEN
-- CONTINUE
-- CONTINUE WHEN


DECLARE
    V_NUM NUMBER := 0;
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE('V_NUM : '|| V_NUM);
		V_NUM := V_NUM + 1;
		IF V_NUM > 4 THEN	
			EXIT;
		END IF;
	END LOOP;
END;
/


DECLARE
    V_NUM NUMBER := 0;
BEGIN
	WHILE V_NUM < 4 LOOP
		DBMS_OUTPUT.PUT_LINE('V_NUM : '|| V_NUM);
		V_NUM := V_NUM + 1;
	END LOOP;
END;
/


BEGIN
	FOR i IN 0..4 LOOP
		DBMS_OUTPUT.PUT_LINE('i : '|| i);
	END LOOP;
END;
/


BEGIN
	FOR i IN REVERSE 0..4 LOOP
		DBMS_OUTPUT.PUT_LINE('i : '|| i);
	END LOOP;
END;
/


-- 1 ~ 10 숫자 중에서 홀수만 출력
BEGIN
	FOR i IN 1..10 LOOP
		IF MOD(i, 2) = 1 THEN  
		DBMS_OUTPUT.PUT_LINE('i : '|| i);
		END IF;
	END LOOP;
END;
/


-- 커서(cursor) : SELECT 문 또는 DML 과 같은 SQL 구문 실행했을 때 
-- 해당 SQL 을 처리하는 정보를 저장한 메모리 공간 