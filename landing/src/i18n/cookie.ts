import { LOCALE_COOKIE, isLocaleCode } from './locales';
import type { LocaleCode } from './types';

export function readLocaleCookie(doc: Document = document): LocaleCode | null {
  for (const part of doc.cookie.split(';')) {
    const [name, value] = part.trim().split('=');
    if (name === LOCALE_COOKIE && isLocaleCode(value)) return value;
  }
  return null;
}

/** A year, site-wide, so nginx can serve the right page for `/` on the next visit. */
export function writeLocaleCookie(code: LocaleCode, doc: Document = document): void {
  const secure = doc.location?.protocol === 'https:' ? '; Secure' : '';
  doc.cookie = `${LOCALE_COOKIE}=${code}; Path=/; Max-Age=31536000; SameSite=Lax${secure}`;
}
