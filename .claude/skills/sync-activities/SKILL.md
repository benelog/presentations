---
allowed-tools: Bash, Read, Edit
description: 발표 목록을 benelog.net 의 '기술 공유' 페이지(content/activities.md) 발표 표와 동기화한다. 새 발표를 추가했거나 제목·행사 정보를 고친 뒤에 실행한다.
---

## Context

- 동기화 필요 여부와 차이: !`python3 scripts/sync_activities.py --check`
- benelog.net 저장소 상태: !`git -C ../benelog.net status --short`

## 동기화 규칙

`scripts/sync_activities.py` 가 각 `YYYYMMDD-slug/slides.md` 의 headmatter 를 읽어
activities.md 의 `## 발표` 섹션 표를 통째로 다시 만든다. 표 외의 내용은 건드리지 않는다.

| 표의 칼럼 | 출처 |
|-----------|------|
| 발표 날짜 | 디렉터리명 앞 8자리 (`20130713-spring-upgrade` → `2013.07.13`) |
| 발표 제목 | 슬라이드의 첫 `# ` 제목 (headmatter 의 `title:` 이 아니라 랜딩 페이지와 같은 기준) |
| 행사 | `event:` — `event_url:` 이 있으면 그 행사 소개 페이지로 링크 |
| PDF | `https://benelog.github.io/presentations/<디렉터리>/slides.pdf` |

- **`event_type: private` 인 발표는 표에서 제외한다.** 사적인 모임에서 한 발표(예: 대학 동창 모임)가 여기 해당한다.
- 정렬은 시간 역순. presentations 저장소의 README 표와 같은 순서다.

headmatter 예시:

```yaml
---
theme: ../themes/green
title: Spring 3.0 -> 3.1 -> 3.2 따라잡기
event: 제5회 hello world 오픈 세미나
event_url: https://d2.naver.com/helloworld/416268   # 행사 소개 페이지 (D2 세미나 등)
event_type: public                                  # public | private
source: https://www.slideshare.net/...              # 원본 발표 자료 URL (행사 소개 링크와 별개)
---
```

`event_url` 은 **행사 소개 페이지**, `source` 는 **원본 발표 자료**로 역할이 다르다. 섞지 않는다.

## Your task

1. 위 `--check` 결과를 확인한다. '이미 동기화되어 있습니다' 면 여기서 끝내고 그 사실만 알린다.
2. `python3 scripts/sync_activities.py` 를 실행해 `../benelog.net/content/activities.md` 를 갱신한다.
3. `git -C ../benelog.net diff` 로 표 외의 내용이 바뀌지 않았는지 확인한다.
4. benelog.net 저장소에서 커밋하고 push 한다. **기본 브랜치는 `master`** 다.
   ```bash
   git -C ../benelog.net add content/activities.md
   git -C ../benelog.net commit -m "<무엇이 바뀌었는지 한 줄로>"
   git -C ../benelog.net push origin master
   ```
5. 표에 새로 들어가거나 빠진 발표를 요약해서 알린다.

새 발표가 표에 안 나온다면 대개 headmatter 문제다 — `event:` 가 없거나 `event_type: private` 인지 확인한다.
