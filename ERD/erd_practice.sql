
/* Drop Triggers */

DROP TRIGGER TRI_board_dno;
DROP TRIGGER TRI_lecture_lec_no;
DROP TRIGGER TRI_reply_rno;



/* Drop Tables */

DROP TABLE admins CASCADE CONSTRAINTS;
DROP TABLE reply CASCADE CONSTRAINTS;
DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE NEW_TABLE CASCADE CONSTRAINTS;
DROP TABLE lecture CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_board_dno;
DROP SEQUENCE SEQ_lecture_lec_no;
DROP SEQUENCE SEQ_reply_rno;




/* Create Sequences */

CREATE SEQUENCE SEQ_board_dno INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_lecture_lec_no INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_reply_rno INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE admins
(
	updatedate date DEFAULT SYSDATE,
	id varchar2(30) NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE board
(
	dno number(10,0) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(2000) DEFAULT 'null',
	writer varchar2(30) NOT NULL,
	PRIMARY KEY (dno)
);


CREATE TABLE lecture
(
	lec_no number(10,0) NOT NULL,
	teacher varchar2(30) DEFAULT 'null',
	subject varchar2(30) DEFAULT 'null',
	PRIMARY KEY (lec_no)
);


CREATE TABLE members
(
	id varchar2(30) NOT NULL,
	name varchar2(30) NOT NULL,
	regdate date DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE NEW_TABLE
(
	stu_id varchar2(30) NOT NULL,
	lec_no number(10,0) NOT NULL,
	orderdate date DEFAULT SYSDATE,
	PRIMARY KEY (stu_id, lec_no)
);


CREATE TABLE reply
(
	rno number(10,0) NOT NULL,
	reply_con varchar2(500) NOT NULL,
	replydate date DEFAULT SYSDATE,
	dno number(10,0) NOT NULL,
	writer varchar2(30) NOT NULL,
	PRIMARY KEY (rno)
);



/* Create Foreign Keys */

ALTER TABLE reply
	ADD FOREIGN KEY (dno)
	REFERENCES board (dno)
;


ALTER TABLE NEW_TABLE
	ADD FOREIGN KEY (lec_no)
	REFERENCES lecture (lec_no)
;


ALTER TABLE admins
	ADD FOREIGN KEY (id)
	REFERENCES members (id)
;


ALTER TABLE board
	ADD FOREIGN KEY (writer)
	REFERENCES members (id)
;


ALTER TABLE NEW_TABLE
	ADD FOREIGN KEY (stu_id)
	REFERENCES members (id)
;


ALTER TABLE reply
	ADD FOREIGN KEY (writer)
	REFERENCES members (id)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_board_dno BEFORE INSERT ON board
FOR EACH ROW
BEGIN
	SELECT SEQ_board_dno.nextval
	INTO :new.dno
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_lecture_lec_no BEFORE INSERT ON lecture
FOR EACH ROW
BEGIN
	SELECT SEQ_lecture_lec_no.nextval
	INTO :new.lec_no
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_reply_rno BEFORE INSERT ON reply
FOR EACH ROW
BEGIN
	SELECT SEQ_reply_rno.nextval
	INTO :new.rno
	FROM dual;
END;

/




