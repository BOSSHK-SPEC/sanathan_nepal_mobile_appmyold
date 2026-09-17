import type { Experience } from '../gl/experience';
import { loadMessages } from '../i18n/load';
import { Journey } from '../journey';
import { runSplash } from '../ui/splash';
import '../styles/splash.css';
import { startPage } from './common';

// Before the landing site took over `/`, the console used hash URLs
// (/#/console/payouts). The fragment never reaches the server, so those
// bookmarks arrive here: forward them to the console's path URL.
if (/^#\/./.test(window.location.hash)) window.location.replace(window.location.hash.slice(1));

// Ready to reveal once the web fonts are in (the 3D follows on its own, after load).
runSplash(document, 'fonts' in document ? document.fonts.ready : Promise.resolve());

const journey = new Journey(document);
const language = startPage();
language.onChange((_locale, messages) => experience?.setCopy(messages.scene));
const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
const pointer = { x: 0, y: 0, tx: 0, ty: 0 };
let experience: Experience | null = null;

window.addEventListener(
  'pointermove',
  (e) => {
    pointer.tx = (e.clientX / window.innerWidth) * 2 - 1;
    pointer.ty = (e.clientY / window.innerHeight) * 2 - 1;
  },
  { passive: true },
);

const remeasure = (): void => {
  journey.measure();
  experience?.resize();
};
window.addEventListener('resize', remeasure);
new ResizeObserver(remeasure).observe(document.body);

let frameRequest = 0;
function frame(now: number): void {
  pointer.x += (pointer.tx - pointer.x) * 0.05;
  pointer.y += (pointer.ty - pointer.y) * 0.05;
  const view = journey.update();
  experience?.render(view, now / 1000, reducedMotion.matches, pointer.x, pointer.y);
  frameRequest = requestAnimationFrame(frame);
}
frameRequest = requestAnimationFrame(frame);

// Leaving for another page: freeze the scene so the browser can capture this
// page for the view transition without competing with WebGL for the frame.
// Resume if the page comes back from the back/forward cache.
window.addEventListener('pageswap', () => cancelAnimationFrame(frameRequest));
window.addEventListener('pageshow', (event) => {
  if (event.persisted) {
    cancelAnimationFrame(frameRequest);
    frameRequest = requestAnimationFrame(frame);
  }
});

const canvas = document.querySelector<HTMLCanvasElement>('.stage');

/**
 * three.js is its own chunk, fetched only after the page has loaded and the
 * browser is idle: the copy, fonts and CSS backdrop paint first, and building
 * the scene never competes with them. Renderer creation is the WebGL2 check —
 * no throwaway probe context.
 */
function start3D(): void {
  if (!canvas || !journey.ok) return;
  // The scene's words (lamps, rashi names) come in the page's language.
  Promise.all([import('../gl/experience'), loadMessages(language.locale)])
    .then(([{ Experience }, messages]) => {
      experience = new Experience(canvas, messages.scene, () => {
        experience = null;
      });
    })
    .catch((error: unknown) => {
      console.warn('[landing] 3D scene unavailable, using the static backdrop.', error);
    });
}

const whenIdle = (cb: () => void): void => {
  if ('requestIdleCallback' in window) window.requestIdleCallback(cb, { timeout: 1500 });
  else setTimeout(cb, 1);
};
if (document.readyState === 'complete') whenIdle(start3D);
else window.addEventListener('load', () => whenIdle(start3D), { once: true });
