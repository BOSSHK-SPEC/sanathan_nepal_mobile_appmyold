import 'dart:async';
import 'dart:convert';

import '../../../../core/storage/key_value_store.dart';
import '../models/user_profile_draft_model.dart';

/// Stores onboarding progress in [KeyValueStore].
abstract interface class OnboardingProgressLocalDataSource {
  String? readStep();
  Future<void> writeStep(String step);
  UserProfileDraftModel? readDraft();
  Future<void> writeDraft(UserProfileDraftModel draft);
  Future<void> clearDraft();
  Future<void> clear();
}

class OnboardingProgressLocalDataSourceImpl
    implements OnboardingProgressLocalDataSource {
  OnboardingProgressLocalDataSourceImpl(this._store);

  final KeyValueStore _store;

  static const String kStep = 'onboarding.step';
  static const String kDetailsDraft = 'onboarding.details_draft';

  @override
  String? readStep() => _store.getString(kStep);

  @override
  Future<void> writeStep(String step) => _store.setString(kStep, step);

  /// A draft that no longer decodes — written by an older build, or damaged —
  /// is dropped rather than thrown: it is read on the way into the details
  /// form, and a stale half-typed name is not worth a crash at that moment.
  @override
  UserProfileDraftModel? readDraft() {
    final raw = _store.getString(kDetailsDraft);
    if (raw == null) return null;
    try {
      return UserProfileDraftModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } on Object {
      unawaited(_store.remove(kDetailsDraft));
      return null;
    }
  }

  @override
  Future<void> writeDraft(UserProfileDraftModel draft) =>
      _store.setString(kDetailsDraft, jsonEncode(draft.toJson()));

  @override
  Future<void> clearDraft() => _store.remove(kDetailsDraft);

  @override
  Future<void> clear() async {
    await Future.wait([_store.remove(kStep), _store.remove(kDetailsDraft)]);
  }
}
