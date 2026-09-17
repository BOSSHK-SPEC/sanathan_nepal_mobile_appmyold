import { describe, expect, it, vi } from 'vitest';
import { ApiError, createAccountApi, type AccountApi, type SignIn } from '../src/account/api';
import { DeleteAccountFlow, normalisePhone } from '../src/account/flow';

const signIn = (over: Partial<SignIn> = {}): SignIn => ({
  userId: 'u1', isNewUser: false, roles: ['seeker'], displayName: 'Asha', phone: '+9779812345678',
  accessToken: 'access-1', refreshToken: 'refresh-1', ...over,
});

function fakeApi(over: Partial<AccountApi> = {}): AccountApi & { calls: string[] } {
  const calls: string[] = [];
  const log = <T>(name: string, value: T) => async (...args: unknown[]) => {
    calls.push(`${name}(${args.join(',')})`);
    return value;
  };
  return {
    calls,
    authMode: log('authMode', 'sms' as const),
    startPhone: log('startPhone', { challengeId: 'c1', expiresInSeconds: 300 }),
    verifyPhone: log('verifyPhone', signIn()),
    refresh: log('refresh', { accessToken: 'access-2', refreshToken: 'refresh-2' }),
    deleteAccount: log('deleteAccount', undefined),
    signOut: log('signOut', undefined),
    ...over,
  };
}

async function toConfirm(api: AccountApi, now = () => 0): Promise<DeleteAccountFlow> {
  const flow = new DeleteAccountFlow(api, now);
  await flow.submitPhone('+977 981-234 5678');
  await flow.submitCode('123456');
  return flow;
}

describe('normalisePhone', () => {
  it('accepts spaces, dashes, brackets and a 00 prefix', () => {
    expect(normalisePhone(' +977 (981) 234-5678 ')).toBe('+9779812345678');
    expect(normalisePhone('0091 98123 45678')).toBe('+919812345678');
  });
});

describe('DeleteAccountFlow', () => {
  it('walks phone → code → confirm → done, deleting only after confirmation', async () => {
    const api = fakeApi();
    const flow = await toConfirm(api);
    expect(flow.current).toMatchObject({ step: 'confirm', phone: '+9779812345678', displayName: 'Asha', isStaff: false });
    expect(api.calls).toEqual(['startPhone(+9779812345678,NP)', 'verifyPhone(c1,123456,NP)']);

    await flow.confirmDelete(false);
    expect(flow.current.error).toBe('mustConfirm');
    expect(api.calls.some((c) => c.startsWith('deleteAccount'))).toBe(false);

    await flow.confirmDelete(true);
    expect(flow.current).toMatchObject({ step: 'done', error: null, busy: false });
    expect(api.calls.at(-1)).toBe('deleteAccount(access-1)');
  });

  it('picks the India region for +91 numbers', async () => {
    const api = fakeApi();
    await new DeleteAccountFlow(api).submitPhone('+919812345678');
    expect(api.calls[0]).toBe('startPhone(+919812345678,IN)');
  });

  it('rejects malformed numbers and codes without calling the API', async () => {
    const api = fakeApi();
    const flow = new DeleteAccountFlow(api);
    await flow.submitPhone('9812345678');
    expect(flow.current.error).toBe('phoneFormat');
    await flow.submitPhone('+9779812345678');
    await flow.submitCode('12');
    expect(flow.current.error).toBe('codeFormat');
    expect(api.calls).toEqual(['startPhone(+9779812345678,NP)']);
  });

  it('removes the account that verifying an unknown number created, and says there was none', async () => {
    const api = fakeApi({ verifyPhone: async () => signIn({ isNewUser: true, accessToken: 'fresh' }) });
    const deleted: string[] = [];
    api.deleteAccount = async (token) => void deleted.push(token);
    const flow = await toConfirm(api);
    expect(flow.current.step).toBe('noAccount');
    expect(deleted).toEqual(['fresh']);
  });

  it('keeps the reader on the code step for a wrong code, and sends them back for an expired one', async () => {
    const wrong = fakeApi({ verifyPhone: async () => { throw new ApiError(400, 'OTP_INCORRECT', 'x'); } });
    const flow = await toConfirm(wrong);
    expect(flow.current).toMatchObject({ step: 'code', error: 'codeIncorrect' });

    const expired = fakeApi({ verifyPhone: async () => { throw new ApiError(400, 'OTP_EXPIRED', 'x'); } });
    expect((await toConfirm(expired)).current).toMatchObject({ step: 'phone', error: 'codeExpired' });
  });

  it('notices a code that expired while the reader was away, without calling verify', async () => {
    let now = 0;
    const api = fakeApi();
    const flow = new DeleteAccountFlow(api, () => now);
    await flow.submitPhone('+9779812345678');
    now = 301_000;
    await flow.submitCode('123456');
    expect(flow.current).toMatchObject({ step: 'phone', error: 'codeExpired' });
    expect(api.calls.some((c) => c.startsWith('verifyPhone'))).toBe(false);
  });

  it('refreshes an expired access token once and retries the delete', async () => {
    const tokens: string[] = [];
    const api = fakeApi({
      deleteAccount: async (token) => {
        tokens.push(token);
        if (token === 'access-1') throw new ApiError(403, 'TOKEN_EXPIRED', 'x');
      },
    });
    const flow = await toConfirm(api);
    await flow.confirmDelete(true);
    expect(tokens).toEqual(['access-1', 'access-2']);
    expect(flow.current.step).toBe('done');
  });

  it('asks the reader to verify again when the session cannot be refreshed', async () => {
    const api = fakeApi({
      deleteAccount: async () => { throw new ApiError(403, 'TOKEN_EXPIRED', 'x'); },
      refresh: async () => { throw new ApiError(400, 'REFRESH_REUSED', 'x'); },
    });
    const flow = await toConfirm(api);
    await flow.confirmDelete(true);
    expect(flow.current).toMatchObject({ step: 'phone', error: 'sessionExpired' });
  });

  it('explains the last-admin rule and deletes nothing', async () => {
    const api = fakeApi({ verifyPhone: async () => signIn({ roles: ['superAdmin'] }), deleteAccount: async () => { throw new ApiError(400, 'LAST_ADMIN_ACCOUNT', 'x'); } });
    const flow = await toConfirm(api);
    expect(flow.current.isStaff).toBe(true);
    await flow.confirmDelete(true);
    expect(flow.current).toMatchObject({ step: 'confirm', error: 'lastAdmin' });
  });

  it('signs the session out when the reader keeps their account', async () => {
    const api = fakeApi();
    const flow = await toConfirm(api);
    await flow.cancel();
    expect(flow.current.step).toBe('cancelled');
    expect(api.calls.at(-1)).toBe('signOut(access-1)');
    await flow.confirmDelete(true); // no session left: nothing happens
    expect(api.calls.filter((c) => c.startsWith('deleteAccount'))).toHaveLength(0);
  });

  it('ignores double submissions while a request is in flight', async () => {
    let release!: () => void;
    const api = fakeApi({ startPhone: () => new Promise((resolve) => { release = () => resolve({ challengeId: 'c1', expiresInSeconds: 300 }); }) });
    const spy = vi.spyOn(api, 'startPhone');
    const flow = new DeleteAccountFlow(api);
    const first = flow.submitPhone('+9779812345678');
    await flow.submitPhone('+9779812345678');
    release();
    await first;
    expect(spy).toHaveBeenCalledTimes(1);
  });

  it('maps network failures and rate limits to messages the reader can act on', async () => {
    const offline = fakeApi({ startPhone: async () => { throw new ApiError(0, 'NETWORK', 'x'); } });
    const flow = new DeleteAccountFlow(offline);
    await flow.submitPhone('+9779812345678');
    expect(flow.current).toMatchObject({ step: 'phone', error: 'network' });

    const limited = fakeApi({ startPhone: async () => { throw new ApiError(400, 'RATE_LIMITED', 'x'); } });
    const flow2 = new DeleteAccountFlow(limited);
    await flow2.submitPhone('+9779812345678');
    expect(flow2.current.error).toBe('rateLimited');
  });
});

describe('createAccountApi', () => {
  it('sends the same requests as the app, and no body or JSON header on delete', async () => {
    const requests: { url: string; init: RequestInit }[] = [];
    const fetchImpl = (async (url: string, init: RequestInit) => {
      requests.push({ url, init });
      return url.endsWith('/profile') ? new Response(null, { status: 204 }) : Response.json({ challengeId: 'c1', expiresInSeconds: 300 });
    }) as unknown as typeof fetch;
    const api = createAccountApi('https://api.example/', fetchImpl);

    await api.startPhone('+9779812345678', 'NP');
    await api.deleteAccount('tok');

    const [start, del] = requests;
    expect(start!.url).toBe('https://api.example/api/v1/auth/phone/start');
    expect(start!.init.method).toBe('POST');
    expect(start!.init.body).toBe('{"phone":"+9779812345678"}');
    expect((start!.init.headers as Record<string, string>)['X-Region']).toBe('NP');
    expect((start!.init.headers as Record<string, string>).Authorization).toBeUndefined();
    expect(start!.init.credentials).toBe('omit');

    expect(del!.url).toBe('https://api.example/api/v1/profile');
    expect(del!.init.method).toBe('DELETE');
    expect(del!.init.body).toBeNull();
    expect((del!.init.headers as Record<string, string>)['Content-Type']).toBeUndefined();
    expect((del!.init.headers as Record<string, string>).Authorization).toBe('Bearer tok');
  });

  it("turns the server's error envelope into an ApiError with its code", async () => {
    const fetchImpl = (async () => Response.json({ error: { kind: 'validation', code: 'OTP_INCORRECT', message: 'Wrong code' } }, { status: 400 })) as unknown as typeof fetch;
    await expect(createAccountApi('https://api.example', fetchImpl).verifyPhone('c', '1234', 'NP')).rejects.toMatchObject({ status: 400, code: 'OTP_INCORRECT' });
  });

  it('reports a network failure as NETWORK', async () => {
    const fetchImpl = (async () => { throw new TypeError('Failed to fetch'); }) as unknown as typeof fetch;
    await expect(createAccountApi('https://api.example', fetchImpl).signOut('t')).rejects.toMatchObject({ code: 'NETWORK' });
  });
});
