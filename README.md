# presentations

발표 슬라이드 모음. [Marp](https://marp.app/) 마크다운으로 작성하고 GitHub Pages 로 배포.

**배포 URL**: <https://benelog.github.io/presentations/>

## 슬라이드 목록

| 날짜 | 제목 | 소스 | 슬라이드 | PDF |
|------|------|------|---------|-----|
| 2026-04-26 | AI agent에게 사적인 일 시키기 | [`20260426-ai-gent/slides.md`](20260426-ai-gent/slides.md) | [보기](https://benelog.github.io/presentations/20260426-ai-gent/) | [PDF](https://benelog.github.io/presentations/20260426-ai-gent/slides.pdf) |

## 빌드 / 배포

```bash
npm install      # 최초 1회
npm run build    # dist/ 에 전체 빌드
npm run dev      # 라이브 미리보기 서버
```

main 에 push 하면 GitHub Actions 가 자동으로 빌드 후 GitHub Pages 에 배포한다.

자세한 작성 규칙·파이프라인은 [`build_slides.md`](build_slides.md) 참고.
