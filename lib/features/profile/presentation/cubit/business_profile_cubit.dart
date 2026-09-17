import '../../domain/usecases/get_my_business.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/session/app_role.dart';
import '../../../../core/session/role_granter.dart';
import '../../../../core/session/session_refresher.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/business_profile.dart';
import '../../domain/repositories/business_repository.dart';
import '../../domain/usecases/get_business_profile.dart';
import '../../domain/usecases/set_business_status.dart';
import '../../domain/usecases/upsert_business_profile.dart';
import '../../../../core/state/app_cubit.dart';

part 'business_profile_cubit.freezed.dart';
part 'business_profile_state.dart';

/// Loads a business profile, applies admin approve/reject actions and lets
/// the owner add / remove products & services in place.
class BusinessProfileCubit extends AppCubit<BusinessProfileState> {
  BusinessProfileCubit({
    required GetBusinessProfile getBusiness,
    required GetMyBusiness getMyBusiness,
    required SetBusinessStatus setStatus,
    required UpsertBusinessProfile upsertBusiness,
    required BusinessRepository repository,
    required RoleGranter roles,
    required SessionRefresher sessionRefresher,
  }) : _getBusiness = getBusiness,
       _getMyBusiness = getMyBusiness,
       _setStatus = setStatus,
       _upsert = upsertBusiness,
       _repository = repository,
       _roles = roles,
       _sessionRefresher = sessionRefresher,
       super(const BusinessProfileState());

  final GetBusinessProfile _getBusiness;
  final GetMyBusiness _getMyBusiness;
  final SetBusinessStatus _setStatus;
  final UpsertBusinessProfile _upsert;
  final BusinessRepository _repository;
  final RoleGranter _roles;
  final SessionRefresher _sessionRefresher;

  /// Loads the signed-in user's own business.
  ///
  /// The owner screen must ask by identity: it has no id to load with until
  /// the business exists, and inventing one reports a registered business as
  /// missing.
  Future<void> loadMine() async {
    emit(state.copyWith(business: state.business.toLoading()));
    final result = await _getMyBusiness();
    emit(
      state.copyWith(
        business: result.fold(state.business.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Reflects an approved business as the `merchant` role on this device.
  ///
  /// The server grants the role when a reviewer approves the business, but the
  /// app reads its permissions from the cached profile — so until something
  /// refreshes that, an approved seller still has no `manageProducts` and the
  /// Products tab tells them they are "under review". This is the same claim
  /// the astrologer flow makes after its application is approved
  /// (`ApplicationCubit.claimConsoleAccess`).
  ///
  /// Returns true when the role was newly claimed, so the caller knows whether
  /// reloading the session is worth it. Safe to call repeatedly: it is a no-op
  /// unless the loaded business is approved.
  Future<bool> claimSellerAccess() async {
    final business = state.business.dataOrNull;
    if (business == null || business.status != BusinessStatus.approved) {
      return false;
    }
    await _roles.grant(AppRole.merchant);
    // Granting writes the role to the cached profile; the session is what the
    // UI actually reads, so it has to be re-derived or nothing on screen
    // changes until the next cold start.
    await _sessionRefresher.refresh();
    return true;
  }

  Future<void> load(String id) async {
    emit(state.copyWith(business: state.business.toLoading()));
    final result = await _getBusiness(id);
    emit(
      state.copyWith(
        business: result.fold(state.business.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Re-fetches the current listing (after the owner edited it in the form).
  Future<void> refresh() async {
    final id = state.business.dataOrNull?.id;
    if (id != null) await load(id);
  }

  /// Owner action: changes or removes ([url] null) the logo or banner.
  ///
  /// Returns the failure, or null on success, so the page can say which. The
  /// listing is replaced with the server's answer rather than patched locally,
  /// so what is on screen is what was actually saved.
  Future<Failure?> setImage(BusinessImageSlot slot, String? url) async {
    final result = await _repository.setBusinessImage(slot, url);
    return result.fold((failure) => failure, (business) {
      emit(state.copyWith(business: LoadState.loaded(business)));
      return null;
    });
  }

  Future<void> approve() => _moderate(BusinessStatus.approved);

  /// Rejects the listing with an optional [reason] shown to the owner.
  Future<void> reject({String reason = ''}) =>
      _moderate(BusinessStatus.rejected, note: reason);

  void toggleFollow() => emit(state.copyWith(isFollowing: !state.isFollowing));

  /// Owner action: appends a product/service and persists the listing.
  Future<void> addItem(BusinessItem item) async {
    final b = state.business.dataOrNull;
    if (b == null) return;
    await _save(b.copyWith(items: [...b.items, item]));
  }

  /// Owner action: updates an existing product/service and persists the listing.
  Future<void> updateItem(BusinessItem item) async {
    final b = state.business.dataOrNull;
    if (b == null) return;
    final updatedItems = b.items
        .map((i) => i.id == item.id ? item : i)
        .toList();
    await _save(b.copyWith(items: updatedItems));
  }

  /// Owner action: removes a product/service and persists the listing.
  Future<void> removeItem(String itemId) async {
    final b = state.business.dataOrNull;
    if (b == null) return;
    await _save(
      b.copyWith(items: b.items.where((i) => i.id != itemId).toList()),
    );
  }

  /// Submits a customer review for this business profile.
  Future<void> addReview(int rating, String text) async {
    final b = state.business.dataOrNull;
    if (b == null) return;
    final result = await _repository.addReview(b.id, rating, text);
    emit(
      state.copyWith(
        business: result.fold(state.business.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> _save(BusinessProfile business) async {
    final result = await _upsert(business);
    emit(
      state.copyWith(
        business: result.fold(state.business.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> _moderate(BusinessStatus status, {String note = ''}) async {
    final id = state.business.dataOrNull?.id;
    if (id == null) return;
    final result = await _setStatus(
      SetBusinessStatusParams(id: id, status: status, note: note),
    );
    emit(
      state.copyWith(
        business: result.fold(state.business.toFailed, LoadState.loaded),
      ),
    );
  }
}
