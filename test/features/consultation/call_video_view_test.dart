import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/presentation/widgets/call_video_view.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// The call screen used to show an avatar and call it a video call. It now
/// renders real video — but the picture is the *last* thing to arrive, so the
/// states around it are what decide whether the screen looks broken.
void main() {
  Widget harness(Widget child) => MaterialApp(
    theme: AppTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: SizedBox(width: 320, height: 480, child: child),
    ),
  );

  testWidgets('with no call yet, it names who is being waited for', (
    tester,
  ) async {
    await tester.pumpWidget(
      harness(
        const CallVideoView(room: null, placeholderName: 'Guru Sharma'),
      ),
    );

    expect(find.text('Guru Sharma'), findsOneWidget);
    expect(find.text('Waiting for them to join…'), findsOneWidget);
  });

  testWidgets('a room that is not a media room does not crash the screen', (
    tester,
  ) async {
    // The room arrives untyped from the cubit — a build with calls switched
    // off, or a stale object, must render the placeholder rather than throw
    // on a screen that is already charging by the minute.
    await tester.pumpWidget(
      harness(
        const CallVideoView(
          room: 'not-a-room',
          placeholderName: 'Guru Sharma',
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Waiting for them to join…'), findsOneWidget);
  });
}
