// Smoke test: the app boots with its providers and renders the welcome screen.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:sanathan_nepal_mobile_app/dashboard/eventProvider.dart';
import 'package:sanathan_nepal_mobile_app/main.dart';
import 'package:sanathan_nepal_mobile_app/view/screens/welcomeScreen.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  testWidgets('App boots and shows the welcome screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => EventProvider(),
        child: const MyApp(),
      ),
    );
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });
}
