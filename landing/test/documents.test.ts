import { readFileSync, readdirSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parseHTML } from 'linkedom';
import { describe, expect, it } from 'vitest';
import { LOCALES, pathFor } from '../src/i18n/locales';
import { MESSAGES } from '../src/i18n/messages';
import { applyPage } from '../src/i18n/page';
import { privacyPolicy } from '../src/legal/privacy';

const root = fileURLToPath(new URL('..', import.meta.url));
const read = (path: string): string => readFileSync(join(root, path), 'utf8');
const TEMPLATES = { privacy: 'privacy/index.html', 'delete-account': 'delete-account/index.html', home: 'index.html' } as const;

function render(page: keyof typeof TEMPLATES, code: (typeof LOCALES)[number]['code']): Document {
  const { document } = parseHTML(read(TEMPLATES[page]));
  const locale = LOCALES.find((l) => l.code === code)!;
  applyPage(document as unknown as Document, locale, MESSAGES[code], { initial: true });
  return document as unknown as Document;
}

describe.each(Object.entries(TEMPLATES))('%s template', (_page, file) => {
  const html = read(file);

  it('stays within the CSP: no inline scripts, handlers or style attributes', () => {
    expect(html).not.toMatch(/<script(?![^>]*\bsrc=)[^>]*>/);
    expect(html).not.toMatch(/\son[a-z]+=/i);
    expect(html).not.toMatch(/\sstyle=/i);
  });

  it('labels every form control', () => {
    const { document } = parseHTML(html);
    for (const control of document.querySelectorAll('input:not([type="radio"]), select, textarea')) {
      const id = control.getAttribute('id');
      const labelled = (id && document.querySelector(`label[for="${id}"]`)) || control.closest('label');
      expect(labelled, `control #${id}`).toBeTruthy();
    }
    for (const radio of document.querySelectorAll('input[type="radio"]')) {
      expect(document.querySelector(`label[for="${radio.getAttribute('id')}"]`)).toBeTruthy();
    }
  });

  it('has the three page tabs, with exactly this page current', () => {
    const { document } = parseHTML(html);
    const page = document.documentElement.getAttribute('data-page');
    const tabs = [...document.querySelectorAll('nav.site-tabs a[data-tab]')];
    expect(tabs.map((t) => t.getAttribute('data-href-page'))).toEqual(['home', 'privacy', 'delete-account']);
    const current = tabs.filter((t) => t.getAttribute('aria-current') === 'page');
    expect(current.map((t) => t.getAttribute('data-href-page'))).toEqual([page]);
    expect(document.querySelector('nav.site-tabs')?.getAttribute('data-i18n-attr')).toBe('aria-label:links.label');
    // The same header on every page, so it stays put while a page transition runs.
    expect(document.querySelector('.nav a.nav-cta[href="/sign-in"]')).toBeTruthy();
  });

  it('credits the author in the footer, safe from page translation', () => {
    const { document } = parseHTML(html);
    const credit = document.querySelector('footer .footer-credit');
    expect(credit?.textContent).toBe('Yashwanth H K');
    expect(credit?.getAttribute('translate')).toBe('no');
    // The only footer link: the author's site, over HTTPS.
    const links = [...document.querySelectorAll('footer a')];
    expect(links.map((a) => [a.getAttribute('href'), a.getAttribute('rel')])).toEqual([['https://yashwanthhk.com', 'author']]);
    expect(document.querySelector('meta[name="author"]')?.getAttribute('content')).toBe('Yashwanth H K');
  });

  it('has unique ids', () => {
    const ids = [...html.matchAll(/\sid="([^"]+)"/g)].map((m) => m[1]);
    expect(new Set(ids).size).toBe(ids.length);
  });
});

describe('Privacy Policy', () => {
  it('never publishes the placeholder phone numbers', () => {
    for (const region of ['NP', 'IN'] as const) expect(JSON.stringify(privacyPolicy(region))).not.toMatch(/X{3,}/);
  });

  it('names the grievance officer for India only', () => {
    expect(privacyPolicy('IN').sections.some((s) => s.id === 'grievance')).toBe(true);
    expect(privacyPolicy('NP').sections.some((s) => s.id === 'grievance')).toBe(false);
  });

  it.each(LOCALES.map((l) => l.code))('%s: renders both regions, a dated heading and a working contents list', (code) => {
    const doc = render('privacy', code);
    const regions = [...doc.querySelectorAll('[data-policy-region]')].map((r) => r.getAttribute('data-policy-region'));
    expect(regions).toEqual(['NP', 'IN']);
    expect(doc.querySelector('[data-policy-updated]')?.getAttribute('data-date')).toBe('2023-04-10');
    expect(doc.querySelector('[data-policy-updated]')?.textContent).not.toContain('{date}');
    for (const link of doc.querySelectorAll('.policy-toc a')) {
      expect(doc.getElementById(link.getAttribute('href')!.slice(1)), link.getAttribute('href')!).toBeTruthy();
    }
    // Nepali and English pages open on Nepal; the Indian languages on India.
    const checked = doc.querySelector('input[name="region"][checked]')?.getAttribute('value');
    expect(checked).toBe(code === 'en' || code === 'ne' ? 'NP' : 'IN');
    // The policy text is in the page language where it exists, else English (and marked so).
    const lang = doc.querySelector('[data-policy-region="NP"]')?.getAttribute('lang');
    expect(lang).toBe(code === 'ne' ? 'ne' : 'en');
  });
});

describe('links between pages', () => {
  it.each(LOCALES.map((l) => l.code))('%s: every page links to the others in the same language', (code) => {
    for (const page of Object.keys(TEMPLATES) as (keyof typeof TEMPLATES)[]) {
      const doc = render(page, code);
      const hrefs = [...doc.querySelectorAll('[data-href-page]')].map((a) => a.getAttribute('href'));
      expect(hrefs.length).toBeGreaterThan(0);
      for (const href of hrefs) expect(href!.startsWith(`/welcome/${code}/`), `${page}: ${href}`).toBe(true);
      expect(hrefs).toContain(pathFor(code, 'privacy'));
    }
  });
});

describe('delete account safety', () => {
  const sources = ['src/account', 'src/pages'].flatMap((dir) =>
    readdirSync(join(root, dir)).filter((f) => f.endsWith('.ts')).map((f) => read(join(dir, f))),
  ).join('\n');

  it('never puts tokens in browser storage, cookies or the URL', () => {
    expect(sources).not.toMatch(/localStorage|sessionStorage|indexedDB|document\.cookie/);
    expect(sources).not.toMatch(/searchParams\.set\([^)]*token/i);
  });

  it('starts with every step hidden: nothing is shown before the flow decides', () => {
    const doc = render('delete-account', 'en');
    for (const panel of doc.querySelectorAll('[data-panel]')) expect(panel.hasAttribute('hidden'), panel.getAttribute('data-panel')!).toBe(true);
  });
});
