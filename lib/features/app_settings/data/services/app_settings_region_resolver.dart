import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../presentation/cubit/app_settings_cubit.dart';

/// [RegionResolver] backed by the live [AppSettingsCubit] state so data
/// sources always see the region the user selected.
class AppSettingsRegionResolver implements RegionResolver {
  const AppSettingsRegionResolver(this._settings);
  final AppSettingsCubit _settings;

  @override
  Region get region => _settings.state.region;

  @override
  RegionConfig get config => region.config;
}
