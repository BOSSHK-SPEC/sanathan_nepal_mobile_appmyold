import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/text_controller_scope.dart';

/// Controllers created beside a sheet and disposed after `await show()` are
/// disposed while the sheet is still animating out — the next frame then
/// throws "A TextEditingController was used after being disposed". These pin
/// the lifetime that avoids it.
void main() {
  testWidgets('controllers stay alive through the exit animation', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showModalBottomSheet<String>(
                context: context,
                builder: (_) => TextControllerScope(
                  count: 1,
                  builder: (sheetContext, controllers) => TextField(
                    controller: controllers.first,
                    onSubmitted: (_) =>
                        Navigator.of(sheetContext).pop(controllers.first.text),
                  ),
                ),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'a reply');

    // Dismiss and pump *through* the exit animation frame by frame: this is
    // exactly the window in which the old pattern threw.
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('initial values seed the controllers positionally', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextControllerScope(
            count: 2,
            initialValues: const ['first'],
            builder: (context, controllers) => Column(
              children: [for (final c in controllers) TextField(controller: c)],
            ),
          ),
        ),
      ),
    );

    expect(find.text('first'), findsOneWidget);
    // The second had no initial value and starts empty rather than crashing on
    // a short list.
    final fields = tester.widgetList<TextField>(find.byType(TextField));
    expect(fields.last.controller?.text, '');
  });

  testWidgets('typing rebuilds the subtree, so a submit button can react', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextControllerScope(
            count: 1,
            builder: (context, controllers) => Column(
              children: [
                TextField(controller: controllers.first),
                if (controllers.first.text.isNotEmpty) const Text('ready'),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('ready'), findsNothing);
    await tester.enterText(find.byType(TextField), 'x');
    await tester.pump();
    expect(find.text('ready'), findsOneWidget);
  });
}
