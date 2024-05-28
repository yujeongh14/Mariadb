### 서브쿼리 (SubQuery) ###
-- 서브쿼리(SubQuery) : 하나의 SQL 문 안에 포함된 또 다른 SQL문
-- `shopdb`로 다시 돌아가보자

-- 김경호의 키 출력
SELECT * FROM `shopdb`.`usertbl` WHERE `name` = '김경호';

-- 김경호보다 큰 키를 가지고 있는 모든 열의 값
SELECT `height` FROM `shopdb`.`usertbl` WHERE `name` = '김경호';

SELECT * FROM `shopdb`.`usertbl`
WHERE `height` > (SELECT `height` FROM `shopdb`.`usertbl` WHERE `name` = '김경호'); 

-- 지역이 '경남'인 사람들의 키(height)보다 큰 레코드를 출력
SELECT `height` FROM `shopdb`.`usertbl` WHERE `address` = '경남';

-- ANY : 어느 한 행(레코드)이라도 만족한다면 모두 출력
SELECT * FROM `shopdb`.`usertbl`
WHERE `height` > ANY (SELECT `height` FROM `shopdb`.`usertbl` WHERE `address` = '경남'); 

-- ALL : 모든 행(레코드)보다 조건을 만족한다면 출력
SELECT * FROM `shopdb`.`usertbl`
WHERE `height` > ANY (SELECT `height` FROM `shopdb`.`usertbl` WHERE `address` = '경남'); 

-- 1 `shopdb`.`buytbl` amount 10인 행의 price보다 큰 행을 출력하세요(서브쿼리)
-- 서브쿼리절
SELECT `price` FROM `shopdb`.`buytbl` WHERE `amount` = 10;
-- 메인쿼리절
SELECT * FROM `shopdb`.`buytbl`
WHERE `price` > (SELECT `price` FROM `shopdb`.`buytbl` WHERE `amount` = 10);

-- 2 `shopdb`.`buytbl` userID가 k로 시작하는 행의 amount 보다 큰 행을 출력하세요(서브쿼리 + ANY)
-- 서브쿼리절
SELECT `userID` FROM `shopdb`.`buytbl` WHERE `userID` LIKE 'K%';
-- 메인쿼리절
SELECT * FROM `shopdb`.`buytbl`
WHERE `amount` > ANY (SELECT `amount` FROM `shopdb`.`buytbl` WHERE `userID` LIKE 'K%');

-- 3 `shopdb`.`buytbl` amount가 5인 행의 price보다 큰 행을 출력하세요(서브쿼리 + ALL)
-- 서브쿼리절
SELECT `price` FROM `shopdb`.`buytbl`WHERE `amount` = 5;
-- 메인쿼리절 
SELECT * FROM `shopdb`.`buytbl`
WHERE `price` > ALL (SELECT `price` FROM `shopdb`.`buytbl` WHERE `amount` = 5);
SELECT * FROM `shopdb`.`buytbl`;
