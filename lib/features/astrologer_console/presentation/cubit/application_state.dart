part of 'application_cubit.dart';

@freezed
abstract class ApplicationState with _$ApplicationState {
  const ApplicationState._();

  const factory ApplicationState({
    @Default(LoadState.idle()) LoadState<AstrologerApplication> application,
    @Default(LoadState.idle()) LoadState<AstrologerApplication> submission,
    @Default(0) int stepIndex,

    /// The document being discarded, while that is in flight.
    ///
    /// Held per kind rather than as a bare flag so only the field being
    /// removed shows progress — a spinner over all five would read as the
    /// whole step reloading.
    KycDocumentKind? removingDocument,
  }) = _ApplicationState;

  AstrologerApplication get form =>
      application.dataOrNull ?? const AstrologerApplication();

  KycStep get step =>
      KycStep.values[stepIndex.clamp(0, KycStep.values.length - 1)];

  bool get isFirstStep => stepIndex == 0;

  bool get isLastStep => stepIndex == KycStep.values.length - 1;

  /// The next button is enabled only when the current step is satisfied —
  /// letting someone reach step five and then discover step two is broken
  /// is the classic way to lose an applicant.
  bool get canAdvance => form.isStepComplete(step);

  double get progress => form.completedSteps / KycStep.values.length;
}
