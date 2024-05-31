### 서브쿼리 (SubQuery) ###
-- 서브쿼리(SubQuery) : 하나의 SQL 문 안에 포함된 또 다른 SQL문
-- `shopdb`로 다시 돌아가보자


-- 김경호의 키 출력
SELECT * FROM `shopdb`.`usertbl` WHERE `name` = '김경호';

-- 김경호보다 큰 키를 가지고 있는 모든 열의 값
SELECT `height` FROM `shopdb`.`usertbl` WHERE `name`= '김경호';
SELECT * FROM `shopdb`.`usertbl` 
WHERE `height` > (SELECT `height` FROM `shopdb`.`usertbl` WHERE `name` = '김경호');

-- 지역이 '경남'인 사람들의 키(height)보다 큰 레코드를 출력
SELECT `height` FROM `shopdb`.`usertbl` WHERE `address` = '경남';

-- ANY : 어느 한 행(레코드)이라도 조건을 만족한다면 모두 출력
SELECT * FROM `shopdb`.`usertbl` 
WHERE `height` > ANY (SELECT `height` FROM `shopdb`.`usertbl` WHERE `address` = '경남');

-- ALL : 모든 행(레코드)보다 조건을 만족한다면 출력
SELECT * FROM `shopdb`.`usertbl` 
WHERE `height` > ALL (SELECT `height` FROM `shopdb`.`usertbl` WHERE `address` = '경남');


-- 1 `shopdb`.`buytbl` amount가 10인 행의 price보다 큰 행을 출력하세요(서브쿼리)
-- 서브쿼리절
SELECT `price` FROM `shopdb`.`buytbl` WHERE `amount` = 10;
-- 메인쿼리절
SELECT * from `shopdb`.`buytbl`
WHERE`price` > (SELECT `price` FROM `shopdb`.`buytbl` WHERE `amount` = 10);

-- 2. `shopdb`.`buytbl` userID 가 K로 시작하는 행의 amount 보다 큰 행을 출력하세요(서브쿼리 + ANY)
-- 서브쿼리절
SELECT `amount` FROM `shopdb`.`buytbl` WHERE `userID` LIKE 'K%';
-- 메인쿼리절
SELECT * from `shopdb`.`buytbl`
WHERE `amount` > ANY (SELECT `amount` FROM `shopdb`.`buytbl` WHERE `userID` LIKE 'K%');

-- 3 `shopdb`.`buytbl` amount 가 5인 행의 price보다 큰 행을 출력하세요(서브쿼리 + ALL)
-- 서브쿼리절
SELECT `price` FROM `shopdb`.`buytbl` WHERE `amount` = 5;
-- 메인쿼리절
SELECT * from `shopdb`.`buytbl`
WHERE `price` > ALL (SELECT `price` FROM `shopdb`.`buytbl` WHERE `amount` = 5);
select * from `shopdb`.`buytbl`;

desc `shopdb`.`buytbl`;

### GROUP BY ###

-- GROUP BY : SOMETHING을 그룹으로 묶어내겠다는 의미
-- GROUP BY를 하는 이유 : 통계를 내기 위해 사용됨.

-- !!! 주의사항 !!!
-- GROUP BY 할 때에,
-- GROUP BY가 되는 열이랑 통계 대상이 되는 열만 SELECT 해야 유의미한 결과를 얻을 수 있음.

-- 예를 들어 1학년 1, 2, 3반, 각반의 평균을 구한다고 가정할때,
-- 담임선생님이라는 존재는 평균을 구할 때 필요없음.
-- 따라서 만약 담임선생님이 한명이라는 전제 조건이 있다면 담임 정보를 SELECT의 열에 추가해도 됨.
-- 만약 담임이 두명이라면 결과가 부정확하게 나올 수 있음.


-- 예를 들어 SELECT `company`, `year`, MAX(`salary`)으로 통계를 내어보면 최고 연봉은 2022년 5200만원인데
--   			  2020년 5200만원 이렇게 나옴.

SELECT `company`,`year`, MAX(`salary`)
FROM `company`.`employee_salaries`
GROUP BY `company`;

-- 회사 직원들의 연도별 급여 테이블
CREATE SCHEMA `company`;

CREATE TABLE `company`.`employee_salaries` (
	`company` VARCHAR(50) NOT NULL,
    `year` YEAR NOT NULL,
    `salary` INT UNSIGNED NOT NULL
);
INSERT INTO `company`.`employee_salaries` (`company`, `year`, `salary`)
VALUES ('회사A', 2020, 50000),
	   ('회사A', 2021, 51000),
       ('회사A', 2022, 52000),
       
       ('회사B', 2020, 60000),
       ('회사B', 2021, 61000),
       ('회사B', 2022, 62000),
       
       ('회사C', 2020, 70000),
       ('회사C', 2021, 71000),
       ('회사C', 2022, 72000);
       
-- 최대 급여를 구하는 쿼리 (MAX)
SELECT `company`, MAX(`salary`) AS `최대 급여`
FROM `company`.`employee_salaries`
GROUP BY `company`;

-- 최소 급여를 구하는 쿼리 (MIN)
SELECT `company`, MIN(`salary`) AS `최소 급여`
FROM `company`.`employee_salaries`
GROUP BY `company`;



-- COUNT와 AVG집계함수
DROP TABLE `company`.`employee_salaries`;

CREATE TABLE `company`.`employee_salaries` (
	`company` VARCHAR(50) NOT NULL,
    `year` YEAR NOT NULL,
    `department` VARCHAR(50) NOT NULL,
    `salary` INT UNSIGNED NOT NULL
);


INSERT INTO `company`.`employee_salaries` (`company`, `year`, `department`, `salary`)
VALUES ('회사A', 2020, 'IT', 50000),
	   ('회사A', 2021, 'IT', 51000),
       ('회사A', 2022, 'IT', 52000),
       
       ('회사A', 2020, 'HR', 45000),
	   ('회사A', 2021, 'HR', 46000),
       ('회사A', 2022, 'HR', 47000),
       
       ('회사B', 2020, 'IT', 60000),
       ('회사B', 2021, 'IT', 61000),
       ('회사B', 2022, 'IT', 62000),
       
        ('회사B', 2020, 'HR', 55000),
       ('회사B', 2021, 'HR', 56000),
       ('회사B', 2022, 'HR', 57000),
       
       ('회사C', 2020, 'IT', 70000),
       ('회사C', 2021, 'IT', 71000),
       ('회사C', 2022, 'IT', 72000),
       
        ('회사C', 2020, 'HR', 65000),
       ('회사C', 2021, 'HR', 66000),
       ('회사C', 2022, 'HR', 67000);
       
       
       
SELECT `company`,
		`department`,
		count(*) AS `number_of_years`,
        AVG(`salary`) AS `average_salary`
FROM `company`.`employee_salaries`
GROUP BY `company`, `department`;


-- 문제
-- 각 회사에서 최고 연봉을 받았던 연도와 부서에 관련해서 SELECT
-- 회사명	 	연도		부서		최고연봉
-- 회사A		2022	IT		52000
-- 회사B		2022	IT		62000
-- 회사C		2022	IT		72000

SELECT *
FROM `company`.`employee_salaries` ;


SELECT `A`.`company` AS `회사명`, `A`.`year` AS `연도`, `A`.`department` AS `부서명`, `A`.`salary` AS `연봉`
FROM `company`.`employee_salaries` AS `A`
INNER JOIN (
	SELECT `company`, MAX(`salary`) AS `max_salary`
    FROM `company`.`employee_salaries`
    GROUP BY `company`
    ) AS `B`
ON `A`.`company` = `B`.`company` AND `A`.`salary` = `B`.`max_salary`;
    

SELECT `company`, MAX(`salary`) AS `max_salary`
    FROM `company`.`employee_salaries`
    GROUP BY `company`;



-- 회사명		최고연봉
-- 회사A		52000
-- 회사B		62000
-- 회사C		72000

SELECT * FROM `company`.`employee_salaries`;


### UNION ###
-- UNION은 전/후로 오는 SELECT 결과를 하나의 결과로 결합
-- 단, 전/후 SELECT 결과의 열의 개수가 같아야 함.
-- !!! 주의사항 !!!
-- 1, 2, 3과 4, 5, 6뒤에 ;을 찍으면 안됨.
-- 항상 마지막에 ; 찍어주기!

SELECT 1, 2, 3, 4
UNION
SELECT 4, 5, 6, 5
UNION
SELECT 7, 8, 9, 10;

SELECT `company`, MAX(`salary`), MIN(`salary`)
FROM `company`.`employee_salaries`
GROUP BY `company`;

SELECT `company` AS `회사명`, MAX(`salary`) AS `최고연봉`, MIN(`salary`) AS `최저연봉`
FROM `company`.`employee_salaries`
WHERE `company` = '회사A'
UNION
SELECT `company` AS `회사명`, MAX(`salary`) AS `최고연봉`, MIN(`salary`) AS `최저연봉`
FROM `company`.`employee_salaries`
WHERE `company` = '회사B'
UNION
SELECT `company` AS `회사명`, MAX(`salary`) AS `최고연봉`, MIN(`salary`) AS `최저연봉`
FROM `company`.`employee_salaries`
WHERE `company` = '회사C';

-- 스키마 생성
CREATE SCHEMA `university`;

-- PROFESSOR 테이블 생성
CREATE TABLE `university`.`professor` (
	`pno` INT NOT NULL 					COMMENT '교수번호',
    `pname` VARCHAR(100) NOT NULL 		COMMENT '교수이름',
    `section` VARCHAR(100) NOT NULL 	COMMENT '전공',
    `orders` VARCHAR(50)				COMMENT '직위',	
	`hiredate` DATE						COMMENT '임용일시',
    CONSTRAINT PRIMARY KEY (`pno`)
);
-- COURSE 테이블 생성
CREATE TABLE `university`.`course` (
	`cno` INT NOT NULL,							-- 과목번호
    `cname` VARCHAR(100) NOT NULL,		-- 과목이름
    `st_num` INT NOT NULL,				-- 학생수
    `pno`	INT,						-- 담당교수번호
    CONSTRAINT PRIMARY KEY (`cno`),
    CONSTRAINT FOREIGN KEY (`pno`) REFERENCES `university`.`professor`(`pno`) -- 교수번호 외래키 설정
);
-- STUDENT 테이블 생성
CREATE TABLE `university`.`student` (
	`sno` INT NOT NULL,					-- 학생번호
    `sname` VARCHAR(100) NOT NULL,		-- 학생이름
    `sex` CHAR(1),						-- 성별
    `major` VARCHAR(100),				-- 전공
    `avg` FLOAT,						-- 평점
    CONSTRAINT PRIMARY KEY (`sno`)
);

-- SCORE 테이블 생성
CREATE TABLE `university`.`score` (
	`sno` INT NOT NULL,							-- 학생번호
    `cno` INT,									-- 과목번호
    `result` FLOAT,								-- 기말고사 점수
    CONSTRAINT PRIMARY KEY (`sno`, `cno`),		-- 복합 기본키 설정
    CONSTRAINT FOREIGN KEY (`sno`) REFERENCES `university`.`student` (`sno`), 	-- 학생번호 외래키 설정
    CONSTRAINT FOREIGN KEY (`cno`) REFERENCES `university`.`course` (`cno`) 	-- 과목번호 외래키 설정
);
-- PROFESSOR 테이블 데이터 추가
INSERT INTO `university`.`professor` (`pno`, `pname`, `section`, `orders`, `hiredate`) VALUES
(1, '김영희', '컴퓨터공학', '교수' , '2010-03-15'),
(2, '이철수', '경제학', '부교수', '2015-07-20'),
(3, '박지영', '영어영문학', '조교수', '2018-01-10'),
(4, '홍길동', '수학', '전임강사', '2022-02-28');

-- COURSE 테이블 데이터 추가
INSERT INTO `university`.`course` (`cno`, `cname`, `st_num`, `pno`) VALUES
(101, '데이터베이스', 50, 1),
(102, '매크로경제학', 40, 2),
(103, '영미시', 30, 3),
(104, '미분적분학', 45, 4);

-- STUDENT 테이블 데이터 추가
INSERT INTO `university`.`student` (`sno`, `sname`, `sex`, `major`, `avg`) VALUES
-- 컴퓨터공학 전공
(1, '김철수', '남', '컴퓨터공학', 3.5),
(2, '이영희', '여', '컴퓨터공학', 3.9),
(9, '백미림', '여', '컴퓨터공학', 3.9),
(13, '송재호', '남', '컴퓨터공학', 4.0),
(17, '유수진', '여', '컴퓨터공학', 3.9),
-- 경제학 전공
(3, '박민수', '남', '경제학', 3.2),
(4, '정지영', '여', '경제학', 4.0),
(10, '김길순', '여', '경제학', 3.4),
(14, '한영희', '여', '경제학', 3.5),
(18, '장성호', '남', '경제학', 3.6),
-- 영어영문학 전공
(5, '홍길동', '남', '영어영문학', 3.8),
(6, '신영수', '남', '영어영문학', 3.7),
(11, '감병호', '남', '영어영문학', 3.3),
(15, '조민정', '여', '영어영문학', 3.8),
(19, '양미영', '여', '영어영문학', 3.1),
-- 수학 전공
(7, '임철호', '남', '수학', 3.1),
(8, '오미나', '여', '수학', 3.6),
(12, '문지수', '여', '수학', 3.7),
(16, '신동호', '남', '수학', 3.2),
(20, '권철수', '남', '수학', 3.5);

-- 성적 데이터 추가
INSERT INTO `university`.`score` (`sno`, `cno`, `result`) VALUES
-- 데이터베이스 과
(1, 101, 85.5), (2, 101, 78.0), (9, 101, 92.3), (13, 101, 75.8), (17, 101, 95.0),
-- 경제학 과
(3, 102, 80.5), (4, 102, 72.0), (10, 102, 85.3), (14, 102, 78.8), (18, 102, 90.0),
-- 영미시 과
(5, 103, 88.5), (6, 103, 82.0), (11, 103, 95.3), (15, 103, 87.8), (19, 103, 91.0),
-- 영미시 과
(7, 104, 90.5), (8, 104, 85.0), (12, 104, 93.3), (16, 104, 88.8), (20, 104, 97.0);
SELECT * FROM `university`.`professor`;
SELECT * FROM `university`.`student`;
SELECT * FROM `university`.`score`;
SELECT * FROM `university`.`course`;


-- 과목번호	과목이름		학생번호		학생이름	전공			최고점수
-- 101		데이터베이스		17		유수진	컴퓨터공학		95
-- 102		매크로경제학		18		장성호	경제학		90
-- 103		영미시			11		감병호	영어영문학		95.3
-- 104		미분적분학			20		권철수	수학			97

-- 서브쿼리를 FROM 기준으로 풀기 - 1     SCORE 테이블 FROM 기준으로 풀기 - 2


-- 서브쿼리를 FROM 기준으로 풀기
-- 과목별 기말고사 최고점 조회하는데, 과목번호, 과목이름, 학생번호, 학생이름, 전공, 최고점수

SELECT `A`.`cno` AS `과목번호`,
	   `A`.`cname` AS `과목이름`,
       `st`.`sno`   AS `학생번호`,
	   `st`.`sname` AS `학생이름`,
       `st`.`major` AS `전공`,
       `ssc`.`result` AS `최고점수`
FROM (
	SELECT `sc`.`cno` AS `cno`,
			`c`.`cname` AS `cname`,
			MAX(`sc`.`result`) AS `max_result`
	FROM `university`.`score` AS `sc`
	INNER JOIN `university`.`course` AS `c` 
	ON `sc`.`cno` = `c`.`cno`
	GROUP BY `sc`.`cno`, `c`.`cname`
) AS `A`
INNER JOIN `university`.`score` AS `ssc` 
ON `A`.`cno` = `ssc`.`cno` AND `ssc`.`result` = `A`.`max_result`
INNER JOIN `university`.`student` AS `st`
ON `st`.`sno` = `ssc`.`sno`
ORDER BY `A`.`cno`;






















