part of 'legal_cubit.dart';

/// UI state of a legal document page.
@freezed
abstract class LegalState with _$LegalState {
  const factory LegalState({
    @Default(LoadState.idle()) LoadState<LegalDocument> document,
  }) = _LegalState;
}
