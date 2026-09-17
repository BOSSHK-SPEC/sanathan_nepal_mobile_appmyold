part of 'flags_cubit.dart';

@freezed
abstract class FlagsState with _$FlagsState {
  const FlagsState._();

  const factory FlagsState({
    @Default(LoadState<List<FeatureFlag>>.idle())
    LoadState<List<FeatureFlag>> flags,
    String? savingKey,
    String? actionError,
  }) = _FlagsState;

  List<FeatureFlag> get items => flags.dataOrNull ?? const [];

  bool isSaving(String key) => savingKey == key;

  /// Flags that are on but not fully rolled out — the ones mid-release, and
  /// the ones most likely to explain a report of "it works for me".
  List<FeatureFlag> get partiallyRolledOut => [
    for (final f in items)
      if (f.enabled && f.rolloutPct < 100) f,
  ];
}
