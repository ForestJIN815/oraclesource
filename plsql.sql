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
-- 1) DML 트리거 : insert, update, delete 와 같은 DML 명령어를 기점으로 동작
-- 2) DDL 트리거 / 시스템 트리거 / 단순 트리거...

CREATE TABLE emp_trg
AS SELECT * FROM emp;

-- 트리거 생성
-- RAISE_APPLICATION_ERROR(오류코드번호, '메세지') : 강제 EXCEPTION
-- 오류코드번호 : -20000 ~ 20999 범위 사용 가능함

CREATE OR REPLACE TRIGGER TRG_NODML_WEEKEND
BEFORE 
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN 
	IF TO_CHAR(SYSDATE, 'DY') IN ('토','일') THEN 	
		IF INSERTING THEN 
			RAISE_APPLICATION_ERROR(-20000, '주말 사원정보 추가 불가');
		ELSIF UPDATING THEN
			RAISE_APPLICATION_ERROR(-20001, '주말 사원정보 수정 불가');
		ELSIF DELETING THEN
			RAISE_APPLICATION_ERROR(-20002, '주말 사원정보 삭제 불가');
		ELSE
			RAISE_APPLICATION_ERROR(-20003, '주말 사원정보 변경 불가');
		END IF;
	END IF;
END;



UPDATE EMP_TRG SET SAL = 2700 WHERE EMPNO=7844;

SELECT ** FROM EMP_TRG;


CREATE TABLE EMP_TRG_LOG(
	TABLENAME VARCHAR2(10), -- DML 이 수행된 테이블 명
	DML_TYPE VARCHAR2(10), -- DML 명령어의 종류
	EMPNO NUMBER(4), -- DML 대상이 된 사원번호
	USER_NAME VARCHAR2(30), -- DML 을 수행한 USER 이름
	CHANGE_DATE DATE, -- DML 이 수행된 날짜
);

CREATE OR REPLACE TRIGGER TRG_EMP_LOG
AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW 

BEGIN
	IF INSERTING THEN
		INSERT INTO EMP_TRG_LOG
		VALUES('EMP_TRG', 'INSERT', :NEW.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
	ELSEIF UPDATING THEN
		INSERT INTO EMP_TRG_LOG
		VALUES('EMP_TRG', 'DELETE', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
	ELSEIF DELETING THEN
		INSERT INTO EMP_TRG_LOG
		VALUES('EMP_TRG', 'DELETE', :old.empno, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
	END IF;
END;

INSERT INTO EMP_TRG
VALUES(9999, 'TESTEMP', 'CLERK', 7788, '2018-02-02', 1200, NULL, 20);

SELECT * FROM EMP_TRG;
SELECT * FROM EMP_TRG_LOG;

-- 트리거 제거
DROP TRIGGER TRG_NODML_WEEKEND;