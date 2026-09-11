import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/primary_button.dart';

void main() {
  testWidgets('PrimaryButton renders label and handles tap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: PrimaryButton(label: 'Go', onPressed: () => tapped = true),
        ),
      ),
    );
    expect(find.text('Go'), findsOneWidget);
    await tester.tap(find.text('Go'));
    expect(tapped, isTrue);
  });
}
