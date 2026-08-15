#!/usr/bin/env python3
"""발표 목록을 benelog.net 의 '저술 및 대외 활동' 페이지(content/works.md)와 동기화한다.

각 `YYYYMMDD-slug/slides.md` 의 headmatter 를 읽어 '## 발표' 섹션의 표를 통째로 다시 만든다.

  발표 날짜      : 디렉터리명 앞 8자리
  행사           : `event:` — `event_url:` 이 있으면 행사 소개 페이지로 링크
  발표 자료(HTML): 슬라이드의 첫 `# ` 제목 (랜딩 페이지와 같은 기준) 을 배포된 슬라이드로 링크
  PDF            : 배포된 slides.pdf

`event_type: private` 인 발표(사적인 모임 등)는 대상에서 제외한다.

사용법:
    python3 scripts/sync_activities.py [--check] [--target <works.md 경로>]

    --check   파일을 고치지 않고 차이만 출력 (동기화 필요하면 exit code 1)
    --target  기본값은 ../benelog.net/content/works.md
"""
import argparse
import io
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DEFAULT_TARGET = os.path.join(ROOT, '..', 'benelog.net', 'content', 'works.md')
BASE_URL = 'https://benelog.github.io/presentations'

HEADER = [
    '| 발표 날짜 | 행사 | 발표 자료(HTML) | PDF |',
    '|-----------|------|-----------------|-----|',
]


def read_headmatter(path):
    lines = io.open(path, encoding='utf-8').read().split('\n')
    if not lines or lines[0].strip() != '---':
        return {}, lines
    end = lines.index('---', 1)
    head = {}
    for line in lines[1:end]:
        if ':' in line and not line.startswith((' ', '\t', '-')):
            key, _, value = line.partition(':')
            head[key.strip()] = value.strip()
    return head, lines[end + 1:]


def collect_decks():
    decks = []
    for name in sorted(os.listdir(ROOT), reverse=True):
        slides = os.path.join(ROOT, name, 'slides.md')
        if not re.match(r'^\d{8}-', name) or not os.path.isfile(slides):
            continue
        head, body = read_headmatter(slides)
        if head.get('event_type') == 'private':
            continue
        title = next((l[2:].strip() for l in body if l.startswith('# ')), name)
        decks.append({
            'dir': name,
            'date': '%s.%s.%s' % (name[0:4], name[4:6], name[6:8]),
            'title': title,
            'event': head.get('event', ''),
            'event_url': head.get('event_url', ''),
        })
    return decks


def render_rows(decks):
    rows = []
    for d in decks:
        event = '[%s](%s)' % (d['event'], d['event_url']) if d['event_url'] else d['event']
        rows.append('| %s | %s | [%s](%s/%s/) | [다운로드](%s/%s/slides.pdf) |'
                    % (d['date'], event, d['title'], BASE_URL, d['dir'], BASE_URL, d['dir']))
    return rows


def replace_table(text, rows):
    """'## 발표' 섹션 안의 표를 새 표로 교체한다."""
    lines = text.split('\n')
    try:
        start = next(i for i, l in enumerate(lines) if l.strip() == '## 발표')
    except StopIteration:
        sys.exit("'## 발표' 섹션을 찾을 수 없습니다: 대상 파일 형식을 확인하세요.")
    table_start = next((i for i in range(start, len(lines)) if lines[i].startswith('| 발표 날짜')), None)
    if table_start is None:
        sys.exit("'## 발표' 섹션에서 발표 표를 찾을 수 없습니다.")
    table_end = table_start
    while table_end < len(lines) and lines[table_end].startswith('|'):
        table_end += 1
    return '\n'.join(lines[:table_start] + HEADER + rows + lines[table_end:])


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--target', default=DEFAULT_TARGET)
    args = parser.parse_args()

    target = os.path.abspath(args.target)
    if not os.path.isfile(target):
        sys.exit('대상 파일이 없습니다: %s' % target)

    decks = collect_decks()
    current = io.open(target, encoding='utf-8').read()
    updated = replace_table(current, render_rows(decks))

    if current == updated:
        print('이미 동기화되어 있습니다 (발표 %d건) → %s' % (len(decks), target))
        return 0

    if args.check:
        print('동기화가 필요합니다 (발표 %d건) → %s' % (len(decks), target))
        import difflib
        sys.stdout.writelines(difflib.unified_diff(
            current.split('\n'), updated.split('\n'),
            fromfile='current', tofile='synced', lineterm='', n=1))
        print()
        return 1

    io.open(target, 'w', encoding='utf-8').write(updated)
    print('갱신했습니다 (발표 %d건) → %s' % (len(decks), target))
    return 0


if __name__ == '__main__':
    sys.exit(main())
