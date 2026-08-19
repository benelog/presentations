# Open API 설계 원칙

> **게시판**: Open API 기술의 이해  
> **작성자**: benelog  
> **작성일**: 2011-08-30  
> **원문**: https://cafe.naver.com/openapibiz/14

---

>  오픈 API설계 원칙의 중요성과 체크포인트를 이해한다. 조잡한 스펙의 API가 배포되어 기업의 기술평판을 해치지 않도록 관리하는 방안을 고민해본다.

  

  

Open API 평판

  

골치거리는?

-   HackersNews에서 한 설문조사 결과 ([http://daumdna.tistory.com/706](http://daumdna.tistory.com/706)) 

-   문서화 미비
-   자주 바뀌는 API
-   인증의 어려움
-   표준의 미비
-   SOAP, non-REST
-   바로 써먹을 샘플코드

-   작은 부분이라도 평판에 영향

![](files/014-img1-screenshot_benelog.png)

  

  

  

REST 설계 원칙

  

Addressability(주소표현성)

-   모든 리소스는 유일한 URI를 지녀야 함. 리소스의 식별자임.
-   URI는 직관적인 단어들을 사용함.

-   /books/orders

-   URI는 hierarchical 하도록 구성함.

-   /orders/books/java/20110601

-   URI의 상위 경로는 하위 경로의 집합을 의미하는 단어로 구성함.

-   /orders/books/java/20110601 에서 java는 책(book)의 카테고리를 의미함.

-   리소스와 직접 관련이 없는 정보는 Query String으로 처리함

-   /orders?category=books&category2=java&orderdate=20110601

  

Connectedness(연결성)

-   하나의 리소스는 다른 리소스들에 대한 정보를 포함할 수 있음.

-   HATEOS(Hypermedia As The Engine Of Application State)
-   아래 예에서는 Resource Representation 내부에 다른 리소스의 참조(연결) 정보가 포함되어 있음.

> <order self="http://bookstore.com/orders/books/java/20110601\_0001000">
> 
> <amount>23</amount>
> 
> <book ref="http://bookstore.com/books/A03856743" />
> 
> <customer ref="http://bookstore.com/customers/124" />
> 
> </order>

  

Statelessness(상태없음)

-   상태를 유지하지 않음 세션, 쿠키 사용(X)
-   URI에 현재 State를 표현할 것을 권장함.

-   http://...... /order/A3024?apikey=a12847bddhwjf

  

Homogeneous Interface(동종 인터페이스)

-   HTTP에서 제공하는 기본적인 4가지의 method를 사용함

-   리소스 조회 : GET
-   새로운 리소스 추가 : POST
-   존재하는 리소스 변경 : PUT
-   존재하는 리소스 삭제 : DELETE

  

  

Content Negotiation(컨텐트 협상)

-   요청 정보에 Accept Header를 추가하여 리소스의 원하는 Representation 형태를 지정함.
-   동일한 URI라도 Accept Header가 달라지면 응답의 Representation이 변경됨

-   요청 URI : /orders/A3024
-   Accept: application/xml XML 응답
-   Accept: application/json JSON 응답

-   URI에 확장자로 Content Negotiation를 대신하는 경우가 있음. 

-   예) Twitter API
-   일반적인 브라우저는 Accept Header를 고정하여 사용하는 경우가 있기 때문
-   /orders/A3024.xml XML 응답
-   /orders/A3024.json JSON 응답

  

  

  

이름 짓기

  

이름 짓기의 원칙

-   문서 없이도 API의 기능이 직관적으로 들어올 수 있는 이름
-   좋은 이름은 좋은 개발을 이끔
-   이름 짓기 힘들다면 좋지 않은 설계의 징후
-   쓰는 사람의 입장에서
-   전체 API에 걸쳐서 일관성이 있게

  

좋은 이름의 조건

-   발음하기 쉬운/검색하기 쉬운 이름
-   문제 지향성(Problem orientation) 
-   ‘어떻게’보다 ‘무엇’을 표현
-   역할과 의도 제시
-   의도 제시형 이름
-   세부 구현에 의존적이지 않게

-   Customer.linearCustomerSearch -> Customer.find

  

참고할만한 자료

-   일반적인 이름짓기의 원칙이 Open API에도 유효하다
-   Code Completed 2nd Edtion

-   Ch 6.2 클래스의 이름
-   Ch 7.3 루틴의 이름
-   Ch 11  변수 이름의효과

-   켄트백의 구현패턴

-   101페이지 , 128페이지 , 53페이지

-   Clean code

-    2장: 의미 있는 이름

  

  

API 설계 정책 

-   이미 있는 API와 검토하고, 유사하게 만들어라

-   예) www.23hq.com에서는 Flickr를 따라했고, Client 모듈을 만드는 진영에서 금방 지원해줬다

-   스스로 Consumer를 먼저 만들어보아라

-   배포 전에 소비자의 입장에서 생각해보고 먼저 개선한다.

-   소수의 설계자 혹은 최종 승인자를 정해라.

-    일관성 있는 설계는 소수에게서 나온다. 

'개념적 무결성을 이루려면 시스템에 하나의 철학이 반영되고, 사용자 입자에서 본 명세는 소수의 두뇌가 고안한 것이어야한다.' - 맨먼스미신 한글판 76페이지

-   버전 체계를 세워라

-   버전에 따른 URL 체계
-   API 버전정보 제공 사례

-   [http://aws.amazon.com/archives?\_encoding=UTF8&jiveRedirect=1](http://aws.amazon.com/archives?_encoding=UTF8&jiveRedirect=1)

  

실습

Open API 명세 평가해보기

[http://openapi.11st.co.kr/openapi/OpenApiSearch.tmall](http://openapi.11st.co.kr/openapi/OpenApiSearch.tmall)

[http://developer.auction.co.kr/Information.aspx?menu=sub5](http://developer.auction.co.kr/Information.aspx?menu=sub5)

