SELECT 1;

/*** 주석 ***/
-- 주석 : 데이터베이스 객체(테이블, 열, 뷰, 저장 프로시저 등) 이나 쿼리에 추가되는 설명, 또는 메모
-- 주석 사용 이유 : 데이터베이스 스키마의 가독성과 이해를 돕기 위해 사용됨.

SHOW DATABASES;		-- 데이터베이스의 종류를 보여달라는 명령어
SHOW SCHEMAS;

/*** 주석의 중료 ***/
-- : 단일 주석
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

--					만들기 		보기 		수정하기 		삭제하기
-- 					CREATE 		READ		UPDATE		DELETE
--	USER			CREATE		.			ALTER		DROP
--	SCHEMA			CREATE		SHOW(S)		.			DROP
--  TABLE			CREATE		SHOW(S)		ALTER		DROP
--  RECORE			INSERT		SELECT		UPDATE		DELETE
--	엑셀 파일 : 데이터를 가지고 있는 것 X, 시트가 실제로 데이터를 가지고 있음.
--	스키마 : 데이터를 가지고 있는 것 X, 테이블이 실제로 데이터를 가지고 있음.