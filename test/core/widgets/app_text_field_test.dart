import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/app_text_field.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: AppTheme.light(),
  home: Scaffold(body: child),
);

/// A saved value has to be *in* the field, not behind it.
///
/// Passing it as `hint` looked right in a screenshot and was wrong in use: the
/// grey placeholder disappears as soon as anyone types, so a stored rate or
/// account number read as an empty form and editing began from blank.
void main() {
  testWidgets('initialValue is real, editable text — not a placeholder', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(const AppTextField(initialValue: '100')));

    expect(find.text('100'), findsOneWidget);
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, '100');
  });

  testWidgets('a later value is picked up when the field is not focused', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(const AppTextField(initialValue: '')));
    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, '');

    // The load finished and the saved rate arrived.
    await tester.pumpWidget(_wrap(const AppTextField(initialValue: '250')));
    await tester.pump();

    expect(find.text('250'), findsOneWidget);
  });

  testWidgets('typing is never overwritten by a late value', (tester) async {
    final focus = FocusNode();
    addTearDown(focus.dispose);

    await tester.pumpWidget(
      _wrap(AppTextField(initialValue: '100', focusNode: focus)),
    );
    await tester.tap(find.byType(TextField));
    await tester.pump();
    await tester.enterText(find.byType(TextField), '35');

    // A rebuild arrives mid-edit — a save response, a parent reload.
    await tester.pumpWidget(
      _wrap(AppTextField(initialValue: '500', focusNode: focus)),
    );
    await tester.pump();

    // What the astrologer typed survives; the cursor is not thrown around.
    expect(find.text('35'), findsOneWidget);
    expect(find.text('500'), findsNothing);
  });

  testWidgets('a caller-supplied controller still owns the value', (
    tester,
  ) async {
    final controller = TextEditingController(text: 'mine');
    addTearDown(controller.dispose);

    await tester.pumpWidget(_wrap(AppTextField(controller: controller)));

    expect(find.text('mine'), findsOneWidget);
  });
}
