import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/calendar/calendar.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/traditional_date_picker.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

class _Outcome {
  DateTime? picked;
  bool closed = false;
}

/// Opens the picker on a deliberately small phone (360 wide) and returns what
/// it hands back once closed.
Future<_Outcome> _open(
  WidgetTester tester, {
  Region region = Region.india,
  Locale locale = const Locale('en'),
  DateTime? initial,
  DateTime? lastDate,
}) async {
  tester.view.physicalSize = const Size(360 * 3, 740 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final outcome = _Outcome();
  await tester.pumpWidget(
    RegionScope(
      region: region,
      child: MaterialApp(
        theme: AppTheme.light(),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () async {
                  outcome.picked = await TraditionalDatePicker.show(
                    context,
                    title: 'Date of Birth',
                    initial: initial,
                    lastDate: lastDate,
                  );
                  outcome.closed = true;
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return outcome;
}

Finder _field(int index) => find.byType(DropdownButtonFormField<int>).at(index);

Future<void> _choose(WidgetTester tester, int field, String label) async {
  await tester.tap(_field(field));
  await tester.pumpAndSettle();
  // The open menu is height-capped and builds its items lazily, so an option
  // further down the list only exists once it has been scrolled to — exactly
  // as a person would scroll to it.
  await tester.scrollUntilVisible(
    find.text(label).last,
    48,
    scrollable: find.byType(Scrollable).last,
  );
  // Let the scroll land before tapping: the tap position is read from the
  // last layout, and an option half-cut-off at the menu's edge is otherwise
  // tapped where it used to be — on the edge, missing it.
  await tester.pumpAndSettle();
  await tester.tap(find.text(label).last);
  await tester.pumpAndSettle();
}

/// Every option in the three boxes is laid out on one line at its natural
/// width — nothing squeezed, wrapped or cut. The old side-by-side layout gave
/// the year and day about 18 px, and their values did not show at all.
void _expectEveryValueShownInFull(WidgetTester tester) {
  final paragraphs = tester.renderObjectList<RenderParagraph>(
    find.descendant(
      of: find.byType(DropdownButtonFormField<int>),
      matching: find.byType(RichText),
    ),
  );
  expect(paragraphs, isNotEmpty);
  for (final paragraph in paragraphs) {
    final natural = TextPainter(
      text: paragraph.text,
      textDirection: TextDirection.ltr,
      textScaler: paragraph.textScaler,
    )..layout();
    final shown = paragraph.text.toPlainText();
    expect(
      paragraph.size.width,
      greaterThanOrEqualTo(natural.width - 0.5),
      reason: '"$shown" is squeezed',
    );
    expect(
      paragraph.size.height,
      lessThanOrEqualTo(natural.height + 0.5),
      reason: '"$shown" wrapped onto a second line',
    );
  }
}

void main() {
  final saka = RegionConfig.india.calendar;

  for (final (region, locale) in [
    (Region.india, const Locale('en')),
    (Region.india, const Locale('hi')),
    (Region.nepal, const Locale('en')),
    (Region.nepal, const Locale('ne')),
  ]) {
    testWidgets(
      'every picked value is shown in full — ${region.name}, ${locale.languageCode}',
      (tester) async {
        await _open(tester, region: region, locale: locale);
        expect(find.byType(DropdownButtonFormField<int>), findsNWidgets(3));
        _expectEveryValueShownInFull(tester);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('a day that stops existing moves to the last day, not an error', (
    tester,
  ) async {
    final months = saka.monthNames(languageCode: 'en');
    // Jyeshtha has 31 days; Ashwin, the first 30-day month, has 30.
    final outcome = await _open(
      tester,
      initial: saka.toGregorian(const TraditionalDate(1923, 3, 31)),
    );
    await _choose(tester, 1, months[6]);

    expect(tester.takeException(), isNull);
    expect(
      find.descendant(of: _field(2), matching: find.text('30')),
      findsWidgets,
    );
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(
      outcome.picked,
      saka.toGregorian(const TraditionalDate(1923, 7, 30)),
    );
  });

  testWidgets('nothing after the last date is offered', (tester) async {
    final months = saka.monthNames(languageCode: 'en');
    final last = saka.toGregorian(const TraditionalDate(1948, 6, 20));
    await _open(tester, initial: last, lastDate: last);

    // Months of the final year stop at Bhadrapada (6)...
    await tester.tap(_field(1));
    await tester.pumpAndSettle();
    expect(find.text(months[6]), findsNothing);
    await tester.tap(find.text(months[5]).last);
    await tester.pumpAndSettle();

    // ...and its days stop at the 20th.
    await tester.tap(_field(2));
    await tester.pumpAndSettle();
    expect(find.text('20'), findsWidgets);
    expect(find.text('21'), findsNothing);
  });

  testWidgets('hands back what was picked, previewed in both calendars', (
    tester,
  ) async {
    final outcome = await _open(
      tester,
      initial: saka.toGregorian(const TraditionalDate(1922, 8, 15)),
    );
    expect(find.text('Kartika 15, 1922'), findsOneWidget);
    expect(find.text('Monday, November 6, 2000'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(outcome.picked, DateTime(2000, 11, 6));
  });

  testWidgets('Cancel hands back nothing', (tester) async {
    final outcome = await _open(tester);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(outcome.closed, isTrue);
    expect(outcome.picked, isNull);
  });
}
