import type { LocaleCode, Messages } from '../types';
import as from './as';
import bn from './bn';
import en from './en';
import gu from './gu';
import hi from './hi';
import kn from './kn';
import ml from './ml';
import mr from './mr';
import ne from './ne';
import or from './or';
import pa from './pa';
import ta from './ta';
import te from './te';

/**
 * Every locale, eagerly. For the build (prerendering) and tests only — the page
 * itself loads one locale at a time through `../load.ts`.
 */
export const MESSAGES: Readonly<Record<LocaleCode, Messages>> = { en, ne, hi, as, bn, gu, kn, ml, mr, or, pa, ta, te };
