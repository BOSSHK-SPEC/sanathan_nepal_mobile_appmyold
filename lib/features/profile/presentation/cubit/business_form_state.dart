part of 'business_form_cubit.dart';

/// State of the multi-section business form.
@freezed
abstract class BusinessFormState with _$BusinessFormState {
  const factory BusinessFormState({
    /// Stored business the draft was seeded from (`failed` when the user has
    /// no business yet – the draft then starts blank).
    @Default(LoadState.idle()) LoadState<BusinessProfile> existing,

    /// Editable form value.
    @Default(BusinessProfile(id: '', name: '', category: ''))
    BusinessProfile draft,

    /// 0 = Business Details, 1 = Products / Services Details.
    @Default(0) int step,

    /// Submit request; `loaded` carries the persisted business.
    @Default(LoadState.idle()) LoadState<BusinessProfile> submission,
  }) = _BusinessFormState;

  const BusinessFormState._();

  /// True once [load] has settled and the draft can be edited.
  bool get isReady => existing.isLoaded || existing.isFailed;
}
