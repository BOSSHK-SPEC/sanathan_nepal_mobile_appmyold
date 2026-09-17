import { ApiError, type AccountApi, type Region } from './api';

/**
 * The Delete account flow, without any DOM: phone → code → confirm → done.
 *
 * Safety rules it enforces:
 * - Nothing is deleted without an explicit confirmation on the last step.
 * - Tokens live only in this object's memory — never in storage, cookies or
 *   the URL — and are dropped as soon as the flow ends.
 * - Verifying a number the server does not know creates an empty account; that
 *   account is deleted again at once and the reader is told there was none.
 * - An expired access token is refreshed once and the delete retried once.
 */

export type Step = 'phone' | 'code' | 'confirm' | 'done' | 'noAccount' | 'cancelled';

export type ErrorKey =
  | 'phoneFormat' | 'codeFormat' | 'notAllowed' | 'rateLimited' | 'codeIncorrect' | 'codeExpired'
  | 'tooManyAttempts' | 'mustConfirm' | 'lastAdmin' | 'sessionExpired' | 'network' | 'unknown';

export interface FlowState {
  readonly step: Step;
  readonly busy: boolean;
  readonly error: ErrorKey | null;
  /** The number as the reader will recognise it, once normalised. */
  readonly phone: string;
  readonly authMode: 'staticOtp' | 'sms';
  readonly displayName: string | null;
  readonly isStaff: boolean;
}

const STAFF_ROLES = new Set(['moderator', 'finance', 'support', 'superAdmin']);
const E164 = /^\+[1-9]\d{7,14}$/;
const CODE = /^\d{4,8}$/;

interface Session {
  accessToken: string;
  refreshToken: string;
}

export class DeleteAccountFlow {
  private state: FlowState = { step: 'phone', busy: false, error: null, phone: '', authMode: 'sms', displayName: null, isStaff: false };
  private readonly listeners = new Set<(state: FlowState) => void>();
  private challenge: { id: string; expiresAt: number; region: Region } | null = null;
  private session: Session | null = null;

  constructor(
    private readonly api: AccountApi,
    private readonly now: () => number = Date.now,
  ) {}

  get current(): FlowState {
    return this.state;
  }

  subscribe(listener: (state: FlowState) => void): () => void {
    this.listeners.add(listener);
    listener(this.state);
    return () => this.listeners.delete(listener);
  }

  /** Fetches whether codes arrive by SMS or are handed out (static OTP). Optional. */
  async loadAuthMode(): Promise<void> {
    this.set({ authMode: await this.api.authMode() });
  }

  async submitPhone(raw: string): Promise<void> {
    if (this.state.busy) return;
    const phone = normalisePhone(raw);
    if (!E164.test(phone)) return this.set({ error: 'phoneFormat' });

    const region: Region = phone.startsWith('+91') ? 'IN' : 'NP';
    this.set({ busy: true, error: null, phone });
    try {
      const challenge = await this.api.startPhone(phone, region);
      this.challenge = { id: challenge.challengeId, expiresAt: this.now() + challenge.expiresInSeconds * 1000, region };
      this.set({ busy: false, step: 'code' });
    } catch (error) {
      this.set({ busy: false, error: errorKey(error, 'phone') });
    }
  }

  async submitCode(raw: string): Promise<void> {
    if (this.state.busy || !this.challenge) return;
    const code = raw.replace(/\s+/g, '');
    if (!CODE.test(code)) return this.set({ error: 'codeFormat' });
    if (this.now() > this.challenge.expiresAt) return this.backToPhone('codeExpired');

    this.set({ busy: true, error: null });
    try {
      const result = await this.api.verifyPhone(this.challenge.id, code, this.challenge.region);
      this.challenge = null;
      this.session = { accessToken: result.accessToken, refreshToken: result.refreshToken };

      if (result.isNewUser) {
        // Signing in just created this account: remove it again so a mistyped
        // number leaves nothing behind.
        await this.api.deleteAccount(result.accessToken).catch(() => this.api.signOut(result.accessToken).catch(() => undefined));
        this.session = null;
        return this.set({ busy: false, step: 'noAccount' });
      }

      this.set({
        busy: false,
        step: 'confirm',
        displayName: result.displayName?.trim() || null,
        isStaff: result.roles.some((role) => STAFF_ROLES.has(role)),
      });
    } catch (error) {
      const key = errorKey(error, 'code');
      if (key === 'codeExpired' || key === 'tooManyAttempts' || key === 'notAllowed') return this.backToPhone(key);
      this.set({ busy: false, error: key });
    }
  }

  async confirmDelete(understood: boolean): Promise<void> {
    if (this.state.busy || !this.session) return;
    if (!understood) return this.set({ error: 'mustConfirm' });

    this.set({ busy: true, error: null });
    try {
      await this.deleteWithRefresh(this.session);
      this.session = null;
      this.set({ busy: false, step: 'done', displayName: null });
    } catch (error) {
      const key = errorKey(error, 'delete');
      if (key === 'sessionExpired') {
        this.session = null;
        return this.backToPhone('sessionExpired');
      }
      this.set({ busy: false, error: key });
    }
  }

  /** "Keep my account": sign this page's session out and stop. */
  async cancel(): Promise<void> {
    if (this.state.busy) return;
    const session = this.session;
    this.session = null;
    this.challenge = null;
    this.set({ step: 'cancelled', error: null, displayName: null, isStaff: false });
    if (session) await this.api.signOut(session.accessToken).catch(() => undefined);
  }

  changeNumber(): void {
    if (this.state.busy) return;
    this.challenge = null;
    this.set({ step: 'phone', error: null });
  }

  restart(): void {
    this.challenge = null;
    this.session = null;
    this.set({ step: 'phone', busy: false, error: null, phone: '', displayName: null, isStaff: false });
  }

  private async deleteWithRefresh(session: Session): Promise<void> {
    try {
      await this.api.deleteAccount(session.accessToken);
    } catch (error) {
      if (!(error instanceof ApiError) || !['TOKEN_EXPIRED', 'UNAUTHENTICATED', 'TOKEN_INVALID'].includes(error.code)) throw error;
      let fresh;
      try {
        fresh = await this.api.refresh(session.refreshToken);
      } catch {
        throw new ApiError(403, 'SESSION_EXPIRED', 'The sign-in could not be refreshed');
      }
      session.accessToken = fresh.accessToken;
      session.refreshToken = fresh.refreshToken;
      await this.api.deleteAccount(fresh.accessToken);
    }
  }

  private backToPhone(error: ErrorKey): void {
    this.challenge = null;
    this.set({ busy: false, step: 'phone', error });
  }

  private set(patch: Partial<FlowState>): void {
    this.state = { ...this.state, ...patch };
    this.listeners.forEach((listener) => listener(this.state));
  }
}

/** "+977 981-234 5678", "00977…" → "+9779812345678". Anything else is left for validation to reject. */
export function normalisePhone(raw: string): string {
  let phone = raw.trim().replace(/[\s\-().]/g, '');
  if (phone.startsWith('00')) phone = `+${phone.slice(2)}`;
  return phone;
}

function errorKey(error: unknown, stage: 'phone' | 'code' | 'delete'): ErrorKey {
  if (!(error instanceof ApiError)) return 'unknown';
  switch (error.code) {
    case 'NETWORK':
    case 'TIMEOUT':
      return 'network';
    case 'PHONE_NOT_ALLOWED':
      return 'notAllowed';
    case 'RATE_LIMITED':
    case 'OTP_RATE_LIMITED':
      return 'rateLimited';
    case 'OTP_INCORRECT':
      return 'codeIncorrect';
    case 'OTP_EXPIRED':
      return 'codeExpired';
    case 'OTP_TOO_MANY_ATTEMPTS':
      return 'tooManyAttempts';
    case 'LAST_ADMIN_ACCOUNT':
      return 'lastAdmin';
    case 'SESSION_EXPIRED':
    case 'REFRESH_INVALID':
    case 'REFRESH_REUSED':
    case 'REFRESH_EXPIRED':
    case 'TOKEN_EXPIRED':
    case 'TOKEN_INVALID':
    case 'UNAUTHENTICATED':
      return 'sessionExpired';
    default:
      if (stage === 'phone' && error.status === 400) return 'phoneFormat';
      if (stage === 'code' && error.status === 400) return 'codeIncorrect';
      return 'unknown';
  }
}
