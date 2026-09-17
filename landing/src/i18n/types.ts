import type { ActKey } from '../story';

/** ISO 15924 script of a locale's text, used to pick fonts and typographic tweaks. */
export type Script = 'latn' | 'deva' | 'beng' | 'guru' | 'gujr' | 'orya' | 'taml' | 'telu' | 'knda' | 'mlym';

export type LocaleCode = 'en' | 'ne' | 'hi' | 'as' | 'bn' | 'gu' | 'kn' | 'ml' | 'mr' | 'or' | 'pa' | 'ta' | 'te';

export interface Locale {
  readonly code: LocaleCode;
  /** The language's name in itself — what its readers look for in a menu. */
  readonly name: string;
  readonly english: string;
  readonly script: Script;
  /**
   * Whether a native speaker has proofread this translation. Unreviewed
   * locales still ship; this is the checklist for the review, not a gate.
   */
  readonly reviewed: boolean;
}

/**
 * A short label that may pair a traditional term with a gloss: "पञ्चाङ्ग · Panchanga"
 * in English, just "ಪಂಚಾಂಗ" in Kannada. `termLang` marks a term in another language.
 */
export interface Pair {
  readonly term: string;
  readonly name: string;
  readonly termLang?: string;
}

export interface ViewCopy {
  readonly label: Pair;
  readonly title: string;
  readonly body: string;
}

type Tuple<T, N extends number, R extends T[] = []> = R['length'] extends N ? R : Tuple<T, N, [...R, T]>;

/** Every string on the landing page. Adding a key here fails the build until every locale has it. */
export interface LandingMessages {
  readonly meta: { readonly title: string; readonly description: string };
  readonly skip: string;
  readonly brandLabel: string;
  readonly rail: Readonly<Record<ActKey, Pair>>;
  readonly signIn: string;
  readonly language: { readonly button: string; readonly heading: string; readonly changed: string };
  readonly hero: { readonly label: Pair; readonly lead: string; readonly cue: string };
  /** Views 1–11 (the hero is view 0). */
  readonly views: Tuple<ViewCopy, 11>;
  readonly footer: string;
  /** Offered to first-time visitors whose browser prefers this language. Written in this language. */
  readonly suggest: { readonly prompt: string; readonly accept: string; readonly dismiss: string };
  readonly scene: {
    /** Lamp words for views 1 and 2 of the river (view 0 is always ॐ). */
    readonly words: [string, string];
    /** Rashi names engraved on the zodiac band, from Mesha. */
    readonly rashis: Tuple<string, 12>;
  };
}

/** Strings for the Privacy Policy and Delete account pages, and the links to them. */
export interface DocumentMessages {
  /** The page tabs in the header; `label` names that navigation for screen readers. */
  readonly links: { readonly label: string; readonly home: string; readonly privacy: string; readonly deleteAccount: string };
  readonly privacy: {
    readonly meta: { readonly title: string; readonly description: string };
    readonly eyebrow: string;
    readonly title: string;
    /** `{date}` is replaced with the policy's last-updated date, formatted for the locale. */
    readonly updated: string;
    readonly regionLabel: string;
    readonly nepal: string;
    readonly india: string;
    readonly contents: string;
    /** Shown when the policy text is not in the page's language; empty when it is. */
    readonly languageNote: string;
    readonly deleteTitle: string;
    readonly deleteBody: string;
  };
  readonly account: {
    readonly meta: { readonly title: string; readonly description: string };
    readonly eyebrow: string;
    readonly title: string;
    readonly lead: string;
    readonly removedTitle: string;
    readonly removed: Tuple<string, 4>;
    readonly keptTitle: string;
    readonly kept: string;
    readonly permanent: string;
    readonly steps: { readonly phone: string; readonly code: string; readonly confirm: string };
    readonly phoneLabel: string;
    readonly phoneHint: string;
    readonly sendCode: string;
    readonly codeLabel: string;
    /** `{phone}` */
    readonly codeSentSms: string;
    /** `{phone}` */
    readonly codeGiven: string;
    readonly verify: string;
    readonly changeNumber: string;
    readonly confirmTitle: string;
    /** `{name}`, `{phone}` */
    readonly signedInAs: string;
    readonly staffNote: string;
    readonly understand: string;
    readonly deleteButton: string;
    readonly keepButton: string;
    readonly working: string;
    readonly doneTitle: string;
    readonly doneBody: string;
    readonly noAccountTitle: string;
    readonly noAccountBody: string;
    readonly cancelledTitle: string;
    readonly cancelledBody: string;
    readonly startOver: string;
    readonly help: string;
    readonly noScript: string;
    readonly errors: {
      readonly phoneFormat: string;
      readonly codeFormat: string;
      readonly notAllowed: string;
      readonly rateLimited: string;
      readonly codeIncorrect: string;
      readonly codeExpired: string;
      readonly tooManyAttempts: string;
      readonly mustConfirm: string;
      readonly lastAdmin: string;
      readonly sessionExpired: string;
      readonly network: string;
      readonly unknown: string;
    };
  };
}

export type Messages = LandingMessages & DocumentMessages;
