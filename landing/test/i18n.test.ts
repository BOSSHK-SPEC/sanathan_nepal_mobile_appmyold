import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { parseHTML } from 'linkedom';
import { describe, expect, it } from 'vitest';
import { applyMessages, lookup } from '../src/i18n/apply';
import { LOCALES, PAGES, localeFromPath, negotiate, pathFor, routeFromPath } from '../src/i18n/locales';
import { MESSAGES } from '../src/i18n/messages';
import type { Locale, Messages, Script } from '../src/i18n/types';

const read = (path: string): string => readFileSync(fileURLToPath(new URL(path, import.meta.url)), 'utf8');
const template = read('../index.html');

/** Letters of each script — a translated string must contain some. */
const SCRIPT_LETTERS: Record<Script, RegExp> = {
  latn: /[A-Za-z]/,
  deva: /[ऀ-ॿ]/,
  beng: /[ঀ-৿]/,
  guru: /[਀-੿]/,
  gujr: /[઀-૿]/,
  orya: /[଀-୿]/,
  taml: /[஀-௿]/,
  telu: /[ఀ-౿]/,
  knda: /[ಀ-೿]/,
  mlym: /[ഀ-ൿ]/,
};

/** Every translatable string, with its path — the brand name stays in Latin by design. */
function strings(m: Messages): [string, string][] {
  const out: [string, string][] = [];
  const walk = (node: unknown, path: string): void => {
    if (typeof node === 'string') out.push([path, node]);
    else if (node && typeof node === 'object') for (const [k, v] of Object.entries(node)) walk(v, path ? `${path}.${k}` : k);
  };
  walk(m, '');
  return out.filter(([path]) => path !== 'meta.title' && !path.endsWith('termLang'));
}

describe('locales', () => {
  it('has unique codes, and Kannada among them', () => {
    const codes = LOCALES.map((l) => l.code);
    expect(new Set(codes).size).toBe(codes.length);
    expect(codes).toContain('kn');
  });

  it('round-trips every page URL in every locale and rejects anything else', () => {
    for (const { code } of LOCALES) {
      for (const page of PAGES) {
        const url = pathFor(code, page);
        // Links name the file, so every server (flutter run included) serves the page, not the console.
        expect(url.endsWith('/index.html'), url).toBe(true);
        expect(routeFromPath(url)).toEqual({ locale: code, page });
        expect(routeFromPath(url.replace(/index\.html$/, ''))).toEqual({ locale: code, page });
      }
    }
    for (const path of ['/', '/welcome/', '/welcome/xx/', '/welcome/kn/extra/', '/welcome/kn/home/', '/welcome/kn/privacy', '/sign-in']) {
      expect(routeFromPath(path), path).toBeNull();
    }
    expect(localeFromPath('/welcome/ta/delete-account/')).toBe('ta');
  });

  it('matches browser preferences on the primary subtag, in order', () => {
    expect(negotiate(['kn-IN', 'en-US'])).toBe('kn');
    expect(negotiate(['fr-FR', 'ta'])).toBe('ta');
    expect(negotiate(['ory'])).toBe('or');
    expect(negotiate(['fr', 'de'])).toBeNull();
  });
});

describe.each(LOCALES.map((l) => [l.code, l] as const))('messages: %s', (_code, locale: Locale) => {
  const messages = MESSAGES[locale.code];

  it('has no empty text where text is required', () => {
    for (const [path, value] of strings(messages)) {
      // Pair halves may be empty; the policy-language note is empty where the policy is in the page's language.
      const optional = /\.(term|name)$/.test(path) || path === 'privacy.languageNote';
      if (!optional) expect(value.trim(), path).not.toBe('');
    }
    for (const pair of [...Object.values(messages.rail), messages.hero.label]) {
      expect(pair.term || pair.name).not.toBe('');
    }
  });

  it(`is written in its own script (${locale.script})`, () => {
    const letters = SCRIPT_LETTERS[locale.script];
    for (const [path, value] of strings(messages)) {
      if (!value || value === 'ॐ' || path === 'brandLabel') continue;
      // The English page keeps the scene's words in Devanagari: they are the motif, not copy.
      if (locale.code === 'en' && path.startsWith('scene.')) continue;
      // Terms in another language are marked with termLang and exempt.
      const pairPath = path.replace(/\.(term|name)$/, '');
      const pair = lookup(messages, pairPath) as { termLang?: string } | undefined;
      if (path.endsWith('.term') && pair?.termLang && pair.termLang !== locale.code) continue;
      expect(letters.test(value), `${locale.code} ${path}: "${value}"`).toBe(true);
    }
  });

  it('names twelve distinct rashis and two lamp words', () => {
    expect(new Set(messages.scene.rashis).size).toBe(12);
    expect(messages.scene.words.every((w) => w.trim())).toBe(true);
  });
});

describe('prerendered pages', () => {
  it.each(LOCALES.map((l) => [l.code, l] as const))('%s renders every binding in its language', (_code, locale) => {
    const { document } = parseHTML(template);
    applyMessages(document as unknown as Document, locale, MESSAGES[locale.code]);
    const root = document.documentElement;

    expect(root.getAttribute('lang')).toBe(locale.code);
    expect(root.getAttribute('data-script')).toBe(locale.script);
    expect(document.querySelectorAll('[data-lang-list] a')).toHaveLength(LOCALES.length);
    expect(document.querySelector('[aria-current="true"][data-locale-option]')?.getAttribute('data-locale-option')).toBe(locale.code);

    if (locale.code !== 'en') {
      const letters = SCRIPT_LETTERS[locale.script];
      for (const el of document.querySelectorAll('[data-i18n]')) {
        const text = el.textContent ?? '';
        expect(letters.test(text), `${locale.code} [data-i18n=${el.getAttribute('data-i18n')}]: "${text}"`).toBe(true);
      }
      expect(document.querySelector('meta[name="description"]')?.getAttribute('content')).toBe(MESSAGES[locale.code].meta.description);
    }
  });

  it('fails loudly on a binding no locale defines', () => {
    const { document } = parseHTML(template.replace('data-i18n="skip"', 'data-i18n="nope.missing"'));
    expect(() => applyMessages(document as unknown as Document, LOCALES[0], MESSAGES.en)).toThrow(/nope\.missing/);
  });
});

describe('deployment', () => {
  it('nginx serves exactly the locales the site has', () => {
    const conf = read('../../deploy/console/nginx.conf');
    const match = /~\^\(([a-z|]+)\)\$/.exec(conf);
    expect(match, 'locale map in deploy/console/nginx.conf').not.toBeNull();
    expect(match![1]!.split('|').sort()).toEqual(LOCALES.map((l) => l.code).sort());
  });

  it("every character on every page has a font from its own script's families", () => {
    const css = read('../src/fonts/.generated/fonts.css');
    const faces = [...css.matchAll(/font-family: '([^']+)';[^}]*unicode-range: ([^;]+);/g)].map((m) => ({
      family: m[1]!,
      ranges: m[2]!.split(',').map((part) => {
        const [lo, hi] = part.trim().replace(/^U\+/i, '').split('-').map((h) => parseInt(h, 16));
        return [lo!, hi ?? lo!] as const;
      }),
    }));
    const suffix: Partial<Record<Script, string>> = { beng: 'Beng', guru: 'Guru', gujr: 'Gujr', orya: 'Orya', taml: 'Taml', telu: 'Telu', knda: 'Knda', mlym: 'Mlym' };

    for (const locale of LOCALES) {
      const s = suffix[locale.script];
      const allowed = new Set(['Sanatan Display', 'Sanatan Text', ...(s ? [`Sanatan Display ${s}`, `Sanatan Text ${s}`] : [])]);
      const usable = faces.filter((f) => allowed.has(f.family));
      for (const [path, value] of strings(MESSAGES[locale.code])) {
        for (const ch of value) {
          const cp = ch.codePointAt(0)!;
          if (cp < 0x80) continue;
          const covered = usable.some((f) => f.ranges.some(([lo, hi]) => cp >= lo && cp <= hi));
          expect(covered, `${locale.code} ${path}: U+${cp.toString(16).toUpperCase()} "${ch}"`).toBe(true);
        }
      }
    }
  });

  it("keeps the components of two-part vowel signs, which the shaper splits them into", () => {
    const css = read('../src/fonts/.generated/fonts.css');
    const ranges = [...css.matchAll(/font-family: 'Sanatan (?:Display|Text)(?: [A-Za-z]+)?';[^}]*unicode-range: ([^;]+);/g)].flatMap((m) =>
      m[1]!.split(',').map((part) => part.trim().replace(/^U\+/i, '').split('-').map((h) => parseInt(h, 16))),
    );
    const covered = (cp: number): boolean => ranges.some(([lo, hi]) => cp >= lo! && cp <= (hi ?? lo!));
    // Kannada, Tamil, Malayalam, Bengali and Odia two-part vowel signs
    for (const sample of ['ಫೋನ್', 'ಸಮಾಲೋಚನೆ', 'கோயில்', 'ஒவ்வொரு', 'ഓർമ്മ', 'ഒരൊറ്റ', 'কোষ্ঠী', 'ଯୋଗ']) {
      for (const ch of sample.normalize('NFD')) {
        if (ch.codePointAt(0)! < 0x80) continue;
        expect(covered(ch.codePointAt(0)!), `${sample}: U+${ch.codePointAt(0)!.toString(16)}`).toBe(true);
      }
    }
  });

  it('the language menu has a glyph for every language name', () => {
    const css = read('../src/fonts/.generated/fonts.css');
    const ranges = [...css.matchAll(/font-family: 'Sanatan (?:Names|Text)';[^}]*unicode-range: ([^;]+);/g)].flatMap((m) =>
      m[1]!.split(',').map((part) => part.trim().replace(/^U\+/i, '').split('-').map((h) => parseInt(h, 16))),
    );
    for (const { name } of LOCALES) {
      for (const ch of name) {
        const cp = ch.codePointAt(0)!;
        expect(ranges.some(([lo, hi]) => cp >= lo! && cp <= (hi ?? lo!)), `${name}: U+${cp.toString(16)}`).toBe(true);
      }
    }
  });
});
