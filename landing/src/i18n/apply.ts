import { LOCALES, isPage, pathFor } from './locales';
import type { Locale, Messages, Pair } from './types';

/**
 * Writes a locale into the page. The same function renders every prerendered
 * page at build time (on a server-side DOM) and switches language in the
 * browser, so the two can never disagree.
 *
 * Markup contract (index.html):
 * - `data-i18n="views.3.title"` — element text (or a Pair) from that message path
 * - `data-i18n-attr="aria-label:brandLabel"` — attributes, `;`-separated
 * - `[data-lang-list]` — filled with one link per locale
 * - `[data-locale-name]` — the current language's own name
 * - `data-href-page="privacy"` — href to that page in the current language
 */
export function applyMessages(doc: Document, locale: Locale, messages: Messages): void {
  const root = doc.documentElement;
  root.setAttribute('lang', locale.code);
  root.setAttribute('dir', 'ltr');
  root.setAttribute('data-locale', locale.code);
  root.setAttribute('data-script', locale.script);

  const title = doc.querySelector('title');
  if (title) title.textContent = messages.meta.title;
  doc.querySelector('meta[name="description"]')?.setAttribute('content', messages.meta.description);

  for (const el of doc.querySelectorAll('[data-i18n]')) {
    const key = el.getAttribute('data-i18n')!;
    const value = lookup(messages, key);
    if (typeof value === 'string') el.textContent = value;
    else if (isPair(value)) renderPair(doc, el, value, locale);
    else throw new Error(`[i18n] "${key}" is not a string or a label in ${locale.code}`);
  }

  for (const el of doc.querySelectorAll('[data-i18n-attr]')) {
    for (const spec of el.getAttribute('data-i18n-attr')!.split(';')) {
      const [attr, key] = spec.split(':').map((s) => s.trim());
      const value = attr && key ? lookup(messages, key) : undefined;
      if (typeof value !== 'string') throw new Error(`[i18n] bad attribute binding "${spec}" in ${locale.code}`);
      el.setAttribute(attr!, value);
    }
  }

  for (const el of doc.querySelectorAll('[data-locale-name]')) el.textContent = locale.name;
  // Links to the site's other pages stay in the reader's language.
  for (const el of doc.querySelectorAll('[data-href-page]')) {
    const page = el.getAttribute('data-href-page');
    if (!isPage(page)) throw new Error(`[i18n] unknown page "${page}" in data-href-page`);
    el.setAttribute('href', pathFor(locale.code, page));
  }
  renderLanguageList(doc, locale);
}

/** One link per locale. Real links, so the menu works before (or without) JavaScript. */
function renderLanguageList(doc: Document, current: Locale): void {
  for (const list of doc.querySelectorAll('[data-lang-list]')) {
    if (list.children.length !== LOCALES.length) {
      list.textContent = '';
      for (const locale of LOCALES) {
        const item = doc.createElement('li');
        const link = doc.createElement('a');
        link.setAttribute('href', pathFor(locale.code));
        link.setAttribute('hreflang', locale.code);
        link.setAttribute('lang', locale.code);
        link.setAttribute('data-locale-option', locale.code);
        const own = doc.createElement('span');
        own.className = 'lang-own';
        own.textContent = locale.name;
        link.append(own);
        if (locale.name !== locale.english) {
          const english = doc.createElement('span');
          english.className = 'lang-english';
          english.setAttribute('lang', 'en');
          english.textContent = locale.english;
          link.append(english);
        }
        item.append(link);
        list.append(item);
      }
    }
    for (const link of list.querySelectorAll('[data-locale-option]')) {
      if (link.getAttribute('data-locale-option') === current.code) link.setAttribute('aria-current', 'true');
      else link.removeAttribute('aria-current');
    }
  }
}

/** "पञ्चाङ्ग · Panchanga" — the term keeps its own `lang` so it is voiced and shaped correctly. */
function renderPair(doc: Document, el: Element, pair: Pair, locale: Locale): void {
  el.textContent = '';
  if (pair.term) {
    const term = doc.createElement('span');
    term.className = 'term';
    if (pair.termLang && pair.termLang !== locale.code) term.setAttribute('lang', pair.termLang);
    term.textContent = pair.term;
    el.append(term);
  }
  if (pair.term && pair.name) {
    const sep = doc.createElement('span');
    sep.className = 'sep';
    sep.setAttribute('aria-hidden', 'true');
    sep.textContent = ' · ';
    el.append(sep);
  }
  if (pair.name) {
    const name = doc.createElement('span');
    name.className = 'name';
    name.textContent = pair.name;
    el.append(name);
  }
}

export function lookup(messages: Messages, key: string): unknown {
  let node: unknown = messages;
  for (const part of key.split('.')) {
    if (node === null || typeof node !== 'object' || !(part in node)) return undefined;
    node = (node as Record<string, unknown>)[part];
  }
  return node;
}

const isPair = (value: unknown): value is Pair =>
  value !== null && typeof value === 'object' && 'term' in value && 'name' in value;
