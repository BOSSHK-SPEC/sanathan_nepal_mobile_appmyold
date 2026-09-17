import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/widgets/otp_code_input.dart';

import 'helpers/test_helpers.dart';

void main() {
  late List<String> changes;
  late List<String> completions;

  Future<void> pump(WidgetTester tester, {bool enabled = true}) async {
    changes = [];
    completions = [];
    await setPhoneSurface(tester);
    await tester.pumpWidget(
      wrapApp(
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: OtpCodeInput(
              enabled: enabled,
              onChanged: changes.add,
              onCompleted: completions.add,
            ),
          ),
        ),
      ),
    );
  }

  Finder box(int i) => find.byKey(Key('otp_box_$i'));

  testWidgets('each typed digit is drawn centred in its own box', (
    tester,
  ) async {
    await pump(tester);
    await tester.enterText(find.byType(TextField), '472');
    await tester.pumpAndSettle();

    for (final (i, digit) in [(0, '4'), (1, '7'), (2, '2')]) {
      final text = find.descendant(of: box(i), matching: find.text(digit));
      expect(text, findsOneWidget);
      final boxCentre = tester.getCenter(box(i));
      final textCentre = tester.getCenter(text);
      expect((textCentre.dx - boxCentre.dx).abs(), lessThan(0.5));
      expect((textCentre.dy - boxCentre.dy).abs(), lessThan(0.5));
    }
    expect(
      find.descendant(of: box(3), matching: find.byType(Text)),
      findsNothing,
    );
    expect(changes.last, '472');
    expect(completions, isEmpty);
  });

  testWidgets('a pasted or autofilled code fills every box, digits only', (
    tester,
  ) async {
    await pump(tester);
    await tester.enterText(find.byType(TextField), '12-34 5678');
    await tester.pumpAndSettle();

    // Separators stripped, extra digits dropped.
    expect(changes.last, '123456');
    expect(completions, ['123456']);
    for (var i = 0; i < 6; i++) {
      expect(
        find.descendant(of: box(i), matching: find.text('${i + 1}')),
        findsOneWidget,
      );
    }
  });

  testWidgets('backspace removes the last digit', (tester) async {
    await pump(tester);
    await tester.enterText(find.byType(TextField), '123');
    await tester.enterText(find.byType(TextField), '12');
    await tester.pumpAndSettle();

    expect(changes.last, '12');
    expect(
      find.descendant(of: box(2), matching: find.byType(Text)),
      findsNothing,
    );
  });

  testWidgets('the hidden field draws no border or fill of its own', (
    tester,
  ) async {
    await pump(tester);
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    final decorator = tester.widget<InputDecorator>(
      find.byType(InputDecorator),
    );
    final d = decorator.decoration;
    expect(d.filled, isFalse);
    for (final border in [
      d.border,
      d.enabledBorder,
      d.focusedBorder,
      d.disabledBorder,
    ]) {
      expect(border, InputBorder.none);
    }
  });

  testWidgets('disabled input does not accept typing', (tester) async {
    await pump(tester, enabled: false);
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.enabled, isFalse);
  });
}
