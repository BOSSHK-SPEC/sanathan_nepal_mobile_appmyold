import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/utils/category_icons.dart';

/// Live categories are identified by a ULID, so the only thing that picks
/// their icon is the server's `iconName`. A key this app does not know does
/// not fail — it silently draws the generic storefront icon — so an
/// unmapped name is invisible until someone notices half the category grid
/// looks the same.
void main() {
  // A ULID never matches a bundled slug, exactly as in production.
  const liveId = '01M27YHS80T00AS1A80RAS72H5';
  const fallback = Icons.storefront_outlined;

  test('every iconName the categories migration uses has its own icon', () {
    // Mirrors packages/db/prisma/migrations/*_marketplace_categories.
    const serverIconNames = {
      'pooja': Icons.local_florist_outlined,
      'bead': Icons.blur_circular_rounded,
      'gem': Icons.diamond_outlined,
      'book': Icons.menu_book_rounded,
      'service': Icons.handshake_outlined,
      'kitchen': Icons.kitchen_outlined,
      'fashion': Icons.checkroom_rounded,
      'phone': Icons.smartphone_rounded,
      'car': Icons.directions_car_outlined,
      'realestate': Icons.home_work_outlined,
      'work': Icons.work_outline_rounded,
    };

    for (final entry in serverIconNames.entries) {
      expect(
        CategoryIcons.forCategory(liveId, iconName: entry.key),
        entry.value,
        reason: '"${entry.key}" must not fall back to the storefront icon',
      );
    }
  });

  test('keys already in use keep drawing what they drew before', () {
    // `home` has always meant the kitchen category. Real estate got its own
    // key instead of changing this one under existing data.
    expect(
      CategoryIcons.forCategory(liveId, iconName: 'home'),
      Icons.kitchen_outlined,
    );
    expect(
      CategoryIcons.forCategory(liveId, iconName: 'lamp'),
      Icons.local_florist_outlined,
    );
    expect(
      CategoryIcons.forCategory(liveId, iconName: 'cloth'),
      Icons.checkroom_rounded,
    );
  });

  test('an unknown key falls back rather than crashing', () {
    expect(
      CategoryIcons.forCategory(liveId, iconName: 'something-new'),
      fallback,
    );
    expect(CategoryIcons.forCategory(liveId), fallback);
  });
}
