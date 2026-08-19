# 우리가 생각하는 Open API

> **게시판**: Open API 기술의 이해  
> **작성자**: benelog  
> **작성일**: 2011-08-30  
> **원문**: https://cafe.naver.com/openapibiz/7

---

>  Open API의 개념을 설명합니다. Open API의 사전적인 의미와 실무에서 통용되는 범위를 이해합니다. 그리고 Open API가 기술 발전의 흐름에서 어떤 위치를 차지하고 있는지와 사업적으로 어떤 장점과 위험이 있을지 정리하고 관련 사례를 살펴봅니다.  
>   
>  Open API를 개념과 의미를 자신만의 단어를 사용해서 설명할 수 있게 되어서, 상황과 맥락에 따라서 이해당사자에게 잘 설명할 수 있을 정도가 되는 것을 목표로 합니다.

  

용어의 정의

  

API란?

-   API = Application Programming Interface
-   여러 정의들

> An application programming interface (API) is a particular set of rules ('code') and specifications that software programs can follow to communicate with each other.
> 
> ( [http://www.openonweb.com/api](http://www.openonweb.com/api) )

>   
> 
> An API, or Application Programming Interface, is a set of functions that one computer program makes available to other programs so  they can talk to it directly.  - John Musser ([http://www.programmableweb.com/faq#Q2](http://www.programmableweb.com/faq#Q2))
> 
> 하나의 프로그램이 다른 프로그램의 접근을 허용해주어 직접 자신과 통신할 수 있도록 해주는 함수의 집합 
> 
> (번역은 \[Raymond 2007\]의 번역판 20페이지 )

> API란 개발자가 조종할 수 있는 일종의 조작 체계입니다. 시스템은 자신이 제공할 수 있는 기능을 호출가능한 함수로 정리하고, 개발자는 이에 적절한 인자값을 넣어 모듈을 실행하고, 그 결과 값을 받아 갑니다.
> 
>   
> 
> \- \[김국현 2010\] 121페이지

  

-   소프트웨어가 서로 의사소통을 하는 규약.
-   일반적 의미로는 운영체제, 어플리케이션, 라이브러리 등 다양한 수준의 인터페이스를 총칭

-   Java library, Framework library도 API

-   넓은 의미로는 다른 사람이 쓰는 코드를 개발하는 사람이면 모두 API개발자라도 할 수 있음.
-   문맥에 따라서 API라는 말로도 'Open API'를 지칭하기도 함.

  

  

Open API란?

  

-   위키페디아의 정의에 따르면 ( [http://en.wikipedia.org/wiki/Open\_API](http://en.wikipedia.org/wiki/Open_API) )

> **Open API** (often referred to as OpenAPI new testnology) is a word used to describe sets of technologies that enable websites to interact with each other by using [REST](http://en.wikipedia.org/wiki/REST "REST"), [SOAP](http://en.wikipedia.org/wiki/SOAP "SOAP"), [Javascript](http://en.wikipedia.org/wiki/Javascript "Javascript") and other web technologies.

-   REST, SOAP, Javascript등을 이용해서 웹사이트를 상호 작용할 수 있게 하는 기술들
-   웹2.0이라는 용어와 동시에 유행

-   누구나 사용할 수 있도록 공개된 API ( \[오창훈 2009\] )

  

  

기술 흐름상의 의미

현실적 타협으로 보는 시각도 있음.

-   분산 기술, 재활용 기술의 연장선상

-   CORBA, DCOM, RMI, EJB
-   CBD
-   저장소까지 연결된다.

-    Http + 텍스트 기반의 프로토콜

-   웹UI 기술과 같은 기술요소 공유
-   사람도 기계도 이해할 수 있는 통신 규약

-   Open API를 SOA의 일반 소비자판으로 보는 시각도 있음

  

  

사업적 의미

  

  

오픈 API의 이득

-   서비스 사용자를 늘인다.

-   Ebay 상품 등록의 50%정도가 API를 통함 ( \[오창훈 2009\] 35페이지)

-   내부 개발자가 할 작업을 줄여주기도 한다.

-   프로슈머 (Prosumer) :  Producer + Consumer 

-   과금 수익

-   제휴 사용자에게는 요금을 받을수도 있다.

미투데이 App : [http://me2day.net/me2/app](http://me2day.net/me2/app)

  

오픈 API의 리스크

-   원래의 서비스에 영향을 미치기도 한다.

-   예) 과도한 API호출로 DB서버 장애

-   보안 위험성
-   제공자 서비스 불안정성 위험

-   오픈 id 사례

-   웹사이트 마다 가입할 필요없이 인증을 대신해주는 Open API 

-   설명 참고 : [http://me2.do/FxImkD](http://blog.naver.com/ahnlabgirl/50018230264)

-   미투데이에서는 지원 중지

-   서비스 안정성 불안 : [http://itviewpoint.com/183669](http://itviewpoint.com/183669)

"서비스 오픈 때부터 오픈아이디를 지원했었던 미투데이로서도 아쉬운 결정입니다만, 

현재 일부 오픈아이디 서비스가 정상 동작되지 않고,

오픈아이디 유저 분들께서도 미투데이 연동 서비스 이용이 원활하게 이루어 지지 않아

부득이하게 오픈아이디 지원을 종료하기로 결정하였습니다."

  

-   제공자와의 이해 관계 충돌 위험

-   미투데이 플리커 API 사용 사례

-   실제 사용자 데이터가 삭제됨
-   "플리커는 왜 미투데이 사진을 지웠나" [http://me2.do/5bWZ4H](http://me2.do/5bWZ4H)
-   "미투데이와 플리커, 메쉬업의 문제"  http://me2.do/FCvDNc
-   "예전에 내 친구의 친구의 기억을 지웠던 플리커 이젠 수많은 사람의 기억을..." : http://me2.do/FRIaV2

-   구글 지도 유료화

-   "구글 지도 서비스 유료화 · · · 기업들 \`대책 마련 분주\`" :[http://me2.do/GeD9p0](http://me2.do/GeD9p0) 참고

-   Service Level Agreement

-   Amazon Service level agreement : [http://aws.amazon.com/s3-sla](http://aws.amazon.com/s3-sla/)
    

  

질문과 토론

  

1\. 과거에 분산 처리나 재활용 기술에 실망한 점이 있다면 공유해주세요

2\. Open API의 리스크에서 인용된 뉴스 기사를 보고 느낀 점을 공유하고,  

(1) Consumer일 때 이런 리스크를 예방하기 위한 방안에는 어떤 것이 있을까요?

(2) Provider일 때 Consumer에게 리스크에 대해 안심 시킬수 있는 방안에는 어떤 것들이 있을까요?

