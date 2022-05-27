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