/**
 * Smooth moves between the site's pages.
 *
 * Browsers with cross-document View Transitions (Chrome/Edge 126+, Safari
 * 18.2+) animate them from CSS alone (`@view-transition` in styles.css), so
 * this does nothing there. Elsewhere it fades the page out before a tab
 * navigation and back in on arrival. Reduced motion turns both off.
 */
const ARRIVING = 'sanatan:tab-navigation';
const LEAVE_MS = 160;

export function enablePageTransitions(doc: Document = document): void {
  const root = doc.documentElement;
  const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
  const native = 'CSSViewTransitionRule' in window;

  // Arrived here through a tab in a browser without view transitions: fade in.
  if (!native && readFlag() && !reducedMotion.matches) {
    root.classList.add('is-arriving');
    window.setTimeout(() => root.classList.remove('is-arriving'), 400);
  }
  // Back/forward cache restores the page as it was left — faded out. Undo that.
  window.addEventListener('pageshow', (event) => {
    if (event.persisted) root.classList.remove('is-leaving', 'is-arriving');
  });

  if (native) return;

  doc.addEventListener('click', (event) => {
    const link = (event.target as Element | null)?.closest<HTMLAnchorElement>('a[data-tab]');
    if (!link || event.defaultPrevented || reducedMotion.matches) return;
    if (event.button !== 0 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey || link.target) return;
    const url = new URL(link.href, window.location.href);
    if (url.origin !== window.location.origin || url.pathname === window.location.pathname) return;

    event.preventDefault();
    writeFlag();
    root.classList.add('is-leaving');
    window.setTimeout(() => window.location.assign(url.href), LEAVE_MS);
  });
}

// A one-shot, per-tab UI flag. Storage can be unavailable (private modes,
// blocked site data); the transition is then simply skipped.
function readFlag(): boolean {
  try {
    const set = window.sessionStorage.getItem(ARRIVING) !== null;
    window.sessionStorage.removeItem(ARRIVING);
    return set;
  } catch {
    return false;
  }
}

function writeFlag(): void {
  try {
    window.sessionStorage.setItem(ARRIVING, '1');
  } catch {
    // no storage: navigate without the arrival fade
  }
}
