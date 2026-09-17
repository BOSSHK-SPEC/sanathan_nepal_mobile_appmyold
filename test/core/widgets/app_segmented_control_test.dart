import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/app_segmented_control.dart';

/// The labels used to be pinned to the top-left of the pill: they sat above
/// the centre line, and only that thin strip answered a tap — which reads as
/// a tab that refuses to switch, not as a small tap target.
void main() {
  Widget host({required int selected, required ValueChanged<int> onChanged}) =>
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 320,
              child: AppSegmentedControl(
                segments: const ['Upcoming', 'Past'],
                selectedIndex: selected,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      );

  testWidgets('labels sit on the centre line of the pill', (tester) async {
    await tester.pumpWidget(host(selected: 0, onChanged: (_) {}));
    await tester.pumpAndSettle();

    final control = tester.getRect(find.byType(AppSegmentedControl));
    for (final label in ['Upcoming', 'Past']) {
      final text = tester.getRect(find.text(label));
      expect(
        (text.center.dy - control.center.dy).abs(),
        lessThan(1),
        reason: '$label is not vertically centred',
      );
    }
  });

  testWidgets('the whole segment is tappable, not just the text', (
    tester,
  ) async {
    var selected = 0;
    await tester.pumpWidget(
      host(selected: 0, onChanged: (index) => selected = index),
    );
    await tester.pumpAndSettle();

    final control = tester.getRect(find.byType(AppSegmentedControl));
    final past = tester.getRect(find.text('Past'));
    // Near the top edge of the Past half — above the label itself.
    await tester.tapAt(Offset(past.center.dx, control.top + 4));
    await tester.pumpAndSettle();

    expect(selected, 1);
  });
}
