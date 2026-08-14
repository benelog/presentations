#!/usr/bin/env node
// 빌드된 슬라이드(SPA)에서 각 슬라이드의 콘텐츠가 캔버스(720px)를 넘어 하단이 잘리는지 검사한다.
//
// 사용법:
//   npm run build                                  # 먼저 dist/ 생성
//   node scripts/check_overflow.js                 # dist/ 전체 덱 검사
//   node scripts/check_overflow.js 20140608-spring-anti-patterns   # 특정 덱만 검사
//
// 빌드본은 해시 라우터(#/N)를 쓰고 print 라우트가 없으므로,
// ArrowRight 키로 끝까지 순회하며 .slidev-layout의 scrollHeight를 측정한다.
// 잘리는 슬라이드가 있으면 exit code 1.

const http = require('http');
const fs = require('fs');
const path = require('path');
const { chromium } = require('playwright-chromium');

const ROOT = path.resolve(__dirname, '..', process.env.DIST_DIR || 'dist');
const BASE_PATH = process.env.BASE_PATH || '/presentations';
const PORT = Number(process.env.PORT || 4179);
const THRESHOLD = 8; // px. 이보다 크게 넘치면 잘림으로 판정

const MIME = {
  '.html': 'text/html', '.js': 'text/javascript', '.css': 'text/css',
  '.png': 'image/png', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg', '.gif': 'image/gif',
  '.svg': 'image/svg+xml', '.json': 'application/json', '.woff2': 'font/woff2', '.ico': 'image/x-icon',
};

const server = http.createServer((req, res) => {
  let urlPath = decodeURIComponent(req.url.split('?')[0]);
  if (urlPath.startsWith(BASE_PATH + '/')) urlPath = urlPath.slice(BASE_PATH.length);
  let filePath = path.join(ROOT, urlPath);
  if (fs.existsSync(filePath) && fs.statSync(filePath).isDirectory()) {
    filePath = path.join(filePath, 'index.html');
  }
  if (!fs.existsSync(filePath)) {
    // SPA fallback: /<deck>/무엇이든 → <deck>/index.html
    const deck = urlPath.split('/').filter(Boolean)[0];
    filePath = path.join(ROOT, deck || '', 'index.html');
    if (!fs.existsSync(filePath)) { res.writeHead(404); res.end('not found'); return; }
  }
  res.writeHead(200, { 'Content-Type': MIME[path.extname(filePath)] || 'application/octet-stream' });
  fs.createReadStream(filePath).pipe(res);
});

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

(async () => {
  if (!fs.existsSync(ROOT)) {
    console.error(`dist 디렉터리가 없습니다: ${ROOT} — 먼저 'npm run build'를 실행하세요.`);
    process.exit(2);
  }
  const decks = process.argv[2]
    ? [process.argv[2]]
    : fs.readdirSync(ROOT).filter((d) => fs.existsSync(path.join(ROOT, d, 'index.html')) && /^[0-9]/.test(d));
  if (!decks.length) {
    console.error('검사할 덱이 없습니다.');
    process.exit(2);
  }

  await new Promise((r) => server.listen(PORT, r));
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: 1280, height: 800 } });
  let bad = 0;

  for (const deck of decks) {
    await page.goto(`http://localhost:${PORT}${BASE_PATH}/${deck}/#/1`, { waitUntil: 'networkidle' });
    await sleep(1200);
    await page.click('body');

    const measured = {}; // slideNo -> {scrollH, clientH}
    let stagnant = 0;
    let guard = 0;
    while (stagnant < 3 && guard < 1000) {
      guard++;
      const cur = await page.evaluate(() => {
        const m = location.hash.match(/#\/(\d+)/);
        const n = m ? parseInt(m[1], 10) : 1;
        const el = document.querySelector(`.slidev-page-${n} .slidev-layout`);
        return { n, m: el ? { scrollH: el.scrollHeight, clientH: el.clientHeight } : null };
      });
      if (cur.m && !measured[cur.n]) measured[cur.n] = cur.m;
      const before = cur.n;
      await page.keyboard.press('ArrowRight');
      await sleep(250);
      const after = await page.evaluate(() => {
        const m = location.hash.match(/#\/(\d+)/);
        return m ? parseInt(m[1], 10) : 1;
      });
      stagnant = after === before ? stagnant + 1 : 0;
    }

    const nums = Object.keys(measured).map(Number).sort((a, b) => a - b);
    const overflows = nums
      .map((n) => ({ slide: n, over: measured[n].scrollH - measured[n].clientH }))
      .filter((o) => o.over > THRESHOLD);
    bad += overflows.length;
    const detail = overflows.map((o) => `${o.slide}(+${o.over}px)`).join(', ');
    console.log(`${deck}: ${nums.length}장 중 잘림 ${overflows.length}건${detail ? ' → ' + detail : ''}`);
  }

  await browser.close();
  server.close();
  process.exit(bad ? 1 : 0);
})();
