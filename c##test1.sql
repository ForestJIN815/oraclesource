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