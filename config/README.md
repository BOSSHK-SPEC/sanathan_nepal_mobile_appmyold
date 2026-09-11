# Build configuration

Each file is a `--dart-define-from-file` bundle. The API base URL is **never**
committed into Dart source — a URL baked into a source file is how a debug
build ends up talking to production.

```bash
flutter run   --dart-define-from-file=config/development.json   # local backend
flutter run   --dart-define-from-file=config/mock.json          # no backend at all
flutter run   --dart-define-from-file=config/production.json    # the live server
flutter build apk --release --dart-define-from-file=config/production.json
```

| File | Backend | Mock data |
|---|---|---|
| `mock.json` | none | yes — runs with the server down |
| `development.json` | `localhost:3100` (`10.0.2.2` on the Android emulator) | no |
| `production.json` | `https://sanatan-api.yashwanthhk.com` | no — a production flavour cannot ship mocks |

`development.json` deliberately sets no `API_BASE_URL`: the per-platform
fallback in `AppEnvironment` picks the right host for the emulator, the
simulator and desktop. A **physical** device is on none of those, so pass your
machine's LAN address explicitly:

```bash
flutter run --dart-define-from-file=config/development.json \
            --dart-define=API_BASE_URL=http://192.168.1.11:3100
```

Later defines win, so this overrides the file rather than conflicting with it.

## Adding an environment

Copy `production.json`, change the URL. Nothing in Dart changes — `FLAVOR`
accepts `development`, `staging` and `production`, and everything else keys off
that.

## A note on secrets

These files hold a hostname, which is not a secret. Never put an API key or a
signing credential in one: `--dart-define` values are compiled into the binary
and are readable by anyone who unpacks the APK.
