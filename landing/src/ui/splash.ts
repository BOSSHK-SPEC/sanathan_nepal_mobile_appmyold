/**
 * The home page's opening: a gold yantra draws itself, the bindu lights like a
 * diya, and the page is revealed through a circle of light growing from it.
 *
 * Rules that keep it from getting in anyone's way:
 * - First page of a browser session only (public/splash-gate.js hides it
 *   before first paint for everyone else; every page sets the flag).
 * - Visible for at least MIN_MS so the drawing reads, gone as soon as the page
 *   is ready after that, and never longer than MAX_MS.
 * - Any click, key, wheel or touch skips it.
 * - If this script never runs, CSS hides the splash on its own (splash.css).
 */
const SEEN = 'sanatan:seen';
const MIN_MS = 1700;
const MAX_MS = 3200;
const REDUCED_MIN_MS = 500;
const EXIT_FALLBACK_MS = 1400;

/** Every page calls this: from now on this session skips the splash. */
export function markSessionSeen(): void {
  try {
    window.sessionStorage.setItem(SEEN, '1');
  } catch {
    // no storage: the splash may show again on the next page load, which is harmless
  }
}

export function runSplash(doc: Document, ready: Promise<unknown>): void {
  const splash = doc.querySelector<HTMLElement>('[data-splash]');
  if (!splash) return;
  if (doc.documentElement.classList.contains('splash-skip')) {
    splash.remove();
    return;
  }

  const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  // performance.now() counts from navigation start — about when the splash first painted.
  const until = (ms: number): Promise<void> => new Promise((resolve) => setTimeout(resolve, Math.max(0, ms - performance.now())));

  let finished = false;
  const finish = (): void => {
    if (finished) return;
    finished = true;
    for (const type of SKIP_EVENTS) window.removeEventListener(type, finish);
    splash.classList.add('is-leaving');
    const remove = (): void => splash.remove();
    splash.addEventListener('animationend', (event) => {
      if (event.target === splash) remove();
    });
    window.setTimeout(remove, EXIT_FALLBACK_MS);
  };

  const minimum = until(reducedMotion ? REDUCED_MIN_MS : MIN_MS);
  const ok = ready.then(() => undefined, () => undefined);
  void Promise.race([Promise.all([ok, minimum]), until(MAX_MS)]).then(finish);
  for (const type of SKIP_EVENTS) window.addEventListener(type, finish, { passive: true });
}

const SKIP_EVENTS = ['pointerdown', 'keydown', 'wheel', 'touchstart'] as const;
