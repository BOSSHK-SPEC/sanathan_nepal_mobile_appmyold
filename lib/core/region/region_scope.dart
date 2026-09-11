import 'package:flutter/widgets.dart';

import 'region.dart';

/// Makes the active [Region] available to the widget tree.
///
/// Provided once by the app root (from the persisted app preferences) so
/// widgets can call `context.region` / `context.regionConfig` without knowing
/// about the settings feature.
class RegionScope extends InheritedWidget {
  const RegionScope({required this.region, required super.child, super.key});

  final Region region;

  static Region of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<RegionScope>()?.region ??
      Region.nepal;

  /// Non-listening lookup (for callbacks).
  static Region read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<RegionScope>()?.region ??
      Region.nepal;

  @override
  bool updateShouldNotify(RegionScope oldWidget) => oldWidget.region != region;
}
