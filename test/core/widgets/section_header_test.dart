import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_spacing.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/section_header.dart';

const _width = 390.0;

Widget _app(Widget child) => MaterialApp(
  theme: AppTheme.light(),
  home: Scaffold(
    body: SizedBox(width: _width, child: child),
  ),
);

/// Right edge of the header's content box – the gutter is padding, so the
/// trailing is "at the end of the row" when it reaches this.
const _contentRight = _width - AppSpacing.pageGutter;

void main() {
  group('SectionHeader trailing', () {
    testWidgets('a see-all button sits at the end of the row', (tester) async {
      await tester.binding.setSurfaceSize(const Size(_width, 400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _app(
          SectionHeader(
            title: 'Horoscope',
            trailing: TextButton(
              onPressed: () {},
              child: const Text('See all'),
            ),
          ),
        ),
      );

      final button = tester.getRect(find.byType(TextButton));
      expect(button.right, moreOrLessEquals(_contentRight, epsilon: 0.5));
      // Not floating mid-row behind the short title.
      expect(button.left, greaterThan(_width / 2));
    });

    testWidgets('the accent rule sits at the end of the row', (tester) async {
      await tester.binding.setSurfaceSize(const Size(_width, 400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_app(const SectionHeader(title: 'Suva Sait')));

      final rule = tester.getRect(
        find.descendant(
          of: find.byType(SectionHeader),
          matching: find.byType(Container),
        ),
      );
      expect(rule.right, moreOrLessEquals(_contentRight, epsilon: 0.5));
    });

    testWidgets('a chevron sits at the end of the row', (tester) async {
      await tester.binding.setSurfaceSize(const Size(_width, 400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _app(
          SectionHeader(
            title: 'Panchanga',
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right),
              visualDensity: VisualDensity.compact,
            ),
          ),
        ),
      );

      final icon = tester.getRect(find.byType(IconButton));
      expect(icon.right, moreOrLessEquals(_contentRight, epsilon: 0.5));
    });

    testWidgets('a long title truncates instead of hiding the trailing', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(_width, 400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _app(
          SectionHeader(
            title: 'A section title far too long to fit beside its button',
            trailing: TextButton(
              onPressed: () {},
              child: const Text('See all'),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      final button = tester.getRect(find.byType(TextButton));
      expect(button.right, moreOrLessEquals(_contentRight, epsilon: 0.5));
      expect(button.width, greaterThan(0));
    });

    testWidgets('onTap makes the whole row tappable', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _app(SectionHeader(title: 'Latest news', onTap: () => taps++)),
      );

      await tester.tap(find.text('Latest news'));
      expect(taps, 1);
    });
  });
}
