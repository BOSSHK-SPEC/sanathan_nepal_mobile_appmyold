import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/section_chevron_button.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

Widget _app(Widget child, {Locale locale = const Locale('en')}) => MaterialApp(
  theme: AppTheme.light(),
  locale: locale,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('SectionChevronButton', () {
    testWidgets('is a > that calls onPressed', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _app(SectionChevronButton(onPressed: () => taps++)),
      );

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      await tester.tap(find.byType(SectionChevronButton));
      expect(taps, 1);
    });

    testWidgets('announces the localised "See All" by default', (
      tester,
    ) async {
      await tester.pumpWidget(_app(SectionChevronButton(onPressed: () {})));
      expect(find.byTooltip('See All'), findsOneWidget);

      await tester.pumpWidget(
        _app(
          SectionChevronButton(onPressed: () {}),
          locale: const Locale('hi'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byTooltip('सभी देखें'), findsOneWidget);
    });

    testWidgets('takes a section-specific tooltip', (tester) async {
      await tester.pumpWidget(
        _app(SectionChevronButton(onPressed: () {}, tooltip: 'All events')),
      );
      expect(find.byTooltip('All events'), findsOneWidget);
    });

    testWidgets('keeps a tap target of at least 40 dp', (tester) async {
      await tester.pumpWidget(_app(SectionChevronButton(onPressed: () {})));
      final size = tester.getSize(find.byType(IconButton));
      expect(size.width, greaterThanOrEqualTo(40));
      expect(size.height, greaterThanOrEqualTo(40));
    });
  });
}
