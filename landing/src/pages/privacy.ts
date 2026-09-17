import { startPage } from './common';
import '../styles/document.css';

startPage();

// The region picker is plain radio buttons styled with :has(), so it works
// without JavaScript. Here: honour and keep ?region=IN|NP, so a shared link
// opens on the right policy.
const radios = [...document.querySelectorAll<HTMLInputElement>('input[name="region"]')];
const requested = new URLSearchParams(window.location.search).get('region')?.toUpperCase();
const match = radios.find((radio) => radio.value === requested);
if (match) match.checked = true;

for (const radio of radios) {
  radio.addEventListener('change', () => {
    if (!radio.checked) return;
    const url = new URL(window.location.href);
    url.searchParams.set('region', radio.value);
    window.history.replaceState(window.history.state, '', url);
  });
}
