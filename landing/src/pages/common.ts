// Shared by every page: fonts, base styles and the language menu.
// Fonts are built by scripts/fonts.mjs (one face per script, subset to the characters used).
import '../fonts/.generated/fonts.css';
import '../styles.css';

import { LanguageSwitcher } from '../i18n/switcher';
import { markSessionSeen } from '../ui/splash';
import { enablePageTransitions } from '../ui/transitions';

export function startPage(doc: Document = document): LanguageSwitcher {
  doc.documentElement.classList.add('js');
  enablePageTransitions(doc);
  markSessionSeen();
  const language = new LanguageSwitcher(doc);
  language.start();
  return language;
}
