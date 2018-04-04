-- 유저 테이블(회원,관리자,탈퇴한회원)
DROP TABLE namiya_user;
CREATE TABLE namiya_user (
   id VARCHAR2(100) PRIMARY KEY, -- 아이디(이메일형식)
   password VARCHAR2(100) NOT NULL, -- 패스워드
   nickname VARCHAR2(100) NOT NULL, -- 닉네임
   logindate	date	default sysdate,
   grade VARCHAR2(1) DEFAULT 'm' -- 회원상태 여부. 회원:m, 관리자:a, 탈퇴한회원:d 
);


-- 게시판 테이블
DROP TABLE namiya_post;
CREATE TABLE namiya_post (
    p_no NUMBER PRIMARY KEY, -- 게시글 글번호(시퀀스)
    p_title VARCHAR2(100) NOT NULL, -- 게시글 제목
    p_content CLOB NOT NULL, -- 게시글 글내용
    p_date DATE DEFAULT SYSDATE, -- 게시글 등록일
    p_lock VARCHAR2(1) NOT NULL, -- 게시글공개여부. n:공개, y:비공개
    reply NUMBER DEFAULT 0, -- 답변 여부. 0이면 답변 없음, 1이면 답변 있음
    id VARCHAR2(100) NOT NULL, -- 유저 아이디(참조키)
    CONSTRAINT fk_namiya_id FOREIGN KEY(id) REFERENCES namiya_user(id) ON DELETE CASCADE
);
-- 게시판 글번호 시퀀스
DROP SEQUENCE namiya_post_seq;
CREATE SEQUENCE namiya_post_seq;


-- 답변 테이블
DROP TABLE namiya_answer;
CREATE TABLE namiya_answer (
    p_no NUMBER PRIMARY KEY, -- 게시글 글번호(참조키)
    a_title VARCHAR2(100) NOT NULL, -- 답변 제목
    a_content CLOB NOT NULL, -- 답변 내용
    a_date DATE DEFAULT SYSDATE, -- 답변 등록일
    CONSTRAINT fk_namiya_pno FOREIGN KEY(p_no) 
    REFERENCES namiya_post(p_no) ON DELETE CASCADE --  답변이 달린 게시글을 삭제하기위함(참조된테이블도 같이 삭제)
);

-- **namiya_user**
-- 관리자 가입
INSERT INTO namiya_user (id, password, nickname , grade ) 
VALUES('ukyi@naver.com','123','욱이','a'); 

-- 회원 가입
INSERT INTO namiya_user(id, password, nickname ) 
VALUES('test@naver.com','123','test'); 

-- 회원 조회
SELECT id, password, nickname, grade, logindate
FROM namiya_user;

--로그인 시 로그인 일자 검색
update namiya_user set logindate=sysdate where id='test@naver';

-- 개인정보 수정
UPDATE namiya_user SET nickname = '테스트1', password = '123' 
WHERE id = 'test@naver.com';

-- 회원 탈퇴 (회원 grade -> d로 업데이트)
UPDATE namiya_user SET grade = 'd'
WHERE id = 'test1@naver.com';

--현재 시간 기준 로그인시간과 격차 조회
update namiya_user set logindate=to_date('1995.12.05','yyyy.mm.dd') where id='test@naver.com';

select count(*) from namiya_uesr where MONTHS_BETWEEN
(to_char(sysdate,'yyyymmdd'),to_char(logindate,'yyyymmdd'))>36;

select id,nickname from namiya_user
where MONTHS_BETWEEN(to_char(sysdate,'yyyymmdd'),to_char(logindate,'yyyymmdd'))>36;

-- **namiya_post**
--게시글 작성
INSERT INTO namiya_post(p_no, p_title, p_content, p_lock, id) 
VALUES(NAMIYA_POST_SEQ.NEXTVAL, '여기는제목', '여기는 글내용', 'y', 'test@naver.com'); 

-- 게시글 수정
UPDATE namiya_post SET p_title = '수정된 글제목', p_content = '수정된 글내용'
WHERE id = 'test@naver.com';

-- 게시글 삭제
DELETE FROM namiya_post 
WHERE p_no = '1';

-- 게시글 조회
SELECT p_no, p_title, p_content, p_date, p_lock, reply, u.nickname
FROM namiya_user u, namiya_post p
WHERE u.id = p.id;


-- **namiya_answer**
-- 답글 작성 (해당게시글 reply -> 1로 업데이트)
UPDATE namiya_post SET reply = 1
WHERE p_no = 1;
INSERT INTO namiya_answer(p_no, a_title, a_content) 
VALUES(1, '여기는 제목', '여기는 답글내용');

-- 답글 수정
UPDATE namiya_answer SET a_title = '수정된 답글제목', a_content = '수정된 답글내용'
WHERE p_no = 1;

-- 답글 조회
SELECT a.p_no, a.a_title, a.a_content, a.a_date 
FROM namiya_answer a, namiya_post p
WHERE a.p_no = p.p_no;

-- 답글 삭제
DELETE FROM namiya_answer 

select p.p_no, p.p_title, p.p_date, p.p_lock, p.reply, p.id, u.nickname
from (select row_number() over(order by p_no desc)
rnum, p_no, p_title, p_lock, reply, id,
to_char(p_date,'yyyy.mm.dd') p_date from namiya_post)
p, namiya_user u where p.id=u.id and rnum
between 1 and 5 order by p_no desc


-- 게시글 검색 (제목별 작성자별 검색탭)
select count(*) from namiya_post where p_title like '%' || ? || '%';

-- 게시글 검색 (작성자)
select p.p_no, p.p_title, p.p_date, p.p_lock, p.reply, p.id, u.nickname
from (select row_number() over(order by p_no desc)
rnum, p_no, p_title, p_lock, reply, u.id,
to_char(p_date,'yyyy.mm.dd') p_date from namiya_post n, namiya_user u
where n.id=u.id and u.nickname = '꾸꾸' ) p,
namiya_user u where p.id=u.id and rnum
between 1 and 30 order by p_no desc
