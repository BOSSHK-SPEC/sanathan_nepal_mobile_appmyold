// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_cubits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddressesState {

 LoadState<List<SavedAddress>> get addresses; LoadState<SavedAddress> get saving; String? get saveError;
/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressesStateCopyWith<AddressesState> get copyWith => _$AddressesStateCopyWithImpl<AddressesState>(this as AddressesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesState&&(identical(other.addresses, addresses) || other.addresses == addresses)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,addresses,saving,saveError);

@override
String toString() {
  return 'AddressesState(addresses: $addresses, saving: $saving, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class $AddressesStateCopyWith<$Res>  {
  factory $AddressesStateCopyWith(AddressesState value, $Res Function(AddressesState) _then) = _$AddressesStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<SavedAddress>> addresses, LoadState<SavedAddress> saving, String? saveError
});


$LoadStateCopyWith<List<SavedAddress>, $Res> get addresses;$LoadStateCopyWith<SavedAddress, $Res> get saving;

}
/// @nodoc
class _$AddressesStateCopyWithImpl<$Res>
    implements $AddressesStateCopyWith<$Res> {
  _$AddressesStateCopyWithImpl(this._self, this._then);

  final AddressesState _self;
  final $Res Function(AddressesState) _then;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? addresses = null,Object? saving = null,Object? saveError = freezed,}) {
  return _then(_self.copyWith(
addresses: null == addresses ? _self.addresses : addresses // ignore: cast_nullable_to_non_nullable
as LoadState<List<SavedAddress>>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<SavedAddress>,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<SavedAddress>, $Res> get addresses {
  
  return $LoadStateCopyWith<List<SavedAddress>, $Res>(_self.addresses, (value) {
    return _then(_self.copyWith(addresses: value));
  });
}/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<SavedAddress, $Res> get saving {
  
  return $LoadStateCopyWith<SavedAddress, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}
}



/// @nodoc


class _AddressesState extends AddressesState {
  const _AddressesState({this.addresses = const LoadState.idle(), this.saving = const LoadState.idle(), this.saveError}): super._();
  

@override@JsonKey() final  LoadState<List<SavedAddress>> addresses;
@override@JsonKey() final  LoadState<SavedAddress> saving;
@override final  String? saveError;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressesStateCopyWith<_AddressesState> get copyWith => __$AddressesStateCopyWithImpl<_AddressesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressesState&&(identical(other.addresses, addresses) || other.addresses == addresses)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,addresses,saving,saveError);

@override
String toString() {
  return 'AddressesState(addresses: $addresses, saving: $saving, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class _$AddressesStateCopyWith<$Res> implements $AddressesStateCopyWith<$Res> {
  factory _$AddressesStateCopyWith(_AddressesState value, $Res Function(_AddressesState) _then) = __$AddressesStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<SavedAddress>> addresses, LoadState<SavedAddress> saving, String? saveError
});


@override $LoadStateCopyWith<List<SavedAddress>, $Res> get addresses;@override $LoadStateCopyWith<SavedAddress, $Res> get saving;

}
/// @nodoc
class __$AddressesStateCopyWithImpl<$Res>
    implements _$AddressesStateCopyWith<$Res> {
  __$AddressesStateCopyWithImpl(this._self, this._then);

  final _AddressesState _self;
  final $Res Function(_AddressesState) _then;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? addresses = null,Object? saving = null,Object? saveError = freezed,}) {
  return _then(_AddressesState(
addresses: null == addresses ? _self.addresses : addresses // ignore: cast_nullable_to_non_nullable
as LoadState<List<SavedAddress>>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<SavedAddress>,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<SavedAddress>, $Res> get addresses {
  
  return $LoadStateCopyWith<List<SavedAddress>, $Res>(_self.addresses, (value) {
    return _then(_self.copyWith(addresses: value));
  });
}/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<SavedAddress, $Res> get saving {
  
  return $LoadStateCopyWith<SavedAddress, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}
}

/// @nodoc
mixin _$SecurityState {

 LoadState<SecuritySettings> get settings; LoadState<List<DeviceSession>> get devices;
/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityStateCopyWith<SecurityState> get copyWith => _$SecurityStateCopyWithImpl<SecurityState>(this as SecurityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.devices, devices) || other.devices == devices));
}


@override
int get hashCode => Object.hash(runtimeType,settings,devices);

@override
String toString() {
  return 'SecurityState(settings: $settings, devices: $devices)';
}


}

/// @nodoc
abstract mixin class $SecurityStateCopyWith<$Res>  {
  factory $SecurityStateCopyWith(SecurityState value, $Res Function(SecurityState) _then) = _$SecurityStateCopyWithImpl;
@useResult
$Res call({
 LoadState<SecuritySettings> settings, LoadState<List<DeviceSession>> devices
});


$LoadStateCopyWith<SecuritySettings, $Res> get settings;$LoadStateCopyWith<List<DeviceSession>, $Res> get devices;

}
/// @nodoc
class _$SecurityStateCopyWithImpl<$Res>
    implements $SecurityStateCopyWith<$Res> {
  _$SecurityStateCopyWithImpl(this._self, this._then);

  final SecurityState _self;
  final $Res Function(SecurityState) _then;

/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? devices = null,}) {
  return _then(_self.copyWith(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as LoadState<SecuritySettings>,devices: null == devices ? _self.devices : devices // ignore: cast_nullable_to_non_nullable
as LoadState<List<DeviceSession>>,
  ));
}
/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<SecuritySettings, $Res> get settings {
  
  return $LoadStateCopyWith<SecuritySettings, $Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<DeviceSession>, $Res> get devices {
  
  return $LoadStateCopyWith<List<DeviceSession>, $Res>(_self.devices, (value) {
    return _then(_self.copyWith(devices: value));
  });
}
}



/// @nodoc


class _SecurityState extends SecurityState {
  const _SecurityState({this.settings = const LoadState.idle(), this.devices = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<SecuritySettings> settings;
@override@JsonKey() final  LoadState<List<DeviceSession>> devices;

/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecurityStateCopyWith<_SecurityState> get copyWith => __$SecurityStateCopyWithImpl<_SecurityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecurityState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.devices, devices) || other.devices == devices));
}


@override
int get hashCode => Object.hash(runtimeType,settings,devices);

@override
String toString() {
  return 'SecurityState(settings: $settings, devices: $devices)';
}


}

/// @nodoc
abstract mixin class _$SecurityStateCopyWith<$Res> implements $SecurityStateCopyWith<$Res> {
  factory _$SecurityStateCopyWith(_SecurityState value, $Res Function(_SecurityState) _then) = __$SecurityStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<SecuritySettings> settings, LoadState<List<DeviceSession>> devices
});


@override $LoadStateCopyWith<SecuritySettings, $Res> get settings;@override $LoadStateCopyWith<List<DeviceSession>, $Res> get devices;

}
/// @nodoc
class __$SecurityStateCopyWithImpl<$Res>
    implements _$SecurityStateCopyWith<$Res> {
  __$SecurityStateCopyWithImpl(this._self, this._then);

  final _SecurityState _self;
  final $Res Function(_SecurityState) _then;

/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? devices = null,}) {
  return _then(_SecurityState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as LoadState<SecuritySettings>,devices: null == devices ? _self.devices : devices // ignore: cast_nullable_to_non_nullable
as LoadState<List<DeviceSession>>,
  ));
}

/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<SecuritySettings, $Res> get settings {
  
  return $LoadStateCopyWith<SecuritySettings, $Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<DeviceSession>, $Res> get devices {
  
  return $LoadStateCopyWith<List<DeviceSession>, $Res>(_self.devices, (value) {
    return _then(_self.copyWith(devices: value));
  });
}
}

/// @nodoc
mixin _$PrivacyState {

 LoadState<List<DataRequest>> get requests; LoadState<DataRequest> get submitting;
/// Create a copy of PrivacyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivacyStateCopyWith<PrivacyState> get copyWith => _$PrivacyStateCopyWithImpl<PrivacyState>(this as PrivacyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivacyState&&(identical(other.requests, requests) || other.requests == requests)&&(identical(other.submitting, submitting) || other.submitting == submitting));
}


@override
int get hashCode => Object.hash(runtimeType,requests,submitting);

@override
String toString() {
  return 'PrivacyState(requests: $requests, submitting: $submitting)';
}


}

/// @nodoc
abstract mixin class $PrivacyStateCopyWith<$Res>  {
  factory $PrivacyStateCopyWith(PrivacyState value, $Res Function(PrivacyState) _then) = _$PrivacyStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<DataRequest>> requests, LoadState<DataRequest> submitting
});


$LoadStateCopyWith<List<DataRequest>, $Res> get requests;$LoadStateCopyWith<DataRequest, $Res> get submitting;

}
/// @nodoc
class _$PrivacyStateCopyWithImpl<$Res>
    implements $PrivacyStateCopyWith<$Res> {
  _$PrivacyStateCopyWithImpl(this._self, this._then);

  final PrivacyState _self;
  final $Res Function(PrivacyState) _then;

/// Create a copy of PrivacyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requests = null,Object? submitting = null,}) {
  return _then(_self.copyWith(
requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as LoadState<List<DataRequest>>,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as LoadState<DataRequest>,
  ));
}
/// Create a copy of PrivacyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<DataRequest>, $Res> get requests {
  
  return $LoadStateCopyWith<List<DataRequest>, $Res>(_self.requests, (value) {
    return _then(_self.copyWith(requests: value));
  });
}/// Create a copy of PrivacyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<DataRequest, $Res> get submitting {
  
  return $LoadStateCopyWith<DataRequest, $Res>(_self.submitting, (value) {
    return _then(_self.copyWith(submitting: value));
  });
}
}



/// @nodoc


class _PrivacyState extends PrivacyState {
  const _PrivacyState({this.requests = const LoadState.idle(), this.submitting = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<List<DataRequest>> requests;
@override@JsonKey() final  LoadState<DataRequest> submitting;

/// Create a copy of PrivacyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrivacyStateCopyWith<_PrivacyState> get copyWith => __$PrivacyStateCopyWithImpl<_PrivacyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivacyState&&(identical(other.requests, requests) || other.requests == requests)&&(identical(other.submitting, submitting) || other.submitting == submitting));
}


@override
int get hashCode => Object.hash(runtimeType,requests,submitting);

@override
String toString() {
  return 'PrivacyState(requests: $requests, submitting: $submitting)';
}


}

/// @nodoc
abstract mixin class _$PrivacyStateCopyWith<$Res> implements $PrivacyStateCopyWith<$Res> {
  factory _$PrivacyStateCopyWith(_PrivacyState value, $Res Function(_PrivacyState) _then) = __$PrivacyStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<DataRequest>> requests, LoadState<DataRequest> submitting
});


@override $LoadStateCopyWith<List<DataRequest>, $Res> get requests;@override $LoadStateCopyWith<DataRequest, $Res> get submitting;

}
/// @nodoc
class __$PrivacyStateCopyWithImpl<$Res>
    implements _$PrivacyStateCopyWith<$Res> {
  __$PrivacyStateCopyWithImpl(this._self, this._then);

  final _PrivacyState _self;
  final $Res Function(_PrivacyState) _then;

/// Create a copy of PrivacyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requests = null,Object? submitting = null,}) {
  return _then(_PrivacyState(
requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as LoadState<List<DataRequest>>,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as LoadState<DataRequest>,
  ));
}

/// Create a copy of PrivacyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<DataRequest>, $Res> get requests {
  
  return $LoadStateCopyWith<List<DataRequest>, $Res>(_self.requests, (value) {
    return _then(_self.copyWith(requests: value));
  });
}/// Create a copy of PrivacyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<DataRequest, $Res> get submitting {
  
  return $LoadStateCopyWith<DataRequest, $Res>(_self.submitting, (value) {
    return _then(_self.copyWith(submitting: value));
  });
}
}

/// @nodoc
mixin _$SupportTicketsState {

 LoadState<List<SupportTicket>> get tickets; LoadState<SupportTicket> get submitting;
/// Create a copy of SupportTicketsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportTicketsStateCopyWith<SupportTicketsState> get copyWith => _$SupportTicketsStateCopyWithImpl<SupportTicketsState>(this as SupportTicketsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportTicketsState&&(identical(other.tickets, tickets) || other.tickets == tickets)&&(identical(other.submitting, submitting) || other.submitting == submitting));
}


@override
int get hashCode => Object.hash(runtimeType,tickets,submitting);

@override
String toString() {
  return 'SupportTicketsState(tickets: $tickets, submitting: $submitting)';
}


}

/// @nodoc
abstract mixin class $SupportTicketsStateCopyWith<$Res>  {
  factory $SupportTicketsStateCopyWith(SupportTicketsState value, $Res Function(SupportTicketsState) _then) = _$SupportTicketsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<SupportTicket>> tickets, LoadState<SupportTicket> submitting
});


$LoadStateCopyWith<List<SupportTicket>, $Res> get tickets;$LoadStateCopyWith<SupportTicket, $Res> get submitting;

}
/// @nodoc
class _$SupportTicketsStateCopyWithImpl<$Res>
    implements $SupportTicketsStateCopyWith<$Res> {
  _$SupportTicketsStateCopyWithImpl(this._self, this._then);

  final SupportTicketsState _self;
  final $Res Function(SupportTicketsState) _then;

/// Create a copy of SupportTicketsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tickets = null,Object? submitting = null,}) {
  return _then(_self.copyWith(
tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as LoadState<List<SupportTicket>>,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as LoadState<SupportTicket>,
  ));
}
/// Create a copy of SupportTicketsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<SupportTicket>, $Res> get tickets {
  
  return $LoadStateCopyWith<List<SupportTicket>, $Res>(_self.tickets, (value) {
    return _then(_self.copyWith(tickets: value));
  });
}/// Create a copy of SupportTicketsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<SupportTicket, $Res> get submitting {
  
  return $LoadStateCopyWith<SupportTicket, $Res>(_self.submitting, (value) {
    return _then(_self.copyWith(submitting: value));
  });
}
}



/// @nodoc


class _SupportTicketsState extends SupportTicketsState {
  const _SupportTicketsState({this.tickets = const LoadState.idle(), this.submitting = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<List<SupportTicket>> tickets;
@override@JsonKey() final  LoadState<SupportTicket> submitting;

/// Create a copy of SupportTicketsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportTicketsStateCopyWith<_SupportTicketsState> get copyWith => __$SupportTicketsStateCopyWithImpl<_SupportTicketsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportTicketsState&&(identical(other.tickets, tickets) || other.tickets == tickets)&&(identical(other.submitting, submitting) || other.submitting == submitting));
}


@override
int get hashCode => Object.hash(runtimeType,tickets,submitting);

@override
String toString() {
  return 'SupportTicketsState(tickets: $tickets, submitting: $submitting)';
}


}

/// @nodoc
abstract mixin class _$SupportTicketsStateCopyWith<$Res> implements $SupportTicketsStateCopyWith<$Res> {
  factory _$SupportTicketsStateCopyWith(_SupportTicketsState value, $Res Function(_SupportTicketsState) _then) = __$SupportTicketsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<SupportTicket>> tickets, LoadState<SupportTicket> submitting
});


@override $LoadStateCopyWith<List<SupportTicket>, $Res> get tickets;@override $LoadStateCopyWith<SupportTicket, $Res> get submitting;

}
/// @nodoc
class __$SupportTicketsStateCopyWithImpl<$Res>
    implements _$SupportTicketsStateCopyWith<$Res> {
  __$SupportTicketsStateCopyWithImpl(this._self, this._then);

  final _SupportTicketsState _self;
  final $Res Function(_SupportTicketsState) _then;

/// Create a copy of SupportTicketsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tickets = null,Object? submitting = null,}) {
  return _then(_SupportTicketsState(
tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as LoadState<List<SupportTicket>>,submitting: null == submitting ? _self.submitting : submitting // ignore: cast_nullable_to_non_nullable
as LoadState<SupportTicket>,
  ));
}

/// Create a copy of SupportTicketsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<SupportTicket>, $Res> get tickets {
  
  return $LoadStateCopyWith<List<SupportTicket>, $Res>(_self.tickets, (value) {
    return _then(_self.copyWith(tickets: value));
  });
}/// Create a copy of SupportTicketsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<SupportTicket, $Res> get submitting {
  
  return $LoadStateCopyWith<SupportTicket, $Res>(_self.submitting, (value) {
    return _then(_self.copyWith(submitting: value));
  });
}
}

/// @nodoc
mixin _$OffersState {

 LoadState<List<Offer>> get offers; LoadState<ReferralSummary> get referral;
/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OffersStateCopyWith<OffersState> get copyWith => _$OffersStateCopyWithImpl<OffersState>(this as OffersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffersState&&(identical(other.offers, offers) || other.offers == offers)&&(identical(other.referral, referral) || other.referral == referral));
}


@override
int get hashCode => Object.hash(runtimeType,offers,referral);

@override
String toString() {
  return 'OffersState(offers: $offers, referral: $referral)';
}


}

/// @nodoc
abstract mixin class $OffersStateCopyWith<$Res>  {
  factory $OffersStateCopyWith(OffersState value, $Res Function(OffersState) _then) = _$OffersStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<Offer>> offers, LoadState<ReferralSummary> referral
});


$LoadStateCopyWith<List<Offer>, $Res> get offers;$LoadStateCopyWith<ReferralSummary, $Res> get referral;

}
/// @nodoc
class _$OffersStateCopyWithImpl<$Res>
    implements $OffersStateCopyWith<$Res> {
  _$OffersStateCopyWithImpl(this._self, this._then);

  final OffersState _self;
  final $Res Function(OffersState) _then;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? offers = null,Object? referral = null,}) {
  return _then(_self.copyWith(
offers: null == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as LoadState<List<Offer>>,referral: null == referral ? _self.referral : referral // ignore: cast_nullable_to_non_nullable
as LoadState<ReferralSummary>,
  ));
}
/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Offer>, $Res> get offers {
  
  return $LoadStateCopyWith<List<Offer>, $Res>(_self.offers, (value) {
    return _then(_self.copyWith(offers: value));
  });
}/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ReferralSummary, $Res> get referral {
  
  return $LoadStateCopyWith<ReferralSummary, $Res>(_self.referral, (value) {
    return _then(_self.copyWith(referral: value));
  });
}
}



/// @nodoc


class _OffersState extends OffersState {
  const _OffersState({this.offers = const LoadState.idle(), this.referral = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<List<Offer>> offers;
@override@JsonKey() final  LoadState<ReferralSummary> referral;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OffersStateCopyWith<_OffersState> get copyWith => __$OffersStateCopyWithImpl<_OffersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OffersState&&(identical(other.offers, offers) || other.offers == offers)&&(identical(other.referral, referral) || other.referral == referral));
}


@override
int get hashCode => Object.hash(runtimeType,offers,referral);

@override
String toString() {
  return 'OffersState(offers: $offers, referral: $referral)';
}


}

/// @nodoc
abstract mixin class _$OffersStateCopyWith<$Res> implements $OffersStateCopyWith<$Res> {
  factory _$OffersStateCopyWith(_OffersState value, $Res Function(_OffersState) _then) = __$OffersStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<Offer>> offers, LoadState<ReferralSummary> referral
});


@override $LoadStateCopyWith<List<Offer>, $Res> get offers;@override $LoadStateCopyWith<ReferralSummary, $Res> get referral;

}
/// @nodoc
class __$OffersStateCopyWithImpl<$Res>
    implements _$OffersStateCopyWith<$Res> {
  __$OffersStateCopyWithImpl(this._self, this._then);

  final _OffersState _self;
  final $Res Function(_OffersState) _then;

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? offers = null,Object? referral = null,}) {
  return _then(_OffersState(
offers: null == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as LoadState<List<Offer>>,referral: null == referral ? _self.referral : referral // ignore: cast_nullable_to_non_nullable
as LoadState<ReferralSummary>,
  ));
}

/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Offer>, $Res> get offers {
  
  return $LoadStateCopyWith<List<Offer>, $Res>(_self.offers, (value) {
    return _then(_self.copyWith(offers: value));
  });
}/// Create a copy of OffersState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ReferralSummary, $Res> get referral {
  
  return $LoadStateCopyWith<ReferralSummary, $Res>(_self.referral, (value) {
    return _then(_self.copyWith(referral: value));
  });
}
}

// dart format on
