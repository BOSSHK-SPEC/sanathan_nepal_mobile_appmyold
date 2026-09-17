import type { Locale, LocaleCode } from './types';

/** Menu order: the app's own languages first, then alphabetical by English name. */
export const LOCALES = [
  { code: 'en', name: 'English', english: 'English', script: 'latn', reviewed: true },
  { code: 'ne', name: 'नेपाली', english: 'Nepali', script: 'deva', reviewed: false },
  { code: 'hi', name: 'हिन्दी', english: 'Hindi', script: 'deva', reviewed: false },
  { code: 'as', name: 'অসমীয়া', english: 'Assamese', script: 'beng', reviewed: false },
  { code: 'bn', name: 'বাংলা', english: 'Bengali', script: 'beng', reviewed: false },
  { code: 'gu', name: 'ગુજરાતી', english: 'Gujarati', script: 'gujr', reviewed: false },
  { code: 'kn', name: 'ಕನ್ನಡ', english: 'Kannada', script: 'knda', reviewed: false },
  { code: 'ml', name: 'മലയാളം', english: 'Malayalam', script: 'mlym', reviewed: false },
  { code: 'mr', name: 'मराठी', english: 'Marathi', script: 'deva', reviewed: false },
  { code: 'or', name: 'ଓଡ଼ିଆ', english: 'Odia', script: 'orya', reviewed: false },
  { code: 'pa', name: 'ਪੰਜਾਬੀ', english: 'Punjabi', script: 'guru', reviewed: false },
  { code: 'ta', name: 'தமிழ்', english: 'Tamil', script: 'taml', reviewed: false },
  { code: 'te', name: 'తెలుగు', english: 'Telugu', script: 'telu', reviewed: false },
] as const satisfies readonly Locale[];

export const DEFAULT_LOCALE: LocaleCode = 'en';

/** Cookie holding the reader's choice. nginx reads it too (deploy/console/nginx.conf). */
export const LOCALE_COOKIE = 'sanatan_lang';

const byCode = new Map<string, Locale>(LOCALES.map((l) => [l.code, l]));

export const isLocaleCode = (value: unknown): value is LocaleCode => typeof value === 'string' && byCode.has(value);

export const localeFor = (code: LocaleCode): Locale => byCode.get(code)!;

/** The site's pages. `home` is the 3D journey; the others are documents. */
export const PAGES = ['home', 'privacy', 'delete-account'] as const;
export type Page = (typeof PAGES)[number];

export const isPage = (value: unknown): value is Page => typeof value === 'string' && (PAGES as readonly string[]).includes(value);

/**
 * URL of a page in a locale. Every locale, English included, has one of each.
 * It names the file (`…/index.html`), not the folder: every server resolves that,
 * including `flutter run`'s dev server, which answers a folder URL with the
 * Flutter console (a white screen while its engine loads) instead of the page.
 */
export const pathFor = (code: LocaleCode, page: Page = 'home'): string =>
  page === 'home' ? `/welcome/${code}/index.html` : `/welcome/${code}/${page}/index.html`;

/**
 * The locale and page a URL path names — `/welcome/kn/`, `/welcome/kn/privacy/`,
 * with or without `index.html` — or null for anything else.
 */
export function routeFromPath(pathname: string): { locale: LocaleCode; page: Page } | null {
  const match = /^\/welcome\/([a-z]{2})\/(?:([a-z-]+)\/)?(?:index\.html)?$/.exec(pathname);
  if (!match || !isLocaleCode(match[1])) return null;
  const page = match[2] ?? 'home';
  return isPage(page) && page !== 'home' ? { locale: match[1], page } : match[2] ? null : { locale: match[1], page: 'home' };
}

/** The locale a URL path names, if any. */
export const localeFromPath = (pathname: string): LocaleCode | null => routeFromPath(pathname)?.locale ?? null;

/**
 * The best supported locale for a browser's language preferences, matching on
 * the primary subtag (`kn-IN` → `kn`). Null when nothing matches.
 */
export function negotiate(preferred: readonly string[]): LocaleCode | null {
  for (const tag of preferred) {
    const primary = tag.toLowerCase().split('-')[0];
    // Odia is also tagged "ory" by older systems.
    const code = primary === 'ory' ? 'or' : primary;
    if (isLocaleCode(code)) return code;
  }
  return null;
}
