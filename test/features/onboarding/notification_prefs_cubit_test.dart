import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/datasources/notification_prefs_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/repositories/notification_prefs_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/notification_prefs.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/get_notification_prefs.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/save_notification_prefs.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/cubit/notification_prefs_cubit.dart';

void main() {
  late InMemoryKeyValueStore store;

  NotificationPrefsCubit build() {
    final repo = NotificationPrefsRepositoryImpl(
      NotificationPrefsLocalDataSourceImpl(store),
    );
    return NotificationPrefsCubit(
      getPrefs: GetNotificationPrefs(repo),
      savePrefs: SaveNotificationPrefs(repo),
    );
  }

  setUp(() => store = InMemoryKeyValueStore());

  group('NotificationPrefsCubit', () {
    blocTest<NotificationPrefsCubit, NotificationPrefsState>(
      'load emits defaults when nothing stored',
      build: build,
      act: (c) => c.load(),
      expect: () => const [
        NotificationPrefsState(prefs: LoadState.loading()),
        NotificationPrefsState(prefs: LoadState.loaded(NotificationPrefs())),
      ],
    );

    blocTest<NotificationPrefsCubit, NotificationPrefsState>(
      'update + save persists and emits saved',
      build: build,
      act: (c) async {
        c.update((p) => p.copyWith(horoscopeDaily: false, birthdays: false));
        await c.save();
      },
      expect: () => const [
        NotificationPrefsState(
          prefs: LoadState.loaded(
            NotificationPrefs(horoscopeDaily: false, birthdays: false),
          ),
        ),
        NotificationPrefsState(
          prefs: LoadState.loaded(
            NotificationPrefs(horoscopeDaily: false, birthdays: false),
          ),
          save: LoadState.loading(),
        ),
        NotificationPrefsState(
          prefs: LoadState.loaded(
            NotificationPrefs(horoscopeDaily: false, birthdays: false),
          ),
          save: LoadState.loaded(null),
        ),
      ],
      verify: (_) {
        final stored = NotificationPrefsLocalDataSourceImpl(store).read();
        expect(stored.horoscopeDaily, isFalse);
        expect(stored.birthdays, isFalse);
        expect(stored.publicHolidays, isTrue);
      },
    );
  });
}
