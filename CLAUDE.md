# CLAUDE.md

## Repository purpose

발표 자료 저장소. 각 발표는 `YYYYMMDD-slug/slides.md` 에 [Marp](https://marp.app/) 마크다운으로 작성한다.
GitHub Actions 가 main 에 push 될 때마다 `marp-cli` 로 HTML/PDF 빌드 후 GitHub Pages 에 배포한다.

빌드 파이프라인의 자세한 가이드는 `build_slides.md` 참고.

## Toolchain

- `marp-cli` (npm) — markdown → HTML/PDF
- `scripts/build.sh` — 모든 발표를 일괄 변환 + 랜딩 페이지 생성
- `.github/workflows/deploy.yml` — GitHub Pages 배포

```bash
npm install            # 최초 1회
npm run build          # dist/ 에 전체 빌드
npm run dev            # 라이브 미리보기 서버
```

## Marp 작성 규칙

```markdown
---
marp: true
theme: default
paginate: true
---

# 타이틀
```

- **슬라이드 구분자는 `---` 하나만.** reveal.js 의 `----` 는 쓰지 않는다.
- frontmatter 의 첫 `---` 쌍은 YAML 구분자이지 슬라이드 분할이 아니다.
- `#` 타이틀, `##` 섹션, `###` 컨텐츠 제목.
- 이미지는 같은 디렉터리에 두고 `![](file.png)` 로 참조.

## Conventions that bite

- **한글 typo 보존.** 컨텐츠 편집과 typo 교정은 별도 커밋으로.
- **`dist/` 는 빌드 산출물.** 커밋하지 않는다 (`.gitignore` 처리됨).
- **새 발표는 `YYYYMMDD-slug/` 패턴으로.** `build.sh` 가 이 패턴(`[0-9]*/slides.md`)으로 자동 인식한다.
- **이전에는 Google Slides API (`gws` CLI) 로 관리했음.** 관련 메타파일(`slides-meta.md`) 과 가이드는 제거됨. `gws` 명령은 더 이상 사용하지 않는다.
