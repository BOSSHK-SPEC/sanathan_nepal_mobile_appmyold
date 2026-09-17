# Landing site — console.yashwanthhk.com

The public front door: one scroll-driven 3D journey in four acts. It builds into
`web/welcome/`, so every console build (`flutter run`, `flutter build web`) serves
it at `/welcome/`, and the console hands the bare `/` to it before starting
(`lib/admin/platform/landing_site.dart`). In production nginx serves it for `/`
directly. Everything else on the domain is the Flutter console
(`lib/main_admin.dart`); every "Staff sign in" link goes to its `/sign-in`.

| Act | Views (one per 115svh of scroll) | Scene |
|---|---|---|
| I · River | ॐ (hero) · पात्रो calendar · पञ्चाङ्ग panchanga | Lamps on dark water lift into Devanagari words sampled from the real font |
| II · Sky | Horoscope · Chandra/kundli · Guru/astrologers | Geocentric Navagraha orrery, 12 rashis / 27 nakshatras / 108 charanas |
| III · Temple | Puja · Marketplace · Wallet | Nyatapola: five terraces, guardian pairs, five tiers, gajur |
| IV · Yantra | Languages · Trust · Staff console | Sri Yantra that separates in depth; the camera flies to the bindu |

Acts hand over with a noise dissolve (an ember line rising from below).

## Running it with the console

In VS Code, the **Console** launch configurations run the *Build landing site* task first, so
opening `http://localhost:5173/` shows the landing page. From a terminal:

```bash
npm --prefix landing ci && npm --prefix landing run build
flutter run -d chrome -t lib/main_admin.dart --dart-define-from-file=config/admin.json
```

If `/` shows sign-in instead, the landing site has not been built (`web/welcome/` is missing).

## Commands

```bash
cd landing
npm ci            # Node 24 (.nvmrc)
npm run dev       # http://localhost:5173/welcome/  (builds fonts first)
npm test          # vitest: scroll timing + index.html contract
npm run build     # fonts → tsc → vitest → vite → ../web/welcome/
npm run preview   # serve the build at http://localhost:4173/welcome/
```

Measured on the production build (Lighthouse 12, mobile, simulated 4G, gzip as nginx
serves it): **Performance 96–97, Accessibility 100, Best Practices 100**; FCP/LCP 2.1–2.3 s,
TBT 10–30 ms, CLS 0.02; 195 KB transferred before the 3D chunk (151 KB gzip) is fetched.

## How it is built

- **Content is HTML** (`index.html`): every caption is a real heading in DOM order, readable
  without JavaScript and without WebGL. `src/journey.ts` turns scroll position into a continuous
  `view` value and fades the pinned captions; nothing waits on an IntersectionObserver.
- **three.js loads after first paint** (`import('./gl/experience')`), only when WebGL2 is available
  without a major performance caveat. Otherwise the CSS backdrop in `styles.css` carries each act.
- **`src/story.ts`** is the single description of acts/views and the hold-then-move easing
  (camera rests for the first and last 20% of every view).
- **`src/gl/experience.ts`** renders the active act — or both, across an act boundary — into
  half-float MSAA targets and composites them (dissolve, vignette, light grain). It steps the pixel
  ratio down if frames run long, and falls back to the backdrop on `webglcontextlost`.
- **`src/gl/acts/*`** each implement `Act` (`src/gl/act.ts`): `update({ k, edge, time, ambient, px, py })`.
  `k` is 0..2 within the act; `edge` is -1..0 while dissolving in, 0..1 while dissolving out.
- **Nothing 3D runs until the page has loaded and the browser is idle.** Creating the renderer is
  the WebGL2 check (no probe context); only the act on screen is built, the other three one per
  idle period after the first frame.
- **Fonts are generated** by `scripts/fonts.mjs` before every dev/build: Latin faces copied from
  `@fontsource`, and the Devanagari display face subset (HarfBuzz) to the characters found in
  `index.html` and `src/`. Devanagari is only ever set in that face — wrap it in an element with
  `lang="ne|sa|hi"`; `test/markup.test.ts` fails otherwise.
- **Old console bookmarks** (`/#/console/…`) are forwarded to their path URLs at the top of
  `src/main.ts`.
- **Reduced motion**: no ambient drift or pointer parallax, and views cut between held poses
  instead of flying.
- **No third-party requests**: fonts and three.js are bundled, so the page runs under the strict
  CSP in `deploy/console/landing-csp.conf`. Do not add inline `<script>`, `on*=` handlers or
  `style=` attributes — `npm test` fails on them.

## Languages

13 languages: English, Nepali, Hindi, Assamese, Bengali, Gujarati, Kannada, Malayalam, Marathi,
Odia, Punjabi, Tamil and Telugu (`src/i18n/locales.ts`).

- **Every string is in `src/i18n/messages/<code>.ts`**, typed by `Messages` (`src/i18n/types.ts`).
  A missing or extra key is a compile error; `test/i18n.test.ts` also fails if a translation is
  empty, left in English, or uses a character no font covers.
- **Each language is its own prerendered page**, `/welcome/<code>/` (the build runs
  `applyMessages` over `index.html` per locale), so it arrives in its language with no flash.
- **Switching is in place**: the menu loads that locale's messages (a ~3 KB chunk) and its fonts,
  fades the words, swaps them with the same `applyMessages`, and updates the 3D scene's lamp words
  and rashi names — scroll position and the scene survive. Links still work without JavaScript.
- **The choice is remembered** in the `sanatan_lang` cookie (1 year). nginx reads it to serve the
  right page for `/`; its locale list must match `locales.ts` (a test checks).
- **First visit**: if the browser prefers a language we have, a small offer appears in that
  language. It never redirects on its own.
- **Fonts**: one face per script per family (`scripts/fonts.mjs`), each subset to the characters
  used; a reader downloads only their script's faces (~170 KB for Kannada).
- **Scripts other than Latin** get more leading and no letter-spacing or uppercasing
  (`html[data-script]` rules in `styles.css`), which would otherwise break conjuncts.

### Editing or adding a translation

1. Edit `src/i18n/messages/<code>.ts` (or copy `en.ts` for a new language, add it to
   `locales.ts`, `messages/index.ts` and the map in `deploy/console/nginx.conf`).
2. `npm test` — types, script, emptiness and font coverage are checked.
3. Check the page at 360 px wide: long labels (the nav "Staff sign in") must not clip.
4. Have a native speaker proofread, then set `reviewed: true` for that locale in `locales.ts`.

Only English is marked reviewed today; every other locale is a careful first draft awaiting a
native reader.

## Opening splash

The home page opens with a splash (`index.html` `[data-splash]`, `src/ui/splash.ts`,
`src/styles/splash.css`): a gold yantra draws itself — circles, an eight-petal lotus, the interlocking
triangles — the bindu lights like a diya with an ember orbiting the ring, "Sanatan Nepal" comes into
focus with a gold sweep, and the page is revealed through a circle of light growing from the bindu.

- **First page of a browser session only.** `public/splash-gate.js` (a tiny classic script, not inline)
  hides it before the first paint when the session has already opened a page; every page sets the flag.
- **Short.** At least 1.7 s so the drawing reads, gone once the fonts are ready, never more than 3.2 s;
  any click, key, wheel or touch skips it. Reduced motion: a still mark and a 0.5 s fade.
- **Cannot trap anyone.** It never locks scrolling, is `aria-hidden`, and CSS hides it after 5 s even if
  no JavaScript runs.

## Page tabs and transitions

Every page has the same header: brand, **Home · Privacy Policy · Delete account** tabs, language
menu and Staff sign in. The tabs are plain links (`a[data-tab]`, `aria-current="page"` on the active
one) that keep the reader's language (`data-href-page`), and take their own row on screens ≤ 900 px.

Links name the file — `/welcome/kn/privacy/index.html`, not `/welcome/kn/privacy/` — because
`flutter run`'s dev server answers a folder URL with the Flutter console (a blank screen while its
engine loads). Flutter's `web/index.html` also forwards any `/welcome/…/` folder URL to its
`index.html` before the engine downloads, and shows a boot screen in the splash's style (removed on
Flutter's `flutter-first-frame` event) whenever the console itself has to load.

Moving between pages animates with cross-document **View Transitions** from CSS alone
(`@view-transition` in `styles.css`): the page fades and rises, the header stays put, and the gold
pill (`view-transition-name: site-tab-indicator`) glides to the new tab. Browsers without them get a
short fade from `src/ui/transitions.ts`; reduced motion turns both off. Each page holds its first
paint until its main content is parsed (`<link rel="expect" … blocking="render">`), and the home page
pauses its 3D loop on `pageswap` so the outgoing page is captured cleanly. Chrome may still skip an
animation now and then (seen ~1 in 20 on the first navigation of a brand-new profile); the
navigation itself is unaffected.

## Privacy Policy and Delete account

Two document pages share the site's chrome, languages and fonts:

| URL | Template | What it does |
|---|---|---|
| `/privacy` | `privacy/index.html` | The app's Privacy Policy for Nepal and India (radio picker, works without JS). |
| `/delete-account` | `delete-account/index.html` | Phone sign-in, then permanent deletion of the account. |

**Privacy Policy** (`src/legal/privacy.ts`) is ported verbatim from the app
(`lib/features/legal/data/datasources/legal_seed_privacy.dart`, `legal_region_party.dart`) —
change both together. English and Nepali are published in full; Hindi shows the app's summary above
the authoritative English; the other languages show the English text with a translated note. The
app's placeholder phone numbers are deliberately left out (a test and CI both fail if one appears).

**Delete account** (`src/account/`) calls the same API as the app:
`POST /api/v1/auth/phone/start` → `POST /api/v1/auth/phone/verify` → `DELETE /api/v1/profile`.
- Nothing is deleted until the reader ticks the confirmation and presses *Delete my account*.
- Tokens live only in memory (never storage, cookies or the URL); a test enforces it.
- Verifying a number with no account creates one on the server; the page deletes it again at once and
  says there was no account.
- An expired access token is refreshed once and the delete retried; otherwise the reader verifies again.
- Server errors map to plain messages (wrong/expired code, rate limit, number not allowed, last admin).
- The API origin is `VITE_API_BASE` at build time (default `https://sanatan-api.yashwanthhk.com`); it
  must be in the API's `CORS_ORIGINS`, and it is the only origin the page's CSP allows
  (`deploy/console/account-csp.conf`).

What the backend actually removes (`softDelete` in the backend's profile repository) is listed on
the page; if that changes, update `account.removed` / `account.kept` in every locale.

## Cultural care

The yantra must stay geometrically intact at rest: layer rotation is scaled by the depth
separation, so the triangles only turn while the layers are apart. ॐ and the yantra are never
used as loaders, cursors or decoration, and never distorted. Have a native reader proof any
Nepali/Hindi copy you add.
