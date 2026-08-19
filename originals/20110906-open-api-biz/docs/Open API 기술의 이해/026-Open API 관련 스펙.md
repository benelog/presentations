# Open API 관련 스펙

> **게시판**: Open API 기술의 이해  
> **작성자**: benelog  
> **작성일**: 2011-08-30  
> **원문**: https://cafe.naver.com/openapibiz/26

---

>  오픈 API에서 사용되는 기술표준과 스펙, 기법에 대해서 살펴봅니다. 많은 기술 스펙이 나온 이유를 이해하도록 합니다.  
>   
>  스펙 중에서 우선적으로 활용하거나 지원할 것들을 선별할 수 있는 정보를 습득해서, 투자효율이 높은 기술전략을 세울 수 있게 합니다.  
>   

 스펙 분류

-   대부분의 프로토콜은 모두 Http 바탕
    
-   데이터 표기 형식 : HTML, Json, XML
    
-   구체적인 원격호출 명세 : XML-RPC, SOAP
    
-   데이터 피딩 포멧 : RSS, ATOM
    
-   느슨한 설계 원칙, 스타일 : REST
    
-   특정 데이터 도메인에서 쓰이는 양식 : iCalendar, KMS, 각종 Microformat
    
      
    

[http://xml.coverpages.org/](http://xml.coverpages.org/)

  

XML

데이터 전송량에서는 불리함  

DTD,XML등으로 엄격한 형식 검증에 유리

  

  

JSON

-   Javascript Object 
-   현재는 javascript만의 포멧이 아님.
-   XML보다는 전송량에서 유리함
-   XML보다는 형식 검증 범위가 작음

-   (기본 validatior :  [http://jsonlint.com/](http://jsonlint.com/) )
-   JSON도 스키마를 정의하려는 표준이 논의되고 있다

-   [http://json-schema.org/](http://json-schema.org/)

-   formatter & validator

-   [http://www.freeformatter.com/json-formatter.html](http://www.freeformatter.com/json-formatter.html)
-   [http://jsonformatter.curiousconcept.com/](http://jsonformatter.curiousconcept.com/)

-   Couchbase, MongoDB는 각종 NoSQL저장소와의 통신에도 쓰임
-   javascript의 쓰임새가 server-side에서 확장되고 있어서 앞으로도 유망

-   (참고:ㅣ Node.js를 이용한 채팅서버 예제:  [http://dev.paran.com/2011/05/17/nowjs-nodejs/](http://dev.paran.com/2011/05/17/nowjs-nodejs/) )

  

  

스크린 스크래이핑

  

-   Http 연결해서 HTML파싱
    
-   쓰임새  
    

-   Open API 개념이 있기 전부터 쓰이던 기술
    
-   요즘도 정식 API가 없는 경우에 어쩔 수 없이 쓰기도함
    
-   정식 Open API가 없는 웹사이트와의 연동에 쓰임http://maps.google.com/maps?q=http%3A%2F%2Fcode.google.com/apis/kml/documentation/KML\_Samples.kml
    
    KML 데모
    
    code.google.com/apis/kml/documentation/KML\_Samples.kml
    

-   협의 없이 많이 이루어짐
    

-   해킹으로 치부되기도 함
    
-   대상 사이트에서 모니터링을 해서 IP blocking을 하기도 함.
-   UI개편이 되면 연동 에러  
    
-   서울버스 사례

-   [오래 달궈온 솥, 이제 막 끓기 직전…서울시 공공정보 5월 공개](http://www.bloter.net/archives/30374 "http://www.bloter.net/archives/30374") "다만 서울버스 앱과 같이 HTML 파싱(Parsing)으로 데이터를 긁어가는 것은 보안과 시스템 효율성을 위해서도 문제가 많은 방식이라며, 오픈 API를 구축해 효율적으로 DB에 접속할 수 있도록 구성해야 한다고 설명했다."
-   [데이터 개방 만든 '서울버스'의 딜레마](http://blog.creation.net/492 "http://blog.creation.net/492")  "일간 접속량 제한이 걸린 오픈 API가 열리고, 기존의 서울버스앱이 HTML 스크래핑이 아닌 서버 중계 방식으로 바뀌게 된다. 즉, 자신이 서버를 직접 운영해야 하는 어려움이 봉착하게 된 것이다."
-    [‘서울버스 무료 앱’ 서버관리 부담 덜었다… NHN, 유지비 감당 못한 유주완 씨에 무료 대여](http://news.donga.com/3/all/20110710/38698026/1 "http://news.donga.com/3/all/20110710/38698026/1") "포털사이트 ‘네이버’를 운영하는 NHN은 “서울버스 앱을 개발한 유주완 씨에게 기한을 정하지 않고 서버를 무료로 빌려주기로 했다”고 10일 밝혔다"

  

  

REST

-   2000년 Roy Fielding의 박사 학위 논문에서 제안됨.
-   원래는 네트워크상의 설계원칙. Http나 웹에 국한되지않는다.
-   Http + json과 xml을 포멧 사용

  

  

피드 포멧  
자주 업데이트되는 디지털 콘텐츠를 사용자에게 전송하는데 사용되는 문서 포멧  
  

RSS

-   Netscape사에서 뉴스 포멧을 전달하기 위한 목적으로 최초 도입
-   Blog, Cafe, SNS , 검색 API에서 대부분 지원
-   웹브라우저, RSS reader사이트 등에서 읽을 수 있음

-   [http://www.appbrain.com/app/google-reader/com.google.android.apps.reader](http://www.appbrain.com/app/google-reader/com.google.android.apps.reader)

-   사례

-   [http://en.blog.wordpress.com/](http://en.blog.wordpress.com/)
-   [http://googleblog.blogspot.com/](http://googleblog.blogspot.com/)

-   Validation

-   [http://feedvalidator.org/](http://feedvalidator.org/)
-   [http://feedvalidator.org/check.cgi?url=http%3A%2F%2Frss.egloos.com%2Fblog%2Fbenelog](http://feedvalidator.org/check.cgi?url=http%3A%2F%2Frss.egloos.com%2Fblog%2Fbenelog)

-   RSS 1.0

-   Workging group 작업 Netscape사만의 포멧이 아닌 

-   RSS 2.0

-   update 필수컬럼 추가
-   [http://examples.mashupguide.net/ch04/RSS2.0\_Apress\_simple\_example.xml](http://examples.mashupguide.net/ch04/RSS2.0_Apress_simple_example.xml)

  

  

ATOM  
  
  

  

XML-RPC

  

-   스펙정리 : www.xmlrpc.com
-   SOAP의 원시형태에 가까움
-   주로 블로그 API에 많이 쓰임.

-   http://section.blog.naver.com/sub/NoticeTip.nhn?board=/read/1000003488/10000000000003416085
-   http://eslife.tistory.com/481

  

RSD

-   Really Simple Discovery

-   지원하는 API 종류를 알려줌
-   [http://en.wikipedia.org/wiki/Really\_Simple\_Discovery](http://en.wikipedia.org/wiki/Really_Simple_Discovery)

-   [http://en.blog.wordpress.com/](http://en.blog.wordpress.com/)

-   http://en.blog.wordpress.com/xmlrpc.php?rsd

-   [http://googleblog.blogspot.com/](http://googleblog.blogspot.com/)
-   [http://en.blog.wordpress.com/](http://en.blog.wordpress.com/)

  

링크백

[http://en.wikipedia.org/wiki/Linkback](http://en.wikipedia.org/wiki/Linkback)

  

SOAP

-   Simple Object Access Protocol
-   이제는 Simple.. 의 약자라고 주장하지 않음
-   전문화된 library와 도구 필요
-   WSDL : type등에 대한 명세
-   통신 프로토콜로 HTTP를 사용하고 XML을 인코딩하는 방식으로 사용하는 원격 프로시저 호출
-   원격 프로시저 호출이 HTTP 를 통한 XML 문서의 교환으로 변환되는 과정을 추상화.
-   사례

-   [http://geocoder.us/help/](http://geocoder.us/help/)
-   [http://geocoder.us/dist/eg/clients/GeoCoderPHP.wsdl](http://geocoder.us/dist/eg/clients/GeoCoderPHP.wsdl)

  

특정 도에인에 특화된 포멧  

  

  

KML

지도 공간에 대한 XML형태 (Keyhole Markup Language)  

code.google.com/apis/kml/documentation/KML\_Samples.kml

[http://maps.google.com/maps?q=http%3A%2F%2Fcode.google.com/apis/kml/documentation/KML\_Samples.kml](http://maps.google.com/maps?q=http%3A%2F%2Fcode.google.com/apis/kml/documentation/KML_Samples.kml)

  

GEO RSS

[http://www.georss.org/Main\_Page](http://www.georss.org/Main_Page)  

  
  

iCalendar 

캘린더 데이터읙 효놔에 사용되는 시장 지배적인 표준  

: [http://tools.ietf.org/html/rfc2445](http://tools.ietf.org/html/rfc2445)  

upcoming.yahoo.com

eventful.com

  

  

Micro-format

간단한 공개 데이터 포멧의 집합

 [http://microformats.org/](http://microformats.org/)

adr

hCard

hCalendar, tag, geo

  

  
질문과 토론  
1\. 서버 간의 연동방식을 정할 때 약속된 규약이 맞지 않아서 문제가 생긴 경험이 있다면 공유해주세요.  
2\. 경험해본 각종 연동/연계 솔류션 중에 가장 편했던 것이나 불편했던 것이 어떤 것이고, 그런 과거의 기술과 비교해서 Open API에서 잘 쓰이는 스펙들이 어떻게 보이는지 이야기해봤으면 합니다.

