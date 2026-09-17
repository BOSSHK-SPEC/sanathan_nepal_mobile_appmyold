import { loadFontsFor } from '../fonts';
import { applyPage } from './page';
import { readLocaleCookie, writeLocaleCookie } from './cookie';
import { loadMessages } from './load';
import { DEFAULT_LOCALE, isLocaleCode, isPage, localeFor, localeFromPath, negotiate, pathFor } from './locales';
import type { Locale, LocaleCode, Messages } from './types';

type Listener = (locale: Locale, messages: Messages) => void;

const FADE_MS = 160;
const SUGGEST_DELAY_MS = 1200;

/**
 * The language menu and everything a language change touches in the browser:
 * swaps the text in place (scroll position and the 3D scene survive), keeps
 * the URL and the `sanatan_lang` cookie in step, and offers first-time visitors
 * the language their browser prefers.
 */
export class LanguageSwitcher {
  private current: LocaleCode;
  private pending: LocaleCode | null = null;
  private readonly listeners = new Set<Listener>();
  private readonly root: HTMLElement;
  private readonly button: HTMLButtonElement | null;
  private readonly menu: HTMLElement | null;
  private readonly usesPopover: boolean;
  private hideSuggestion: (() => void) | null = null;

  constructor(private readonly doc: Document) {
    this.root = doc.documentElement;
    const attr = this.root.getAttribute('data-locale');
    this.current = isLocaleCode(attr) ? attr : DEFAULT_LOCALE;
    this.button = doc.querySelector<HTMLButtonElement>('[data-lang-button]');
    this.menu = doc.getElementById('lang-menu');
    this.usesPopover = 'popover' in HTMLElement.prototype;
  }

  get locale(): LocaleCode {
    return this.current;
  }

  onChange(listener: Listener): void {
    this.listeners.add(listener);
  }

  start(): void {
    this.bindMenu();

    const fromUrl = localeFromPath(window.location.pathname);
    const saved = readLocaleCookie(this.doc);
    // An explicit locale URL (a shared link) wins; otherwise the reader's saved choice.
    const wanted = fromUrl ?? saved;
    const rendered = this.root.hasAttribute('data-locale');

    if (wanted && (wanted !== this.current || !rendered)) {
      void this.switchTo(wanted, { remember: false, animate: false });
    } else if (!rendered) {
      // Dev server: the template is unrendered English — fill in the menu.
      void this.switchTo(this.current, { remember: false, animate: false, force: true });
    }
    if (!saved && !fromUrl) window.setTimeout(() => void this.maybeSuggest(), SUGGEST_DELAY_MS);
  }

  async switchTo(code: LocaleCode, options: { remember?: boolean; animate?: boolean; force?: boolean } = {}): Promise<void> {
    const { remember = true, animate = true, force = false } = options;
    if (remember) writeLocaleCookie(code, this.doc);
    if (code === this.current && !force) return;

    this.pending = code;
    this.button?.setAttribute('aria-busy', 'true');
    let messages: Messages;
    try {
      messages = await loadMessages(code);
      // Fonts first, so the new script never flashes in a fallback face.
      await loadFontsFor(sampleText(messages), localeFor(code).script);
    } catch (error) {
      console.warn(`[i18n] could not switch to ${code}`, error);
      if (this.pending === code) this.pending = null;
      this.button?.removeAttribute('aria-busy');
      return;
    }
    if (this.pending !== code) return; // a later choice superseded this one

    const fade = animate && !window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    if (fade) {
      this.root.classList.add('is-switching-language');
      await new Promise((resolve) => setTimeout(resolve, FADE_MS));
      if (this.pending !== code) return;
    }

    const locale = localeFor(code);
    applyPage(this.doc, locale, messages);
    this.current = code;
    this.pending = null;
    this.updateUrl(code);
    this.announce(messages.language.changed);
    this.button?.removeAttribute('aria-busy');
    this.hideSuggestion?.(); // a language was chosen: the offer has been answered
    if (fade) requestAnimationFrame(() => this.root.classList.remove('is-switching-language'));
    this.listeners.forEach((listener) => listener(locale, messages));
  }

  /** Locale URLs follow the choice; clean URLs (`/`, `/privacy`) stay as they are — nginx picks the language from the cookie. */
  private updateUrl(code: LocaleCode): void {
    const { pathname, search, hash } = window.location;
    if (!pathname.startsWith('/welcome/')) return;
    const page = this.root.getAttribute('data-page');
    const next = pathFor(code, isPage(page) ? page : 'home');
    if (pathname !== next) window.history.replaceState(window.history.state, '', next + search + hash);
  }

  private bindMenu(): void {
    const { button, menu } = this;
    if (!button || !menu) return;

    if (this.usesPopover) {
      menu.addEventListener('toggle', (event) => {
        const open = (event as ToggleEvent).newState === 'open';
        button.setAttribute('aria-expanded', String(open));
        if (open) this.focusOption();
      });
    } else {
      // Browsers without the Popover API: same behaviour, by hand.
      button.removeAttribute('popovertarget');
      menu.removeAttribute('popover');
      menu.hidden = true;
      menu.classList.add('is-fallback');
      button.addEventListener('click', () => this.setFallbackOpen(menu.hidden !== false));
      this.doc.addEventListener('click', (event) => {
        if (!menu.hidden && !menu.contains(event.target as Node) && !button.contains(event.target as Node)) {
          this.setFallbackOpen(false);
        }
      });
      this.doc.addEventListener('keydown', (event) => {
        if (event.key === 'Escape' && !menu.hidden) {
          this.setFallbackOpen(false);
          button.focus();
        }
      });
    }

    menu.addEventListener('click', (event) => {
      const option = (event.target as Element).closest('[data-locale-option]');
      if (!option) return;
      const mouse = event as MouseEvent;
      if (mouse.button !== 0 || mouse.metaKey || mouse.ctrlKey || mouse.shiftKey || mouse.altKey) return; // open in new tab etc.
      const code = option.getAttribute('data-locale-option');
      if (!isLocaleCode(code)) return;
      event.preventDefault();
      this.closeMenu();
      void this.switchTo(code);
    });

    menu.addEventListener('keydown', (event) => {
      if (event.key !== 'ArrowDown' && event.key !== 'ArrowUp' && event.key !== 'Home' && event.key !== 'End') return;
      const options = [...menu.querySelectorAll<HTMLElement>('[data-locale-option]')];
      const index = options.indexOf(this.doc.activeElement as HTMLElement);
      const next =
        event.key === 'Home' ? 0
        : event.key === 'End' ? options.length - 1
        : (index + (event.key === 'ArrowDown' ? 1 : -1) + options.length) % options.length;
      event.preventDefault();
      options[next]?.focus();
    });
  }

  private focusOption(): void {
    const current = this.menu?.querySelector<HTMLElement>('[aria-current="true"]') ?? this.menu?.querySelector<HTMLElement>('a');
    current?.focus();
  }

  private setFallbackOpen(open: boolean): void {
    if (!this.menu || !this.button) return;
    this.menu.hidden = !open;
    this.button.setAttribute('aria-expanded', String(open));
    if (open) this.focusOption();
  }

  private closeMenu(): void {
    if (!this.menu) return;
    if (this.usesPopover) {
      if (this.menu.matches(':popover-open')) this.menu.hidePopover();
    } else {
      this.setFallbackOpen(false);
    }
    this.button?.focus();
  }

  private announce(text: string): void {
    const status = this.doc.querySelector('[data-i18n-status]');
    if (!status) return;
    status.textContent = '';
    window.setTimeout(() => (status.textContent = text), 50);
  }

  /** A quiet offer, in their language, when the browser prefers one we have. Never an automatic redirect. */
  private async maybeSuggest(): Promise<void> {
    const best = negotiate(navigator.languages?.length ? navigator.languages : [navigator.language]);
    if (!best || best === this.current || readLocaleCookie(this.doc)) return;
    const box = this.doc.querySelector<HTMLElement>('[data-suggest]');
    if (!box) return;

    const messages = await loadMessages(best).catch(() => null);
    if (!messages || readLocaleCookie(this.doc)) return;
    const { prompt, accept, dismiss } = messages.suggest;
    await loadFontsFor(prompt + accept + dismiss, localeFor(best).script, ['text']);

    box.setAttribute('lang', best);
    box.querySelector('[data-suggest-prompt]')!.textContent = prompt;
    const acceptButton = box.querySelector<HTMLButtonElement>('[data-suggest-accept]')!;
    const dismissButton = box.querySelector<HTMLButtonElement>('[data-suggest-dismiss]')!;
    acceptButton.textContent = accept;
    dismissButton.textContent = dismiss;

    const hide = (): void => {
      this.hideSuggestion = null;
      box.classList.remove('is-visible');
      window.setTimeout(() => (box.hidden = true), 250);
    };
    this.hideSuggestion = hide;
    acceptButton.addEventListener('click', () => {
      hide();
      void this.switchTo(best);
    }, { once: true });
    dismissButton.addEventListener('click', () => {
      writeLocaleCookie(this.current, this.doc); // they chose to stay: remember that
      hide();
    }, { once: true });

    box.hidden = false;
    requestAnimationFrame(() => box.classList.add('is-visible'));
  }
}

/** Enough of a locale's text to make the browser fetch every face it needs. */
function sampleText(m: Messages): string {
  return [m.hero.lead, m.signIn, m.views[0].title, m.views[0].label.term, m.rail.river.term, ...m.scene.words].join(' ');
}
