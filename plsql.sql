-- Ctrl + Shift + O => Output 실행됨

-- 커서(cursor) : SELECT 문 또는 DML 과 같은 SQL 구문 실행했을 때 
-- 해당 SQL 을 처리하는 정보를 저장한 메모리 공간 


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

-- 조회 결과가 여러개의 행일때
-- 명시적 커서
-- 1) 커서 선언
-- 2) 커서 열기
-- 3) FETCH (커서에서 읽어온 데이터 사용)
-- 4) 커서 닫기

DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
   
   -- 명시적 커서 선언
   CURSOR c1 IS 
   	   SELECT DEPTNO, DNAME, LOC
	   FROM DEPT
	   WHERE DEPTNO = 40;
BEGIN
	-- 커서 열기
	OPEN c1;

	-- FETCH
	FETCH c1 INTO V_DEPT_ROW;

	DBMS_OUTPUT.PUT_LINE('DEPTNO : '|| V_DEPT_ROW.DEPTNO);
	DBMS_OUTPUT.PUT_LINE('DNAME : '|| V_DEPT_ROW.DNAME);
	DBMS_OUTPUT.PUT_LINE('LOC : '|| V_DEPT_ROW.LOC);

	-- 커서 닫기
	CLOSE c1;
END;
/


-- 여러 행일 때
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
   -- 명시적 커서 선언
   CURSOR c1 IS 
   	   SELECT DEPTNO, DNAME, LOC
	   FROM DEPT;
BEGIN
	-- 커서 열기
	OPEN c1;	
	LOOP
		-- FETCH
		FETCH c1 INTO V_DEPT_ROW;
		EXIT WHEN c1%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('DEPTNO : '|| V_DEPT_ROW.DEPTNO 
			|| ' DNAME : '|| V_DEPT_ROW.DNAME
		    || ' LOC : '|| V_DEPT_ROW.LOC);
		
	END LOOP;
	
	-- 커서 닫기
	CLOSE c1;
END;
/


DECLARE
   -- 명시적 커서 선언
   CURSOR c1 IS 
   	   SELECT DEPTNO, DNAME, LOC
	   FROM DEPT;
BEGIN
	-- 커서 open, fetch, close 자동으로 실행
	FOR c1_row IN c1 LOOP	
		DBMS_OUTPUT.PUT_LINE('DEPTNO : '|| c1_row.DEPTNO 
			|| ' DNAME : '|| c1_row.DNAME
		    || ' LOC : '|| c1_row.LOC);
		   
	END LOOP;
END;
/


-- 예외 

DECLARE
	V_TAX NUMBER;
BEGIN
	SELECT dname INTO v_tax 
	FROM dept
	WHERE deptno = 10;
EXCEPTION
	WHEN value_error THEN
		DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생');
END;
/

-- 저장 서브 프로그램
-- 1) 프로시저
-- 2) 트리거

CREATE OR REPLACE PROCEDURE pro_noparam
IS 
	V_EMPNO NUMBER(4) := 7788;
	V_ENAME VARCHAR2(10);
BEGIN
	V_ENAME := SCOTT;
	DBMS_OUTPUT.PUT_LINE('V_EMPNO : '|| V_EMPNO); 
	DBMS_OUTPUT.PUT_LINE('V_ENAME : '|| V_ENAME); 
END;
/

-- SQL PLUS
-- EXECUTE pro_noparam;

-- 프로시저를 익명 블록에서 실행
BEGIN
	pro_noparam;
END;
/



-- 트리거 : 데이터베이스 안의 특정 상황이나 동작, 이벤트가 발생하는 경우 자동으로 실행되는 기능 정의
