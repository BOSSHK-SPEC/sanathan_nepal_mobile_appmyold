import type { Locale, Messages } from '../i18n/types';
import { type PolicyLanguage, type Region, privacyPolicy } from './privacy';

/** Which text of the policy a page language reads: its own where one exists, otherwise English. */
export const policyLanguage = (locale: Locale): PolicyLanguage => (locale.code === 'ne' ? 'ne' : locale.code === 'hi' ? 'hi' : 'en');

/** The region a reader most likely means: Nepal for English and Nepali pages, India for the Indian languages. */
export const defaultRegion = (locale: Locale): Region => (locale.code === 'en' || locale.code === 'ne' ? 'NP' : 'IN');

/**
 * Renders both regions' policies into `[data-policy]` (the region picker shows
 * one) and the last-updated line. DOM-only, so the build and the browser share it.
 */
export function renderPolicy(doc: Document, locale: Locale, messages: Messages): void {
  const host = doc.querySelector('[data-policy]');
  if (!host) return;
  const lang = policyLanguage(locale);
  const make = (tag: string, attrs: Record<string, string> = {}, text?: string): Element => {
    const node = doc.createElement(tag);
    for (const [k, v] of Object.entries(attrs)) node.setAttribute(k, v);
    if (text !== undefined) node.textContent = text;
    return node;
  };

  host.textContent = '';
  let lastUpdated = '';
  for (const region of ['NP', 'IN'] as const) {
    const policy = privacyPolicy(region);
    lastUpdated = policy.lastUpdated;
    const prefix = region.toLowerCase();
    const article = make('article', {
      class: 'policy-region',
      'data-policy-region': region,
      lang: lang === 'ne' ? 'ne' : 'en',
      'aria-label': region === 'NP' ? messages.privacy.nepal : messages.privacy.india,
    });

    const toc = make('nav', { class: 'policy-toc', 'aria-label': messages.privacy.contents, lang: locale.code });
    toc.append(make('p', { class: 'policy-toc-title' }, messages.privacy.contents));
    const list = make('ol');
    for (const section of policy.sections.filter((s) => s.level === 1)) {
      const item = make('li');
      item.append(make('a', { href: `#${prefix}-${section.id}`, lang: lang === 'hi' ? 'hi' : lang }, section.heading[lang]));
      list.append(item);
    }
    toc.append(list);
    article.append(toc);

    const body = make('div', { class: 'policy-body' });
    appendText(body, policy.intro, lang, make);
    for (const section of policy.sections) {
      body.append(make(section.level === 1 ? 'h2' : 'h3', { id: `${prefix}-${section.id}`, lang: lang === 'hi' ? 'hi' : lang }, section.heading[lang]));
      if (section.body) appendText(body, section.body, lang, make);
    }
    article.append(body);
    host.append(article);
  }

  const updated = doc.querySelector('[data-policy-updated]');
  if (updated) {
    const date = new Intl.DateTimeFormat(locale.code, { dateStyle: 'long', timeZone: 'UTC' }).format(new Date(`${lastUpdated}T00:00:00Z`));
    updated.textContent = messages.privacy.updated.replace('{date}', date);
    updated.setAttribute('data-date', lastUpdated);
  }
}

function appendText(
  parent: Element,
  text: { en: string; ne: string; hi: string },
  lang: PolicyLanguage,
  make: (tag: string, attrs?: Record<string, string>, text?: string) => Element,
): void {
  if (lang === 'hi') parent.append(make('p', { class: 'policy-summary', lang: 'hi' }, text.hi));
  parent.append(make('p', lang === 'hi' ? { lang: 'en' } : {}, lang === 'ne' ? text.ne : text.en));
}
