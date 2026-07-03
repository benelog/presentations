# CLAUDE.md

## Repository purpose

발표 자료 저장소. 각 발표는 `YYYYMMDD-slug/slides.md` 에 [Slidev](https://sli.dev/) 마크다운으로 작성한다.
GitHub Actions 가 main 에 push 될 때마다 `slidev` 로 HTML(SPA)/PDF 빌드 후 GitHub Pages 에 배포한다.

빌드 파이프라인의 자세한 가이드는 `build_slides.md` 참고.

## Toolchain

- `@slidev/cli` (npm) — markdown → HTML(SPA)/PDF (PDF는 `playwright-chromium` 사용)
- `scripts/build.sh` — 모든 발표를 일괄 변환 + 랜딩 페이지 생성
- `themes/green/` — 공용 로컬 테마 (`slidev-theme-green`)
- `.github/workflows/deploy.yml` — GitHub Pages 배포

```bash
npm install                              # 최초 1회
npm run build                            # dist/ 에 전체 빌드
npm run dev -- YYYYMMDD-slug/slides.md   # 라이브 미리보기 서버
```

## Slidev 작성 규칙

```markdown
---
theme: ../themes/green
title: 발표 제목
---

# 타이틀
```

- **슬라이드 구분자는 `---` 하나만.** 구분자 다음 줄은 반드시 빈 줄이어야 한다.
- `---` 바로 다음 줄에 `key: value` 를 붙이면 per-slide frontmatter 가 된다 (예: `layout: image-right` + `image: <url>` + `backgroundSize: contain`).
- headmatter 의 첫 `---` 쌍은 YAML 구분자이지 슬라이드 분할이 아니다. 첫 슬라이드의 frontmatter 역할도 겸한다.
- `#` 타이틀, `##` 섹션, `###` 컨텐츠 제목.
- 이미지는 같은 디렉터리에 두고 `![](./file.png)` 로 참조 — **`./` 접두사 필수**.
- 이미지 크기 지정은 `<img src="./file.png" style="height:550px" />`.
- 슬라이드 한정 스타일은 슬라이드 안의 `<style>` 블록 (자동 scoped).

## Conventions that bite

- **한글 typo 보존.** 컨텐츠 편집과 typo 교정은 별도 커밋으로.
- **`dist/` 는 빌드 산출물.** 커밋하지 않는다 (`.gitignore` 처리됨).
- **새 발표는 `YYYYMMDD-slug/` 패턴으로.** `build.sh` 가 이 패턴(`[0-9]*/slides.md`)으로 자동 인식한다.
- **테마는 상대 경로 참조.** Slidev 는 entry 파일 디렉터리를 루트로 삼으므로 headmatter 에 `theme: ../themes/green`.
- **이전에는 Marp 로 빌드했고, 그 전에는 Google Slides API (`gws` CLI) 로 관리했음.** Marp 테마(`themes/green.css`)와 `gws` 관련 파일은 제거됨.
