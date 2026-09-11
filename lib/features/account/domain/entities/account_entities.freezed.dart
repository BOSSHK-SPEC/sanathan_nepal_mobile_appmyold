// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedAddress {

 String get id; String get fullName; String get phone; String get line1; String get city; AddressLabel get label; String get line2;/// District in Nepal, state in India — the field's meaning is regional,
/// so it is stored generically and labelled per region in the UI.
 String get region; String get postalCode; bool get isDefault;
/// Create a copy of SavedAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedAddressCopyWith<SavedAddress> get copyWith => _$SavedAddressCopyWithImpl<SavedAddress>(this as SavedAddress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedAddress&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.city, city) || other.city == city)&&(identical(other.label, label) || other.label == label)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.region, region) || other.region == region)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,phone,line1,city,label,line2,region,postalCode,isDefault);

@override
String toString() {
  return 'SavedAddress(id: $id, fullName: $fullName, phone: $phone, line1: $line1, city: $city, label: $label, line2: $line2, region: $region, postalCode: $postalCode, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $SavedAddressCopyWith<$Res>  {
  factory $SavedAddressCopyWith(SavedAddress value, $Res Function(SavedAddress) _then) = _$SavedAddressCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String phone, String line1, String city, AddressLabel label, String line2, String region, String postalCode, bool isDefault
});




}
/// @nodoc
class _$SavedAddressCopyWithImpl<$Res>
    implements $SavedAddressCopyWith<$Res> {
  _$SavedAddressCopyWithImpl(this._self, this._then);

  final SavedAddress _self;
  final $Res Function(SavedAddress) _then;

/// Create a copy of SavedAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? phone = null,Object? line1 = null,Object? city = null,Object? label = null,Object? line2 = null,Object? region = null,Object? postalCode = null,Object? isDefault = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,line1: null == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as AddressLabel,line2: null == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _SavedAddress extends SavedAddress {
  const _SavedAddress({required this.id, required this.fullName, required this.phone, required this.line1, required this.city, this.label = AddressLabel.home, this.line2 = '', this.region = '', this.postalCode = '', this.isDefault = false}): super._();
  

@override final  String id;
@override final  String fullName;
@override final  String phone;
@override final  String line1;
@override final  String city;
@override@JsonKey() final  AddressLabel label;
@override@JsonKey() final  String line2;
/// District in Nepal, state in India — the field's meaning is regional,
/// so it is stored generically and labelled per region in the UI.
@override@JsonKey() final  String region;
@override@JsonKey() final  String postalCode;
@override@JsonKey() final  bool isDefault;

/// Create a copy of SavedAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedAddressCopyWith<_SavedAddress> get copyWith => __$SavedAddressCopyWithImpl<_SavedAddress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedAddress&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.city, city) || other.city == city)&&(identical(other.label, label) || other.label == label)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.region, region) || other.region == region)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,phone,line1,city,label,line2,region,postalCode,isDefault);

@override
String toString() {
  return 'SavedAddress(id: $id, fullName: $fullName, phone: $phone, line1: $line1, city: $city, label: $label, line2: $line2, region: $region, postalCode: $postalCode, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$SavedAddressCopyWith<$Res> implements $SavedAddressCopyWith<$Res> {
  factory _$SavedAddressCopyWith(_SavedAddress value, $Res Function(_SavedAddress) _then) = __$SavedAddressCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String phone, String line1, String city, AddressLabel label, String line2, String region, String postalCode, bool isDefault
});




}
/// @nodoc
class __$SavedAddressCopyWithImpl<$Res>
    implements _$SavedAddressCopyWith<$Res> {
  __$SavedAddressCopyWithImpl(this._self, this._then);

  final _SavedAddress _self;
  final $Res Function(_SavedAddress) _then;

/// Create a copy of SavedAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? phone = null,Object? line1 = null,Object? city = null,Object? label = null,Object? line2 = null,Object? region = null,Object? postalCode = null,Object? isDefault = null,}) {
  return _then(_SavedAddress(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,line1: null == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as AddressLabel,line2: null == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$DeviceSession {

 String get id; String get deviceName; String get platform; DateTime get lastActiveAt; String get location;/// The device this list is being viewed on, which cannot be revoked
/// from here without locking the user out mid-action.
 bool get isCurrent;
/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceSessionCopyWith<DeviceSession> get copyWith => _$DeviceSessionCopyWithImpl<DeviceSession>(this as DeviceSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceSession&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt)&&(identical(other.location, location) || other.location == location)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent));
}


@override
int get hashCode => Object.hash(runtimeType,id,deviceName,platform,lastActiveAt,location,isCurrent);

@override
String toString() {
  return 'DeviceSession(id: $id, deviceName: $deviceName, platform: $platform, lastActiveAt: $lastActiveAt, location: $location, isCurrent: $isCurrent)';
}


}

/// @nodoc
abstract mixin class $DeviceSessionCopyWith<$Res>  {
  factory $DeviceSessionCopyWith(DeviceSession value, $Res Function(DeviceSession) _then) = _$DeviceSessionCopyWithImpl;
@useResult
$Res call({
 String id, String deviceName, String platform, DateTime lastActiveAt, String location, bool isCurrent
});




}
/// @nodoc
class _$DeviceSessionCopyWithImpl<$Res>
    implements $DeviceSessionCopyWith<$Res> {
  _$DeviceSessionCopyWithImpl(this._self, this._then);

  final DeviceSession _self;
  final $Res Function(DeviceSession) _then;

/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deviceName = null,Object? platform = null,Object? lastActiveAt = null,Object? location = null,Object? isCurrent = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,lastActiveAt: null == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _DeviceSession extends DeviceSession {
  const _DeviceSession({required this.id, required this.deviceName, required this.platform, required this.lastActiveAt, this.location = '', this.isCurrent = false}): super._();
  

@override final  String id;
@override final  String deviceName;
@override final  String platform;
@override final  DateTime lastActiveAt;
@override@JsonKey() final  String location;
/// The device this list is being viewed on, which cannot be revoked
/// from here without locking the user out mid-action.
@override@JsonKey() final  bool isCurrent;

/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceSessionCopyWith<_DeviceSession> get copyWith => __$DeviceSessionCopyWithImpl<_DeviceSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceSession&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt)&&(identical(other.location, location) || other.location == location)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent));
}


@override
int get hashCode => Object.hash(runtimeType,id,deviceName,platform,lastActiveAt,location,isCurrent);

@override
String toString() {
  return 'DeviceSession(id: $id, deviceName: $deviceName, platform: $platform, lastActiveAt: $lastActiveAt, location: $location, isCurrent: $isCurrent)';
}


}

/// @nodoc
abstract mixin class _$DeviceSessionCopyWith<$Res> implements $DeviceSessionCopyWith<$Res> {
  factory _$DeviceSessionCopyWith(_DeviceSession value, $Res Function(_DeviceSession) _then) = __$DeviceSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String deviceName, String platform, DateTime lastActiveAt, String location, bool isCurrent
});




}
/// @nodoc
class __$DeviceSessionCopyWithImpl<$Res>
    implements _$DeviceSessionCopyWith<$Res> {
  __$DeviceSessionCopyWithImpl(this._self, this._then);

  final _DeviceSession _self;
  final $Res Function(_DeviceSession) _then;

/// Create a copy of DeviceSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deviceName = null,Object? platform = null,Object? lastActiveAt = null,Object? location = null,Object? isCurrent = null,}) {
  return _then(_DeviceSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,lastActiveAt: null == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SecuritySettings {

 String get phone; String get email; bool get twoFactorEnabled; bool get loginAlertsEnabled; DateTime? get passwordChangedAt;
/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecuritySettingsCopyWith<SecuritySettings> get copyWith => _$SecuritySettingsCopyWithImpl<SecuritySettings>(this as SecuritySettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecuritySettings&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.twoFactorEnabled, twoFactorEnabled) || other.twoFactorEnabled == twoFactorEnabled)&&(identical(other.loginAlertsEnabled, loginAlertsEnabled) || other.loginAlertsEnabled == loginAlertsEnabled)&&(identical(other.passwordChangedAt, passwordChangedAt) || other.passwordChangedAt == passwordChangedAt));
}


@override
int get hashCode => Object.hash(runtimeType,phone,email,twoFactorEnabled,loginAlertsEnabled,passwordChangedAt);

@override
String toString() {
  return 'SecuritySettings(phone: $phone, email: $email, twoFactorEnabled: $twoFactorEnabled, loginAlertsEnabled: $loginAlertsEnabled, passwordChangedAt: $passwordChangedAt)';
}


}

/// @nodoc
abstract mixin class $SecuritySettingsCopyWith<$Res>  {
  factory $SecuritySettingsCopyWith(SecuritySettings value, $Res Function(SecuritySettings) _then) = _$SecuritySettingsCopyWithImpl;
@useResult
$Res call({
 String phone, String email, bool twoFactorEnabled, bool loginAlertsEnabled, DateTime? passwordChangedAt
});




}
/// @nodoc
class _$SecuritySettingsCopyWithImpl<$Res>
    implements $SecuritySettingsCopyWith<$Res> {
  _$SecuritySettingsCopyWithImpl(this._self, this._then);

  final SecuritySettings _self;
  final $Res Function(SecuritySettings) _then;

/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? email = null,Object? twoFactorEnabled = null,Object? loginAlertsEnabled = null,Object? passwordChangedAt = freezed,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,twoFactorEnabled: null == twoFactorEnabled ? _self.twoFactorEnabled : twoFactorEnabled // ignore: cast_nullable_to_non_nullable
as bool,loginAlertsEnabled: null == loginAlertsEnabled ? _self.loginAlertsEnabled : loginAlertsEnabled // ignore: cast_nullable_to_non_nullable
as bool,passwordChangedAt: freezed == passwordChangedAt ? _self.passwordChangedAt : passwordChangedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}



/// @nodoc


class _SecuritySettings extends SecuritySettings {
  const _SecuritySettings({this.phone = '', this.email = '', this.twoFactorEnabled = false, this.loginAlertsEnabled = false, this.passwordChangedAt}): super._();
  

@override@JsonKey() final  String phone;
@override@JsonKey() final  String email;
@override@JsonKey() final  bool twoFactorEnabled;
@override@JsonKey() final  bool loginAlertsEnabled;
@override final  DateTime? passwordChangedAt;

/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecuritySettingsCopyWith<_SecuritySettings> get copyWith => __$SecuritySettingsCopyWithImpl<_SecuritySettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecuritySettings&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.twoFactorEnabled, twoFactorEnabled) || other.twoFactorEnabled == twoFactorEnabled)&&(identical(other.loginAlertsEnabled, loginAlertsEnabled) || other.loginAlertsEnabled == loginAlertsEnabled)&&(identical(other.passwordChangedAt, passwordChangedAt) || other.passwordChangedAt == passwordChangedAt));
}


@override
int get hashCode => Object.hash(runtimeType,phone,email,twoFactorEnabled,loginAlertsEnabled,passwordChangedAt);

@override
String toString() {
  return 'SecuritySettings(phone: $phone, email: $email, twoFactorEnabled: $twoFactorEnabled, loginAlertsEnabled: $loginAlertsEnabled, passwordChangedAt: $passwordChangedAt)';
}


}

/// @nodoc
abstract mixin class _$SecuritySettingsCopyWith<$Res> implements $SecuritySettingsCopyWith<$Res> {
  factory _$SecuritySettingsCopyWith(_SecuritySettings value, $Res Function(_SecuritySettings) _then) = __$SecuritySettingsCopyWithImpl;
@override @useResult
$Res call({
 String phone, String email, bool twoFactorEnabled, bool loginAlertsEnabled, DateTime? passwordChangedAt
});




}
/// @nodoc
class __$SecuritySettingsCopyWithImpl<$Res>
    implements _$SecuritySettingsCopyWith<$Res> {
  __$SecuritySettingsCopyWithImpl(this._self, this._then);

  final _SecuritySettings _self;
  final $Res Function(_SecuritySettings) _then;

/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? email = null,Object? twoFactorEnabled = null,Object? loginAlertsEnabled = null,Object? passwordChangedAt = freezed,}) {
  return _then(_SecuritySettings(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,twoFactorEnabled: null == twoFactorEnabled ? _self.twoFactorEnabled : twoFactorEnabled // ignore: cast_nullable_to_non_nullable
as bool,loginAlertsEnabled: null == loginAlertsEnabled ? _self.loginAlertsEnabled : loginAlertsEnabled // ignore: cast_nullable_to_non_nullable
as bool,passwordChangedAt: freezed == passwordChangedAt ? _self.passwordChangedAt : passwordChangedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$DataRequest {

 DataRequestKind get kind; DataRequestStatus get status; DateTime? get requestedAt; DateTime? get readyAt;/// Download reference once an export is ready.
 String? get downloadRef;
/// Create a copy of DataRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataRequestCopyWith<DataRequest> get copyWith => _$DataRequestCopyWithImpl<DataRequest>(this as DataRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataRequest&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.readyAt, readyAt) || other.readyAt == readyAt)&&(identical(other.downloadRef, downloadRef) || other.downloadRef == downloadRef));
}


@override
int get hashCode => Object.hash(runtimeType,kind,status,requestedAt,readyAt,downloadRef);

@override
String toString() {
  return 'DataRequest(kind: $kind, status: $status, requestedAt: $requestedAt, readyAt: $readyAt, downloadRef: $downloadRef)';
}


}

/// @nodoc
abstract mixin class $DataRequestCopyWith<$Res>  {
  factory $DataRequestCopyWith(DataRequest value, $Res Function(DataRequest) _then) = _$DataRequestCopyWithImpl;
@useResult
$Res call({
 DataRequestKind kind, DataRequestStatus status, DateTime? requestedAt, DateTime? readyAt, String? downloadRef
});




}
/// @nodoc
class _$DataRequestCopyWithImpl<$Res>
    implements $DataRequestCopyWith<$Res> {
  _$DataRequestCopyWithImpl(this._self, this._then);

  final DataRequest _self;
  final $Res Function(DataRequest) _then;

/// Create a copy of DataRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? status = null,Object? requestedAt = freezed,Object? readyAt = freezed,Object? downloadRef = freezed,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DataRequestKind,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DataRequestStatus,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,readyAt: freezed == readyAt ? _self.readyAt : readyAt // ignore: cast_nullable_to_non_nullable
as DateTime?,downloadRef: freezed == downloadRef ? _self.downloadRef : downloadRef // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _DataRequest extends DataRequest {
  const _DataRequest({required this.kind, required this.status, this.requestedAt, this.readyAt, this.downloadRef}): super._();
  

@override final  DataRequestKind kind;
@override final  DataRequestStatus status;
@override final  DateTime? requestedAt;
@override final  DateTime? readyAt;
/// Download reference once an export is ready.
@override final  String? downloadRef;

/// Create a copy of DataRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataRequestCopyWith<_DataRequest> get copyWith => __$DataRequestCopyWithImpl<_DataRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DataRequest&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.readyAt, readyAt) || other.readyAt == readyAt)&&(identical(other.downloadRef, downloadRef) || other.downloadRef == downloadRef));
}


@override
int get hashCode => Object.hash(runtimeType,kind,status,requestedAt,readyAt,downloadRef);

@override
String toString() {
  return 'DataRequest(kind: $kind, status: $status, requestedAt: $requestedAt, readyAt: $readyAt, downloadRef: $downloadRef)';
}


}

/// @nodoc
abstract mixin class _$DataRequestCopyWith<$Res> implements $DataRequestCopyWith<$Res> {
  factory _$DataRequestCopyWith(_DataRequest value, $Res Function(_DataRequest) _then) = __$DataRequestCopyWithImpl;
@override @useResult
$Res call({
 DataRequestKind kind, DataRequestStatus status, DateTime? requestedAt, DateTime? readyAt, String? downloadRef
});




}
/// @nodoc
class __$DataRequestCopyWithImpl<$Res>
    implements _$DataRequestCopyWith<$Res> {
  __$DataRequestCopyWithImpl(this._self, this._then);

  final _DataRequest _self;
  final $Res Function(_DataRequest) _then;

/// Create a copy of DataRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? status = null,Object? requestedAt = freezed,Object? readyAt = freezed,Object? downloadRef = freezed,}) {
  return _then(_DataRequest(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DataRequestKind,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DataRequestStatus,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,readyAt: freezed == readyAt ? _self.readyAt : readyAt // ignore: cast_nullable_to_non_nullable
as DateTime?,downloadRef: freezed == downloadRef ? _self.downloadRef : downloadRef // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TicketMessage {

 String get id; String get body; DateTime get sentAt; bool get fromSupport; List<String> get attachments;
/// Create a copy of TicketMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketMessageCopyWith<TicketMessage> get copyWith => _$TicketMessageCopyWithImpl<TicketMessage>(this as TicketMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.fromSupport, fromSupport) || other.fromSupport == fromSupport)&&const DeepCollectionEquality().equals(other.attachments, attachments));
}


@override
int get hashCode => Object.hash(runtimeType,id,body,sentAt,fromSupport,const DeepCollectionEquality().hash(attachments));

@override
String toString() {
  return 'TicketMessage(id: $id, body: $body, sentAt: $sentAt, fromSupport: $fromSupport, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class $TicketMessageCopyWith<$Res>  {
  factory $TicketMessageCopyWith(TicketMessage value, $Res Function(TicketMessage) _then) = _$TicketMessageCopyWithImpl;
@useResult
$Res call({
 String id, String body, DateTime sentAt, bool fromSupport, List<String> attachments
});




}
/// @nodoc
class _$TicketMessageCopyWithImpl<$Res>
    implements $TicketMessageCopyWith<$Res> {
  _$TicketMessageCopyWithImpl(this._self, this._then);

  final TicketMessage _self;
  final $Res Function(TicketMessage) _then;

/// Create a copy of TicketMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? body = null,Object? sentAt = null,Object? fromSupport = null,Object? attachments = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,fromSupport: null == fromSupport ? _self.fromSupport : fromSupport // ignore: cast_nullable_to_non_nullable
as bool,attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}



/// @nodoc


class _TicketMessage implements TicketMessage {
  const _TicketMessage({required this.id, required this.body, required this.sentAt, this.fromSupport = false, final  List<String> attachments = const <String>[]}): _attachments = attachments;
  

@override final  String id;
@override final  String body;
@override final  DateTime sentAt;
@override@JsonKey() final  bool fromSupport;
 final  List<String> _attachments;
@override@JsonKey() List<String> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}


/// Create a copy of TicketMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketMessageCopyWith<_TicketMessage> get copyWith => __$TicketMessageCopyWithImpl<_TicketMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.fromSupport, fromSupport) || other.fromSupport == fromSupport)&&const DeepCollectionEquality().equals(other._attachments, _attachments));
}


@override
int get hashCode => Object.hash(runtimeType,id,body,sentAt,fromSupport,const DeepCollectionEquality().hash(_attachments));

@override
String toString() {
  return 'TicketMessage(id: $id, body: $body, sentAt: $sentAt, fromSupport: $fromSupport, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class _$TicketMessageCopyWith<$Res> implements $TicketMessageCopyWith<$Res> {
  factory _$TicketMessageCopyWith(_TicketMessage value, $Res Function(_TicketMessage) _then) = __$TicketMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String body, DateTime sentAt, bool fromSupport, List<String> attachments
});




}
/// @nodoc
class __$TicketMessageCopyWithImpl<$Res>
    implements _$TicketMessageCopyWith<$Res> {
  __$TicketMessageCopyWithImpl(this._self, this._then);

  final _TicketMessage _self;
  final $Res Function(_TicketMessage) _then;

/// Create a copy of TicketMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? body = null,Object? sentAt = null,Object? fromSupport = null,Object? attachments = null,}) {
  return _then(_TicketMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,fromSupport: null == fromSupport ? _self.fromSupport : fromSupport // ignore: cast_nullable_to_non_nullable
as bool,attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$SupportTicket {

 String get id; String get reference; String get subject; TicketTopic get topic; TicketStatus get status; DateTime get createdAt; DateTime get updatedAt; List<TicketMessage> get messages;
/// Create a copy of SupportTicket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportTicketCopyWith<SupportTicket> get copyWith => _$SupportTicketCopyWithImpl<SupportTicket>(this as SupportTicket, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportTicket&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.messages, messages));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,subject,topic,status,createdAt,updatedAt,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'SupportTicket(id: $id, reference: $reference, subject: $subject, topic: $topic, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $SupportTicketCopyWith<$Res>  {
  factory $SupportTicketCopyWith(SupportTicket value, $Res Function(SupportTicket) _then) = _$SupportTicketCopyWithImpl;
@useResult
$Res call({
 String id, String reference, String subject, TicketTopic topic, TicketStatus status, DateTime createdAt, DateTime updatedAt, List<TicketMessage> messages
});




}
/// @nodoc
class _$SupportTicketCopyWithImpl<$Res>
    implements $SupportTicketCopyWith<$Res> {
  _$SupportTicketCopyWithImpl(this._self, this._then);

  final SupportTicket _self;
  final $Res Function(SupportTicket) _then;

/// Create a copy of SupportTicket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? subject = null,Object? topic = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? messages = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as TicketTopic,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<TicketMessage>,
  ));
}

}



/// @nodoc


class _SupportTicket extends SupportTicket {
  const _SupportTicket({required this.id, required this.reference, required this.subject, required this.topic, required this.status, required this.createdAt, required this.updatedAt, final  List<TicketMessage> messages = const <TicketMessage>[]}): _messages = messages,super._();
  

@override final  String id;
@override final  String reference;
@override final  String subject;
@override final  TicketTopic topic;
@override final  TicketStatus status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<TicketMessage> _messages;
@override@JsonKey() List<TicketMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of SupportTicket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportTicketCopyWith<_SupportTicket> get copyWith => __$SupportTicketCopyWithImpl<_SupportTicket>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportTicket&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._messages, _messages));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,subject,topic,status,createdAt,updatedAt,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'SupportTicket(id: $id, reference: $reference, subject: $subject, topic: $topic, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$SupportTicketCopyWith<$Res> implements $SupportTicketCopyWith<$Res> {
  factory _$SupportTicketCopyWith(_SupportTicket value, $Res Function(_SupportTicket) _then) = __$SupportTicketCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference, String subject, TicketTopic topic, TicketStatus status, DateTime createdAt, DateTime updatedAt, List<TicketMessage> messages
});




}
/// @nodoc
class __$SupportTicketCopyWithImpl<$Res>
    implements _$SupportTicketCopyWith<$Res> {
  __$SupportTicketCopyWithImpl(this._self, this._then);

  final _SupportTicket _self;
  final $Res Function(_SupportTicket) _then;

/// Create a copy of SupportTicket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? subject = null,Object? topic = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? messages = null,}) {
  return _then(_SupportTicket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as TicketTopic,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<TicketMessage>,
  ));
}


}

/// @nodoc
mixin _$Offer {

 String get id; String get code; String get title; String get description; OfferKind get kind; DateTime get expiresAt; bool get used;/// Minimum spend, when the offer has one.
 double get minimumSpend;
/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfferCopyWith<Offer> get copyWith => _$OfferCopyWithImpl<Offer>(this as Offer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Offer&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.used, used) || other.used == used)&&(identical(other.minimumSpend, minimumSpend) || other.minimumSpend == minimumSpend));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,title,description,kind,expiresAt,used,minimumSpend);

@override
String toString() {
  return 'Offer(id: $id, code: $code, title: $title, description: $description, kind: $kind, expiresAt: $expiresAt, used: $used, minimumSpend: $minimumSpend)';
}


}

/// @nodoc
abstract mixin class $OfferCopyWith<$Res>  {
  factory $OfferCopyWith(Offer value, $Res Function(Offer) _then) = _$OfferCopyWithImpl;
@useResult
$Res call({
 String id, String code, String title, String description, OfferKind kind, DateTime expiresAt, bool used, double minimumSpend
});




}
/// @nodoc
class _$OfferCopyWithImpl<$Res>
    implements $OfferCopyWith<$Res> {
  _$OfferCopyWithImpl(this._self, this._then);

  final Offer _self;
  final $Res Function(Offer) _then;

/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? title = null,Object? description = null,Object? kind = null,Object? expiresAt = null,Object? used = null,Object? minimumSpend = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as OfferKind,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as bool,minimumSpend: null == minimumSpend ? _self.minimumSpend : minimumSpend // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}



/// @nodoc


class _Offer extends Offer {
  const _Offer({required this.id, required this.code, required this.title, required this.description, required this.kind, required this.expiresAt, this.used = false, this.minimumSpend = 0}): super._();
  

@override final  String id;
@override final  String code;
@override final  String title;
@override final  String description;
@override final  OfferKind kind;
@override final  DateTime expiresAt;
@override@JsonKey() final  bool used;
/// Minimum spend, when the offer has one.
@override@JsonKey() final  double minimumSpend;

/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfferCopyWith<_Offer> get copyWith => __$OfferCopyWithImpl<_Offer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Offer&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.used, used) || other.used == used)&&(identical(other.minimumSpend, minimumSpend) || other.minimumSpend == minimumSpend));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,title,description,kind,expiresAt,used,minimumSpend);

@override
String toString() {
  return 'Offer(id: $id, code: $code, title: $title, description: $description, kind: $kind, expiresAt: $expiresAt, used: $used, minimumSpend: $minimumSpend)';
}


}

/// @nodoc
abstract mixin class _$OfferCopyWith<$Res> implements $OfferCopyWith<$Res> {
  factory _$OfferCopyWith(_Offer value, $Res Function(_Offer) _then) = __$OfferCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String title, String description, OfferKind kind, DateTime expiresAt, bool used, double minimumSpend
});




}
/// @nodoc
class __$OfferCopyWithImpl<$Res>
    implements _$OfferCopyWith<$Res> {
  __$OfferCopyWithImpl(this._self, this._then);

  final _Offer _self;
  final $Res Function(_Offer) _then;

/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? title = null,Object? description = null,Object? kind = null,Object? expiresAt = null,Object? used = null,Object? minimumSpend = null,}) {
  return _then(_Offer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as OfferKind,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,used: null == used ? _self.used : used // ignore: cast_nullable_to_non_nullable
as bool,minimumSpend: null == minimumSpend ? _self.minimumSpend : minimumSpend // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ReferralSummary {

 String get code; int get invited; int get joined; double get earned;/// What each side gets, for the share message.
 double get rewardPerReferral;
/// Create a copy of ReferralSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReferralSummaryCopyWith<ReferralSummary> get copyWith => _$ReferralSummaryCopyWithImpl<ReferralSummary>(this as ReferralSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReferralSummary&&(identical(other.code, code) || other.code == code)&&(identical(other.invited, invited) || other.invited == invited)&&(identical(other.joined, joined) || other.joined == joined)&&(identical(other.earned, earned) || other.earned == earned)&&(identical(other.rewardPerReferral, rewardPerReferral) || other.rewardPerReferral == rewardPerReferral));
}


@override
int get hashCode => Object.hash(runtimeType,code,invited,joined,earned,rewardPerReferral);

@override
String toString() {
  return 'ReferralSummary(code: $code, invited: $invited, joined: $joined, earned: $earned, rewardPerReferral: $rewardPerReferral)';
}


}

/// @nodoc
abstract mixin class $ReferralSummaryCopyWith<$Res>  {
  factory $ReferralSummaryCopyWith(ReferralSummary value, $Res Function(ReferralSummary) _then) = _$ReferralSummaryCopyWithImpl;
@useResult
$Res call({
 String code, int invited, int joined, double earned, double rewardPerReferral
});




}
/// @nodoc
class _$ReferralSummaryCopyWithImpl<$Res>
    implements $ReferralSummaryCopyWith<$Res> {
  _$ReferralSummaryCopyWithImpl(this._self, this._then);

  final ReferralSummary _self;
  final $Res Function(ReferralSummary) _then;

/// Create a copy of ReferralSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? invited = null,Object? joined = null,Object? earned = null,Object? rewardPerReferral = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,invited: null == invited ? _self.invited : invited // ignore: cast_nullable_to_non_nullable
as int,joined: null == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as int,earned: null == earned ? _self.earned : earned // ignore: cast_nullable_to_non_nullable
as double,rewardPerReferral: null == rewardPerReferral ? _self.rewardPerReferral : rewardPerReferral // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}



/// @nodoc


class _ReferralSummary extends ReferralSummary {
  const _ReferralSummary({required this.code, this.invited = 0, this.joined = 0, this.earned = 0, this.rewardPerReferral = 0}): super._();
  

@override final  String code;
@override@JsonKey() final  int invited;
@override@JsonKey() final  int joined;
@override@JsonKey() final  double earned;
/// What each side gets, for the share message.
@override@JsonKey() final  double rewardPerReferral;

/// Create a copy of ReferralSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferralSummaryCopyWith<_ReferralSummary> get copyWith => __$ReferralSummaryCopyWithImpl<_ReferralSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferralSummary&&(identical(other.code, code) || other.code == code)&&(identical(other.invited, invited) || other.invited == invited)&&(identical(other.joined, joined) || other.joined == joined)&&(identical(other.earned, earned) || other.earned == earned)&&(identical(other.rewardPerReferral, rewardPerReferral) || other.rewardPerReferral == rewardPerReferral));
}


@override
int get hashCode => Object.hash(runtimeType,code,invited,joined,earned,rewardPerReferral);

@override
String toString() {
  return 'ReferralSummary(code: $code, invited: $invited, joined: $joined, earned: $earned, rewardPerReferral: $rewardPerReferral)';
}


}

/// @nodoc
abstract mixin class _$ReferralSummaryCopyWith<$Res> implements $ReferralSummaryCopyWith<$Res> {
  factory _$ReferralSummaryCopyWith(_ReferralSummary value, $Res Function(_ReferralSummary) _then) = __$ReferralSummaryCopyWithImpl;
@override @useResult
$Res call({
 String code, int invited, int joined, double earned, double rewardPerReferral
});




}
/// @nodoc
class __$ReferralSummaryCopyWithImpl<$Res>
    implements _$ReferralSummaryCopyWith<$Res> {
  __$ReferralSummaryCopyWithImpl(this._self, this._then);

  final _ReferralSummary _self;
  final $Res Function(_ReferralSummary) _then;

/// Create a copy of ReferralSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? invited = null,Object? joined = null,Object? earned = null,Object? rewardPerReferral = null,}) {
  return _then(_ReferralSummary(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,invited: null == invited ? _self.invited : invited // ignore: cast_nullable_to_non_nullable
as int,joined: null == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as int,earned: null == earned ? _self.earned : earned // ignore: cast_nullable_to_non_nullable
as double,rewardPerReferral: null == rewardPerReferral ? _self.rewardPerReferral : rewardPerReferral // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
