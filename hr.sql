-- EMPLOYESS (scott 계정의 emp 테이블 원본)
-- EMPLOYESS 전체 조회
SELECT * FROM EMPLOYEES e;
-- EMPLOYESS 의 first_name, last_name, job_id 조회
SELECT 
	FIRST_NAME, 
	LAST_NAME, 
	JOB_ID
FROM 
	EMPLOYEES e;

-- 사원번호가 176 인 사원의 LAST_NAME, 부서번호 조회
SELECT e.LAST_NAME, e.DEPARTMENT_ID 
FROM EMPLOYEES e 
WHERE EMPLOYEE_ID = 176;

-- 연봉이 12000 이상 되는 직원들의 LAST_NAME 과 연봉 조회
SELECT LAST_NAME, SALARY FROM EMPLOYEES e WHERE SALARY >= 12000;

-- 연봉이 5000 에서 12000 범위가 아닌 사람들의 LAST_NAME 과 연봉 조회
SELECT e.LAST_NAME, e.SALARY 
FROM EMPLOYEES e 
WHERE e.SALARY < 5000 OR e.SALARY > 12000;

-- 20번 혹은 50번 부서에서 근무하는 사원들의 last_name, 부서번호를 조회
-- 단 이름의 오름차순, 부서의 오름차순으로 정렬
SELECT E.LAST_NAME, E.DEPARTMENT_ID 
FROM EMPLOYEES e 
WHERE E.DEPARTMENT_ID = 20 OR E.DEPARTMENT_ID = 50
ORDER BY E.LAST_NAME ASC, E.DEPARTMENT_ID ASC;

-- 커미션을 버는 사람들의 last_name, salary, commission_pct 를 조회
-- 단 연봉의 내림차순, 커미션 내림차순으로 정렬
SELECT E.LAST_NAME, E.SALARY, E.COMMISSION_PCT 
FROM EMPLOYEES e 
WHERE E.COMMISSION_PCT > 0 ORDER BY E.SALARY DESC, E.COMMISSION_PCT DESC; 

-- 연봉이 2500, 3500, 7000 이 아니며 job_id 가 SA_REP OR ST_CLERK 인 사원 조회
SELECT *
FROM EMPLOYEES e
WHERE E.SALARY NOT IN (2500, 3500, 7000) AND E.JOB_ID IN('SA_REP', 'ST_CLERK');

-- 2018/02/20 ~ 2018/05/01 사이에 고용된 직원들의 LAST_NAME, EMPLOYEE_ID, 고용일자(HIRE_DATE) 조회
SELECT LAST_NAME, EMPLOYEE_ID, E.HIRE_DATE 
FROM EMPLOYEES e 
WHERE E.HIRE_DATE >= '2018-02-20' AND E.HIRE_DATE <= '2018-05-01';

-- 2015년에 고용된 사원 조회
SELECT *
FROM EMPLOYEES e 
WHERE E.HIRE_DATE >= '2015-01-01' AND E.HIRE_DATE <= '2015-12-31';


-- [BETWEEN A AND B] --

-- 20번 혹은 50번 부서에서 근무하며, 연봉이 5000 ~ 12000 사이인 직원들의
-- FIRST_NAME, LAST_NAME, 연봉 조회(연봉 오름차순)
SELECT
	E.FIRST_NAME,
	E.LAST_NAME,
	E.SALARY
FROM
	EMPLOYEES e
WHERE
	E.DEPARTMENT_ID IN(20, 50)
	AND E.SALARY BETWEEN 5000 AND 12000
ORDER BY
	E.SALARY;

-- 연봉이 5000 ~ 12000 사이가 아닌 직원들의 정보 조회
SELECT
	*
FROM
	EMPLOYEES e
WHERE
	E.SALARY NOT BETWEEN 5000 AND 12000

-- 2018/02/20 ~ 2018/05/01 사이에 고용된 직원들의 LAST_NAME, EMPLOYEE_ID, 고용일자(HIRE_DATE) 조회
SELECT LAST_NAME, EMPLOYEE_ID, E.HIRE_DATE 
FROM EMPLOYEES e 
WHERE E.HIRE_DATE BETWEEN '2018-02-20' AND '2018-05-01';


-- [LIKE] --

-- LAST_NAME 에 u 가 포함되는 사원들의 사번, last_name 조회
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE '%u%';

-- LAST_NAME 의 네번째 글자가 a 인 사원들의 사번, last_name 조회
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE '___a%';

-- LAST_NAME 에 a 혹은 e 글자가 포함되는 사원들의 사번, last_name 조회(단 last_name오름차순)
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE '%a%' OR LAST_NAME LIKE '%e%'
ORDER BY e.LAST_NAME ASC;

-- LAST_NAME 에 a 와 e 글자가 포함되는 사원들의 사번, last_name 조회(단 last_name오름차순)
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE '%a%' AND LAST_NAME LIKE '%e%' -- (1-1)
ORDER BY e.LAST_NAME ASC;

-- LAST_NAME 에 a 와 e 글자가 포함되는 사원들의 사번, last_name 조회(단 last_name오름차순)
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE LAST_NAME LIKE '%a%e%' OR LAST_NAME LIKE '%e%a%' -- (1-2)
ORDER BY LAST_NAME;


-- [IS NULL] --

-- MANAGER ID 가 없는 사원들의 LAST_NAME 및 JOB_ID 조회
SELECT E.LAST_NAME, E.JOB_ID 
FROM EMPLOYEES e 
WHERE e.MANAGER_ID IS NULL;

-- JOB_ID 가 ST_CLERK 이 아닌 사원이 없는 부서 조회
-- 단, 부서번호가 NULL 인 경우는 제외한다. (1-1)
SELECT E.DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE E.JOB_ID != 'ST_CLERK' AND E.DEPARTMENT_ID IS NOT NULL;

-- JOB_ID 가 ST_CLERK 이 아닌 사원이 없는 부서 조회
-- 단, 부서번호가 NULL 인 경우는 제외한다. (1-2)
SELECT E.DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE E.JOB_ID NOT IN ('ST_CLERK') AND E.DEPARTMENT_ID IS NOT NULL;


-- COMMISSION_PCT 가 NULL 이 아닌 사원들 중에서 COMMISION = SALARY * COMMISION_PCT 를 구한다
-- 사원번호, FIRST_NAME, JOB_ID 와 함께 조회
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, E.SALARY * E.COMMISSION_PCT AS COMMISION
FROM EMPLOYEES e 
WHERE E.COMMISSION_PCT IS NOT NULL;


-- 부서 80 의 사원에 적용 가능한 세율 표시하기
-- LAST_NAME, SALARY, TAX_RATE 출력
-- TAX_RATE 는 SALARY/2000 으로 나눈 후 버림
--			   해당 값이 0 이면 0.0 / 1, 0.09 / 2, 0.20 / 3, 0.30 / 4, 0.40 / 5, 0.42 / 6, 0.44 / 그 외 0.45  

SELECT
	LAST_NAME,
	SALARY,
	DECODE(TRUNC(SALARY / 2000),
		0, 0.00, 
		1, 0.09, 
		2, 0.20,
		3, 0.30,
		4, 0.40,
		5, 0.42,
		6, 0.44,
		0.45
	) AS TAX_RATE
FROM
	EMPLOYEES; 



-- 회사 내의 최대 연봉 및 최소 연봉의 차이를 출력
SELECT MAX(E.SALARY) - MIN(E.SALARY) AS SAL_GAP 
FROM EMPLOYEES e; 

-- 매니저로 근무하는 사원들의 총 숫자를 출력
SELECT COUNT(DISTINCT E.MANAGER_ID) AS 매니저수
FROM EMPLOYEES e; 

-- 매니저가 없는 사원들은 제외하고 매니저가 관리하는 사원들 중에서 최소 급여를 받는 사원 조회
-- (매니저가 관리하는 사원 중에서 연봉이 6000 미만 제외)
SELECT
	MANAGER_ID,
	MIN(SALARY)
FROM
	EMPLOYEES e
GROUP BY
	MANAGER_ID
HAVING
	MANAGER_ID IS NOT NULL
	AND MIN(SALARY) >= 6000
ORDER BY
	MANAGER_ID;
	


-- [join] --


-- 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기
-- 사원번호, 입사일, 이름(last_name), 매니저아이디 출력
-- employees self 조인
SELECT e.EMPLOYEE_ID, e.HIRE_DATE, e.LAST_NAME, e.MANAGER_ID
	FROM EMPLOYEES e -- (내정보) ?
	JOIN EMPLOYEES e2 -- (매니저정보) ?
	ON e.MANAGER_ID = e2.EMPLOYEE_ID
	AND e.HIRE_DATE < e2.HIRE_DATE; 


-- 도시 이름이 T 로 시작하는 지역에 사는 사원들의 정보 조회
-- 사원번호, 이름(last_name), 부서번호, 지역명
-- employees, department, locations 조인
SELECT
	e.EMPLOYEE_ID,
	e.LAST_NAME,
	d.DEPARTMENT_ID,
	l.CITY
FROM
	EMPLOYEES e
JOIN DEPARTMENTS d ON
	e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN LOCATIONS l ON
	d.LOCATION_ID = l.LOCATION_ID
WHERE
	l.CITY LIKE 'T%';


-- 각 부서별 사원 수, 평균 연봉(소수점 2자리까지) 조회
-- 부서명, 부서 위치 아이디, 부서별 사원 수, 평균 연봉 출력
-- employees, department 조인
SELECT
	d.DEPARTMENT_NAME,
	d.LOCATION_ID,
	COUNT(e.EMPLOYEE_ID),
	ROUND(AVG(e.SALARY), 2)
FROM
	EMPLOYEES e
JOIN DEPARTMENTS d ON
	e.EMPLOYEE_ID = d.DEPARTMENT_ID
GROUP BY
	d.DEPARTMENT_NAME,
	d.LOCATION_ID
ORDER BY
	d.LOCATION_ID;


-- Executive 부서에 근무하는 모든 사원들의 부서번호, 이름(last_name), job_id 조회
-- employees, department 조인
SELECT e.DEPARTMENT_ID, e.LAST_NAME, e.JOB_ID 
	FROM EMPLOYEES e 
	JOIN DEPARTMENTS d
	ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
	WHERE d.DEPARTMENT_NAME = 'Executive';


-- 기존의 직무를 계속하고 있는 사원 조회
-- 사원번호, job_id 출력
-- employees, job_history 조인
SELECT
	e.EMPLOYEE_ID,
	e.JOB_ID
FROM
	EMPLOYEES e
JOIN JOB_HISTORY jh 
	ON e.EMPLOYEE_ID = jh.EMPLOYEE_ID
	AND e.JOB_ID = jh.JOB_ID; 


-- 각 사원별 소속 부서에서 자신보다 늦게 고용되었거나 많은 급여를 받는 사원의 정보 조회
-- 부서번호, first_name 과 last_name 을 연결하여 출력, 급여, 입사일 출력
-- employees self 조인
SELECT
	DISTINCT e.department_id, -- 이거 하나 DISTINCT 하면 나머지 다 걸린다 <중복제거>
	e.first_name || ' ' || e.last_name,
	e.salary,
	e.hire_date
FROM EMPLOYEES e
JOIN EMPLOYEES e2 
ON e.department_id = e2.DEPARTMENT_ID
    AND e.hire_date < e2.HIRE_DATE
	AND e.salary < e2.SALARY
ORDER BY e.department_id;



-- [서브쿼리]로 작성
-- Executive 부서에 근무하는 모든 사원들의 부서번호, 이름(last_name), job_id 조회
-- employees, department 조인

--SELECT e.DEPARTMENT_ID, e.LAST_NAME, e.JOB_ID --------- [조인] 작성 
--	FROM EMPLOYEES e 
--	JOIN DEPARTMENTS d
--	ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
--	WHERE d.DEPARTMENT_NAME = 'Executive';

SELECT ------------------------------------------------ [서브쿼리] 작성 
	e.DEPARTMENT_ID,
	e.LAST_NAME,
	e.JOB_ID 
FROM
	EMPLOYEES e
WHERE
	 (E.DEPARTMENT_ID,'Executive') 
  IN (SELECT
	  D.DEPARTMENT_ID,
	  D.DEPARTMENT_NAME
  FROM
	  DEPARTMENTS d);
