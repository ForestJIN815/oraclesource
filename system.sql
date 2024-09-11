-- 사용자 생성 시 특정 문자열로 시작하는 user 생성을 안하겠음
-- hr(c##hr)
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;


-- scott 에게 뷰 권한 부여
GRANT CREATE VIEW TO scott; 

-- scott 에게 SYNONYM 권한 부여
GRANT CREATE SYNONYM TO scott;


-- 사용자 생성
--CREATE USER 사용자이름 IDENTIFIED BY 비밀번호
--DEFAULT TABLESPACE 테이블스페이스명
--TEMPORARY TABLESPACE 테이블스페이스 그룹명
--QUOTA 테이블스페이스크기 ON 테이블스페이스명;

-- 공통 사용자 또는 롤 이름이 부적합합니다.
-- 오라클 버전의 변화로 사용자를 생성 시 C## 붙이는 걸로 변경됨
CREATE USER C##TEST1 IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 10M ON USERS;
-- ~~~~~ 스키마 생성되고 'C##TEST1' 라는 이름으로 만들어졌다

-- 연결 권한 부여
GRANT CREATE SESSION TO C##TEST1;

-- 비밀번호 변경
ALTER USER C##TEST1 IDENTIFIED BY 54321;

-- 사용자 삭제
-- CASCADE : 사용자와 객체를 모두 삭제
-- DROP USER c##test1 CASCADE; -- 바꿔줘야 함

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 복사
-- 권한 권리
-- 1) 시스템 권한
--    사용자 생성, 수정, 삭제, 데이터베이스 접근, 오라클 데이터베이스 객체 생성 관리 권한
-- 	  ex) 데이터베이스 접속 권한 : GRANT CREATE SESSION TO C##TEST1;
-- 2) 객체 권한
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 복사

-- c##test1 : 접속, 테이블 권한 부여
CREATE USER SESSION, CREATE TABLE TO C##TEST1;