import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { describe, expect, it } from 'vitest';
import { ACTS, VIEWS_PER_ACT, VIEW_COUNT } from '../src/story';

/**
 * index.html and src/story.ts describe the same journey. If they drift, the
 * page silently loses its scene (Journey.ok is false), so fail here instead.
 */
const html = readFileSync(fileURLToPath(new URL('../index.html', import.meta.url)), 'utf8');
const views = [...html.matchAll(/<section class="view[^"]*"[^>]*data-act="([a-z]+)"/g)].map((m) => m[1]);

describe('index.html', () => {
  it(`has ${VIEW_COUNT} views, in act order`, () => {
    expect(views).toEqual(ACTS.flatMap((act) => Array<string>(VIEWS_PER_ACT).fill(act)));
  });

  it('has exactly one h1, on the first view', () => {
    expect(html.match(/<h1[\s>]/g)).toHaveLength(1);
    expect(html.indexOf('<h1')).toBeLessThan(html.indexOf('<h2'));
  });

  it('keeps an anchor at the start of every act, and the skip link target', () => {
    for (const act of ACTS) expect(html).toContain(`id="${act}"`);
    expect(html).toContain('id="sign-in"');
  });

  it('sends every staff button to the console sign-in', () => {
    const buttons = [...html.matchAll(/<a[^>]*>Staff sign in<\/a>/g)].map((m) => m[0]);
    expect(buttons.length).toBeGreaterThanOrEqual(2); // header and the last view
    for (const b of buttons) expect(b).toContain('href="/sign-in"');
  });

  it('stays within the CSP: no inline scripts, handlers or style attributes', () => {
    expect(html).not.toMatch(/<script(?![^>]*\bsrc=)[^>]*>/);
    expect(html).not.toMatch(/\son[a-z]+=/i);
    expect(html).not.toMatch(/\sstyle=/i);
  });

  it('has a decorative splash that cannot trap anyone', () => {
    expect(html).toMatch(/<div class="splash" data-splash aria-hidden="true">/);
    // The session gate is an external, same-origin script (CSP: script-src 'self').
    expect(html).toContain('<script src="/welcome/splash-gate.js"></script>');
    const css = readFileSync(fileURLToPath(new URL('../src/styles/splash.css', import.meta.url)), 'utf8');
    expect(css).toMatch(/animation: splash-failsafe 0s linear \d+s forwards/); // hides itself without JS
    expect(css).toContain('prefers-reduced-motion');
    expect(css).not.toMatch(/overflow:\s*hidden/); // never locks scrolling
  });
});
