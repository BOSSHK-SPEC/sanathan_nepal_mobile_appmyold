import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/business_profile.dart';
import '../../domain/usecases/get_business_profile.dart';
import '../../domain/usecases/get_my_business.dart';
import '../../domain/usecases/upsert_business_profile.dart';
import '../../../../core/state/app_cubit.dart';

part 'business_form_cubit.freezed.dart';
part 'business_form_state.dart';

/// Holds the business-form draft, its items and the submit action.
class BusinessFormCubit extends AppCubit<BusinessFormState> {
  BusinessFormCubit({
    required GetBusinessProfile getBusiness,
    required GetMyBusiness getMyBusiness,
    required UpsertBusinessProfile upsertBusiness,
    required String businessId,
  }) : _getBusiness = getBusiness,
       _getMyBusiness = getMyBusiness,
       _upsert = upsertBusiness,
       _businessId = businessId,
       super(const BusinessFormState());

  final GetBusinessProfile _getBusiness;
  final GetMyBusiness _getMyBusiness;
  final UpsertBusinessProfile _upsert;
  final String _businessId;

  /// Loads an existing business into the draft (or starts blank).
  Future<void> load() async {
    emit(state.copyWith(existing: state.existing.toLoading()));
    // An empty id means "whatever business I own" — the form is opened from
    // the owner screen, which has no id until one exists.
    final result = _businessId.isEmpty
        ? await _getMyBusiness()
        : await _getBusiness(_businessId);
    emit(
      result.fold(
        (f) => state.copyWith(
          existing: state.existing.toFailed(f),
          draft: BusinessProfile(id: _businessId, name: '', category: ''),
        ),
        (b) => state.copyWith(existing: LoadState.loaded(b), draft: b),
      ),
    );
  }

  void updateDraft(BusinessProfile draft) => emit(state.copyWith(draft: draft));

  void goToStep(int step) => emit(state.copyWith(step: step));

  void addItem(BusinessItem item) => emit(
    state.copyWith(
      draft: state.draft.copyWith(items: [...state.draft.items, item]),
    ),
  );

  void removeItem(String id) => emit(
    state.copyWith(
      draft: state.draft.copyWith(
        items: state.draft.items.where((i) => i.id != id).toList(),
      ),
    ),
  );

  void addDocument(String name) => emit(
    state.copyWith(
      draft: state.draft.copyWith(documents: [...state.draft.documents, name]),
    ),
  );

  /// Persists the draft. Every submission (new or edited listing) goes back
  /// to `pending` moderation and clears a previous admin note.
  Future<void> submit() async {
    emit(state.copyWith(submission: state.submission.toLoading()));
    final result = await _upsert(
      state.draft.copyWith(status: BusinessStatus.pending, moderationNote: ''),
    );
    emit(
      result.fold(
        (f) => state.copyWith(submission: state.submission.toFailed(f)),
        (b) => state.copyWith(draft: b, submission: LoadState.loaded(b)),
      ),
    );
  }
}
