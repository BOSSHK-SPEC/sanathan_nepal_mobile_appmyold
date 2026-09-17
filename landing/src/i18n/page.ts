import { defaultRegion, renderPolicy } from '../legal/render';
import { applyMessages } from './apply';
import type { Locale, Messages } from './types';

/**
 * Everything a locale changes on a page: the bound strings (applyMessages) and
 * page-specific content such as the Privacy Policy text. Used by the build to
 * prerender every page in every language, and by the language switcher.
 *
 * `initial` is true when rendering a page from scratch (the build): it may also
 * choose defaults the reader can later change, like the policy's region.
 */
export function applyPage(doc: Document, locale: Locale, messages: Messages, options: { initial?: boolean } = {}): void {
  applyMessages(doc, locale, messages);
  const page = doc.documentElement.getAttribute('data-page');
  if (page === 'privacy') {
    renderPolicy(doc, locale, messages);
    if (options.initial) {
      const region = defaultRegion(locale);
      for (const radio of doc.querySelectorAll('input[name="region"]')) {
        if (radio.getAttribute('value') === region) radio.setAttribute('checked', '');
        else radio.removeAttribute('checked');
      }
    }
  }
}
