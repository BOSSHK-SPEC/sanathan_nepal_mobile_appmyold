import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/order_summary.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/widgets/order_card.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

Widget _host(Widget child) => RegionScope(
  region: Region.nepal,
  child: MaterialApp(
    theme: AppTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: SingleChildScrollView(child: child)),
  ),
);

OrderSummary _order({
  required OrderRole role,
  String? businessId,
  String phone = '',
}) => OrderSummary(
  id: 'ord-1',
  productName: 'mouse',
  price: 300,
  counterpartyName: 'Uttam Astro & Gems',
  counterpartyId: 'seller-user-1',
  counterpartyBusinessId: businessId,
  counterpartyPhone: phone,
  role: role,
  status: OrderStatus.placed,
  updatedAt: DateTime(2026, 9, 20, 10),
);

/// Call and Chat were drawn on every order card and wired to `() {}` — two
/// buttons that looked alive and did nothing at all when tapped.
void main() {
  group('order card contact buttons', () {
    testWidgets('a purchase from a shop can call it and message it', (
      tester,
    ) async {
      var chats = 0;
      var calls = 0;
      await tester.pumpWidget(
        _host(
          OrderCard(
            order: _order(
              role: OrderRole.buyer,
              businessId: 'biz-1',
              phone: '+977-9841234567',
            ),
            onChat: () => chats++,
            onCall: () => calls++,
          ),
        ),
      );

      await tester.tap(find.text('Chat'));
      await tester.tap(find.text('Call'));
      expect(chats, 1);
      expect(calls, 1);
    });

    testWidgets('a sale offers Call but no Chat: the seller owns the shop', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          OrderCard(
            // No business to write to — a thread is keyed on
            // (business, customer) and the server refuses an owner messaging
            // their own shop.
            order: _order(role: OrderRole.seller, phone: '+977-9812345678'),
            onChat: () {},
            onCall: () {},
          ),
        ),
      );

      expect(find.text('Call'), findsOneWidget);
      expect(find.text('Chat'), findsNothing);
    });

    testWidgets('a seller who published no number gets neither button', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          OrderCard(
            order: _order(role: OrderRole.buyer),
            onChat: () {},
            onCall: () {},
          ),
        ),
      );

      expect(find.text('Call'), findsNothing);
      expect(find.text('Chat'), findsNothing);
    });
  });
}
