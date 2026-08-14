# 발표 슬라이드 모음

**배포 URL**: <https://benelog.github.io/presentations/>

## 슬라이드 목록

시간 역순(최신 발표가 먼저)으로 정렬. 발표한 행사는 각 `slides.md` headmatter의 `event:` 필드에 기록한다.

| 날짜 | 제목 | 행사 | 소스 | 슬라이드 | PDF |
|------|------|------|------|---------|-----|
| 2026-05-28 | 25년 전의 진로 선택과 AI 시대의 변화 | 연세대학교 응용통계학과 신입생 세미나 | [`20260528-yonsei-stats-rc101/slides.md`](20260528-yonsei-stats-rc101/slides.md) | [보기](https://benelog.github.io/presentations/20260528-yonsei-stats-rc101/) | [PDF](https://benelog.github.io/presentations/20260528-yonsei-stats-rc101/slides.pdf) |
| 2026-04-26 | AI agent에게 개인적인 일 시키기 | | [`20260426-ai-gent/slides.md`](20260426-ai-gent/slides.md) | [보기](https://benelog.github.io/presentations/20260426-ai-gent/) | [PDF](https://benelog.github.io/presentations/20260426-ai-gent/slides.pdf) |
| 2022-04-13 | 컴퓨터 프로그래밍과 진로 | 연세대학교 응용통계학과 신입생 세미나 | [`20220413-yonsei-stats-rc101/slides.md`](20220413-yonsei-stats-rc101/slides.md) | [보기](https://benelog.github.io/presentations/20220413-yonsei-stats-rc101/) | [PDF](https://benelog.github.io/presentations/20220413-yonsei-stats-rc101/slides.pdf) |
| 2021-09-14 | 네이버 개발자 업무와 기술 플랫폼 | 연세대학교 응용통계학과 대학원생 세미나 | [`20210914-yonsei-stats-bk/slides.md`](20210914-yonsei-stats-bk/slides.md) | [보기](https://benelog.github.io/presentations/20210914-yonsei-stats-bk/) | [PDF](https://benelog.github.io/presentations/20210914-yonsei-stats-bk/slides.pdf) |
| 2020-05-07 | 엔티티 클래스 설계와 퍼시스턴스 프레임워크 | 우아한형제들 세미나 | [`20200507-entity-design/slides.md`](20200507-entity-design/slides.md) | [보기](https://benelog.github.io/presentations/20200507-entity-design/) | [PDF](https://benelog.github.io/presentations/20200507-entity-design/slides.pdf) |
| 2017-11-26 | HTTP/2 세대의 Java | KSUG(한국 스프링 사용자 모임) 세미나 | [`20171128-http2-java/slides.md`](20171128-http2-java/slides.md) | [보기](https://benelog.github.io/presentations/20171128-http2-java/) | [PDF](https://benelog.github.io/presentations/20171128-http2-java/slides.pdf) |
| 2014-11-27 | Spring Batch와 함께 하는 TDD | KSUG(한국 스프링 사용자 모임) 세미나 | [`20141127-spring-batch-tdd/slides.md`](20141127-spring-batch-tdd/slides.md) | [보기](https://benelog.github.io/presentations/20141127-spring-batch-tdd/) | [PDF](https://benelog.github.io/presentations/20141127-spring-batch-tdd/slides.pdf) |
| 2014-06-08 | 스프링 어플리케이션의 문제해결 사례 & 안티 패턴 | Spring Camp 2014 | [`20140608-spring-anti-patterns/slides.md`](20140608-spring-anti-patterns/slides.md) | [보기](https://benelog.github.io/presentations/20140608-spring-anti-patterns/) | [PDF](https://benelog.github.io/presentations/20140608-spring-anti-patterns/slides.pdf) |
| 2012-10-22 | Open API Client 개발 | 제4회 NHN 오픈세미나 (NHN 오픈 API 특집) | [`20121022-open-api-client/slides.md`](20121022-open-api-client/slides.md) | [보기](https://benelog.github.io/presentations/20121022-open-api-client/) | [PDF](https://benelog.github.io/presentations/20121022-open-api-client/slides.pdf) |
| 2010-11-13 | SpringOne2GX 2010 참석 후기 | KSUG(한국 스프링 사용자 모임) 세미나 | [`20101116-springone2gx/slides.md`](20101116-springone2gx/slides.md) | [보기](https://benelog.github.io/presentations/20101116-springone2gx/) | [PDF](https://benelog.github.io/presentations/20101116-springone2gx/slides.pdf) |
| 2010-08-14 | Effective & Agile Java | 소프트웨어 마에스트로 멘토링 | [`20100814-effective-agile-java/slides.md`](20100814-effective-agile-java/slides.md) | [보기](https://benelog.github.io/presentations/20100814-effective-agile-java/) | [PDF](https://benelog.github.io/presentations/20100814-effective-agile-java/slides.pdf) |
| 2010-05-29 | 웹 프레임워크의 Web tier 처리방식과 Spring MVC | KSUG(한국 스프링 사용자 모임) 세미나 | [`20100529-spring-mvc/slides.md`](20100529-spring-mvc/slides.md) | [보기](https://benelog.github.io/presentations/20100529-spring-mvc/) | [PDF](https://benelog.github.io/presentations/20100529-spring-mvc/slides.pdf) |
| 2010-02-20 | Spring Roo와 함께 하는 쾌속 웹개발 | KSUG(한국 스프링 사용자 모임) 세미나 | [`20100220-spring-roo/slides.md`](20100220-spring-roo/slides.md) | [보기](https://benelog.github.io/presentations/20100220-spring-roo/) | [PDF](https://benelog.github.io/presentations/20100220-spring-roo/slides.pdf) |

## 빌드 / 배포
[Slidev](https://sli.dev/) 마크다운으로 작성하고 GitHub Pages 로 배포.

```bash
npm install                              # 최초 1회
npm run build                            # dist/ 에 전체 빌드
npm run dev -- YYYYMMDD-slug/slides.md   # 라이브 미리보기 서버
```

main 에 push 하면 GitHub Actions 가 자동으로 빌드 후 GitHub Pages로 배포됨.

자세한 작성 규칙·파이프라인은 [`build_slides.md`](build_slides.md) 참고.
