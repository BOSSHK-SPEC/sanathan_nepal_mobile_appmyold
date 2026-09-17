import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/datasources/app_preferences_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/repositories/app_preferences_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/get_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/save_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/shell/presentation/widgets/quick_menu_sheet.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// An approved astrologer was still being invited to become one: the quick
/// menu offered "Become an astrologer" to everyone, with no check at all.
void main() {
  late AppSettingsCubit settings;

  setUp(() {
    final prefsRepo = AppPreferencesRepositoryImpl(
      AppPreferencesLocalDataSourceImpl(InMemoryKeyValueStore()),
    );
    settings = AppSettingsCubit(
      getPreferences: GetAppPreferences(prefsRepo),
      savePreferences: SaveAppPreferences(prefsRepo),
    );
  });

  Widget wrap({required Set<AppRole> roles}) => MaterialApp(
    theme: AppTheme.light(),
    locale: const Locale('en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: SessionScope(
      session: AppSession(userId: 'u1', isAuthenticated: true, roles: roles),
      child: BlocProvider<AppSettingsCubit>.value(
        value: settings,
        child: const Scaffold(body: QuickMenuSheet()),
      ),
    ),
  );

  Future<void> openMenu(WidgetTester tester, Set<AppRole> roles) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(wrap(roles: roles));
    await tester.pumpAndSettle();
  }

  /// The menu shows eight tiles a page and mounts only the page in view, so
  /// the astrologer tile has to be paged to before it exists at all.
  Future<Finder?> findTile(WidgetTester tester, String label) async {
    final grid = find.byType(PageView).last;
    for (var page = 0; page < 5; page++) {
      if (find.text(label).evaluate().isNotEmpty) return find.text(label);
      await tester.fling(grid, const Offset(-400, 0), 1000);
      await tester.pumpAndSettle();
    }
    return find.text(label).evaluate().isEmpty ? null : find.text(label);
  }

  testWidgets('an approved astrologer is offered their console, not the '
      'application', (tester) async {
    await openMenu(tester, {AppRole.seeker, AppRole.astrologer});

    expect(await findTile(tester, 'Astrologer console'), isNotNull);
    expect(find.text('Become an astrologer'), findsNothing);
  });

  testWidgets('everyone else is still invited to apply', (tester) async {
    await openMenu(tester, {AppRole.seeker});

    expect(await findTile(tester, 'Become an astrologer'), isNotNull);
    expect(find.text('Astrologer console'), findsNothing);
  });
}
