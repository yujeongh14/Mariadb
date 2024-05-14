SELECT 1;

/*** 주석 ***/
-- 주석 : 데이터베이스 객체(테이블, 열, 뷰, 저장 프로시저 등) 이나 쿼리에 추가되는 설명, 또는 메모
-- 주석 사용 이유 : 데이터베이스 스키마의 가독성과 이해를 돕기 위해 사용됨.

SHOW DATABASES;		-- 데이터베이스의 종류를 보여달라는 명령어
SHOW SCHEMAS;

/*** 주석의 종류 ***/
-- : 단일 주석
# : 단일 주석
/*
	: 여러 줄 주석
    : 다중 주석
*/
-- 단축키 : CTRL + /

/*** 명명법(nameing convention) ***/
-- Example) Republic of Korea 를 하나의 단어로 만들 때.
-- 1. 카멜 케이스 : republicOfKorea
-- 2. 파스칼 케이스 : RepublicOfKorea
-- 3. 스네이크 케이스 : repulic_of_korea
-- 4. 어퍼 스네이크 케이스 : REPUBLIC_OF_KOREA
-- 5. 케밥 케이스 : republic-of-korea
-- ==> DB는 '스네이크 케이스'를 사용함   
SHOW DATABASES;
SELECT 1;
CREATE SCHEMA `studyDB`;
show tables;

--					만들기 		보기 		수정하기 		삭제하기
-- 					CREATE 		READ		UPDATE		DELETE
--	USER			CREATE		.			ALTER		DROP
--	SCHEMA			CREATE		SHOW(S)		.			DROP
--  TABLE			CREATE		SHOW(S)		ALTER		DROP
--  RECORE			INSERT		SELECT		UPDATE		DELETE
--	엑셀 파일 : 데이터를 가지고 있는 것 X, 시트가 실제로 데이터를 가지고 있음.
--	스키마 : 데이터를 가지고 있는 것 X, 테이블이 실제로 데이터를 가지고 있음.

### 공통 사항 ###
-- 1. 키워드: 대문자 작성
-- 2. 데이터베이스의 구성요소의 이름: 소문자 작성
--							: 단어간 구분 == _(언더스코어)
--				가령, `student_scores`, `city-pops` 등 (`studentScores`, `cityPoPs` X)

-- 3. 데이터베이스의 구성요소(사용자, 호스트, 스키마, 테이블, 열 이름 등): 백틱(`)을 사용함.
-- EX) `testdb`, `name`, `age`, ect...

-- 4. 데이터베이스의 구성요소가 아닌 문자 값: 홑따옴표나(') 쌍따옴표(")를 사용함.

/*****************************/
### MYSQL DMBS 권한부여 localhost ###
/*****************************/
-- 사용자 이름(User Name)	: 데이터베이스에 로그인하는데 사용되는 식별자
--						: 데이터베이스 시스템에 특정 권한을 가질 수 있고 이를 통해 DB 객체(Instance)에 접근할 수 있음.

-- 권한(Permission)		: 1. SELECT	: 레코드 조회 			FROM 테이블
--						  2. INSERT	: NEW 레코드 삽입 	    To 	 테이블
--						  3. UPDATE	: 레코드 수정 	     	FROM 테이블 
--						  4. DELETE	: 레코드 삭제 	     	To 	 테이블
--						  5. CRAETE	: new 테이블, 뷰, 인덱스 등 생성 
--						  6. ALTER	: 테이블 구조 변경
--						  7. DROP	: 테이블, 뷰, 인덱스 등 삭제 
--						  8. GRANT	: 다른 사용자에게 권한 부여 

-- 접속한 두명의 사용자 이름이 동일하다면 어떻게 구분할까?
-- ==> 사용자 호스트(User Host)가 사용됨.

-- 사용자 호스트 (User Host): 사용자가 이름이 동일할 때 접속호스트(IP주소)가 다를 수 있음.
--						: 사용자의 정보 (사용자가 접속하는 클라이언트 컴퓨터) == 접속 구분 요소


## 생성(CREATE) ##
CREATE USER `study`@`localhost` IDENTIFIED BY 'test1234';

-- @ 			: 사용자와 호스트를 구분해주는 구분자 
-- localhost	: 로컬 호스트(현재 컴퓨터)에서만 접속이 가능함.
--				: 사용자가 직접 접근하는 컴퓨터나 서버를 의미, 외부 접속 x, 로컬 접속 o

-- IDENTIFIED BY : 암호 설정 키워드, 사용자에게 암효를 부여함.
--				: 				사용자는 암호를 알아야 접속 가능

-- 비밀번호는 구성요소가 아닌 문자열로 인식함.

SELECT `user`, `host` FROM `mysql`.`user`;



CREATE USER `study`@`%` IDENTIFIED BY 'test1234';
-- %: 와일드 카드 문자로, 모든 호스트를 나타냄
-- 어떤 호스트에서든 접속할 수 있다는 것을 의미함

GRANT SELECT ON *.* TO `study`@`localhost`;
-- 모든 DATABASE(SCHEMA)의 모든 TABLE에 관한 SELECT 권한을 `study`@`%`에 부여하겠다.

## 삭제 (DROP) ##
DROP USER `study`@`localhost`;

## 생성 (CREATE) ##
CREATE USER `study`@`localhost`IDENTIFIED BY 'test1234';

## 수정 (ALTER) ##
ALTER USER `study`@`localhost`IDENTIFIED BY 'test12345';

## 조회 ## -- 참고
SELECT `user`,`host` FROM `mysql`.`user`;

/************************/
### 권한 (PERMISSION) ###
/************************/
GRANT ALL ON *.* TO `study`@`localhost`;
-- *.*: 모든 스키마 안에 모든 테이블, 범위 설정
-- `study`@`localhost`: 여기까지 묶어서 사용자라고 함.

GRANT CREATE, SELECT ON *.* TO `study`@`localhost`;
-- 부분적으로 권한을 주고 싶을 때, ALL로 모든 권한을 주고 이거 써도 유효 X

## 회수 (REVOKE) ##
-- REVOKE ALL ON *.* FROM `study`@`localhost`;
REVOKE ALTER, DROP ON *.* FROM `study`@`localhost`;

## 적용 (FLUSH) ##
FLUSH PRIVILEGES; -- 아니면 프로그램 꺼야하니까 귀찮아서 하는 거.

## 권한 확인(SHOW) ##
# 1번 
SHOW GRANTS;
-- 현재 접속한 사용자가 가지고 있는 권한 목록을 보여줌.

# 2번 
SELECT * FROM INFORMATION_SCHEMA.USER_PRIVILEGES WHERE GRANTEE = CURRENT_USER();

#####################################################
### 문제 ###
#####################################################
### 사용자 계정 추가 ###
### 로컬 전용계정 ###
-- 문제 01)
-- 로컬에서 접속할 수 있는 유저를 생성하세요.
-- user10과 user20이라는 유저를 만들고, 비밀번홀르 모두 'study1234'로 설정하세요.
-- 권한을 즉시 적용하세요.


### 외부 접속 허용 ###
-- 문제 02)
-- 외부에서 접근을 허용하는 유저를 생성하세요.
-- user30과 user40이라는 유저를 만들고, 비밀번호를 모두 'study1234'로 설정하세요.
-- 권한을 즉시 적용하세요.
