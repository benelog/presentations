# 발표 슬라이드 모음

**배포 URL**: <https://benelog.github.io/presentations/>

## 슬라이드 목록

| 날짜 | 제목 | 소스 | 슬라이드 | PDF |
|------|------|------|---------|-----|
| 2026-04-26 | AI agent에게 개인적인 일 시키기 | [`20260426-ai-gent/slides.md`](20260426-ai-gent/slides.md) | [보기](https://benelog.github.io/presentations/20260426-ai-gent/) | [PDF](https://benelog.github.io/presentations/20260426-ai-gent/slides.pdf) |
| 2022-04-13 | 컴퓨터 프로그래밍과 진로 | [`20220413-yonsei-stats-rc101/slides.md`](20220413-yonsei-stats-rc101/slides.md) | [보기](https://benelog.github.io/presentations/20220413-yonsei-stats-rc101/) | [PDF](https://benelog.github.io/presentations/20220413-yonsei-stats-rc101/slides.pdf) |
| 2021-09-14 | 네이버 개발자 업무와 기술 플랫폼 | [`20210914-yonsei-stats-bk/slides.md`](20210914-yonsei-stats-bk/slides.md) | [보기](https://benelog.github.io/presentations/20210914-yonsei-stats-bk/) | [PDF](https://benelog.github.io/presentations/20210914-yonsei-stats-bk/slides.pdf) |
| 2020-05-07 | 엔티티 클래스 설계와 퍼시스턴스 프레임워크 | [`20200507-entity-design/slides.md`](20200507-entity-design/slides.md) | [보기](https://benelog.github.io/presentations/20200507-entity-design/) | [PDF](https://benelog.github.io/presentations/20200507-entity-design/slides.pdf) |

## 빌드 / 배포
[Marp](https://marp.app/) 마크다운으로 작성하고 GitHub Pages 로 배포.

```bash
npm install      # 최초 1회
npm run build    # dist/ 에 전체 빌드
npm run dev      # 라이브 미리보기 서버
```

main 에 push 하면 GitHub Actions 가 자동으로 빌드 후 GitHub Pages로 배포됨.

자세한 작성 규칙·파이프라인은 [`build_slides.md`](build_slides.md) 참고.
