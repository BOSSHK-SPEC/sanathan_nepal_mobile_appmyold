import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/account_entities.dart';
import '../../domain/usecases/account_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'account_cubits.freezed.dart';
part 'account_states.dart';

/// Saved delivery addresses.
class AddressesCubit extends AppCubit<AddressesState> {
  AddressesCubit({
    required GetAddresses getAddresses,
    required SaveAddress saveAddress,
    required DeleteAddress deleteAddress,
    required SetDefaultAddress setDefault,
  }) : _get = getAddresses,
       _save = saveAddress,
       _delete = deleteAddress,
       _setDefault = setDefault,
       super(const AddressesState());

  final GetAddresses _get;
  final SaveAddress _save;
  final DeleteAddress _delete;
  final SetDefaultAddress _setDefault;

  Future<void> load() async {
    emit(state.copyWith(addresses: state.addresses.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        addresses: result.fold(state.addresses.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<bool> save(SavedAddress address) async {
    emit(state.copyWith(saving: state.saving.toLoading(), saveError: null));
    final result = await _save(address);
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            saving: state.saving.toFailed(failure),
            saveError: failure.message,
          ),
        );
        return false;
      },
      (saved) async {
        emit(state.copyWith(saving: LoadState.loaded(saved)));
        await load();
        return true;
      },
    );
  }

  Future<void> delete(String addressId) async {
    await _delete(addressId);
    await load();
  }

  Future<void> makeDefault(String addressId) async {
    await _setDefault(addressId);
    await load();
  }
}

/// Security settings and signed-in devices.
class SecurityCubit extends AppCubit<SecurityState> {
  SecurityCubit({
    required GetSecuritySettings getSettings,
    required UpdateSecuritySettings updateSettings,
    required GetDevices getDevices,
    required RevokeDevice revokeDevice,
    required RevokeAllOtherDevices revokeAll,
  }) : _get = getSettings,
       _update = updateSettings,
       _getDevices = getDevices,
       _revoke = revokeDevice,
       _revokeAll = revokeAll,
       super(const SecurityState());

  final GetSecuritySettings _get;
  final UpdateSecuritySettings _update;
  final GetDevices _getDevices;
  final RevokeDevice _revoke;
  final RevokeAllOtherDevices _revokeAll;

  Future<void> load() async {
    emit(
      state.copyWith(
        settings: state.settings.toLoading(),
        devices: state.devices.toLoading(),
      ),
    );
    final settingsFuture = _get();
    final devicesFuture = _getDevices();
    final settings = await settingsFuture;
    final devices = await devicesFuture;
    emit(
      state.copyWith(
        settings: settings.fold(state.settings.toFailed, LoadState.loaded),
        devices: devices.fold(state.devices.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> setTwoFactor({required bool enabled}) =>
      _patch(state.current.copyWith(twoFactorEnabled: enabled));

  Future<void> setLoginAlerts({required bool enabled}) =>
      _patch(state.current.copyWith(loginAlertsEnabled: enabled));

  Future<void> _patch(SecuritySettings next) async {
    emit(state.copyWith(settings: LoadState.loaded(next)));
    await _update(next);
  }

  Future<String?> revoke(String deviceId) async {
    final result = await _revoke(deviceId);
    return result.fold((failure) => failure.message, (_) async {
      await load();
      return null;
    });
  }

  Future<void> revokeAllOthers() async {
    await _revokeAll();
    await load();
  }
}

/// Data export and deletion requests.
class PrivacyCubit extends AppCubit<PrivacyState> {
  PrivacyCubit({
    required GetDataRequests getRequests,
    required RequestData requestData,
  }) : _get = getRequests,
       _request = requestData,
       super(const PrivacyState());

  final GetDataRequests _get;
  final RequestData _request;

  Future<void> load() async {
    emit(state.copyWith(requests: state.requests.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        requests: result.fold(state.requests.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<String?> request(DataRequestKind kind) async {
    emit(state.copyWith(submitting: state.submitting.toLoading()));
    final result = await _request(kind);
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: state.submitting.toFailed(failure)));
        return failure.message;
      },
      (request) async {
        emit(state.copyWith(submitting: LoadState.loaded(request)));
        await load();
        return null;
      },
    );
  }
}

/// Support tickets and their threads.
class SupportTicketsCubit extends AppCubit<SupportTicketsState> {
  SupportTicketsCubit({
    required GetTickets getTickets,
    required CreateTicket createTicket,
    required ReplyToTicket replyToTicket,
  }) : _get = getTickets,
       _create = createTicket,
       _reply = replyToTicket,
       super(const SupportTicketsState());

  final GetTickets _get;
  final CreateTicket _create;
  final ReplyToTicket _reply;

  Future<void> load() async {
    emit(state.copyWith(tickets: state.tickets.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        tickets: result.fold(state.tickets.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<SupportTicket?> create({
    required String subject,
    required TicketTopic topic,
    required String body,
  }) async {
    emit(state.copyWith(submitting: state.submitting.toLoading()));
    final result = await _create(
      CreateTicketParams(subject: subject, topic: topic, body: body),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: state.submitting.toFailed(failure)));
        return null;
      },
      (ticket) async {
        emit(state.copyWith(submitting: LoadState.loaded(ticket)));
        await load();
        return ticket;
      },
    );
  }

  Future<bool> reply(String ticketId, String body) async {
    emit(state.copyWith(submitting: state.submitting.toLoading()));
    final result = await _reply(
      ReplyToTicketParams(ticketId: ticketId, body: body),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: state.submitting.toFailed(failure)));
        return false;
      },
      (ticket) async {
        emit(state.copyWith(submitting: LoadState.loaded(ticket)));
        await load();
        return true;
      },
    );
  }
}

/// Offers and the referral programme.
class OffersCubit extends AppCubit<OffersState> {
  OffersCubit({required GetOffers getOffers, required GetReferral getReferral})
    : _getOffers = getOffers,
      _getReferral = getReferral,
      super(const OffersState());

  final GetOffers _getOffers;
  final GetReferral _getReferral;

  Future<void> load() async {
    emit(state.copyWith(offers: state.offers.toLoading()));
    final offersFuture = _getOffers();
    final referralFuture = _getReferral();
    final offers = await offersFuture;
    final referral = await referralFuture;
    emit(
      state.copyWith(
        offers: offers.fold(state.offers.toFailed, LoadState.loaded),
        referral: referral.fold(state.referral.toFailed, LoadState.loaded),
      ),
    );
  }
}
