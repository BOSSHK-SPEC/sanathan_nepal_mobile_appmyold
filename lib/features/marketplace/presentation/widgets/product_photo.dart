import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_image.dart';
import '../utils/category_icons.dart';

/// Renders a product image. Sources using the `category:<id>` scheme are
/// drawn as themed placeholders (gradient + category icon) so mock data never
/// depends on downloaded photos; anything else is delegated to [AppImage].
class ProductPhoto extends StatelessWidget {
  const ProductPhoto(
    this.source, {
    super.key,
    this.width,
    this.height,
    this.radius = 0,
    this.fit = BoxFit.cover,
    this.iconSize = 32,
  });

  final String source;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit fit;
  final double iconSize;

  static const String categoryScheme = 'category:';

  @override
  Widget build(BuildContext context) {
    if (source.isEmpty || source.startsWith(categoryScheme)) {
      final categoryId = source.replaceFirst(categoryScheme, '');
      final colors = context.colors;
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: colors.cardGradient,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: colors.divider),
        ),
        child: Center(
          child: Icon(
            CategoryIcons.forCategory(categoryId),
            size: iconSize,
            color: colors.primary,
          ),
        ),
      );
    }
    return AppImage(
      source,
      width: width,
      height: height,
      fit: fit,
      radius: radius,
    );
  }
}
