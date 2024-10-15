create table usertbl(
	userid varchar2(20) primary key,
	name varchar2(20) not null,
	password varchar2(20) not null,
	age number(3) not null,
	email varchar2(20) not null
);

INSERT INTO USERTBL VALUES('hong123','홍길동','hong123',25,'hong123@gmail.com');

-- email 열 크기 50으로 변경
ALTER TABLE USERTBL MODIFY email VARCHAR2(50);

-- userid(hong123) 와 password(hong123)가 일치하는 회원 조회
SELECT userid,name FROM USERTBL u WHERE USERID ='hong123' AND PASSWORD ='hong123';

-- 회원 전체 조회
SELECT userid,name,age,email FROM USERTBL;


-- 비밀번호 변경
-- 아이디와 현재 비밀번호가 일치하면 새 비밀번호로 변경
UPDATE USERTBL 
SET PASSWORD = 'hong456'
WHERE USERID = 'hong123' AND PASSWORD = 'hong123';

SELECT * FROM USERTBL u;

-- 회원삭제
-- 아이디와 비밀번호 일치시 삭제
DELETE FROM USERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong123';


-- booktbl
-- code number(4) pk
-- title 텍스트(50)
-- writer 텍스트(30)
-- price number(10)

create table booktbl(
	code number(4) primary key,
	title varchar2(50) not null,
	writer varchar2(30) not null,
	price number(10) not null
);



ALTER TABLE booktbl ADD descripton VARCHAR2(1000);


-- 1000 자바의 정석 신용균 25000
INSERT INTO booktbl(code, title, writer, price)
values(1000,'자바의 정석', '신용균', 25000);
-- 1001 자바의 신 강신용 29000
INSERT INTO booktbl(code, title, writer, price)
values(1001,'자바의 신', '강신용', 29000);
-- 1002 자바의 1000제 남궁성 32000
INSERT INTO booktbl(code, title, writer, price)
values(1002,'자바의 1000제', '남궁성', 32000);
-- 1003 오라클 박응용 33000
INSERT INTO booktbl(code, title, writer, price)
values(1003,'오라클 박응용', '박응용', 33000);
-- 1004 점프투파이썬 신기성 35000
INSERT INTO booktbl(code, title, writer, price)
values(1004,'점프투파이썬 신기성', '신기성', 35000);


-- 전체 조회
SELECT * FROM booktbl;

-- 도서번호 1000 번인 도서 조회(상세조회)
SELECT * FROM booktbl WHERE code = 1000;

-- 도서번호 1001 번인 도서 가격 수정
UPDATE booktbl SET price = 45000 WHERE code = 1000;

-- 도서번호 1001 번인 도서 가격 및 상세설명 수정
UPDATE booktbl SET price = 45000, DESCRIPTION='상세 설명' WHERE code = 1001;

-- 도서번호 1004 번인 도서 삭제
DELETE FROM booktbl WHERE code = 1004;

-- 도서명 '자바' 키워드가 들어있는 도서 조회
SELECT * FROM booktbl WHERE title LIKE '%자바%';



