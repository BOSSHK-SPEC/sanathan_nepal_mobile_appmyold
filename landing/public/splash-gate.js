// Runs before the first paint (a classic script in <head>, not inline, so the
// CSP stays script-src 'self'). The home page's splash is for the first page of
// a browser session only: anyone who has already opened a page skips it with
// no flash. src/ui/splash.ts sets the flag. Storage may be unavailable; the
// splash then simply shows.
(function () {
  try {
    if (window.sessionStorage.getItem('sanatan:seen')) document.documentElement.classList.add('splash-skip');
  } catch (e) {
    /* no storage */
  }
})();
