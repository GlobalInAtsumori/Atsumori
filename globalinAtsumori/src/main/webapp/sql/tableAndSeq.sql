-- member 테이블
CREATE TABLE member (
    memberNo NUMBER NOT NULL,
    memberName VARCHAR2(20) NOT NULL,
    memberId VARCHAR2(20) NOT NULL,
    password VARCHAR2(30) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    country VARCHAR2(20) NOT NULL,
    permission VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_MEMBER PRIMARY KEY (memberNo)
);
select * from member;
-- tradePost 테이블
CREATE TABLE tradePost (
    tradePostNo NUMBER NOT NULL,
    tradeTitle VARCHAR2(100) NOT NULL,
    tradeContent VARCHAR2(3000) NOT NULL,
    cost NUMBER NOT NULL,
    status VARCHAR2(20) NOT NULL,
    customer NUMBER,
    memberNo NUMBER NOT NULL,
    createDate DATE,
    CONSTRAINT PK_TRADEPOST PRIMARY KEY (tradePostNo),
    CONSTRAINT FK_TRADEPOST_MEMBER FOREIGN KEY (memberNo) REFERENCES member(memberNo)
);

-- chatMessage 테이블
CREATE TABLE chatMessage (
    messageNo NUMBER NOT NULL,
    memberNo NUMBER NOT NULL,
    message VARCHAR2(2000) NOT NULL,
    sentAt DATE NOT NULL,
    CONSTRAINT PK_CHATMESSAGE PRIMARY KEY (messageNo)
);

-- tradeImage 테이블
CREATE TABLE tradeImage (
    tradeImgNo NUMBER NOT NULL,
    tradeImgUrl VARCHAR2(500) NOT NULL,
    tradePostNo NUMBER NOT NULL,
    CONSTRAINT PK_TRADEIMAGE PRIMARY KEY (tradeImgNo),
    CONSTRAINT FK_TRADEIMG_POST FOREIGN KEY (tradePostNo) REFERENCES tradePost(tradePostNo)
);

-- board 테이블
CREATE TABLE board2 (
    boardNo NUMBER NOT NULL,
    title VARCHAR2(100) NOT NULL,
    content VARCHAR2(3000) NOT NULL,
    createDate DATE NOT NULL,
    memberNo NUMBER NOT NULL,
    CONSTRAINT PK_BOARD PRIMARY KEY (boardNo),
    CONSTRAINT FK_BOARD_MEMBER FOREIGN KEY (memberNo) REFERENCES member(memberNo)
);

-- restaurant 테이블
CREATE TABLE restaurant (
    restNo NUMBER NOT NULL,
    restName VARCHAR2(100) NOT NULL,
    address VARCHAR2(200) NOT NULL,
    longitude NUMBER NOT NULL,
    latitude NUMBER NOT NULL,
    CONSTRAINT PK_RESTAURANT PRIMARY KEY (restNo)
);

insert into restaurant values(1, 'testRest', '영등포구 영등포동', 100, 100);
insert into restaurant values(2, '영등포역', '영등포구 영등포동', 126.90466, 37.50933);
delete from restaurant where restNo = 2;
select * from restaurant;
-- review 테이블
CREATE TABLE review (
    reviewNo NUMBER NOT NULL,
    reviewTitle VARCHAR2(100) NOT NULL,
    reviewContent VARCHAR2(3000) NOT NULL,
    memberNo NUMBER NOT NULL,
    restNo NUMBER NOT NULL,
    createDate DATE NOT NULL,
    CONSTRAINT PK_REVIEW PRIMARY KEY (reviewNo),
    CONSTRAINT FK_REVIEW_MEMBER FOREIGN KEY (memberNo) REFERENCES member(memberNo),
    CONSTRAINT FK_REVIEW_RESTAURANT FOREIGN KEY (restNo) REFERENCES restaurant(restNo)
);
select * from review;
-- reviewImage 테이블
CREATE TABLE reviewImage (
    reviewImgNo NUMBER NOT NULL,
    reviewImgUrl VARCHAR2(500) NOT NULL,
    reviewNo NUMBER NOT NULL,
    CONSTRAINT PK_REVIEWIMAGE PRIMARY KEY (reviewImgNo),
    CONSTRAINT FK_REVIEWIMG_REVIEW FOREIGN KEY (reviewNo) REFERENCES review(reviewNo)
);

drop table reviewImage;
select * from REVIEWIMAGE;
select * from review where reviewno = 4;
-- boardComment 테이블
CREATE TABLE boardComment (
    commentNo NUMBER NOT NULL,
    content VARCHAR2(1000) NOT NULL,
    createDate DATE NOT NULL,
    boardNo NUMBER NOT NULL,
    memberNo NUMBER NOT NULL,
    CONSTRAINT PK_BOARDCOMMENT PRIMARY KEY (commentNo),
    CONSTRAINT FK_BOARDCOMM_MEMBER FOREIGN KEY (memberNo) REFERENCES member(memberNo),
    CONSTRAINT FK_BOARDCOMM_BOARD FOREIGN KEY (boardNo) REFERENCES board2(boardNo)
);

-- member 테이블용 시퀀스
CREATE SEQUENCE member_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- tradePost 테이블용 시퀀스
CREATE SEQUENCE tradepost_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- chatMessage 테이블용 시퀀스
CREATE SEQUENCE chatmessage_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- tradeImage 테이블용 시퀀스
CREATE SEQUENCE tradeimage_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- board 테이블용 시퀀스
CREATE SEQUENCE board_seq2
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- restaurant 테이블용 시퀀스
CREATE SEQUENCE restaurant_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- review 테이블용 시퀀스
CREATE SEQUENCE review_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- reviewImage 테이블용 시퀀스
CREATE SEQUENCE reviewimage_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- boardComment 테이블용 시퀀스
CREATE SEQUENCE boardcomment_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
