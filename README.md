# Sanatan Nepal – Mobile App

Flutter implementation of the [Sanatan Nepal Figma design](https://www.figma.com/design/3W6r3GNnEXOLcw5VBqTski)
– Patro/Panchang calendar, Panchanga & Shubh Muhurat, Horoscope, Events, Weather,
Forex, Date Converter, Marketplace, Appointments, Profile, Blogs/News – with the **light
(orange)** and **dark (indigo/purple)** themes from the design.

**Multi-region:** the user picks **Nepal 🇳🇵** or **India 🇮🇳** (onboarding / profile
preferences) and the whole app adapts:

| | Nepal | India |
|---|---|---|
| Languages | नेपाली, English | English, हिन्दी |
| Calendar | Bikram Sambat primary, AD secondary | Gregorian primary, Saka (Indian national) secondary + Vikram Samvat year |
| Weekend | Saturday | Sunday |
| Festivals/holidays | Nepali festivals & public holidays | Indian national holidays + Hindu/Sikh/Muslim/Christian/Jain/Buddhist festivals (2025–27) |
| Panchanga | Kathmandu, NST, Nepal Sambat | New Delhi, IST, Rahu Kaal / Yamaganda / Gulika / Abhijit / Choghadiya |
| Currency & forex | NPR (रु./Rs.), Nepal Rastra Bank rates | INR (₹), ECB/Frankfurter rates |
| Payments | eSewa, Khalti, bank, COD | UPI, card, net banking, COD |
| Phone / bullion | +977, per tola | +91, per 10 g |

Region logic lives in `lib/core/region` (`RegionConfig`, `RegionScope`, `RegionResolver`) and
`lib/core/calendar` (`TraditionalCalendar`: `BikramSambatCalendar`, `SakaCalendar`) – see
ARCHITECTURE.md → "Regions".

## Architecture

Clean Architecture, feature-first, SOLID. See [ARCHITECTURE.md](ARCHITECTURE.md) for the
full guide (layer rules, state management, theming, l10n, DI, testing).

```
lib/
  app/        MaterialApp.router, GetIt DI, go_router (bottom-nav shell + feature routes)
  core/       theme tokens (AppColors ThemeExtension, Mukta typography), Result/Failure,
              use-case contracts, ApiClient (Dio), KeyValueStore, shared widgets
  l10n/       ARB files (ne/en) → generated AppLocalizations (shared strings)
  features/   <feature>/{domain,data,presentation} + <feature>_routes.dart + <feature>_injection.dart
```

| Feature | Screens (Figma) | Data |
|---|---|---|
| onboarding | Splash, Language/Theme, Login, Phone/OTP, Details, Notification prefs | mock auth + local |
| home | Home (calendar strip, weather, horoscope, events, suva sait, forex, panchanga, ads) | composes features |
| calendar / date_converter | Patro month grid, date popups, Traditional⇄Gregorian converter | BS via `nepali_utils`, Saka rule-based; region festival seeds |
| horoscope / panchanga | 12-sign daily/weekly/monthly/yearly, Panchanga tables, Suva Sait | mock (deterministic) |
| weather / forex | Weather page & card, Forex trend/converter/table | **Open-Meteo**, **NRB forex API** (Nepal) / **Frankfurter** (India), mock fallback |
| events / notifications | Festivals, My events, To-do, details, create/edit, notifications & settings | mock in-memory + local prefs |
| marketplace | Marketplace tab, listing, product details, cart, checkout, boost flow, popups | mock + persisted cart |
| appointment | Provider profile/tabs, booking wizard, my appointments, details, reschedule/cancel | mock in-memory |
| profile | User profile (About/Activities/Notifications/Links), edit, business profile & form, support | mock + local |
| legal / content | Privacy policy, Terms, Blogs, News, article details | seeded |

State: `flutter_bloc` Cubits with **freezed** states (`LoadState<T>` slices) · Entities/models:
**freezed** (+ `json_serializable` for models) · DI: `get_it` · Navigation: `go_router` · Errors:
freezed sealed `Failure` + `Result<T>` · Fonts: Mukta (bundled).

## Getting started

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs   # freezed / json_serializable
flutter run
```

Quality gate:

```bash
flutter analyze      # 0 issues
flutter test         # ~380 tests (bloc_test, mocktail, widget tests, both regions)
```

## Notes

* No backend exists yet; every feature ships a deterministic `Mock*DataSource` behind its
  repository interface. Swapping to a real API = new data source class + one DI line.
* The pre-rewrite code is kept in `legacy/` for reference only (excluded from analysis).
* Android/iOS location permission entries are in place for the weather feature (falls back to
  Kathmandu when denied).
