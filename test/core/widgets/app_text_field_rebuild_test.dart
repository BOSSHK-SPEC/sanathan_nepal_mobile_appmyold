import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/app_text_field.dart';

/// A value pushed into an [AppTextField] from outside — a cubit trimming what
/// was typed, a server response arriving — while it sits inside a [Form].
///
/// Only a Form makes this dangerous: the field's controller notifies the Form,
/// and a Form marked dirty mid-build throws. The existing tests use a bare
/// field, which is why this was never caught before a real form hit it.
Widget _inForm(String value, {FocusNode? focus}) => MaterialApp(
  theme: AppTheme.light(),
  home: Scaffold(
    body: Form(
      child: AppTextField(initialValue: value, focusNode: focus),
    ),
  ),
);

String _text(WidgetTester tester) =>
    tester.widget<EditableText>(find.byType(EditableText)).controller.text;

void main() {
  testWidgets('a value changed from outside, inside a Form, does not throw', (
    tester,
  ) async {
    await tester.pumpWidget(_inForm('   '));
    await tester.pumpWidget(_inForm(''));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(_text(tester), '');
  });

  testWidgets('the new value lands after the frame that delivered it', (
    tester,
  ) async {
    await tester.pumpWidget(_inForm('sita@'));
    await tester.pumpWidget(_inForm('sita@example.com'));
    await tester.pump();
    expect(_text(tester), 'sita@example.com');
  });

  testWidgets('typing is protected even when no FocusNode is passed in', (
    tester,
  ) async {
    // The details form passes none. Focus used to be read from the caller's
    // node only, so without one the field always looked unfocused and a late
    // value could replace what was being typed.
    await tester.pumpWidget(_inForm(''));
    await tester.tap(find.byType(EditableText));
    await tester.enterText(find.byType(EditableText), 'Sit');
    await tester.pumpWidget(_inForm('Server value'));
    await tester.pump();

    expect(_text(tester), 'Sit');
  });
}
