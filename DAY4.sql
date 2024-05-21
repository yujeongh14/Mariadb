/*******************************************/
-- ### 데이터베이스에서의 함수 ###
/*******************************************/
-- COUNT(x) : x의 개수를 반환한다.
-- x는 열(Column)이거나 리터럴(Literal)

-- CAST(x AS y) : 값 x를 y형태로 변환한다.
-- 주로 UNSIGNED인 값 들을 연산할 때 음수가 나올 가능성이 있다면 사용.
-- UNSIGNED인 값 끼리 계산하였을 때 결과로 음수가 나오면 오류가 남.

-- CAST( `대상 열` AS SIGNED) :`대상 열` 값을 SIGNED로 변경
-- CAST( `대상 열` AS UNSIGNED)  : `대상 열` 값을 UNSIGNED로 변경함.

-- CEILING(x) : 값 x에 대해 올림
SELECT CEILING(3.14);

-- FLOOR(x) : 값 x에 대해 내림
SELECT FLOOR(3.14);

-- ROUND(X) : 값 X에 대해 반올림
SELECT ROUND(3.54);

-- ROUND(A, B) : 값 A에 대해 소수점 B자리 까지 반올림
SELECT ROUND(3.141502, 2);

-- CONCAT(A, B, ...) : 주어진 값을 이어붙임
SELECT CONCAT(100, '%', '-', 'SDFSDF');

-- 문제 01
-- shopdb SCHEMA 만들기
CREATE SCHEMA `shopdb`;
-- UserTbl 만들기
-- 열 :
-- 		 userID(8자 문자 NULL X, PK)
-- 		 name(10자 문자, NUll X)
-- 		 birthYear(정수, NULL X)
-- 		 address(20자 문자, NULL X)
-- 		 mobile1(10자 문자)
-- 		 mobile2(10자 문자)
-- 		 height(정수)
-- 		 mDa10te(날짜)
CREATE TABLE `shopdb`.`userTbl` (
	`userId` VARCHAR(8) NOT NULL,
    `name` VARCHAR(10) NOT NULL,
    `birthYear` INT NOT NULL,
    `address` VARCHAR(20) NOT NULL,
    `mobile1` VARCHAR(10),
    `mobile2` VARCHAR(10),
    `height` SMALLINT,
    `mDate` DATE,
    CONSTRAINT PRIMARY KEY (`userId`)
);

drop table  `shopdb`.`userTbl` ;


-- BuyTbl 만들기
-- 열 :
-- 		 num(정수 NULL X, PK)
-- 		 userID(8자 문자, NUll X)
-- 		 prodName(10자 문자, NULL X)
-- 		 groupName(20자 문자)
-- 		 price(정수, NULL X)
-- 		 amount(정수 NULL X)

CREATE TABLE `shopdb`.`buyTbl` (
	`num` INT UNSIGNED NOT NULL,
    `userId` VARCHAR(8) NOT NULL,
    `prodName` VARCHAR(10) NOT NULL,
    `groupName` VARCHAR(20),
    `price` INT UNSIGNED NOT NULL,
    `amount` SMALLINT NOT NULL,
    CONSTRAINT PRIMARY KEY (`num`),
    CONSTRAINT FOREIGN KEY (`userId`) REFERENCES `shopdb`.`userTbl`(`userId`)
);
drop table `shopdb`.`buyTbl`;


-- 테이블 확인
DESC `shopdb`.`userTbl`;
DESC `shopdb`.`buyTbl`;


use `shopdb`;

-- Usertbl 값삽입
INSERT INTO userTbl VALUES('LSG','이승기',1987,'서울','011','1111111',182,'2008-8-8');
INSERT INTO userTbl VALUES('KBS','김범수',1979,'경남','011','2222222',173,'2012-4-4');
INSERT INTO userTbl VALUES('KKH','김경호',1971,'전남','019','3333333',177,'2007-7-7');
INSERT INTO userTbl VALUES('JYP','조용필',1950,'경기','011','4444444',166,'2009-4-4');
INSERT INTO userTbl VALUES('SSK','성시경',1979,'서울',NULL,NULL,186,'2013-12-12');
INSERT INTO userTbl VALUES('LJB','임재범',1963,'서울','016','6666666',182,'2009-9-9');
INSERT INTO userTbl VALUES('YJS','윤종신',1969,'경남',NULL,NULL,170,'2005-5-5');
INSERT INTO userTbl VALUES('EJW','은지원',1972,'경북','011','8888888',174,'2014-3-3');
INSERT INTO userTbl VALUES('JKW','조관우',1965,'경기','018','9999999',172,'2010-10-10');
INSERT INTO userTbl VALUES('BBK','바비킴',1973,'서울','010','0000000',176,'2013-5-5');


select * from userTbl;

-- Buytbl 값 삽입

INSERT INTO buyTbl VALUES(1,'KBS','운동화',NULL,30,2);
INSERT INTO buyTbl VALUES(2,'KBS','노트북','전자',1000,1);
INSERT INTO buyTbl VALUES(3,'JYP','모니터','전자',200,1);
INSERT INTO buyTbl VALUES(4,'BBK','모니터','전자',200,5);
INSERT INTO buyTbl VALUES(5,'KBS','청바지','의류',50,3);
INSERT INTO buyTbl VALUES(6,'BBK','메모리','전자',80,10);
INSERT INTO buyTbl VALUES(7,'SSK','책','서적',15,5);
INSERT INTO buyTbl VALUES(8,'EJW','책','서적',15,2);
INSERT INTO buyTbl VALUES(9,'EJW','청바지','의류',50,1);
INSERT INTO buyTbl VALUES(10,'BBK','운동화',NULL,30,2);
INSERT INTO buyTbl VALUES(11,'EJW','책','서적',15,1);
INSERT INTO buyTbl VALUES(12,'BBK','운동화',NULL,30,2);
SELECT * FROM `shopdb`.`buyTbl`;

SELECT U.`userId`, U.`name`, B.`prodName`,  B.`price`, B.`amount` FROM `shopdb`.`userTbl` AS U
INNER JOIN `shopdb`.`buyTbl` AS B ON U.`userID` = B.`userID`;





/***********************************/
### 제약 조건 ###
/***********************************/

-- 기본키 : CONSTRAINT PRIMARY KEY (`<열 이름>`,...)
-- 유니크 : CONSTRAINT UNIQUE (`<열 이름>`,...)
-- 외래키 : CONSTRAINT FOREIGN KEY (`<대상 열>`,...) REFERENCES `스키마`,`테이블` (`<참고 열>,...)
-- 단, 외래키가 걸리는 `참고 열`은 기본키이거나 UNIQUE여야 한다. 그리고 `<대상 열>`과 `<참고 열>`은 타입이 같아야 한다.

-- FOREIGN KEY ==> 중요함!!!



-- 문제
--  1 구매양(amount)가 5개 이상인 행을 출력
	SELECT * FROM `shopdb`.`buytbl` WHERE `amount` >= 5;
    
--  2 가격이(price) 50 이상 500 이하인 행의 UserID와 prodName 만 출력
	SELECT `userID`, `prodName` FROM `shopdb`.`buytbl` WHERE `price` >= 50 AND `price` <= 500;
    SELECT `userID`, `prodName` FROM `shopdb`.`buytbl` WHERE `price` between 50 and 500;

--  3 구매양(amount)이 10 이상 이거나 가격이 100 이상인 행 출력
	SELECT * FROM `shopdb`.`buyTbl` WHERE `amount` >= 10 or `price` >= 100;
    
--  4 UserID 가 K로 시작하는 행 출력
	SELECT * FROM `shopdb`.`buyTbl` WHERE `userID` LIKE 'K%';
    
--  5 상품(prodName)이 책이거나 userID가 W로 끝나는 행출력
	SELECT * FROM `shopdb`.`buyTbl` WHERE `prodName` = '책' or `userID` LIKE '%w';
    
 -- 6 groupname이 비어있지 않는 행만 출력 (<>)
	SELECT * FROM `shopdb`.`buyTbl` WHERE `groupName` != 'null';

-- 문제
--  1 userID 순으로 오름차순 정렬
	SELECT * FROM `shopdb`.`buyTbl` ORDER BY `userID` ASC;
    SELECT * FROM `shopdb`.`userTbl` ORDER BY `userID` ASC; 
    
-- 	2 price 순으로 내림차순 정렬
	SELECT * FROM `shopdb`.`buyTbl` ORDER BY `price` DESC;
    
--  3 구매양(amount)가 3이상인 행을 prodName 내림차순으로 정렬
	SELECT * FROM `shopdb`.`buyTbl` WHERE `amount` >= 3 ORDER BY `prodName` DESC;
