import 'app_environment.dart';

/// Chooses between a feature's mock and its live implementation.
///
/// Every feature's `register<Feature>Feature` uses this for its data sources,
/// so the mock/live decision reads identically everywhere and there is exactly
/// one condition to change. Both branches are closures: the unused one is
/// never constructed, so a mock never loads its seed data in a live build.
///
/// [AppEnvironment.useMockData] is always false in a production build, so
/// mocks cannot ship.
T selectDataSource<T>({
  required T Function() mock,
  required T Function() live,
}) => AppEnvironment.useMockData ? mock() : live();
