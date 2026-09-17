import type { LocaleCode, Messages } from './types';

// One chunk per locale: a reader downloads only the language they switch to.
const loaders = import.meta.glob<{ default: Messages }>('./messages/[a-z][a-z].ts');

export async function loadMessages(code: LocaleCode): Promise<Messages> {
  const load = loaders[`./messages/${code}.ts`];
  if (!load) throw new Error(`[i18n] no messages for "${code}"`);
  return (await load()).default;
}
