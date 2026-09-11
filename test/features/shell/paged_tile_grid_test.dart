import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/shell/presentation/widgets/paged_tile_grid.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.dark(),
    home: Scaffold(body: Center(child: child)),
  );

  testWidgets('shows 8 tiles per page (2 rows × 4) and paginates the rest', (
    tester,
  ) async {
    final items = List.generate(13, (i) => 'tile$i');
    await tester.pumpWidget(
      wrap(
        PagedTileGrid<String>(
          items: items,
          tileBuilder: (_, item) => Text(item),
        ),
      ),
    );

    // Page 1 visible.
    expect(find.text('tile0'), findsOneWidget);
    expect(find.text('tile7'), findsOneWidget);
    expect(find.text('tile8'), findsNothing);
    expect(find.byType(PagePillIndicator), findsOneWidget);
    expect(find.bySemanticsLabel('Page 1 of 2'), findsOneWidget);

    // Swipe to page 2.
    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.text('tile8'), findsOneWidget);
    expect(find.text('tile12'), findsOneWidget);
    expect(find.text('tile0'), findsNothing);
    expect(find.bySemanticsLabel('Page 2 of 2'), findsOneWidget);
  });

  testWidgets('single page hides the indicator', (tester) async {
    await tester.pumpWidget(
      wrap(
        PagedTileGrid<int>(
          items: const [1, 2, 3],
          tileBuilder: (_, i) => Text('$i'),
        ),
      ),
    );
    expect(find.byType(PagePillIndicator), findsNothing);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('tapping a pill jumps to that page', (tester) async {
    await tester.pumpWidget(
      wrap(
        PagedTileGrid<int>(
          items: List.generate(16, (i) => i),
          tileBuilder: (_, i) => Text('t$i'),
        ),
      ),
    );
    final pills = find.descendant(
      of: find.byType(PagePillIndicator),
      matching: find.byType(GestureDetector),
    );
    expect(pills, findsNWidgets(2));
    await tester.tap(pills.last);
    await tester.pumpAndSettle();
    expect(find.text('t15'), findsOneWidget);
  });
}
