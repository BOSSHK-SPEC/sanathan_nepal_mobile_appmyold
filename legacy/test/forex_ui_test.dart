import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';
import 'package:sanathan_nepal_mobile_app/view/widgets/forExUi.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  testWidgets('ForexUI renders the fl_chart trend chart with two series',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(false),
        child: MaterialApp(home: ForexUI()),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    final chart = tester.widget<LineChart>(find.byType(LineChart));
    expect(chart.data.lineBarsData, hasLength(2));
    expect(find.text('Buying'), findsOneWidget);
    expect(find.text('Selling'), findsOneWidget);

    // Switching the view rebuilds the chart without errors.
    await tester.tap(find.byType(DropdownButton<ChartView>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Monthly').last);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(LineChart), findsOneWidget);
  });
}
