import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_flag.freezed.dart';

/// A server-side toggle.
///
/// [rolloutPct] is a percentage of users, evaluated server-side — the console
/// only reports and sets it. A flag that is `enabled` at 0% is off for
/// everyone, which is a normal way to stage a release.
@freezed
abstract class FeatureFlag with _$FeatureFlag {
  const factory FeatureFlag({
    required String key,
    @Default('') String description,
    @Default(false) bool enabled,

    /// Null means the flag applies to every region.
    String? region,
    @Default(0) int rolloutPct,
  }) = _FeatureFlag;
}
