// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payout_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PayoutState {

/// Destinations offered in the active region.
 List<PayoutDestination> get destinations; LoadState<List<PayoutRequest>> get payouts; LoadState<PayoutAccount> get saving; LoadState<PayoutRequest> get withdrawing; PayoutAccount? get account; bool get accountLoaded; PayoutAccount? get draftAccount; double get availableBalance; double? get withdrawAmount; List<TaxDocument> get taxDocuments; String? get saveError; String? get withdrawError;
/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayoutStateCopyWith<PayoutState> get copyWith => _$PayoutStateCopyWithImpl<PayoutState>(this as PayoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayoutState&&const DeepCollectionEquality().equals(other.destinations, destinations)&&(identical(other.payouts, payouts) || other.payouts == payouts)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.withdrawing, withdrawing) || other.withdrawing == withdrawing)&&(identical(other.account, account) || other.account == account)&&(identical(other.accountLoaded, accountLoaded) || other.accountLoaded == accountLoaded)&&(identical(other.draftAccount, draftAccount) || other.draftAccount == draftAccount)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.withdrawAmount, withdrawAmount) || other.withdrawAmount == withdrawAmount)&&const DeepCollectionEquality().equals(other.taxDocuments, taxDocuments)&&(identical(other.saveError, saveError) || other.saveError == saveError)&&(identical(other.withdrawError, withdrawError) || other.withdrawError == withdrawError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(destinations),payouts,saving,withdrawing,account,accountLoaded,draftAccount,availableBalance,withdrawAmount,const DeepCollectionEquality().hash(taxDocuments),saveError,withdrawError);

@override
String toString() {
  return 'PayoutState(destinations: $destinations, payouts: $payouts, saving: $saving, withdrawing: $withdrawing, account: $account, accountLoaded: $accountLoaded, draftAccount: $draftAccount, availableBalance: $availableBalance, withdrawAmount: $withdrawAmount, taxDocuments: $taxDocuments, saveError: $saveError, withdrawError: $withdrawError)';
}


}

/// @nodoc
abstract mixin class $PayoutStateCopyWith<$Res>  {
  factory $PayoutStateCopyWith(PayoutState value, $Res Function(PayoutState) _then) = _$PayoutStateCopyWithImpl;
@useResult
$Res call({
 List<PayoutDestination> destinations, LoadState<List<PayoutRequest>> payouts, LoadState<PayoutAccount> saving, LoadState<PayoutRequest> withdrawing, PayoutAccount? account, bool accountLoaded, PayoutAccount? draftAccount, double availableBalance, double? withdrawAmount, List<TaxDocument> taxDocuments, String? saveError, String? withdrawError
});


$LoadStateCopyWith<List<PayoutRequest>, $Res> get payouts;$LoadStateCopyWith<PayoutAccount, $Res> get saving;$LoadStateCopyWith<PayoutRequest, $Res> get withdrawing;$PayoutAccountCopyWith<$Res>? get account;$PayoutAccountCopyWith<$Res>? get draftAccount;

}
/// @nodoc
class _$PayoutStateCopyWithImpl<$Res>
    implements $PayoutStateCopyWith<$Res> {
  _$PayoutStateCopyWithImpl(this._self, this._then);

  final PayoutState _self;
  final $Res Function(PayoutState) _then;

/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? destinations = null,Object? payouts = null,Object? saving = null,Object? withdrawing = null,Object? account = freezed,Object? accountLoaded = null,Object? draftAccount = freezed,Object? availableBalance = null,Object? withdrawAmount = freezed,Object? taxDocuments = null,Object? saveError = freezed,Object? withdrawError = freezed,}) {
  return _then(_self.copyWith(
destinations: null == destinations ? _self.destinations : destinations // ignore: cast_nullable_to_non_nullable
as List<PayoutDestination>,payouts: null == payouts ? _self.payouts : payouts // ignore: cast_nullable_to_non_nullable
as LoadState<List<PayoutRequest>>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<PayoutAccount>,withdrawing: null == withdrawing ? _self.withdrawing : withdrawing // ignore: cast_nullable_to_non_nullable
as LoadState<PayoutRequest>,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as PayoutAccount?,accountLoaded: null == accountLoaded ? _self.accountLoaded : accountLoaded // ignore: cast_nullable_to_non_nullable
as bool,draftAccount: freezed == draftAccount ? _self.draftAccount : draftAccount // ignore: cast_nullable_to_non_nullable
as PayoutAccount?,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double,withdrawAmount: freezed == withdrawAmount ? _self.withdrawAmount : withdrawAmount // ignore: cast_nullable_to_non_nullable
as double?,taxDocuments: null == taxDocuments ? _self.taxDocuments : taxDocuments // ignore: cast_nullable_to_non_nullable
as List<TaxDocument>,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,withdrawError: freezed == withdrawError ? _self.withdrawError : withdrawError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PayoutRequest>, $Res> get payouts {
  
  return $LoadStateCopyWith<List<PayoutRequest>, $Res>(_self.payouts, (value) {
    return _then(_self.copyWith(payouts: value));
  });
}/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PayoutAccount, $Res> get saving {
  
  return $LoadStateCopyWith<PayoutAccount, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PayoutRequest, $Res> get withdrawing {
  
  return $LoadStateCopyWith<PayoutRequest, $Res>(_self.withdrawing, (value) {
    return _then(_self.copyWith(withdrawing: value));
  });
}/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayoutAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $PayoutAccountCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayoutAccountCopyWith<$Res>? get draftAccount {
    if (_self.draftAccount == null) {
    return null;
  }

  return $PayoutAccountCopyWith<$Res>(_self.draftAccount!, (value) {
    return _then(_self.copyWith(draftAccount: value));
  });
}
}



/// @nodoc


class _PayoutState extends PayoutState {
  const _PayoutState({required final  List<PayoutDestination> destinations, this.payouts = const LoadState.idle(), this.saving = const LoadState.idle(), this.withdrawing = const LoadState.idle(), this.account, this.accountLoaded = false, this.draftAccount, this.availableBalance = 0, this.withdrawAmount, final  List<TaxDocument> taxDocuments = const <TaxDocument>[], this.saveError, this.withdrawError}): _destinations = destinations,_taxDocuments = taxDocuments,super._();
  

/// Destinations offered in the active region.
 final  List<PayoutDestination> _destinations;
/// Destinations offered in the active region.
@override List<PayoutDestination> get destinations {
  if (_destinations is EqualUnmodifiableListView) return _destinations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_destinations);
}

@override@JsonKey() final  LoadState<List<PayoutRequest>> payouts;
@override@JsonKey() final  LoadState<PayoutAccount> saving;
@override@JsonKey() final  LoadState<PayoutRequest> withdrawing;
@override final  PayoutAccount? account;
@override@JsonKey() final  bool accountLoaded;
@override final  PayoutAccount? draftAccount;
@override@JsonKey() final  double availableBalance;
@override final  double? withdrawAmount;
 final  List<TaxDocument> _taxDocuments;
@override@JsonKey() List<TaxDocument> get taxDocuments {
  if (_taxDocuments is EqualUnmodifiableListView) return _taxDocuments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taxDocuments);
}

@override final  String? saveError;
@override final  String? withdrawError;

/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayoutStateCopyWith<_PayoutState> get copyWith => __$PayoutStateCopyWithImpl<_PayoutState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayoutState&&const DeepCollectionEquality().equals(other._destinations, _destinations)&&(identical(other.payouts, payouts) || other.payouts == payouts)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.withdrawing, withdrawing) || other.withdrawing == withdrawing)&&(identical(other.account, account) || other.account == account)&&(identical(other.accountLoaded, accountLoaded) || other.accountLoaded == accountLoaded)&&(identical(other.draftAccount, draftAccount) || other.draftAccount == draftAccount)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.withdrawAmount, withdrawAmount) || other.withdrawAmount == withdrawAmount)&&const DeepCollectionEquality().equals(other._taxDocuments, _taxDocuments)&&(identical(other.saveError, saveError) || other.saveError == saveError)&&(identical(other.withdrawError, withdrawError) || other.withdrawError == withdrawError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_destinations),payouts,saving,withdrawing,account,accountLoaded,draftAccount,availableBalance,withdrawAmount,const DeepCollectionEquality().hash(_taxDocuments),saveError,withdrawError);

@override
String toString() {
  return 'PayoutState(destinations: $destinations, payouts: $payouts, saving: $saving, withdrawing: $withdrawing, account: $account, accountLoaded: $accountLoaded, draftAccount: $draftAccount, availableBalance: $availableBalance, withdrawAmount: $withdrawAmount, taxDocuments: $taxDocuments, saveError: $saveError, withdrawError: $withdrawError)';
}


}

/// @nodoc
abstract mixin class _$PayoutStateCopyWith<$Res> implements $PayoutStateCopyWith<$Res> {
  factory _$PayoutStateCopyWith(_PayoutState value, $Res Function(_PayoutState) _then) = __$PayoutStateCopyWithImpl;
@override @useResult
$Res call({
 List<PayoutDestination> destinations, LoadState<List<PayoutRequest>> payouts, LoadState<PayoutAccount> saving, LoadState<PayoutRequest> withdrawing, PayoutAccount? account, bool accountLoaded, PayoutAccount? draftAccount, double availableBalance, double? withdrawAmount, List<TaxDocument> taxDocuments, String? saveError, String? withdrawError
});


@override $LoadStateCopyWith<List<PayoutRequest>, $Res> get payouts;@override $LoadStateCopyWith<PayoutAccount, $Res> get saving;@override $LoadStateCopyWith<PayoutRequest, $Res> get withdrawing;@override $PayoutAccountCopyWith<$Res>? get account;@override $PayoutAccountCopyWith<$Res>? get draftAccount;

}
/// @nodoc
class __$PayoutStateCopyWithImpl<$Res>
    implements _$PayoutStateCopyWith<$Res> {
  __$PayoutStateCopyWithImpl(this._self, this._then);

  final _PayoutState _self;
  final $Res Function(_PayoutState) _then;

/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? destinations = null,Object? payouts = null,Object? saving = null,Object? withdrawing = null,Object? account = freezed,Object? accountLoaded = null,Object? draftAccount = freezed,Object? availableBalance = null,Object? withdrawAmount = freezed,Object? taxDocuments = null,Object? saveError = freezed,Object? withdrawError = freezed,}) {
  return _then(_PayoutState(
destinations: null == destinations ? _self._destinations : destinations // ignore: cast_nullable_to_non_nullable
as List<PayoutDestination>,payouts: null == payouts ? _self.payouts : payouts // ignore: cast_nullable_to_non_nullable
as LoadState<List<PayoutRequest>>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<PayoutAccount>,withdrawing: null == withdrawing ? _self.withdrawing : withdrawing // ignore: cast_nullable_to_non_nullable
as LoadState<PayoutRequest>,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as PayoutAccount?,accountLoaded: null == accountLoaded ? _self.accountLoaded : accountLoaded // ignore: cast_nullable_to_non_nullable
as bool,draftAccount: freezed == draftAccount ? _self.draftAccount : draftAccount // ignore: cast_nullable_to_non_nullable
as PayoutAccount?,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double,withdrawAmount: freezed == withdrawAmount ? _self.withdrawAmount : withdrawAmount // ignore: cast_nullable_to_non_nullable
as double?,taxDocuments: null == taxDocuments ? _self._taxDocuments : taxDocuments // ignore: cast_nullable_to_non_nullable
as List<TaxDocument>,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,withdrawError: freezed == withdrawError ? _self.withdrawError : withdrawError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PayoutRequest>, $Res> get payouts {
  
  return $LoadStateCopyWith<List<PayoutRequest>, $Res>(_self.payouts, (value) {
    return _then(_self.copyWith(payouts: value));
  });
}/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PayoutAccount, $Res> get saving {
  
  return $LoadStateCopyWith<PayoutAccount, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PayoutRequest, $Res> get withdrawing {
  
  return $LoadStateCopyWith<PayoutRequest, $Res>(_self.withdrawing, (value) {
    return _then(_self.copyWith(withdrawing: value));
  });
}/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayoutAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $PayoutAccountCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of PayoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayoutAccountCopyWith<$Res>? get draftAccount {
    if (_self.draftAccount == null) {
    return null;
  }

  return $PayoutAccountCopyWith<$Res>(_self.draftAccount!, (value) {
    return _then(_self.copyWith(draftAccount: value));
  });
}
}

// dart format on
