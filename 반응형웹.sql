CREATE TABLE "USER" 
(   ID  		VARCHAR2(20) 	NOT NULL 	 PRIMARY KEY,
    PASSWORD 	VARCHAR2(20)	NOT NULL,
    NICKNAME 	VARCHAR2(20)	NOT NULL,
    PROFILE 	VARCHAR2(100) 	DEFAULT 	'resources/image/icons8-user-64.png'
 );

CREATE TABLE CONTENTS 
(   NICKNAME  	VARCHAR2(20) 	NOT NULL,
    PROFILE 	VARCHAR2(100)	DEFAULT 	'resources/image/icons8-user-64.png',
    IDX			INTEGER 		NOT NULL,
    TITLE 		VARCHAR2(100)	NOT NULL,
    CONTENT		VARCHAR2(4000)  NOT NULL,
    CATEGORY	VARCHAR2(20)	NOT NULL,
    IMAGE		VARCHAR2(1000) 			,
    WRITEDATE	TIMESTAMP  		DEFAULT 	sysdate,
    VIEWS		INTEGER			DEFAULT 	0,
    COMMENTNUM	INTEGER			DEFAULT 	0
 );

CREATE TABLE COMMENTS (
	NICKNAME  	VARCHAR2(20) 	NOT NULL,
	IDX			INTEGER 		NOT NULL,
	COMMENT_IDX INTEGER 		NOT NULL,
	COMMENT_LEV	INTEGER			NOT NULL,
	TARGET_IDX  VARCHAR2(3000)	NOT NULL,
	CONTENT		CHAR(300)  		NOT NULL,
	WRITEDATE	TIMESTAMP  		DEFAULT 	sysdate
);




/* 시퀀스 설정 들 */
CREATE SEQUENCE user_idx_seq;
   
DELETE FROM "USER";
DROP SEQUENCE user_idx_seq;
CREATE SEQUENCE user_idx_seq; 

CREATE SEQUENCE contents_idx_seq;
   
DELETE FROM CONTENTS;
DROP SEQUENCE contents_idx_seq;
CREATE SEQUENCE contents_idx_seq;

CREATE SEQUENCE comments_idx_seq;
   
DELETE FROM COMMENTS;
DROP SEQUENCE comments_idx_seq;
CREATE SEQUENCE comments_idx_seq;


SELECT * FROM USER_SEQUENCES ;

COMMIT;

/* 유저 더미 데이터 */
/* 58 ~ 60 */

INSERT INTO "USER" (ID, PASSWORD, NICKNAME) VALUES ('user1','0000', 'user' || user_idx_seq.nextval);
INSERT INTO "USER" (ID, PASSWORD, NICKNAME) VALUES ('user2','0000', 'user' || user_idx_seq.nextval);
INSERT INTO "USER" (ID, PASSWORD, NICKNAME) VALUES ('user3','0000', 'user' || user_idx_seq.nextval);

SELECT * FROM "USER";

/* 게시글 더미 데이터 */
/* 67 ~ 257 드레그 -> ALT + X * 반복 */

INSERT INTO CONTENTS (NICKNAME, IDX, TITLE, CONTENT, CATEGORY, IMAGE) 
VALUES (
	'user1', 
	contents_idx_seq.nextval, 
	'첫번째 글입니다.', 
	'블로그 게시물의 내용을 간략하게 소개하는 짧고 인상적인 부제를 추가하여 독자들의 관심을 유도하세요. 참신하고 흥미로운 블로그 게시물로 독자 및 잠재 고객과 소통하세요. 블로그 게시물은 최신 업데이트 및 비즈니스 소식을 지속적으로 공유할 수 있는...',
	'ALL', 
	'https://static.wixstatic.com/media/b2f7ef303bfa46ffa607186d757eb73f.jpg/v1/fill/w_454,h_341,fp_0.50_0.50,q_90/b2f7ef303bfa46ffa607186d757eb73f.webp'
);

INSERT INTO CONTENTS (NICKNAME, IDX, TITLE, CONTENT, CATEGORY, IMAGE) 
VALUES (
	'user1', 
	contents_idx_seq.nextval, 
	'안녕하세요!', 
	'안녕하세요!

다양한 패션아이템을 직접 체험해보고

진솔한 느낌을 담아 컨텐츠를 제작하는 유니스입니다.

요즘 사실 집에 이 브랜드 신발 하나 없는집이

없을정도로 여러가지 종류의 슈즈들이 많이 출시되고

셀럽들이 사랑하는 브랜드라

인기가 많은데요.

연말에 착용하기 좋은 부츠부터 평소에

일상룩 활용하기에도 괜찮은 슈즈를

많이 찾게되더라고요.

그리하여 오늘은

2021 크리스마스 선물 추천 하는

남자 신발 및 여자 부츠 코디를 통해

좀 더 자세하게 알아볼 수 있는 정보소식을

준비해보았고요.

지금부터 바로 보여드릴게욧! ♡♥

2021 크리스마스 선물 선물 추천 하는

닥터마틴 남자 신발 아이템', 
	'ALL',
	'resources/image/_2021_크리스마스_선물_추천_하는_남자_신발_및_닥터마틴_여자_부츠_코디_확인해욧.gif'
	
);

INSERT INTO CONTENTS (NICKNAME, IDX, TITLE, CONTENT, CATEGORY, IMAGE) 
VALUES (
	'user3', 
	contents_idx_seq.nextval, 
	'자연스럽게 주름이 지는 스타일', 
	'이런식으로 신는 모양새에 따라

자연스럽게 주름이 지는 스타일이라 함께 하는

시간만큼 더 빈티지한 멋을 더할 수 있고

서브컬처부터 컨템포러리까지 많은 사랑을 받아온

아이코닉 스타일로

편안한 에어웨어 솔을 사용해

착화감과 내구성까지 높여준 부츠랍니다.', 
	'ALL', 
	'resources/image/SE-0540504e-ee2b-41fa-bfb1-5face6a4030b.jpg'
);
INSERT INTO CONTENTS (NICKNAME, IDX, TITLE, CONTENT, CATEGORY, IMAGE) 
VALUES (
	'user2', 
	contents_idx_seq.nextval, 
	'팥죽만들기', 
	'2021년 동짓날은 12월 22일 수요일입니다. 우리나라 24절기중 밤이 가장 긴 동짓날은 작은 설이라고 불릴만큼 예전에는 중요한 절기였지요. 이날 팥죽을 쑤어 집주변에 뿌리면 악귀를 쫓아낸다는 풍습이 있었습니다. 요샌 그냥 동지팥죽 한그릇 먹음으로 액땜을 하는 의미로 끓여먹네요.

올해는 떡집에서 파는 습식 찹쌀가루를 사다가 새알심을 빚었는데, 역시 찹쌀을 갈아서 만든 습식이라 새알심이 더 쫄깃하고 맛있네요. 

장금이는 인절미같다면서 새알심만 먹겠다고 너무 좋아합니다.ㅎㅎ

동지팥죽은 단팥죽보다 단맛이 덜하구요, 개인취향껏 소금과 설탕을 적당히 넣어서 드시면 됩니다.

올해 동지팥죽은 유난히 더 맛있게 쑤어진거 같네요.ㅎㅎ

​동지 팥죽 만들기

10인분, 조리시간 60분

1작은술=5ml,1큰술=15ml,1컵=200ml

팥 500g(약3컵)

멥쌀 1.5컵

물 3.5~4리터 -->팥 삶을때 2리터, 쌀 끓일때 1.5리터
​

▶새알심 반죽

습식 찹쌀가루 3컵, 뜨거운 물 4~5큰술

굵은소금 1/2작은술(떡집에서 찹쌀가루 사올때 소금첨가유무 확인필수)

제일먼저 멥쌀 1.5컵을 씻어서 물에 2시간정도 불려줍니다.

밥알이 동동 있는 동지팥죽을 만들기위해 죽을 쑤어서 끓일거에요.

마른 팥은 물로 헹궈서 물을 넉넉하게 부어 3분정도 끓여줍니다.

그리고 팥의 사포닌을 제거하기 위해서 한번 살짝 끓여주는거라 끓인 물은 모두 버리고 팥은 헹궈서~

압력솥에 팥과 물 2리터를 부어서 뚜껑 닫아 센불로 켜서~

추가 흔들리기 시작하면 중불로 줄여 20여분 끓여줍니다.

- 팥죽 쑤면서 농도를 보고 물을 조금 가감하세요. 끓일때는 묽어도 뜸들이면 더 되직해지니 주의!!

- 습식 찹쌀가루 수분정도에 따라 들어가는 물양이 다를수 있습니다. 반죽이 너무 질면 손에 들러붙어 동글동글하게 안만들어져요.

- 새알심 마른 찹쌀가루로 만들때는 마른 찹쌀가루 1.5컵, 뜨거운 물 10~11큰술, 굵은소금 1/2작은술
​

말랑말랑 새알심 넣는 장면을 담아봤는데요,

새알심 떨어지는 소리를 듣고 이상한 상상 금지!!ㅋㅋㅋ', 
	'ALL',
	'resources/image/IMG_5949.jpg'
	
);
INSERT INTO CONTENTS (NICKNAME, IDX, TITLE, CONTENT, CATEGORY, IMAGE) 
VALUES (
	'user3', 
	contents_idx_seq.nextval, 
	'안녕하세요 쭈은맘의 맛있는 이야기', 
	'안녕하세요 쭈은맘의 맛있는 이야기

쭈은맘이에요

지난 주말에는 색다른 별미를 맛보러 

발산역 맛집에 다녀왔어요

일반 초밥과는 남다른 비주얼을 한 긴꼬리 스시의 매력에 행복지수가 올라간 장소엿어요


​톡선초밥+반우동 17,000

주소 강서구 공항대로 269-15 힐스테이트에코마곡 201호 긴꼬리초밥

번호 02-3662-7005 

영업시간 :매일 11:30 -22:00 브레이크타임 15:30 -17:00

​1.긴꼬리초밥

이때 갔던 긴꼬리초밥은 발산역 9번 출구로 나와서 2분만 걸으면 바로 보였어요.

빌딩 외벽에 광고판이 붙어 있어 발견하기 쉬웠고, 지하에 주차도 가능하다길래 편의성이 돋보였어요.

​실내는 카페가 아닌가 싶을 정도로 세련되게 

꾸며져 있어 놀라웠어요.

좌석수도 많은 편이라 손님이 몰리는 피크타임에 와도 오래 안 기다리겠다 싶었어요.

테이블에는 락교, 초새강, 간장, 종지, 병따개 등이 놓여 있었어요. 자리마다 비치되어 있어 번거롭게 요청할 필요가 없다는 점이 좋게 와닿았어요.', 
	'ALL',
	'resources/image/1.jpg'
);

INSERT INTO CONTENTS (NICKNAME, IDX, TITLE, CONTENT, CATEGORY) 
VALUES (
	'user1', 
	contents_idx_seq.nextval, 
	'환영합니다.4', 
	'
인성정보(대표 원종윤)가 공식 페이스북 페이지 및 네이버 블로그 오픈을 통해 고객과의 접점을 확대하고 소통에 나선다고 15일 밝혔다.

이번에 개설한 인성정보의 공식 SNS에서는 ▲하이브리드 업무환경 ▲ 지능형 클라우드 컨택센터 ▲인프라 매니지드 서비스 ▲소프트웨어정의 데이터센터 등 인성정보가 제공하는 IT 서비스 및 솔루션에 대한 소개는 물론 시장동향에 대한 최신 정보를 지속적으로 제공할 예정이다. 

또한 인성정보의 주요 소식과 고객사례, 행사 및 컨퍼런스 정보 등도 공유할 계획이다.

인성정보는 새로운 커뮤니케이션 채널 확대를 기념하는 퀴즈 이벤트도 마련했다. 이달 31일까지 인성정보 공식 페이스북 페이지와 네이버 블로그를 방문해 각각 페이지 ‘좋아요’와 ‘이웃추가’를 누르고 퀴즈에 응모하면 이벤트 참여가 완료된다. ', 
	'ALL'
);

SELECT * FROM CONTENTS;


INSERT INTO COMMENTS (NICKNAME, IDX, COMMENT_IDX ,COMMENT_LEV ,CONTENT) 
VALUES ('user2', 1, comments_idx_seq.nextval, 1, '안녕하세요.');
INSERT INTO COMMENTS (NICKNAME, IDX, COMMENT_IDX ,COMMENT_LEV ,CONTENT) 
VALUES ('user3', 1, comments_idx_seq.nextval, 2, '답글 입니다.');
INSERT INTO COMMENTS (NICKNAME, IDX, COMMENT_IDX ,COMMENT_LEV ,CONTENT) 
VALUES ('user3', 1, comments_idx_seq.nextval, 3, '답글 입니다.2');
INSERT INTO COMMENTS (NICKNAME, IDX, COMMENT_IDX ,COMMENT_LEV ,CONTENT) 
VALUES ('user2', 2, comments_idx_seq.nextval, 1, '안녕하세요.');
INSERT INTO COMMENTS (NICKNAME, IDX, COMMENT_IDX ,COMMENT_LEV ,CONTENT) 
VALUES ('user3', 2, comments_idx_seq.nextval, 2, '답글입니다.');

SELECT * FROM COMMENTS;

SELECT * FROM CONTENTS ORDER BY WRITEDATE DESC;
SELECT * FROM (SELECT * FROM CONTENTS ORDER BY views DESC) WHERE ROWNUM <= 6 ;
select * from (
			select rownum rnum, TT.* from (
				select * from CONTENTS ORDER BY IDX desc
			) TT where rownum <= 5
		) where rnum >= 0;
	
select * from (
			select rownum rnum, GG.* from (
				select * from CONTENTS ORDER BY writedate desc
			) GG
		) where rnum between 1 and 5;
select * from (
			select rownum rnum, GG.* from (
				select * from CONTENTS where category='ALL' order by idx desc
			) GG
		) where rnum between 1 and 5;
select count(*) from CONTENTS where NICKNAME='user1' AND title LIKE '%%' and category like '%%';
select count(*) from CONTENTS where category LIKE '%%';
select count(*) from CONTENTS where title LIKE '%4%' OR title LIKE '%%';
select count(*) from CONTENTS where title LIKE '%4%' OR title LIKE '%%';
select * from CONTENTS where title LIKE '%4%' OR title LIKE '%%';
select nickname from "USER" where id = 'userme';

select * from comments where idx = 3 ORDER BY TARGET_IDX, comment_idx DESC ;
SELECT * FROM comments WHERE TARGET_IDX = '0';
update comments set TARGET_IDX = '1' where COMMENT_IDX = 1;


COMMIT;


