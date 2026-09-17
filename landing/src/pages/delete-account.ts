import { createAccountApi } from '../account/api';
import { DeleteAccountFlow, type FlowState, type Step } from '../account/flow';
import { loadMessages } from '../i18n/load';
import type { Messages } from '../i18n/types';
import { startPage } from './common';
import '../styles/document.css';

/** Production API unless the build says otherwise (`VITE_API_BASE`, e.g. for a local backend). */
const API_BASE = import.meta.env.VITE_API_BASE || 'https://sanatan-api.yashwanthhk.com';

const language = startPage();
const flow = new DeleteAccountFlow(createAccountApi(API_BASE));
let messages: Messages | null = null;

const $ = <T extends Element>(selector: string): T => {
  const node = document.querySelector<T>(selector);
  if (!node) throw new Error(`delete-account: missing ${selector}`);
  return node;
};
const panels = new Map<Step, HTMLElement>(
  [...document.querySelectorAll<HTMLElement>('[data-panel]')].map((panel) => [panel.dataset.panel as Step, panel]),
);
const phoneForm = $<HTMLFormElement>('[data-panel="phone"]');
const codeForm = $<HTMLFormElement>('[data-panel="code"]');
const confirmForm = $<HTMLFormElement>('[data-panel="confirm"]');
const phoneInput = $<HTMLInputElement>('#phone');
const codeInput = $<HTMLInputElement>('#code');
const understand = $<HTMLInputElement>('#understand');
const errorLine = $<HTMLElement>('[data-error]');
const busyLine = $<HTMLElement>('[data-busy]');
const flowSection = $<HTMLElement>('[data-flow]');

phoneForm.addEventListener('submit', (event) => {
  event.preventDefault();
  void flow.submitPhone(phoneInput.value);
});
codeForm.addEventListener('submit', (event) => {
  event.preventDefault();
  void flow.submitCode(codeInput.value);
});
confirmForm.addEventListener('submit', (event) => {
  event.preventDefault();
  void flow.confirmDelete(understand.checked);
});
flowSection.addEventListener('click', (event) => {
  const action = (event.target as Element).closest<HTMLElement>('[data-action]')?.dataset.action;
  if (action === 'change-number') flow.changeNumber();
  else if (action === 'keep') void flow.cancel();
  else if (action === 'restart') flow.restart();
});

let shownStep: Step | null = null;

function render(state: FlowState): void {
  if (!messages) return;
  const t = messages.account;

  for (const [step, panel] of panels) panel.hidden = step !== state.step;
  const order: Step[] = ['phone', 'code', 'confirm'];
  const index = order.indexOf(state.step);
  for (const item of document.querySelectorAll<HTMLElement>('[data-step-indicator]')) {
    const i = order.indexOf(item.dataset.stepIndicator as Step);
    item.classList.toggle('is-current', i === index);
    item.classList.toggle('is-done', index === -1 ? state.step === 'done' : i < index);
  }

  $('[data-code-hint]').textContent = (state.authMode === 'staticOtp' ? t.codeGiven : t.codeSentSms).replace('{phone}', state.phone);
  $('[data-signed-in]').textContent = t.signedInAs.replace('{name}', state.displayName ?? '—').replace('{phone}', state.phone);
  $<HTMLElement>('[data-staff-note]').hidden = !state.isStaff;

  errorLine.textContent = state.error ? t.errors[state.error] : '';
  busyLine.textContent = state.busy ? t.working : '';
  flowSection.setAttribute('aria-busy', String(state.busy));
  for (const control of flowSection.querySelectorAll<HTMLButtonElement | HTMLInputElement>('button, input')) control.disabled = state.busy;
  const invalid = state.error !== null;
  phoneInput.setAttribute('aria-invalid', String(invalid && state.step === 'phone'));
  codeInput.setAttribute('aria-invalid', String(invalid && state.step === 'code'));

  if (state.step !== shownStep) {
    // A new step: move focus to where the reader acts next, and clear stale input.
    const previous = shownStep;
    shownStep = state.step;
    if (previous !== null) {
      if (state.step === 'phone') phoneInput.focus();
      else if (state.step === 'code') {
        codeInput.value = '';
        codeInput.focus();
      } else {
        understand.checked = false;
        panels.get(state.step)?.querySelector<HTMLElement>('.flow-title')?.focus();
      }
    }
  }
}

language.onChange((_locale, next) => {
  messages = next;
  render(flow.current);
});

void loadMessages(language.locale).then((loaded) => {
  messages ??= loaded; // a language switch that finished first wins
  flow.subscribe(render);
});
void flow.loadAuthMode();

// Nothing to keep once the reader leaves: a session signed in here is signed out.
window.addEventListener('pagehide', () => {
  if (flow.current.step === 'confirm') void flow.cancel();
});
