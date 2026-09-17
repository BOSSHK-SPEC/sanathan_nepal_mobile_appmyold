import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/widgets/business_branding_picker.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/widgets/business_header.dart';
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

const _business = BusinessProfile(
  id: 'b1',
  name: 'Pashupati Puja Store',
  category: 'Puja items',
);

/// The banner and logo could be shown but never set: the header's camera
/// opened a form with no picture fields at all.
void main() {
  group('business header', () {
    testWidgets('the owner gets a camera on the banner and on the logo', (
      tester,
    ) async {
      final changed = <String>[];
      await tester.pumpWidget(
        _host(
          BusinessHeader(
            business: _business,
            isFollowing: false,
            onFollow: () {},
            onMessage: () {},
            onEdit: () {},
            onChangeCover: () => changed.add('cover'),
            onChangeLogo: () => changed.add('logo'),
          ),
        ),
      );

      expect(find.byIcon(Icons.photo_camera_outlined), findsNWidgets(2));
      await tester.tap(find.bySemanticsLabel('Change logo'));
      await tester.tap(find.bySemanticsLabel('Change banner'));
      expect(changed, ['logo', 'cover']);
    });

    testWidgets('a visitor gets neither', (tester) async {
      await tester.pumpWidget(
        _host(
          BusinessHeader(
            business: _business,
            isFollowing: false,
            onFollow: () {},
            onMessage: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.photo_camera_outlined), findsNothing);
    });
  });

  group('business form picker', () {
    testWidgets(
      'offers both pictures, and nothing to remove until one is set',
      (tester) async {
        final picked = <BusinessImageSlot>[];
        await tester.pumpWidget(
          _host(
            BusinessBrandingPicker(
              logoUrl: null,
              coverUrl: null,
              onPick: picked.add,
              onRemove: (_) {},
            ),
          ),
        );

        expect(find.text('Add logo'), findsOneWidget);
        expect(find.text('Add banner'), findsOneWidget);
        expect(find.text('Remove logo'), findsNothing);
        expect(find.text('Remove banner'), findsNothing);

        await tester.tap(find.text('Add banner'));
        await tester.tap(find.text('Add logo'));
        expect(picked, [BusinessImageSlot.cover, BusinessImageSlot.logo]);
      },
    );
  });
}
