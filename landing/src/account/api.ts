/**
 * The few Sanatan API calls the Delete account page needs, with plain fetch.
 * Mirrors the app's client (lib/core/network): JSON bodies, `X-Region`, a
 * per-request `X-Trace-Id`, and a Bearer token only where one is required.
 * Tokens are passed in and never stored — see flow.ts.
 */

export type Region = 'NP' | 'IN';

export interface Challenge {
  readonly challengeId: string;
  readonly expiresInSeconds: number;
}

export interface SignIn {
  readonly userId: string;
  readonly isNewUser: boolean;
  readonly roles: readonly string[];
  readonly displayName?: string;
  readonly phone?: string;
  readonly accessToken: string;
  readonly refreshToken: string;
}

export interface Tokens {
  readonly accessToken: string;
  readonly refreshToken: string;
}

/** What the page needs from the API — an interface so the flow can be tested without a network. */
export interface AccountApi {
  authMode(): Promise<'staticOtp' | 'sms'>;
  startPhone(phone: string, region: Region): Promise<Challenge>;
  verifyPhone(challengeId: string, code: string, region: Region): Promise<SignIn>;
  refresh(refreshToken: string): Promise<Tokens>;
  deleteAccount(accessToken: string): Promise<void>;
  signOut(accessToken: string): Promise<void>;
}

/** An API failure with the server's error code (`OTP_INCORRECT`, …), or `NETWORK` / `TIMEOUT`. */
export class ApiError extends Error {
  constructor(
    readonly status: number,
    readonly code: string,
    message: string,
  ) {
    super(message);
    this.name = 'ApiError';
  }
}

const TIMEOUT_MS = 15_000;

export function createAccountApi(baseUrl: string, fetchImpl: typeof fetch = fetch.bind(globalThis)): AccountApi {
  const root = baseUrl.replace(/\/+$/, '');

  async function call<T>(path: string, init: { method: string; body?: unknown; token?: string; region?: Region }): Promise<T> {
    const headers: Record<string, string> = { Accept: 'application/json', 'X-Trace-Id': traceId() };
    if (init.region) headers['X-Region'] = init.region;
    if (init.body !== undefined) headers['Content-Type'] = 'application/json';
    if (init.token) headers.Authorization = `Bearer ${init.token}`;

    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), TIMEOUT_MS);
    let response: Response;
    try {
      response = await fetchImpl(`${root}${path}`, {
        method: init.method,
        headers,
        body: init.body === undefined ? null : JSON.stringify(init.body),
        signal: controller.signal,
        credentials: 'omit',
        cache: 'no-store',
        referrerPolicy: 'no-referrer',
      });
    } catch (error) {
      const aborted = error instanceof DOMException && error.name === 'AbortError';
      throw new ApiError(0, aborted ? 'TIMEOUT' : 'NETWORK', aborted ? 'The request timed out' : 'The request could not be sent');
    } finally {
      clearTimeout(timer);
    }

    if (response.status === 204) return undefined as T;
    const data: unknown = await response.json().catch(() => null);
    if (!response.ok) {
      const error = (data as { error?: { code?: string; message?: string } } | null)?.error;
      throw new ApiError(response.status, error?.code ?? `HTTP_${response.status}`, error?.message ?? response.statusText);
    }
    return data as T;
  }

  return {
    async authMode() {
      // Best effort: only changes a hint on the page, never blocks the flow.
      try {
        const response = await fetchImpl(`${root}/version`, { cache: 'no-store', credentials: 'omit' });
        const body = (await response.json()) as { auth?: { mode?: string } };
        return body.auth?.mode === 'staticOtp' ? 'staticOtp' : 'sms';
      } catch {
        return 'sms';
      }
    },
    startPhone: (phone, region) => call('/api/v1/auth/phone/start', { method: 'POST', body: { phone }, region }),
    verifyPhone: (challengeId, code, region) =>
      call('/api/v1/auth/phone/verify', { method: 'POST', body: { challengeId, code, region }, region }),
    refresh: (refreshToken) => call('/api/v1/auth/refresh', { method: 'POST', body: { refreshToken } }),
    // No body and no Content-Type: the server takes none.
    deleteAccount: (accessToken) => call('/api/v1/profile', { method: 'DELETE', token: accessToken }),
    signOut: (accessToken) => call('/api/v1/auth/signout', { method: 'POST', token: accessToken }),
  };
}

function traceId(): string {
  return typeof crypto !== 'undefined' && 'randomUUID' in crypto ? crypto.randomUUID() : `${Date.now().toString(16)}-${Math.random().toString(16).slice(2)}`;
}
