DESC `studydb`.`tbl_usr`;
SELECT * FROM `studydb`.`tbl_usr`;


DROP TABLE `studydb`.`tbl_usr`;

CREATE TABLE `studydb`.`tbl_usr` (
	`index` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`age` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `name` VARCHAR(20) NOT NULL,
    `contact` VARCHAR(30) NOT NULL,
    `email` VARCHAR(30) NOT NULL,
    CONSTRAINT PRIMARY KEY (`index`)
    -- CONSTRAINT : 제약조건
    -- 제약조건이란? : DB에서 데이터 무결성(Data Integrity)를 유지,
    -- 				      데이터 일관성(Data Consistency)를 보장하기 위해 사용됨.
);

DESC `studydb`.`tbl_usr`;



### 레코드 ###
### 삽입(Insert) ###
--                ↓ 스키마   ↓ 테이블  ↓ 열,...
INSERT INTO `studydb`.`tbl_usr` ( `age`, `name`, `contact`, `email`)
                        VALUES ( 28, '김철수', '010-1234-5678', 'chulsoo.kim@example.com');
/* Error Code: 1364. Field 'index' doesn't have a default value */

INSERT INTO `studydb`.`tbl_usr` (`age`,`name`, `contact`, `email`)
                        VALUES (32, '세영', '010-8765-4321', 'seoyoung.lee@example.com');
/* 1    32    (NULL)    010-8765-4321 seoyoung.lee@example.com */



-- @ 위 코드는 오류 발생 name의 열 속성이 NOT NULL이기 때문에 반드시 name을 명시해주고 다른걸 넣어야함.--> `name` NOT NULL 일 때의 경우


INSERT INTO `studydb`.`tbl_usr` (`age`, `name`, `contact`, `email`)
                        VALUES (  45, '이서영', '010-0000-0002', 'soyeong.lee@example.com');
/* 2    45    이서영    010-0000-0002    soyeong.lee@example.com */


INSERT INTO `studydb`.`tbl_usr` (`index`, `age`, `name`, `contact`, `email`)
                        VALUES (4,    34, '박준형', '010-1234-0003', 'junhyung.park@example.com'),
                               (5,    29, '최민수', '010-5678-0004', 'minsoo.choi@example.com');
/* 3    34    박준형    010-1234-0003    junhyung.park@example.com
   4    29    최민수    010-5678-0004    minsoo.choi@example.com */
   
   ### 레코드 삭제 ###
-- DELETE FROM `<스키마>`.`<테이블>` WHERE <조건>;
DELETE FROM `studydb`.`tbl_usr` WHERE `index`=2;
SELECT * FROM `studydb`.`tbl_usr`;


### 레코드 수정 ###
-- UPDATE `<스키마>`.`<테이블>` SET `<변경할 열>` = <변경할 값> WHERE <조건>;
UPDATE `studydb`.`tbl_usr` SET `name` = '최수민' WHERE `name`='최민수';




### 레코드 조회 ###
-- SELECT <열>,... FROM `<스키마>`.`<테이블>` <기타>;
SELECT  `name` AS `이름`, `age` AS `나이`, `contact` AS `연락처`  FROM `studydb`.`tbl_usr`;
SELECT  * FROM `studydb`.`tbl_usr` 
WHERE `age` IS NULL
ORDER BY `age` DESC 
LIMIT 2;

-- 열 대신 *을 사용하게 되면 '모든 열'을 조회할 수 있다.
-- * : 모든 열
-- AS : 별명을 짓는 키워드, 조회시 별명대로 조회를 시켜줌.


-- 기타 : 
--         WHERE <조건> : 조건
--         ORDER BY <열> ASC|DESC : <열> 기준으로 정렬한다. (ASC : 오름차순, DESC : 내림차순)
--         LIMIT x : 조회되는 레코드의 개수를 x개로 제한한다.
-- !!! 주의 사항 : ORDER BY와 LIMIT 순서 지키기 !!!

  
-- ### 비교 연산자 (Comparison Operators) ### 
-- x >= y 	: x가 y이상
-- x <= y 	: x가 y이하
-- x > y 	: x가 y초과
-- x < y 	: x가 y미만
-- x = y 	: x가 y랑 같음(숫자, 문자 등)
-- x <> y 	: x가 y랑 다름

-- ### 논리 연산자 (Logical Operators) ###
-- x IS NULL 		: x가 NULL임
-- x IS NOT NULL 	: x가 NULL이 아님
-- x AND y 			: x및 y조건 둘다 참(TRUE)이어야 참을 반환
-- x OR y 			: x및 y조건 중 하나 이상이 참이면 참을 반환

-- ## 패턴 매칭 연산자 (Pattern Matching Operator) ###
-- x LIKE y 		: x가 y의 형태를 가짐
-- 	 				: % : 와일드 카드, 모든 문자열을 대체

/********************/
### 정리 ###
/********************/

-- DATABASE 확인  	: SHOW DATABASES;
-- TABLE 확인 		: SHOW TABLES;
-- SOURCE 가져오기 	: SOURCE SQL파일명
-- TABLE 구조 		: desc 테이블명

-- 삽입				: INSERT INTO 테이블명(열1,열2...) VALUES (값1,값2...);
-- 수정				: UPDATE 테이블명 SET 열이름 = 값,열이름 = 값 WHERE 열이름 = 값;
-- 삭제				: DELETE FROM 테이블명 WHERE 열이름=값;
-- 조회				: SELECT * FROM 테이블명;

-- DATABASE 생성		: create database 테이터베이스명;
-- TABLE 생성 			: create table 테이블명(열1 자료형 [제약조건],열2 자료형 [제약조건]..);
-- TABLE 구조 변경 	 	: [열추가] ALTER TABLE 테이블명 ADD COLUMN 		열이름 자료형 [제약조건] [after 열이름]
-- TABLE 구조 변경 		: [열변경] ALTER TABLE 테이블명 CHANGE COLUMN   기존열이름 바꿀열이름 자료형 [제약조건]
-- TABLE 구조 변경 	 	: [열삭제] ALTER TABLE 테이블명 DROP COLUMN.    열이름

-- TABLE삭제 			 : DROP TABLE FROM 테이블명; 

-- DB 삭제 : DROP DB명;
-- TABLE삭제 : DROP 테이블명

-- 접속하기 : 
-- mysql -u 유저명 -p -h ServerIP
