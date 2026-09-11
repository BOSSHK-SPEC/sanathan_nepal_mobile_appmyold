import 'region.dart';

/// Read-side access to the active region for the data/domain layers
/// (repositories, data sources) that have no BuildContext.
///
/// The app-settings feature provides the implementation and registers it in
/// GetIt; features depend only on this interface (DIP).
abstract interface class RegionResolver {
  Region get region;
  RegionConfig get config;
}

/// Fixed-region resolver for tests and previews.
class FixedRegionResolver implements RegionResolver {
  const FixedRegionResolver(this.region);
  @override
  final Region region;
  @override
  RegionConfig get config => region.config;
}
