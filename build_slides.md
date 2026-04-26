# Marp 슬라이드 빌드 가이드

발표 자료는 [Marp](https://marp.app/) 마크다운으로 작성하고, GitHub Actions가 매 push마다 HTML/PDF로 빌드해 GitHub Pages에 배포한다.

## 디렉터리 규칙

```
presentations/
├── 20260426-ai-gent/
│   └── slides.md
├── YYYYMMDD-slug/
│   └── slides.md
├── scripts/build.sh
└── .github/workflows/deploy.yml
```

- 발표 하나당 디렉터리 하나, 이름은 `YYYYMMDD-slug` 형식.
- 그 안에 `slides.md`만 있으면 자동으로 빌드 대상이 된다 (이미지·자료는 같은 디렉터리에 두면 됨).

## Marp markdown 규칙

```markdown
---
marp: true
theme: default
paginate: true
---

# 타이틀

---

## 섹션

---

### 컨텐츠 슬라이드 제목

* 불릿
* 불릿
```

- **슬라이드 구분자**: `---` (3 dashes) 하나만. reveal.js의 `----` 는 쓰지 않는다.
- **frontmatter**: 첫 `---` ... `---` YAML 블록은 슬라이드가 아니다.
- `#` 타이틀, `##` 섹션, `###` 컨텐츠 제목.
- 한글 typo는 원본 그대로 유지. 수정은 별도 커밋.
- 이미지: `![](image.png)` — 같은 디렉터리에 두면 빌드 시 함께 복사된다.

자세한 Marp 문법은 <https://marpit.marp.app/markdown> 참고.

## 로컬 빌드

```bash
npm install                       # 최초 1회
npm run build                     # 모든 슬라이드를 dist/ 로 빌드
npm run dev                       # marp 서버 — 라이브 미리보기
```

`npm run build` 는 `scripts/build.sh` 를 실행해:

1. `dist/` 를 비운다.
2. 각 `YYYYMMDD-*/slides.md` 를 `dist/<dir>/index.html` + `dist/<dir>/slides.pdf` 로 변환.
3. `dist/index.html` (랜딩 페이지) 을 생성 — 발표 목록 + PDF 링크.

## GitHub Pages 배포

`.github/workflows/deploy.yml` 가 main 브랜치 push 마다:

1. Node 20 설치 → `@marp-team/marp-cli` 글로벌 설치.
2. `bash scripts/build.sh` 실행.
3. `dist/` 를 GitHub Pages artifact 로 업로드 → Pages 환경에 deploy.

**최초 1회 GitHub 설정**: 저장소 Settings → Pages → "Build and deployment" Source 를 **GitHub Actions** 로 변경.

## 새 발표 추가

1. `YYYYMMDD-slug/` 디렉터리 만들고 `slides.md` 작성.
2. 로컬에서 `npm run build` 로 확인.
3. commit & push → 몇 분 뒤 Pages URL 의 랜딩 페이지에 자동 등장.

## 테마

기본은 `themes/green.css` (`theme: green`) — Marp default 테마 + Noto Sans/Serif KR 웹폰트, blog.benelog.net 팔레트.
PDF 출력 시 headless Chromium 이 Google Fonts 에서 폰트를 fetch 하므로 시스템에 한글 폰트가 없어도 깨지지 않는다.

- 인라인 오버라이드: frontmatter 아래 `<style>...</style>` 또는 `style: |` 블록.
- 새 테마 추가: `themes/foo.css` 만들고 `theme: foo` 로 참조 (`build.sh` 가 `--theme-set=themes/` 로 자동 등록).

기본 내장 테마: `default`, `gaia`, `uncover`.
