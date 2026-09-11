import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/session/profile_session_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/session/presentation/widgets/role_switch_banner.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

void main() {
  Widget harness(AppSession session, {Locale locale = const Locale('en')}) =>
      SessionScope(
        session: session,
        child: MaterialApp(
          theme: AppTheme.light(),
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: RoleSwitchBanner()),
        ),
      );

  testWidgets('the seeded demo account is invited to apply', (tester) async {
    // The seed holds {admin}; that expands to seeker + superAdmin, and
    // seekers can apply — so the banner must offer the application.
    final session = AppSession(
      userId: 'u1',
      isAuthenticated: true,
      roles: ProfileSessionSource.rolesForAll(const {UserRole.admin}),
    );

    await tester.pumpWidget(harness(session));
    await tester.pumpAndSettle();

    expect(find.text('Become an astrologer'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);
  });

  testWidgets('an approved astrologer is offered the switch instead', (
    tester,
  ) async {
    final session = AppSession(
      userId: 'u1',
      isAuthenticated: true,
      roles: ProfileSessionSource.rolesForAll(const {
        UserRole.admin,
        UserRole.astrologer,
      }),
    );

    await tester.pumpWidget(harness(session));
    await tester.pumpAndSettle();

    expect(find.text('Astrologer'), findsOneWidget);
    expect(find.byIcon(Icons.swap_horiz_rounded), findsOneWidget);
    expect(find.text('Become an astrologer'), findsNothing);
  });

  testWidgets('a signed-out visitor sees nothing', (tester) async {
    await tester.pumpWidget(harness(AppSession.guest));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNothing);
    expect(find.text('Become an astrologer'), findsNothing);
  });

  testWidgets('renders in Nepali', (tester) async {
    final session = AppSession(
      userId: 'u1',
      isAuthenticated: true,
      roles: ProfileSessionSource.rolesForAll(const {UserRole.user}),
    );
    await tester.pumpWidget(harness(session, locale: const Locale('ne')));
    await tester.pumpAndSettle();
    expect(find.text('ज्योतिषी बन्नुहोस्'), findsOneWidget);
  });
}
