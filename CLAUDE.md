# Sanatan Nepal – Architecture Guide

Flutter app implementing the Figma design
`https://www.figma.com/design/3W6r3GNnEXOLcw5VBqTski` (light = orange theme,
dark = indigo/purple theme, bilingual Nepali/English).

## Layout (Clean Architecture, feature-first)

```
lib/
  main.dart                  # bootstrap (DI, l10n init, runApp)
  app/
    app.dart                 # MaterialApp.router + theme/locale from AppSettingsCubit
    di/injection.dart        # GetIt: core singletons + register<Feature>Feature(sl)
    router/app_routes.dart   # ALL route paths/names (constants)
    router/app_router.dart   # composes per-feature route lists + bottom-nav shell
  core/                      # shared, feature-agnostic code (no feature imports!)
    theme/                   # AppColors (ThemeExtension), AppTheme, AppTypography, AppSpacing/AppRadius
    widgets/                 # PrimaryButton, AppTextField, AppCard, SectionHeader, AdBanner, PillTabs, AppTopBar, state views…
    error/                   # Failure (sealed) / exceptions
    utils/                   # Result<T> (sealed), guard(), NepaliDateUtils
    usecase/                 # UseCase / NoParamsUseCase contracts
    network/api_client.dart  # Dio wrapper (inject via GetIt, never new Dio() in features)
    storage/key_value_store.dart # KeyValueStore interface + SharedPrefs impl + InMemory impl
    extensions/              # context.colors / context.textTheme / context.l10n / context.tr(ne:,en:)
  l10n/                      # app_en.arb, app_ne.arb  → generated/ (flutter gen-l10n)  – shared/common strings only
  features/<feature>/
    <feature>_routes.dart    # `List<RouteBase> <feature>Routes` (+ `<feature>TabRoute` for shell tabs)
    <feature>_injection.dart # `void register<Feature>Feature(GetIt sl)`
    domain/  entities/ repositories/ (abstract) usecases/
    data/    models/ (extend entities, fromJson/toJson) datasources/ (remote|local|mock) repositories/ (impl)
    presentation/ cubit|bloc/ pages/ widgets/ l10n/<feature>_strings.dart
```

### Dependency rule
`presentation → domain ← data`. Domain has **no** Flutter/Dio imports. Data
implements domain interfaces. Presentation only talks to use cases via Cubits.
`core/` never imports from `features/`.

### SOLID in practice
* **S** – one class per file, one reason to change (Cubit = UI state only; repo = data orchestration only; datasource = I/O only).
* **O** – add a feature = new folder + one line in `injection.dart` + one spread in `app_router.dart`.
* **L** – models and entities are separate freezed types bridged by `toEntity()/fromEntity()`; repositories always hand back entities.
* **I** – small repository/data-source interfaces (`abstract interface class`).
* **D** – constructors take abstractions (`AppPreferencesRepository`, `KeyValueStore`, `ApiClient`), wired in GetIt.

### Immutability & code generation (freezed)
All value types are **freezed** – no hand-written `copyWith`/`==`/`hashCode`/`props`
(`equatable` is not used in new code). Run `dart run build_runner watch --delete-conflicting-outputs`
while developing; generated `*.freezed.dart` / `*.g.dart` are committed and excluded from lints.

* **Entities** (`domain/entities`): `@freezed abstract class X with _$X { const factory X({...}) = _X; }`
  – pure Dart, no JSON. Add `const X._();` when you need getters/methods.
* **Models** (`data/models`): `@freezed abstract class XModel with _$XModel` + `factory XModel.fromJson`
  (json_serializable, `field_rename: snake`, `explicit_to_json`) + `XModel.fromEntity(e)` and `X toEntity()`.
  Repositories return entities (`model.toEntity()`), never models.
* **Unions**: `@freezed sealed class` + Dart 3 `switch` pattern matching (freezed `when/map` are disabled
  in `build.yaml` on purpose).

### Error handling
Data sources throw `core/error/exceptions.dart`. Repositories wrap calls with `guard(() => …)` which
returns `Result<T>` (freezed sealed union `Success<T>` | `ResultFailure<T>`, with `fold`, `map`,
`valueOrNull`, `failureOrNull`). `Failure` is a freezed sealed union
(`Failure.server/network/cache/validation/notFound/permission/unknown`) – exhaustive `switch` in UI.

### State management
`flutter_bloc` Cubits with **freezed states** declared as a `part` of the cubit file:

```dart
// weather_cubit.dart
part 'weather_cubit.freezed.dart';
part 'weather_state.dart';

// weather_state.dart
part of 'weather_cubit.dart';

@freezed
abstract class WeatherState with _$WeatherState {
  const factory WeatherState({
    @Default(LoadState.idle()) LoadState<WeatherBundle> weather,
    @Default(0) int selectedHourIndex,
    GeoLocation? explicitLocation,
  }) = _WeatherState;
}
```

* Every independent async slice is a `LoadState<T>` (`core/state/load_state.dart`):
  `idle | loading(previous) | loaded(data) | failed(failure, previous)` with `dataOrNull`,
  `isLoading`, `toLoading()`, `toFailed(f)`, `errorMessage`. No `status` enums, no `message` strings,
  no nullable "data" fields duplicated per status.
* Cubit pattern: `emit(state.copyWith(x: state.x.toLoading())); final r = await useCase(); emit(state.copyWith(x: r.fold(state.x.toFailed, LoadState.loaded)));`
* Widgets: `switch (state.x) { case Loading(): …; case Loaded(:final data): …; case Failed(:final failure): …; case Idle(): … }`
  or `state.x.dataOrNull` for optional rendering; `BlocBuilder`/`BlocSelector` with `buildWhen` where useful.
* Pages obtain cubits with `BlocProvider(create: (_) => sl<XxxCubit>()..load())`.
* Global settings (region/theme/locale/silent) → `AppSettingsCubit` (state = freezed `AppPreferences`).

### Dependency injection
`get_it` (`lib/app/di/injection.dart` → `register<Feature>Feature(sl)` per feature). Data sources,
repositories, use cases → `registerLazySingleton`; cubits → `registerFactory` (`registerFactoryParam` when
they need runtime args). Constructors take abstractions only (`XxxRepository`, `KeyValueStore`,
`ApiClient`, `RegionResolver`).

### Theming
Never hard-code hex in widgets. Use `context.colors.<role>` (`AppColors` roles:
background, surface, surfaceVariant, primary, accent, textPrimary/Secondary/Muted,
border, divider, chipBackground/chipSelected, today, holiday, primaryGradient,
headerGradient, cardGradient, navBar…). Both Figma themes are covered by the two
`AppColors` presets. Typography: `context.textTheme` (Mukta is the app font).
Spacing: `AppSpacing`, radius: `AppRadius`.

### Localization
* Common strings: `lib/l10n/app_en.arb` + `app_ne.arb`, accessed via `context.l10n.key`.
* Feature strings: `features/<f>/presentation/l10n/<f>_strings.dart` –
  an abstract class with `en`/`ne` const implementations and
  `static <F>Strings of(BuildContext ctx) => ctx.isNepali ? const _Ne() : const _En();`
  (feature isolation, no cross-feature ARB conflicts).
* Devanagari digits: `NepaliDateUtils.toDevanagari(n)` / `'123'.toDevanagariDigits()`.

### Assets
`assets/images/<feature>/…`, `assets/icons/<feature>/….svg` – exported from
Figma. Reference through `AppAssets.image('feature/name.png')` or feature-local
constants. Use `AppImage` for rendering.

### Navigation
`go_router`. Paths live in `AppRoutes`. Bottom-nav tabs = `StatefulShellRoute`
branches (home / marketplace / horoscope / profile); everything else is pushed
on the root navigator. Use `context.push(AppRoutes.x)` / `context.go`.


### Regions (Nepal 🇳🇵 / India 🇮🇳)
The app is multi-region. Everything region-specific hangs off `core/region/`:

* `Region` enum + `RegionConfig` (`lib/core/region/region.dart`) – single source of truth:
  currency (`NPR रु.` / `INR ₹`), phone prefix (+977/+91), time-zone label (NST/IST),
  default city (Kathmandu / New Delhi), offered languages (`ne,en` / `en,hi`), traditional
  calendar (`BikramSambatCalendar` / `SakaCalendar`), payment rails (eSewa/Khalti/bank/COD vs
  UPI/card/net-banking/COD), bullion unit (tola / 10 g), samvat header labels, weekend day
  (Saturday / Sunday).
* Widgets: `context.region`, `context.regionConfig`, `context.traditionalCalendar`
  (from `RegionScope`, provided at the app root; the whole tree is rebuilt on change).
* Data/domain layers: inject `RegionResolver` (`sl<RegionResolver>()`, `region`/`config`
  getters – never read the cubit directly). Tests use `FixedRegionResolver(Region.india)`.
* Money/phone/time formatting: `RegionFormat.money(amount, config:, languageCode:)` etc.
* Traditional calendars: `TraditionalCalendar` (`fromGregorian`, `toGregorian`,
  `daysInMonth`, `monthNames(languageCode:)`, `eraLabel`, `weekendWeekdays`) and
  `TraditionalDate(year, month, day)`. Nepal = Bikram Sambat (nepali_utils), India = Indian
  national (Saka) calendar with `VikramSamvat.yearFor(date)` for the VS year label.
  Features must not call `nepali_utils`/`NepaliDateTime` directly for region logic – go through
  `context.traditionalCalendar` / `RegionResolver.config.calendar` so India gets Saka dates.
* Languages: `AppLanguage {nepali, english, hindi}`; `context.isNepali`, `context.isHindi`,
  `context.usesDevanagariDigits` (ne + hi). Feature strings classes should add a `_Hi`
  implementation where translations exist; until then `of()` may fall back to English for `hi`.
  Shared strings live in `app_en/ne/hi.arb`.
* Region-specific datasets (festivals, seed products/providers, legal text, forex source) are
  selected inside the data layer by `RegionResolver` – the presentation layer stays region-blind.

### Roles & seller flow
`UserProfile.role` = `user | seller | admin` (mock seed = admin so the flow is demoable). Any user → Profile ›
Links › "My Business / Become a Seller" (`/business/mine`) → Business Details Form → status **pending** →
Admin › "Business approvals" (`/admin/businesses`, route-guarded) approves/rejects → approved sellers add
products via Marketplace › "My Products & Services" › + Add Product (`/marketplace/product/new`) or the
quick-menu "Add Products" tile; edit/delete from their cards or the details page.

### Data
No backend contract exists yet, so each feature ships a `Mock<Feature>DataSource`
(deterministic seed data) behind the repository interface, plus real
implementations where a public API exists (NRB forex, Open-Meteo weather,
Bikram Sambat via `nepali_utils`). Swapping to a real API = new data source
class + one DI line.

### Testing
`test/features/<feature>/…` – unit tests for use cases/repositories (mocktail),
`bloc_test` for cubits, widget tests for key pages. `flutter analyze` must be clean.

### Commands
```
flutter pub get && flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs   # or `watch` while developing
flutter analyze
flutter test
flutter run
```
Legacy (pre-rewrite) code is kept in `legacy/` for reference only and is
excluded from analysis.

The staff console's public landing page is a separate static site in `landing/`
(Vite + TypeScript + three.js, see `landing/README.md`). `npm --prefix landing run build`
writes it to `web/welcome/` (git-ignored), so console builds ship it; the console
hands `/` to it at startup and handles every other path (`/sign-in`, `/console/*`).
The VS Code Console launch configs build it first; `deploy-console.yml` builds it in CI.
It is translated into 13 languages (`landing/src/i18n/`, one prerendered page each at `/welcome/<code>/`),
and also carries the public Privacy Policy (`/privacy`, text ported from `lib/features/legal`) and the
web Delete account flow (`/delete-account`: phone OTP → `DELETE /api/v1/profile`), which store listings link to.
