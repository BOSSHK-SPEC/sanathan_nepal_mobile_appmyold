import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_status.freezed.dart';

/// Whether the app may run at all right now.
///
/// Lives in core because it gates the whole tree, not one feature: a forced
/// upgrade or a maintenance window has to be able to stop everything,
/// including screens that have no idea it exists.
enum AppAvailability {
  /// Normal operation.
  available,

  /// A newer build is available and worth mentioning, but not required.
  updateAvailable,

  /// This build is below the minimum supported version and must not run.
  updateRequired,

  /// Planned downtime.
  maintenance,
}

@freezed
abstract class AppStatus with _$AppStatus {
  const AppStatus._();

  const factory AppStatus({
    @Default(AppAvailability.available) AppAvailability availability,

    /// Current build, e.g. "1.4.2".
    @Default('') String currentVersion,
    @Default('') String latestVersion,

    /// Store URL for the upgrade action.
    String? storeUrl,

    /// Shown during maintenance; the honest version of "try again later".
    String? message,
    DateTime? expectedBackAt,
  }) = _AppStatus;

  /// Blocks the whole app, as opposed to merely suggesting something.
  bool get isBlocking =>
      availability == AppAvailability.updateRequired ||
      availability == AppAvailability.maintenance;

  bool get canDismiss => availability == AppAvailability.updateAvailable;
}

/// Supplies [AppStatus]. Backed by remote config in production; a fixed
/// implementation keeps the app running until that exists.
abstract interface class AppStatusSource {
  Future<AppStatus> check();
}

/// Always-available status, so nothing is gated until a real source exists.
class AlwaysAvailableStatusSource implements AppStatusSource {
  const AlwaysAvailableStatusSource({this.version = '1.0.0'});

  final String version;

  @override
  Future<AppStatus> check() async =>
      AppStatus(currentVersion: version, latestVersion: version);
}
