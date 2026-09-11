import 'package:flutter/material.dart';

import '../../data/datasources/marketplace_categories.dart';

/// Maps a category to a Material icon, with no bundled assets.
///
/// Two keys, because there are two sources of categories. The server
/// identifies them by ULID and ships a separate `iconName` (`lamp`, `bead`,
/// `book`); the bundled demo list identifies them by slug (`poojaSamagri`).
/// Matching on the id alone silently gave every live category the fallback
/// storefront icon, because no ULID will ever equal a slug.
abstract final class CategoryIcons {
  /// [iconName] is the server's key and wins when present; [categoryId] is
  /// the bundled slug, which is all the demo data has.
  static IconData forCategory(String categoryId, {String? iconName}) {
    final byName = iconName == null ? null : _byIconName(iconName);
    return byName ?? _bySlug(categoryId);
  }

  /// Every `iconName` the server's category migration uses must appear here
  /// (packages/db/prisma/migrations/*_marketplace_categories). A key missing
  /// from this switch does not fail — it quietly renders every such category
  /// with the same generic storefront icon, which is how half the list would
  /// have looked identical.
  static IconData? _byIconName(String iconName) => switch (iconName) {
    'lamp' || 'pooja' => Icons.local_florist_outlined,
    'bead' => Icons.blur_circular_rounded,
    'book' => Icons.menu_book_rounded,
    'gem' || 'gemstone' || 'diamond' => Icons.diamond_outlined,
    'cloth' || 'fashion' || 'shirt' => Icons.checkroom_rounded,
    // `home` predates real estate and has always meant the kitchen category;
    // real estate gets its own key rather than changing what `home` draws.
    'home' || 'kitchen' => Icons.kitchen_outlined,
    'realestate' => Icons.home_work_outlined,
    'service' => Icons.handshake_outlined,
    'phone' => Icons.smartphone_rounded,
    'car' => Icons.directions_car_outlined,
    'work' => Icons.work_outline_rounded,
    // An unknown key falls through to the slug rather than to the generic
    // icon, so a category the server adds tomorrow still gets a sensible one
    // if its slug happens to be known.
    _ => null,
  };

  static IconData _bySlug(String categoryId) => switch (categoryId) {
    MarketplaceCategories.jobs => Icons.work_outline_rounded,
    MarketplaceCategories.automobiles => Icons.directions_car_outlined,
    MarketplaceCategories.realEstate => Icons.home_work_outlined,
    MarketplaceCategories.mensFashion => Icons.checkroom_rounded,
    MarketplaceCategories.gemstones => Icons.diamond_outlined,
    MarketplaceCategories.electronics => Icons.smartphone_rounded,
    MarketplaceCategories.services => Icons.handshake_outlined,
    MarketplaceCategories.poojaSamagri => Icons.local_florist_outlined,
    MarketplaceCategories.homeKitchen => Icons.kitchen_outlined,
    _ => Icons.storefront_outlined,
  };
}
