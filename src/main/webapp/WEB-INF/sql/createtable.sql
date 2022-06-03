USE mydb6;
DROP TABLE Member;
CREATE TABLE Member (
	id VARCHAR(20) PRIMARY KEY,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    nickName VARCHAR(20) NOT NULL UNIQUE,
    inserted DATETIME NOT NULL DEFAULT NOW()
);
DELETE FROM Member;

-- 권한 테이블
DROP TABLE Auth;
CREATE TABLE Auth (
	memberId VARCHAR(20) NOT NULL,
    role VARCHAR(20) NOT NULL,
    FOREIGN KEY (memberId) REFERENCES Member(id)
);
DELETE FROM Auth;

ALTER TABLE Member
MODIFY COLUMN email VARCHAR(50) NOT NULL UNIQUE;

ALTER TABLE Member
MODIFY COLUMN password VARCHAR(100) NOT NULL;

DESC Member;
SELECT * FROM Member;
SELECT * FROM Auth;

INSERT INTO Auth
VALUES ('admin', 'ROLE_ADMIN');

DELETE FROM Auth
WHERE role = 'ROLE_ADMIN';

INSERT INTO Auth (memberId, role)
(SELECT id, 'ROLE_USER' 
FROM Member 
WHERE id NOT IN (SELECT memberId FROM Auth));

-- Board 테이블에 Member의 id 참조하는 컬럼추가
ALTER TABLE Board
ADD COLUMN memberId VARCHAR(20) NOT NULL DEFAULT 'qwer1' REFERENCES Member(id) AFTER body;
ALTER TABLE Board
MODIFY COLUMN memberId VARCHAR(20) NOT NULL;

DESC Board;
SELECT * FROM Board;

SELECT b.id, b.title, b.body, b.inserted, m.nickName, COUNT(r.id) numOfReply
FROM Board b LEFT JOIN Reply r ON b.id = r.board_id
             LEFT JOIN Member m ON b.memberId = m.id
WHERE b.id = 24;

-- Reply 테이블에 memberId 컬럼 추가(Member 테이블 id 컬럼 참조키 제약사항, not null 제약사항 추가)
DESC Reply;
SELECT * FROM Reply;
ALTER TABLE Reply
ADD COLUMN memberId VARCHAR(20) NOT NULL DEFAULT 'qwer1' REFERENCES Member(id) AFTER content;
ALTER TABLE Reply
MODIFY COLUMN memberId VARCHAR(20) NOT NULL;

DESC Member;

SELECT r.id        id, 
	   r.board_id  boardId,
	   r.content   content,
	   r.memberId  memberId,
	   m.nickName  nickName,
	   r.inserted  inserted,
       IF (r.id = 'user1', 'true', 'false') own
FROM Reply r LEFT JOIN Member m ON r.memberId = m.id 
ORDER BY id;

-- Board에 fileName 컬럼 추가??? 그러지말고 파일 테이블을 만들자(중복, Null 최소화)

CREATE TABLE File (
	id INT PRIMARY KEY AUTO_INCREMENT,
	boardId INT NOT NULL REFERENCES Board(id),
	fileName VARCHAR(255) NOT NULL
);

DESC File;
SELECT * FROM File;
DELETE FROM Board
WHERE id = '48';