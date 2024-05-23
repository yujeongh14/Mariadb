-- SCHEMA : `region`
-- TABLE  : `provinces`
-- COLUMN : `index`					`code`			`name`
-- PROPERTY : TINYINT UNSIGNED		VARCHAR(3)		VARCHAR(3)
-- NULL   : 	x					x				x
-- KEY    : PRIMARY KEY
-- CONSTRAINT : 					UNIQUE			UNIQUE

CREATE SCHEMA `region`;
CREATE TABLE `region`.`provinces`(
	`index` TINYINT UNSIGNED NOT NULL, 
    `code` VARCHAR(3) NOT NULL, 
    `name` VARCHAR(3) NOT NULL,
     CONSTRAINT PRIMARY KEY (`index`),
     CONSTRAINT UNIQUE (`code`,`name`)
);

INSERT INTO `region`.`provinces` (`code`, `name`) 
						VALUES ('02', '서울'),
							   ('031', '경기'),
                               ('032', '인천'),
                               ('033', '강원'),
                               ('041', '충청남'),
                               ('042', '대전'),
                               ('043', '충청북'),
                               ('044', '세종'),
                               ('051','부산'),
                               ('052','울산'),
                               ('053','대구'),
                               ('054','경상북'),
                               ('055','경상남'),
                               ('061','전라남'),
                               ('062','광주'),
                               ('063','전라북'),
                               ('064','제주');

SELECT * FROM `region`.`provinces`;

-- 문제:
-- name 컬럼이 '영천'인 행의 개수를 조회하고, 결과를  code 컬럼 기준으로 정렬하세요
SELECT COUNT(*) FROM `region`.`provinces`
WHERE `name`='영천'
ORDER BY `code`;

-- 문제:
-- 이름이 '대'로 시작하는 모든 행의 code와 name을 조회하고, 결과를 code 칼럼 기준으로 정렬하세요
SELECT `code`,`name` FROM `region`.`provinces` 
WHERE `name` LIKE '대%' 
ORDER BY `code`; 

-- 문제:
-- 이름이 '남'으로 끝나는 모든 행의 code와 name을 조회하고, 결과를 code 칼럼 기준으로 정렬하세요
SELECT `code`, `name` FROM `region`.`provinces` 
WHERE `name` LIKE '%남' 
ORDER BY `code`; 

-- 문제:
-- code 칼럼이 '05'로 시작하는 모든 행의 code와 name을 조회하고, 결과를 code 칼럼 기준으로 정렬하세요
SELECT `code`, `name` FROM `region`.`provinces` 
WHERE `code` Like '05%' 
ORDER BY `code`; 

-- SCHEMA : `region`
-- TABLE  : `pops`
-- COLUMN : `index`				`year`		`province_index`		`pop`
-- PROPERTY : INT UNSIGNED		 YEAR		 TINYINT UNSIGNED		 INT UNSIGNED
-- NULL   :	 	x				 x				x					 x	
-- KEY    : PRIMARY KEY												 FOREIGN KEY(`provinces`.`index`)	
-- CONSTRAINT : 				UNIQUE		 UNIQUE

CREATE TABLE `region`.`pops`(
	`index` INT UNSIGNED NOT NULL AUTO_INCREMENT, 
    `year` YEAR NOT NULL UNIQUE, 
    `province_index` TINYINT UNSIGNED NOT NULL UNIQUE, 
    `pop` INT UNSIGNED NOT NULL,
     CONSTRAINT PRIMARY KEY (`index`),
     CONSTRAINT FOREIGN KEY (`index`) REFERENCES `region`.`provinces`(`index`)
);

INSERT INTO `region`.`pops` (`year`, `province_index`, `pop`) 
					VALUES 	('2021', 1, 9736027),
							('2020', 1, 9911088),
							('2019', 1, 10010983),
							('2021', 2, 13925862),
							('2020', 2, 13807158),
							('2019', 2, 13653984),
							('2021', 3, 3014739),
							('2020', 3, 3010476),
							('2019', 3, 3029285),
							('2021', 4, 1555876),
							('2020', 4, 1560172),
							('2019', 4, 1560571),
							('2021', 5, 2181835),
							('2020', 5, 2185575),
							('2019', 5, 2194384),
							('2021', 6, 1469543),
							('2020', 6, 1480777),
							('2019', 6, 1493979),
							('2021', 7, 1633472),
							('2020', 7, 1637897),
							('2019', 7, 1640721),
							('2021', 8, 376779),
							('2020', 8, 360907),
							('2019', 8, 346275),
							('2021', 9, 3396109),
							('2020', 9, 3438710),
							('2019', 9, 3466563),
							('2021', 10, 1138419),
							('2020', 10, 1153901),
							('2019', 10, 1168469),
							('2021', 11, 2412642),
							('2020', 11, 2446144),
							('2019', 11, 2468222),       
							('2021', 12, 2677709),
							('2020', 12, 2691891),
							('2019', 12, 2723955),
							('2021', 13, 3377331),
							('2020', 13, 3407455),
							('2019', 13, 3438676),
							('2021', 14, 1865459),
							('2020', 14, 1884455),
							('2019', 14, 1903383),
							('2021', 15, 1462545),
							('2020', 15, 1471385),
							('2019', 15, 1480293),
							('2021', 16, 1817186),
							('2020', 16, 1835392),
							('2019', 16, 1851991),
							('2021', 17, 697476),
							('2020', 17, 697578),
							('2019', 17, 696657);

SELECT `code`,`name`, `pop`
FROM `region`.`provinces`
INNER JOIN `region`.`pops`
ON `provinces`.`index` = `pops`.`index`

-- CAST(`some_col` AS SIGNED). 주로 UNSIGNED인 값들을 연산할 때 음수가 나올 가능성이 있다면 사용.

-- 대비율 = (21년도 인구 수 - 19년도 인구 수) / 19년도 인구 수 X 100

-- 소수점 두자리까지 반올림 % 


-- 지역번호 지역명		2019년 인구	 	2020년 인구 	2021년 인구 	대비(19~21)	대비율(19~21)
-- 02		서울		10010983		9911088		9736027		-274956		-2.75%
-- 051		부산		3466563			3438710		3396109		-70454		-2.03%
-- 055		경상남	3438676			3407455		3377331		-61345		-1.78%
-- 053		대구		2468222			2446144		2412642		-55580		-2.25%
-- 054		경상북	2723955			2691891		2677709		-46246		-1.70%
-- 061		전라남	1903383			1884455		1865459		-37924		-1.99%
-- 063		전라북	1851991			1835392		1817186		-34805		-1.88%
-- 052		울산		1168469			1153901		1138419		-30050		-2.57%
-- 042		대전		1493979			1480777		1469543		-24436		-1.64%
-- 062		광주		1480293			1471385		1462545		-17748		-1.20%
-- 032		인천		3029285			3010476		3014739		-14546		-0.48%
-- 041		충청남	2194384			2185575		2181835		-12549		-0.57%
-- 043		충청북	1640721			1637897		1633472		-7249		-0.44%
-- 033		강원		1560571			1560172		1555876		-4695		-0.30%
-- 064		제주		696657			697578		697476		819			0.12%
-- 044		세종		346275			360907		376779		30504		8.81%
-- 031		기		13653984		13807158	13925862	271878		1.99%








 