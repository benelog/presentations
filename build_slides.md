# Slidev 슬라이드 빌드 가이드

발표 자료는 [Slidev](https://sli.dev/) 마크다운으로 작성하고, GitHub Actions가 매 push마다 HTML(SPA)/PDF로 빌드해 GitHub Pages에 배포한다.

## 디렉터리 규칙

```
presentations/
├── 20260426-ai-gent/
│   └── slides.md
├── YYYYMMDD-slug/
│   └── slides.md
├── themes/green/           # Slidev 로컬 테마 (slidev-theme-green)
├── scripts/build.sh
└── .github/workflows/deploy.yml
```

- 발표 하나당 디렉터리 하나, 이름은 `YYYYMMDD-slug` 형식.
- 그 안에 `slides.md`만 있으면 자동으로 빌드 대상이 된다 (이미지·자료는 같은 디렉터리에 두면 됨).
- Slidev는 entry 파일의 디렉터리를 프로젝트 루트로 삼는다. 테마는 각 `slides.md` 의 headmatter에서 상대 경로(`theme: ../themes/green`)로 참조한다.

## Slidev markdown 규칙

```markdown
---
theme: ../themes/green
title: 발표 제목
event: 발표한 행사 이름
event_url: 행사 소개 페이지 URL   # 선택. 있으면 랜딩 페이지에서 행사명에 링크가 걸린다
event_type: public               # public | private. private 은 사적인 모임 발표
source: 원본 발표 자료 URL        # 선택. SlideShare 등 (행사 소개 링크와는 별개)
---

# 타이틀

---

## 섹션

---

### 컨텐츠 슬라이드 제목

* 불릿
* 불릿
```

- **슬라이드 구분자**: `---` (3 dashes) 하나만.
- **구분자 다음 줄은 반드시 빈 줄**이어야 한다. `---` 바로 다음 줄에 내용이 붙어 있으면 Slidev가 그 블록을 per-slide frontmatter(YAML)로 해석한다. 이 동작을 이용해 슬라이드별 레이아웃을 지정한다:

  ```markdown
  ---
  layout: image-right
  image: https://example.com/cover.jpg
  backgroundSize: contain
  ---

  ### 오른쪽에 이미지가 들어가는 슬라이드
  ```

- `#` 타이틀, `##` 섹션, `###` 컨텐츠 제목. (green 테마가 H1/H2만 있는 슬라이드는 세로 중앙 정렬함)
- 한글 typo는 원본 그대로 유지. 수정은 별도 커밋.
- 이미지: `![](./image.png)` — **`./` 접두사 필수** (없으면 빌드 시 모듈 해석 오류). 같은 디렉터리에 두면 빌드 시 번들되고 원본도 함께 복사된다.
- 이미지 크기 지정: `<img src="./image.png" style="height:550px" />` 처럼 HTML 태그 사용.
- 전체 배경 이미지: 해당 슬라이드 frontmatter에 `layout: image` + `image: ./cover.jpg`.
- 슬라이드별 스타일: 슬라이드 안에 `<style>` 블록을 넣으면 해당 슬라이드에만 적용된다(자동 scoped).
- 줄바꿈: markdown-it `breaks` 미사용. 한 문단 안의 단순 개행은 이어붙는다. 줄을 나누려면 빈 줄로 문단을 분리.

자세한 Slidev 문법은 <https://sli.dev/guide/syntax> 참고.

## 로컬 빌드

```bash
npm install                              # 최초 1회
npm run build                            # 모든 슬라이드를 dist/ 로 빌드 (HTML + PDF)
npm run dev -- YYYYMMDD-slug/slides.md   # 라이브 미리보기 서버
```

`npm run build` 는 `scripts/build.sh` 를 실행해:

1. `dist/` 를 비운다.
2. 각 `YYYYMMDD-*/slides.md` 를 `slidev build` 로 `dist/<dir>/` (SPA) 에, `slidev export` 로 `dist/<dir>/slides.pdf` 에 변환. base 경로는 `/presentations/<dir>/` (환경변수 `BASE_PATH` 로 변경 가능).
3. frontmatter에서 참조하는 이미지 등 번들되지 않는 에셋을 `dist/<dir>/` 에 복사.
4. `dist/index.html` (랜딩 페이지) 을 생성 — 발표 목록 + PDF 링크.

PDF export는 `playwright-chromium` 을 사용한다 (devDependency로 설치됨).

### 버전 고정 주의

`@slidev/cli` 는 **52.15.2 로 정확히 고정**되어 있다. 52.16.0 은 sub-path 배포(`--base`) 시 슬라이드 이동마다 base 경로가 URL에 중복으로 붙는 회귀가 있다
(슬라이드 넘김 시 `/presentations/x/presentations/x/2` 형태가 되면서 404 발생. [slidevjs/slidev#2630](https://github.com/slidevjs/slidev/pull/2630) 으로 수정됨).
52.16.0 이후 fix가 포함된 릴리스가 나오면 업그레이드해도 된다.

### Router mode

테마 defaults 에 `routerMode: hash` 가 설정되어 있다 (`themes/green/package.json`).
GitHub Pages 는 SPA rewrite 를 지원하지 않아 history 모드에서는 `/2` 같은 딥링크·새로고침이 404 가 되므로, `#/2` 형식의 hash 라우팅을 쓴다.

## GitHub Pages 배포

`.github/workflows/deploy.yml` 가 main 브랜치 push 마다:

1. Node 22 설치 → `npm ci`.
2. `playwright install --with-deps chromium` (PDF export용).
3. `bash scripts/build.sh` 실행.
4. `dist/` 를 GitHub Pages artifact 로 업로드 → Pages 환경에 deploy.

**최초 1회 GitHub 설정**: 저장소 Settings → Pages → "Build and deployment" Source 를 **GitHub Actions** 로 변경.

## 새 발표 추가

1. `YYYYMMDD-slug/` 디렉터리 만들고 `slides.md` 작성. headmatter에 `theme: ../themes/green` 지정.
2. 로컬에서 `npm run build` 로 확인.
3. commit & push → 몇 분 뒤 Pages URL 의 랜딩 페이지에 자동 등장.

## 테마

기본은 `themes/green/` (headmatter에서 `theme: ../themes/green`) — Noto Sans/Serif KR 웹폰트, blog.benelog.net 팔레트의 로컬 Slidev 테마.

- `themes/green/styles/green.css` — 슬라이드 캔버스/타이포그래피 전체 스타일 (`.slidev-layout` 기준)
- `themes/green/global-top.vue` — 우하단 페이지 번호 (Marp의 `paginate: true` 대체)
- `themes/green/setup/shiki.ts` — 코드 하이라이트 테마 (one-dark-pro)
- `themes/green/package.json` — `slidev.defaults` 로 `canvasWidth: 1280` (16:9, 1280×720) 지정

레이아웃은 Slidev 내장 레이아웃(`image`, `image-right`, `two-cols` 등)을 그대로 쓸 수 있다.
새 테마 추가: `themes/foo/` 디렉터리를 만들고 headmatter에서 `theme: ../themes/foo` 로 참조.

PDF 출력 시 headless Chromium 이 Google Fonts 에서 폰트를 fetch 하므로 시스템에 한글 폰트가 없어도 깨지지 않는다.
