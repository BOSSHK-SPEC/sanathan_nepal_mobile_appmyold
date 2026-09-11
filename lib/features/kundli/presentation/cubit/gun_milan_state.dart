part of 'gun_milan_cubit.dart';

@freezed
abstract class GunMilanState with _$GunMilanState {
  const GunMilanState._();

  const factory GunMilanState({
    @Default(LoadState.idle()) LoadState<List<BirthProfile>> profiles,
    @Default(LoadState.idle()) LoadState<GunMilanResult> result,
    String? brideId,
    String? groomId,
  }) = _GunMilanState;

  List<BirthProfile> get charts => profiles.dataOrNull ?? const [];

  BirthProfile? get bride => _find(brideId);

  BirthProfile? get groom => _find(groomId);

  BirthProfile? _find(String? id) {
    if (id == null) return null;
    for (final p in charts) {
      if (p.id == id) return p;
    }
    return null;
  }

  bool get canMatch => brideId != null && groomId != null && brideId != groomId;

  GunMilanResult? get score => result.dataOrNull;

  /// Two saved charts are the minimum; below that the screen explains why
  /// rather than showing two empty pickers.
  bool get hasEnoughCharts => charts.length >= 2;
}
