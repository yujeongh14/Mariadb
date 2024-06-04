### CONSTRAINT OPTIONS ###
-- CASCADE : '순차적인' 의미

-- ON DELETE CASCADE : 삭제됐을 때 순차적으로, 또는 연쇄적으로
-- ON UPDATE CASCADE : 수정됐을 때 순차적으로, 또는 연쇄적으로

-- ==> 부모 테이블의 데이터가 변경될 때 자식 테이블의 데이터에 자동으로 연쇄적으로 변경을 적용하는 방식

-- 만약, CASCADE가 없을 경우 수정, 삭제가 안됨.


-- WHY? --> 외래키가 걸려있는 애(자식 테이블)가 건 애 (부모 테이블)을 바라보고 있으니깐.
-- 그래서 얘네를 쓰게 되면 삭제나 수정을 간편하게 할 수 있음.


-- ## 형식 ##
-- CONSTRAINT FOREIGN KEY ----- REFERENCES -----
-- ON DELETE CASCADE
-- ON UPDATE CASCADE



CREATE SCHEMA `site`;

CREATE TABLE `site`.`user_statuses` (
	`index` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(20) NOT NULL,
    CONSTRAINT PRIMARY KEY (`index`),
    CONSTRAINT UNIQUE (`code`)
);

INSERT INTO `site`.`user_statuses` (`code`)
VALUES ('NORMAL'),
	   ('SUSPENDED'),
       ('DELETED');
       
SELECT * FROM `site`.`user_statuses`
ORDER BY `index`;

CREATE TABLE `site`.`user_contact_providers` (
	`index` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(10) 	NOT NULL,
    `name` VARCHAR(10)	NOT NULL,
    CONSTRAINT PRIMARY KEY (`index`),
    CONSTRAINT UNIQUE (`code`)
);

INSERT INTO `site`.`user_contact_providers` (`code`, `name`)
VALUES ('KT', 'KT'),
	   ('SKT', 'SKT'),
       ('LGU+', 'LGU+');

SELECT * FROM `site`.`user_contact_providers`;

CREATE TABLE `site`.`user_genders` (
	`index` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(10) NOT NULL,
    `name` VARCHAR(10) NOT NULL,
    CONSTRAINT PRIMARY KEY (`index`),
    CONSTRAINT UNIQUE(`code`)
);

INSERT INTO `site`.`user_genders` (`code`, `name`)
VALUES ('FEM', '여자'),
       ('MAL', '남자');

SELECT * FROM `SITE`.`user_genders`;       

CREATE TABLE `site`.`users` (
	`index` 					INT UNSIGNED 		NOT NULL AUTO_INCREMENT,
    `email`						VARCHAR(50)			NOT NULL,
    `password`					VARCHAR(128)		NOT NULL,
    `created_at`				DATETIME			NOT NULL DEFAULT NOW(),
    `updated_at`				DATETIME 			NOT NULL DEFAULT NOW(),
    `status_index`				TINYINT UNSIGNED	NOT NULL,
    `nickname`					VARCHAR(10)			NOT NULL,
    `name`						VARCHAR(10)			NOT NULL,
    `birth`						DATE				NOT NULL,
    `gender_index`				TINYINT UNSIGNED	NOT NULL,
    `contact_provider_index` 	TINYINT UNSIGNED 	NOT NULL COMMENT '연락처 통신사',
    `contact_first`				VARCHAR(4)			NOT NULL,
	`contact_second`			VARCHAR(4)			NOT NULL,
    `contact_third`				VARCHAR(4)			NOT NULL,
    `address_postal`			VARCHAR(5)			NOT NULL COMMENT '주소 우편번호',
    `address_primary`			VARCHAR(100)		NOT NULL COMMENT '주소 기본',
    `address_secondary`			VARCHAR(100)		NOT NULL COMMENT '주소 상세',
    CONSTRAINT PRIMARY KEY (`index`),
    CONSTRAINT UNIQUE (`email`),
    CONSTRAINT UNIQUE (`nickname`),
    CONSTRAINT UNIQUE (`contact_first`, `contact_second`, `contact_third`),
    CONSTRAINT FOREIGN KEY (`status_index`) REFERENCES `site`.`user_statuses` (`index`)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY (`gender_index`) REFERENCES `site`.`user_genders` (`index`)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY (`contact_provider_index`) REFERENCES `site`.`user_contact_providers` (`index`)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO `site`.`users` 
(`email`, `password`, `status_index`, `nickname`, `name`, `birth`, `gender_index`, `contact_provider_index`, 
`contact_first`, `contact_second`, `contact_third`, `address_postal`, `address_primary`, `address_secondary`)
VALUES ('koreaqkqh@naver.com', 'test1234', '1', 'KoreaIT', '코리아', '2000-11-11', '2', 
'3', '010', '1234', '1234', '12345', '대구광역시 중구 중앙대로 366', '10층');

INSERT INTO `site`.`users` 
(`email`, `password`, `status_index`, `nickname`, `name`, `birth`, `gender_index`, `contact_provider_index`, 
`contact_first`, `contact_second`, `contact_third`, `address_postal`, `address_primary`, `address_secondary`)
VALUES ('koreaqkqh2@naver.com', '1234test', '1', 'ABC', '에이비씨', '1970-02-11', '1', 
'2', '010', '1111', '2222', '31045', '서울특별시 테헤란로 12-1', '');

SELECT * FROM `site`.`users`;


-- 순번 이메일					가입일시		     수정 일시		 		 상태코드	 닉네임	  실명	생년월일	    
-- 1  koreaqkqh@naver.com	2024-06-04 20:21:52  2024-06-04 20:21:52  NORMAL  KoreaIT  코리아	2000-11-11  
-- 2  koreaqkqh2@naver.com	2024-06-04 20:21:53  2024-06-04 20:21:53  NORMAL  ABC	  에이비씨	1970-02-11  

-- 성별 통신사  연락처  	      우편번호    기본주소 					상세주소	
-- 남자	LGU+  010-1234-1234	12345	대구광역시 중구 중앙대로 366	10층
-- 여자	SKT  010-1111-2222	31045	서울특별시 테헤란로 12-1	
SELECT `user`.`index` AS '순번',
	   `user`.`email` AS '이메일',
       `user`.`created_at` AS '가입 일시',
       `user`.`updated_at` AS '수정 일시',
       `user_status`.`code` AS '상태 코드',
       `user`.`nickname` AS '닉네임',
       `user`.`name` AS '실명',
       `user`.`birth` AS '생년월일',
       `user_gender`.`name` AS '성별',
		`user_contact_provider`.`name` AS '통신사',
        CONCAT(`user`.`contact_first`, '-', `user`.`contact_second`, '-', `user`.`contact_third`) AS '연락처',
       `user`.`address_postal` AS '우편번호',
       `user`.`address_primary` AS '기본주소',
	   `user`.`address_secondary` AS '상세주소'
FROM `site`.`users` AS `user`
LEFT JOIN `site`.`user_statuses` AS `user_status` ON `user`.`status_index` = `user_status`.`index`
LEFT JOIN `site`.`user_genders` AS `user_gender` ON `user`.`gender_index` = `user_gender`.`index`
LEFT JOIN `site`.`user_contact_providers` AS `user_contact_provider` 
ON `user_contact_provider`.`index` = `user`.`contact_provider_index`;



CREATE TABLE `site`.`hotels` (
	`index`						INT UNSIGNED 		NOT NULL AUTO_INCREMENT,
    `name`						VARCHAR(50)			NOT NULL,
    `description`				VARCHAR(1000)		NOT NULL,
    `contact_country`			VARCHAR(3)			NOT NULL,
    `contact_first`				VARCHAR(4)			NOT NULL,
	`contact_second`			VARCHAR(4)			NOT NULL,
    `contact_third`				VARCHAR(4)			NOT NULL,
	`address_postal`			VARCHAR(5)			NOT NULL COMMENT '주소 우편번호',
    `address_primary`			VARCHAR(100)		NOT NULL COMMENT '주소 기본',
    `address_secondary`			VARCHAR(100)		NOT NULL COMMENT '주소 상세',
    CONSTRAINT PRIMARY KEY (`index`)
);
  



INSERT INTO `site`.`hotels` (`name`, `description`, `contact_country`, `contact_first`, `contact_second`, `contact_third`,
`address_postal`, `address_primary`, `address_secondary`)
VALUES ('아난티 힐튼 부산',
		'Hilton CleanStay 기준을 합격한 부산으로 최적의 여행을 떠나 무료 주차를 즐겨보세요. 부산의 기장군에 위치한 본 숙소는 관광 명소 및 흥미로운',
        '082', '051', '509', '1111', '46083', '부산 기장군 지장읍 기장해안로 268-32', ''),
        ('시그니엘 서울',
		'주차 및 Wi-Fi가 항상 무료로 제공되므로 언제든지 차량을 입출차할 수 있으며 연락을 취하실 수 있습니다. 서울의 송파에 위치한 본 숙소는 관광 명소',
        '082', '02', '3213', '1000', '05551', '서울 송파구 올림픽로 300 롯데월드타워', '76~101층');
        
SELECT * FROM `site`.`hotels`;


CREATE TABLE `site`.`hotel_room_types` (
	`index` 				INT UNSIGNED 				NOT NULL 		AUTO_INCREMENT,
    `hotel_index`			INT UNSIGNED				NOT NULL,
    `name`					VARCHAR(50)					NOT NULL,
    `count`					SMALLINT UNSIGNED			NOT NULL		COMMENT '호텔 내 해당 객실 타입 개수',
    `size`					SMALLINT UNSIGNED			NOT NULL		COMMENT '제곱미터 단위로 적을 것',
    `desc_view`				VARCHAR(10)					NOT NULL		COMMENT '~뷰 : 오션, 마운틴, 시티',
    `price`					INT UNSIGNED 				NOT NULL		COMMENT '기본가',
    `desc_bed_single_count` TINYINT UNSIGNED			NOT NULL		COMMENT '싱글베드 개수',
    `desc_bed_double_count`	TINYINT UNSIGNED			NOT NULL		COMMENT '더블베드 개수',
    `desc_free_wifi_flag` 	BOOLEAN						NOT NULL		COMMENT '무료 WIFI 여부',
    `desc_smoke_flag`		BOOLEAN 					NOT NULL 		COMMENT '흡연 가능 여부',
    CONSTRAINT PRIMARY KEY (`index`),
    CONSTRAINT FOREIGN KEY (`hotel_index`) REFERENCES `site`.`hotels` (`index`)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);
INSERT INTO `site`.`hotel_room_types`
(`hotel_index`, `name`, `count`, `size`, `price`, `desc_view`, `desc_bed_single_count`, `desc_bed_double_count`,
`desc_free_wifi_flag`, `desc_smoke_flag`)
VALUES (1, '트윈 프리미엄', 10, 70, 420000, '마운틴', 2, 0, TRUE, FALSE),
	   (1, '킹 프리미엄', 10, 70, 420000, '마운틴', 0, 1, TRUE, FALSE),
       (1, '프리미엄 오션뷰', 5, 70, 510000, '오션', 0, 1, TRUE, FALSE),
       (2, '프리미어 더블', 10, 53, 590000, '시티', 0, 1, TRUE, FALSE),
       (2, '시그니엘 프리미어', 5, 61, 690000, '시티', 0, 1, TRUE, FALSE),
       (2, '프레지덴셜 스위트', 1, 143, 8000000, '시티', 0, 1, TRUE, FALSE);
SELECT * FROM `site`.`hotel_room_types`;

CREATE TABLE `site`.`hotel_room_charges`
(
	`hotel_index`			INT UNSIGNED	NOT NULL,
    `hotel_room_type_index`	INT UNSIGNED	NOT NULL,
    `date`					DATE			NOT NULL,
    `charge`				DOUBLE			NOT NULL,
    CONSTRAINT PRIMARY KEY (`hotel_index`, `hotel_room_type_index`, `date`),
    CONSTRAINT FOREIGN KEY (`hotel_index`, `hotel_room_type_index`) REFERENCES `site`.`hotel_room_types` (`hotel_index`, `index`)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO `site`.`hotel_room_charges` (`hotel_index`, `hotel_room_type_index`, `date`, `charge`)
VALUES (1, 1, '2022-09-05', 1),
	   (1, 2, '2022-09-05', 1),
	   (1, 3, '2022-09-05', 1),
	   (2, 4, '2022-09-05', 1),
	   (2, 5, '2022-09-05', 1),
       (2, 6, '2022-09-05', 1),
       (1, 1, '2022-09-06', 1),
	   (1, 2, '2022-09-06', 1),
	   (1, 3, '2022-09-06', 1),
	   (2, 4, '2022-09-06', 1),
	   (2, 5, '2022-09-06', 1),
       (2, 6, '2022-09-06', 1),
       (1, 1, '2022-09-07', 1),
	   (1, 2, '2022-09-07', 1),
	   (1, 3, '2022-09-07', 1),
	   (2, 4, '2022-09-07', 1),
	   (2, 5, '2022-09-07', 1),
       (2, 6, '2022-09-07', 1),
       (1, 1, '2022-09-08', 1),
	   (1, 2, '2022-09-08', 1),
	   (1, 3, '2022-09-08', 1),
	   (2, 4, '2022-09-08', 1),
	   (2, 5, '2022-09-08', 1),
       (2, 6, '2022-09-08', 1),
	   (1, 1, '2022-09-09', 1.1),
	   (1, 2, '2022-09-09', 1.1),
	   (1, 3, '2022-09-09', 1.1),
	   (2, 4, '2022-09-09', 1.25),
	   (2, 5, '2022-09-09', 1.25),
       (2, 6, '2022-09-09', 2),
       (1, 1, '2022-09-10', 1.25),
	   (1, 2, '2022-09-10', 1.25),
	   (1, 3, '2022-09-10', 1.25),
	   (2, 4, '2022-09-10', 1.5),
	   (2, 5, '2022-09-10', 1.5),
       (2, 6, '2022-09-10', 2.25),
       (1, 1, '2022-09-11', 1.1),
	   (1, 2, '2022-09-11', 1.1),
	   (1, 3, '2022-09-11', 1.1),
	   (2, 4, '2022-09-11', 1.25),
	   (2, 5, '2022-09-11', 1.25),
       (2, 6, '2022-09-11', 2);
       
SELECT * FROM `site`.`hotel_room_charges`;



        

-- 투숙 일자		호텔 이름		객실 이름		숙박 비용
-- 2022-09-05	시그니엘 서울	프레지덴셜 스위트	8000000
-- 2022-09-06	시그니엘 서울	프레지덴셜 스위트	8000000
-- 2022-09-07	시그니엘 서울	프레지덴셜 스위트	8000000
-- 2022-09-08	시그니엘 서울	프레지덴셜 스위트	8000000
-- 2022-09-09	시그니엘 서울	프레지덴셜 스위트	16000000
-- 2022-09-10	시그니엘 서울	프레지덴셜 스위트	18000000
-- 2022-09-11	시그니엘 서울	프레지덴셜 스위트	16000000

SELECT `charge`.`date` AS '투숙 일자',
	   `hotel`.`name` AS '호텔 이름',
	   `type`.`name` AS '객실 이름',
       (`charge`.`charge`) * (`type`.`price`) AS '숙박 비용'
FROM `site`.`hotel_room_charges` AS `charge`
LEFT JOIN `site`.`hotels` AS `hotel` ON `charge`.`hotel_index` = `hotel`.`index`
LEFT JOIN `site`.`hotel_room_types` AS `type` ON `type`.`index` = `charge`.`hotel_room_type_index`
WHERE `type`.`name` = '프레지덴셜 스위트';



-- DATEDIFF(a, b) : a라는 일시에서 b라는 일수를 뺀 값이 나옴.

-- 항목			값
-- 호텔 이름		시그니엘 서울
-- 체크인			2022-09-08
-- 체크아웃		2022-09-12
-- 투숙일(박)		4박
-- 숙박 비용		58000000
SELECT '항목', '값'
UNION
SELECT '호텔 이름', `hotel`.`name`
FROM `site`.`hotels` AS `hotel`
WHERE `hotel`.`name` = '시그니엘 서울'
UNION
SELECT '체크인', `charge`.`date`
FROM `site`.`hotel_room_charges` AS `charge`
WHERE `charge`.`date` = '2022-09-09'
UNION
SELECT '체크아웃', '2022-09-12'
UNION
SELECT '투숙일(박)', CONCAT(DATEDIFF('2022-09-12', '2022-09-08') , '박')
UNION
SELECT '숙박 비용', '58000000';

-- 숙박 예약 테이블 만들기 !!

-- 예약자성명  예약자 이메일 				예약자연락처		객실				체크인		체크아웃		투숙일(박) 결제 금액
-- 코리아		koreaqkqh@naver.com		010-1234-1234	프레지덴셜 스위트	2022-09-09	2022-09-10	1		16000000
-- 에이비씨	koreaqkqh2@naver.com	010-1111-2222	시그니엘 프리미어	2022-09-05	2022-09-08	3		690000
-- 에이비씨	koreaqkqh2@naver.com	010-1111-2222	시그니엘 프리미어	2022-09-05	2022-09-08	3		690000
-- 에이비씨	koreaqkqh2@naver.com	010-1111-2222	시그니엘 프리미어	2022-09-05	2022-09-08	3		690000
-- 코리아		koreaqkqh@naver.com		010-1234-1234	시그니엘 프리미어	2022-09-05	2022-09-11	6		690000
-- 코리아		koreaqkqh@naver.com		010-1234-1234	시그니엘 프리미어	2022-09-05	2022-09-11	6		690000
-- 코리아		koreaqkqh@naver.com		010-1234-1234	시그니엘 프리미어	2022-09-05	2022-09-11	6		690000
-- 코리아		koreaqkqh@naver.com		010-1234-1234	시그니엘 프리미어	2022-09-05	2022-09-11	6		690000
-- 코리아		koreaqkqh@naver.com		010-1234-1234	시그니엘 프리미어	2022-09-05	2022-09-11	6		862500
-- 코리아		koreaqkqh@naver.com		010-1234-1234	시그니엘 프리미어	2022-09-05	2022-09-11	6		1035000
