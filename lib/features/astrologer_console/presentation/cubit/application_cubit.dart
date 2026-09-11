import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/session/app_role.dart';
import '../../../../core/session/role_granter.dart';
import '../../../../core/state/load_state.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../astrologers/domain/entities/specialty.dart';
import '../../domain/entities/application.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'application_cubit.freezed.dart';
part 'application_state.dart';

/// The five-step KYC wizard.
///
/// Every edit writes a draft, so an applicant who leaves halfway through —
/// which most do, because documents are on another device — comes back to
/// what they had rather than starting again.
class ApplicationCubit extends AppCubit<ApplicationState> {
  ApplicationCubit({
    required GetApplication getApplication,
    required SaveApplicationDraft saveDraft,
    required UploadKycDocument uploadDocument,
    required RemoveKycDocument removeDocument,
    required AcceptAstrologerTerms acceptTerms,
    required SubmitApplication submit,
    required RoleGranter roles,
  }) : _get = getApplication,
       _roles = roles,
       _saveDraft = saveDraft,
       _upload = uploadDocument,
       _removeDocument = removeDocument,
       _acceptTerms = acceptTerms,
       _submit = submit,
       super(const ApplicationState());

  final GetApplication _get;
  final SaveApplicationDraft _saveDraft;
  final UploadKycDocument _upload;
  final RemoveKycDocument _removeDocument;

  /// Reflects the server's decision on the local account, so route guards
  /// stop refusing an astrologer who has already been approved.
  final RoleGranter _roles;
  final AcceptAstrologerTerms _acceptTerms;
  final SubmitApplication _submit;

  /// Version stamped on acceptance, so a later change of terms is visible.
  static const String termsVersion = '2026-09-01';

  /// How often the status screen re-checks while a decision is pending.
  static const Duration pollInterval = Duration(seconds: 3);

  Timer? _poller;

  /// Long enough to swallow a burst of typing, short enough that leaving the
  /// screen straight after a keystroke still saves.
  static const Duration draftDebounce = Duration(milliseconds: 400);

  Timer? _draftDebounce;

  /// Bumped by every edit, so a response can tell whether the text it was
  /// saving is still the text on screen.
  int _editCounter = 0;

  Future<void> load() async {
    emit(state.copyWith(application: state.application.toLoading()));
    await _fetch();
  }

  Future<void> _fetch() async {
    final result = await _get();
    if (isClosed) return;
    emit(
      state.copyWith(
        application: result.fold(state.application.toFailed, LoadState.loaded),
      ),
    );
    await _syncRole();
  }

  /// Mirrors an approval onto the local account.
  ///
  /// The server grants the astrologer role when a reviewer approves, but the
  /// app authorizes its own routes from the stored profile — so without this
  /// an approved astrologer holds no `viewAstrologerConsole` permission, and
  /// every console route bounces them back to the application flow they have
  /// already finished.
  ///
  /// Runs on **every** read of an approved application, not only on the poll
  /// tick that first sees the decision. Approval usually lands while the app
  /// is closed, so the transition is never observed live; keying off the
  /// status itself is what makes a cold start work. [RoleGranter.grant] is
  /// idempotent, so repeating it costs a comparison.
  Future<void> _syncRole() async {
    if (state.form.status != ApplicationStatus.approved) return;
    await _roles.grant(AppRole.astrologer);
  }

  /// Grants the role and reports whether the console is reachable.
  ///
  /// The "Open console" button awaits this before navigating: the route guard
  /// reads the session synchronously, so navigating first and granting after
  /// is a race the user loses — they land back on the intro screen.
  Future<bool> claimConsoleAccess() async {
    if (state.form.status != ApplicationStatus.approved) return false;
    await _roles.grant(AppRole.astrologer);
    return true;
  }

  /// Polls while a decision is outstanding, and stops the moment one lands.
  ///
  /// Called by the status screen only: the wizard has nothing to wait for.
  void watchForDecision({required VoidCallback onApproved}) {
    _poller?.cancel();
    // An application that is already approved when the screen opens has no
    // transition left to observe, so the decision is acted on immediately
    // rather than waited for — otherwise the first three seconds of the
    // screen are a window in which "Open console" bounces.
    if (state.form.status == ApplicationStatus.approved) {
      onApproved();
      return;
    }
    _poller = Timer.periodic(pollInterval, (_) async {
      if (isClosed) return;
      await _fetch();
      final status = state.form.status;
      if (status == ApplicationStatus.approved) {
        _poller?.cancel();
        onApproved();
      } else if (status.isTerminal) {
        _poller?.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _poller?.cancel();
    return super.close();
  }

  void goToStep(int index) => emit(
    state.copyWith(stepIndex: index.clamp(0, KycStep.values.length - 1)),
  );

  void nextStep() => goToStep(state.stepIndex + 1);

  void previousStep() => goToStep(state.stepIndex - 1);

  // --- Field edits: each one persists a draft -------------------------

  void setName(String value) => _patch((a) => a.copyWith(fullName: value));

  void setPhone(String value) => _patch((a) => a.copyWith(phone: value));

  void setEmail(String value) => _patch((a) => a.copyWith(email: value));

  void setExperience(int years) =>
      _patch((a) => a.copyWith(experienceYears: years));

  void setBio(String value) => _patch((a) => a.copyWith(bio: value));

  void toggleSpecialty(Specialty specialty) => _patch((a) {
    final next = [...a.specialties];
    if (!next.remove(specialty)) next.add(specialty);
    return a.copyWith(specialties: next);
  });

  void toggleLanguage(String code) => _patch((a) {
    final next = [...a.languageCodes];
    if (!next.remove(code)) next.add(code);
    return a.copyWith(languageCodes: next);
  });

  void setRate(ConsultChannel channel, double? rate) => _patch((a) {
    final next = {...a.ratePerMinute};
    if (rate == null || rate <= 0) {
      next.remove(channel);
    } else {
      next[channel] = rate;
    }
    return a.copyWith(ratePerMinute: next);
  });

  void setIntroVideo(String? ref) =>
      _patch((a) => a.copyWith(introVideoRef: ref));

  /// Applies an edit locally, then persists it.
  ///
  /// Local state updates first so a field never lags the keystroke, and the
  /// save is debounced: the draft now goes to a server, and one request per
  /// character both floods it and races — a response carrying "R" can land
  /// after one carrying "Ram" and overwrite it, which is exactly what a draft
  /// containing a single letter looks like.
  void _patch(AstrologerApplication Function(AstrologerApplication) change) {
    final next = change(state.form);
    // Counted per edit, not per request: a keystroke made while a save is in
    // flight already makes that save's response stale, whether or not it has
    // been sent yet.
    final edit = ++_editCounter;
    emit(state.copyWith(application: LoadState.loaded(next)));

    _draftDebounce?.cancel();
    _draftDebounce = Timer(draftDebounce, () => _flushDraft(next, edit));
  }

  /// Persists [draft], ignoring a response that has been overtaken.
  Future<void> _flushDraft(AstrologerApplication draft, int edit) async {
    final result = await _saveDraft(draft);
    if (isClosed) return;

    // Someone kept typing while this was in flight. Their text is newer than
    // anything the server can tell us, so the response is dropped.
    if (edit != _editCounter) return;

    // A rejected draft used to be discarded here, so an applicant could fill
    // the whole wizard against a server that had stored none of it.
    result.fold(
      (failure) => emit(
        // The edit stays on screen as `previous` — losing what they just
        // typed because the save failed would be the worse error.
        state.copyWith(application: LoadState.failed(failure, previous: draft)),
      ),
      (saved) => emit(state.copyWith(application: LoadState.loaded(saved))),
    );
  }

  /// Writes any pending draft immediately.
  ///
  /// Called when a step is left, so nothing is lost to a debounce that had not
  /// fired yet.
  Future<void> saveNow() async {
    final pending = _draftDebounce;
    if (pending == null || !pending.isActive) return;
    pending.cancel();
    await _flushDraft(state.form, _editCounter);
  }

  /// Attaches an uploaded document to the application.
  ///
  /// A failure is surfaced rather than dropped. Swallowing it meant a rejected
  /// upload looked exactly like no upload at all: the file went to storage,
  /// the slot stayed empty, and the step could never be completed — with
  /// nothing on screen to explain why.
  Future<void> uploadDocument(KycDocumentKind kind, String fileRef) async {
    final result = await _upload(UploadKycParams(kind: kind, fileRef: fileRef));
    emit(
      state.copyWith(
        application: result.fold(state.application.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Discards an uploaded document.
  ///
  /// The server deletes the stored file and answers with the whole
  /// application, so the step's completeness follows from the same response
  /// that removed the file — there is no window where the field is empty but
  /// the step still counts itself done.
  ///
  /// A second call while one is in flight is dropped rather than queued: the
  /// only way to reach it is a double tap, and the second delete would fail
  /// on a document the first already removed.
  Future<void> removeDocument(KycDocumentKind kind) async {
    if (state.removingDocument != null) return;
    emit(state.copyWith(removingDocument: kind));

    final result = await _removeDocument(kind);
    emit(
      state.copyWith(
        removingDocument: null,
        application: result.fold(state.application.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> acceptTerms() async {
    final result = await _acceptTerms(termsVersion);
    // Accepting the terms is what completes the final step, so a silent
    // failure here leaves Submit disabled with the box visibly ticked.
    emit(
      state.copyWith(
        application: result.fold(state.application.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<bool> submit() async {
    // The last edit may still be waiting on the debounce; submitting without
    // it would send the server an application missing its newest field.
    await saveNow();

    emit(state.copyWith(submission: state.submission.toLoading()));
    final result = await _submit();
    return result.fold(
      (failure) {
        emit(state.copyWith(submission: state.submission.toFailed(failure)));
        return false;
      },
      (application) {
        emit(
          state.copyWith(
            submission: LoadState.loaded(application),
            application: LoadState.loaded(application),
          ),
        );
        return true;
      },
    );
  }
}
