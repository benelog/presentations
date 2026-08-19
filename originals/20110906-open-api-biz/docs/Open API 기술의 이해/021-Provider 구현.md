# Provider 구현

> **게시판**: Open API 기술의 이해  
> **작성자**: benelog  
> **작성일**: 2011-08-30  
> **원문**: https://cafe.naver.com/openapibiz/21

---

Open API Provider 기술의 장단점을 이해하고, 프로젝트 적용할 때 이슈로 관리해야할 포인트를 집어낼 수 있다

  

구현 기술 경향

-   Annotation 활용

-   Spring과 JAX-RS구현체 모두 비슷한 프로그래밍모델을 가지고 있음

-   경량 Container 활용

-   JAX-RS 구현체를 쓰더라도 container로 Spring 사용가능

  

  

Spring framework

  

-   Spring MVC의 REST 지원 기능을 Open API개발에 사용 가능

-   @PathVariable 등 REST에 적합한 Annotation 지원
-   JSR 표준은 아님
-   HTML페이지와 xml,json을 동시에 제공할 때 유리

-   Content negotiation

"

  

JAX-RS와 SpringMVC의 REST지원의 관계

[http://benelog.egloos.com/2703581](http://benelog.egloos.com/2703581)

  

"

 스프링 3.0에서도 Spring web MVC에서 나름대로의 스펙을 가진 REST지원 기능이 있습니다. 사실 위의 @Path와@PathParam 은 스프링의 @RequestMapping, @RequsetParams 아노테이션과 무척 유사해보이는, 비슷한프로그래밍 모델을 가지고 있습니다. 왜 스프링개발자들이 Spring MVC에서 JAX-RS를 바로 지원 안하고 나름대로의 스펙을만들었는지에 대해서는, 스프링소스의 팀 블로그를 통해서 밝힌 적이 있습니다.

-   [http://blog.springsource.com/2009/03/08/rest-in-spring-3-mvc/](http://blog.springsource.com/2009/03/08/rest-in-spring-3-mvc/) 참조

 기존의 JAX-RS 스펙을 바로 지원하는 것도 프로토타이핑해봤지만, 자연스럽게 않게 억지로 끼워 맞추는 듯한 방식이 나왔고, 결국Spring MVC사용자들에게 더 일관적이고 편한 방식을 제공하는 나름대로의 기능을 넣기로 결정했다는 것이였습니다. 결국JAX-RS와 Spring MVC는 REST 지원부분에서 겹쳐지는 부분이 생겼고, 이를 두고 스프링은 표준 스펙을 존중하지않는다는 비난을 하는 사람도 있었습니다. 

 이날 발표에서도 유겐할러는 Spring MVC는 근본적으로 MVC구조라서 View의 rendering을 하는 부분을 분리할 수 밖에 없고, 따라서JAX-RS 방식과 달라질 수 밖에 없다고 했습니다. 그리고 [Jersey](https://jersey.dev.java.net/), [RESTEasy](http://www.jboss.org/resteasy/), [Restlet](http://www.restlet.org/)와같은 JAX-RS 구현체를 쓴다고 해도 Spring를 같이 쓸 수 있으니, 상황에 따라서 Spring MVC의 REST 기능이나JAX-RS 구현체를 모두 골라서 쓸 수 있다고 했습니다. UI페이지와 REST요청을 같이 처리해야하는 어플리케이션에서는Spring MVC로,  계층적인 리소스 구조처럼 REST 방식을 깊이까지 쓰는 어플리케이션이라면 JAX-RS 구현체를 쓰는것처럼 말이죠. 스프링은 언제나 그래왔듯이 선택에 대한 것이라는 말을 덧붙였습니다. (Spring is (and alwayswas) about choice),

 그리고 JAX-RS 스펙은 Java EE6에서 독립적인 스펙이고, 다른웹스펙과도 연관관계가 없고, JSF와 프로그래밍 모델도 다르다고 유겐할러는 설명했습니다.  스프링은 그런 관련성이 있는 스펙들을일관성 있게 묶어가고 있다는 것을 대비시켜 보이기 위해서 굳이 그런 언급을 한 것이 아닐까하는 생각도 들었습니다.

"

  

  

  

JAX-RS, JAX-WS 구현체

  

JAX-RS

> @Path("widgets")  
> public class WidgetsResource {  
>    @Autowired  
>    private WidgetsService service;  
>    @GET  @Path("{id}")  @Produces("text/html")  
>    public String getWidget(@PathParam("id") int id) { ... }  
> }
> 
> }

-   Java API for RESTful Web Service

  

Apache CXF

-   OpenSource WebServices Framework
-   JAX-WS ,JAX-RS 지원
-   [http://www.ibm.com/developerworks/kr/series/ws-pojo-springcxf.html](http://www.ibm.com/developerworks/kr/series/ws-pojo-springcxf.html)
-   [http://oldprogrammer.tistory.com/26](http://oldprogrammer.tistory.com/26)

  

JBoss RESTEasy

-   JAX-RS지원
-   Asynchronous HTTP(Server-Side Pushing) COMET
-   Embedded Container와 JUnit을 이용한 단위 테스트 지원
-   GZIP Compression, Server-Side Caching, Browser Cache

  

Restlet

-   [http://www.restlet.org/](http://www.restlet.org/)
-   JAX-RS 지원
-   Servlet기반 경량 프레임웍

  

Jersey

-   [https://jersey.dev.java.net/](https://jersey.dev.java.net/)
-   Sun Glassfish에 탑재
-   [\[REST\] jersey로 REST구현하기](http://blog.openframework.or.kr/73 "http://blog.openframework.or.kr/73")
-   [\[REST\] Jersey로 xml과 json데이터를 추출하기](http://blog.openframework.or.kr/67 "http://blog.openframework.or.kr/67")
-   [\[jersey\] 1.0.2 릴리즈](http://blog.openframework.or.kr/104 "http://blog.openframework.or.kr/104")
-   [\[JSON\] Jackson JSON Processor](http://blog.openframework.or.kr/105 "http://blog.openframework.or.kr/105")
-   [Jersey and Spring](http://blogs.sun.com/enterprisetechtips/entry/jersey_and_spring "http://blogs.sun.com/enterprisetechtips/entry/jersey_and_spring")
-   [http://openframework.or.kr/Wiki.jsp?page=Jeysey\_start1](http://openframework.or.kr/Wiki.jsp?page=Jeysey_start1)
-   [Java에서 RESTful 웹 서비스 구현하기](http://blog.sdnkorea.com/blog/471 "http://blog.sdnkorea.com/blog/471")

  

Metro

-   [https://metro.dev.java.net/](https://metro.dev.java.net/)
-   JAX-WS 구현체

  

Wink

-   [http://incubator.apache.org/wink/](http://incubator.apache.org/wink/)
-   REST- Server와 Client를 같이 제공
-   [Apache Wink를 Jackson JSON 프로세서와 함께 사용하기](https://www.ibm.com/developerworks/kr/library/wa-aj-jackson/index.html "https://www.ibm.com/developerworks/kr/library/wa-aj-jackson/index.html")

  

Scalability

-   Stateless하면 Scalable하다.

-   수평확장이 쉽다.

-   Statful한 부분을 인식한다. (대부분 각종 저장소)

-   DB (Persistent repository)

-   가장 비싸고, 확장하기 어렵다.

-   Global Cache
-   Clustered Session Repository 

-   가능한 많은 역할을 Stateless한 구성요소에서

-   로직을 DB보다는 WAS로

-   Stateful한 구성요소끼리도 역할분담이 쉬운 구조로 개발하기

-   예)Join이 많은 쿼리는 Cache하기가 까다롭다.

  

이슈 관리

-   XML, JSON등 다양한 포멧을 제공하는데 소스 중복이 얼마나 있는가?
-   향후 다른 기술로 대체해야한다면 소스의 수정 비용이 큰가?
-   데이터가 늘어난다면 소스 수준에서 수정할 곳이 얼마나 있는가?

  

참고자료

Cache : 발표자료([http://deview.naver.com/2010/file/B3.pdf](http://deview.naver.com/2010/file/B3.pdf)), 동영상([http://blog.naver.com/deview\_con/40114281320](http://blog.naver.com/deview_con/40114281320))

