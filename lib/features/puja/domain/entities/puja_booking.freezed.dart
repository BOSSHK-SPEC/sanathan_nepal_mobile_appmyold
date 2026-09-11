// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'puja_booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SankalpDetails {

 String get fullName; String get gotra; String get rashiOrNakshatra;/// Others named in the sankalp — family pujas name the household.
 List<String> get familyMembers;
/// Create a copy of SankalpDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SankalpDetailsCopyWith<SankalpDetails> get copyWith => _$SankalpDetailsCopyWithImpl<SankalpDetails>(this as SankalpDetails, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SankalpDetails&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.gotra, gotra) || other.gotra == gotra)&&(identical(other.rashiOrNakshatra, rashiOrNakshatra) || other.rashiOrNakshatra == rashiOrNakshatra)&&const DeepCollectionEquality().equals(other.familyMembers, familyMembers));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,gotra,rashiOrNakshatra,const DeepCollectionEquality().hash(familyMembers));

@override
String toString() {
  return 'SankalpDetails(fullName: $fullName, gotra: $gotra, rashiOrNakshatra: $rashiOrNakshatra, familyMembers: $familyMembers)';
}


}

/// @nodoc
abstract mixin class $SankalpDetailsCopyWith<$Res>  {
  factory $SankalpDetailsCopyWith(SankalpDetails value, $Res Function(SankalpDetails) _then) = _$SankalpDetailsCopyWithImpl;
@useResult
$Res call({
 String fullName, String gotra, String rashiOrNakshatra, List<String> familyMembers
});




}
/// @nodoc
class _$SankalpDetailsCopyWithImpl<$Res>
    implements $SankalpDetailsCopyWith<$Res> {
  _$SankalpDetailsCopyWithImpl(this._self, this._then);

  final SankalpDetails _self;
  final $Res Function(SankalpDetails) _then;

/// Create a copy of SankalpDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? gotra = null,Object? rashiOrNakshatra = null,Object? familyMembers = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,gotra: null == gotra ? _self.gotra : gotra // ignore: cast_nullable_to_non_nullable
as String,rashiOrNakshatra: null == rashiOrNakshatra ? _self.rashiOrNakshatra : rashiOrNakshatra // ignore: cast_nullable_to_non_nullable
as String,familyMembers: null == familyMembers ? _self.familyMembers : familyMembers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}



/// @nodoc


class _SankalpDetails extends SankalpDetails {
  const _SankalpDetails({this.fullName = '', this.gotra = '', this.rashiOrNakshatra = '', final  List<String> familyMembers = const <String>[]}): _familyMembers = familyMembers,super._();
  

@override@JsonKey() final  String fullName;
@override@JsonKey() final  String gotra;
@override@JsonKey() final  String rashiOrNakshatra;
/// Others named in the sankalp — family pujas name the household.
 final  List<String> _familyMembers;
/// Others named in the sankalp — family pujas name the household.
@override@JsonKey() List<String> get familyMembers {
  if (_familyMembers is EqualUnmodifiableListView) return _familyMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_familyMembers);
}


/// Create a copy of SankalpDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SankalpDetailsCopyWith<_SankalpDetails> get copyWith => __$SankalpDetailsCopyWithImpl<_SankalpDetails>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SankalpDetails&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.gotra, gotra) || other.gotra == gotra)&&(identical(other.rashiOrNakshatra, rashiOrNakshatra) || other.rashiOrNakshatra == rashiOrNakshatra)&&const DeepCollectionEquality().equals(other._familyMembers, _familyMembers));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,gotra,rashiOrNakshatra,const DeepCollectionEquality().hash(_familyMembers));

@override
String toString() {
  return 'SankalpDetails(fullName: $fullName, gotra: $gotra, rashiOrNakshatra: $rashiOrNakshatra, familyMembers: $familyMembers)';
}


}

/// @nodoc
abstract mixin class _$SankalpDetailsCopyWith<$Res> implements $SankalpDetailsCopyWith<$Res> {
  factory _$SankalpDetailsCopyWith(_SankalpDetails value, $Res Function(_SankalpDetails) _then) = __$SankalpDetailsCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String gotra, String rashiOrNakshatra, List<String> familyMembers
});




}
/// @nodoc
class __$SankalpDetailsCopyWithImpl<$Res>
    implements _$SankalpDetailsCopyWith<$Res> {
  __$SankalpDetailsCopyWithImpl(this._self, this._then);

  final _SankalpDetails _self;
  final $Res Function(_SankalpDetails) _then;

/// Create a copy of SankalpDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? gotra = null,Object? rashiOrNakshatra = null,Object? familyMembers = null,}) {
  return _then(_SankalpDetails(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,gotra: null == gotra ? _self.gotra : gotra // ignore: cast_nullable_to_non_nullable
as String,rashiOrNakshatra: null == rashiOrNakshatra ? _self.rashiOrNakshatra : rashiOrNakshatra // ignore: cast_nullable_to_non_nullable
as String,familyMembers: null == familyMembers ? _self._familyMembers : familyMembers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$PujaBooking {

 String get id; String get serviceId; String get serviceName; PujaMode get mode; DateTime get scheduledAt; double get amount; SankalpDetails get sankalp; DateTime get bookedAt; PujaBookingStatus get status; bool get withSamagri;/// The rail the devotee paid through. Core's [PaymentRail] rather
/// than another feature's payment enum — puja must not depend on
/// the appointment feature to describe money.
 PaymentRail? get paymentRail;/// Where the priest goes, for an at-home booking.
 String? get address;/// Live stream, available shortly before a temple puja begins.
 String? get streamUrl;/// Photos and the recording, delivered after the ritual.
 List<String> get prasadPhotos; String? get recordingUrl; String? get priestName; String? get cancellationReason;
/// Create a copy of PujaBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PujaBookingCopyWith<PujaBooking> get copyWith => _$PujaBookingCopyWithImpl<PujaBooking>(this as PujaBooking, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PujaBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.sankalp, sankalp) || other.sankalp == sankalp)&&(identical(other.bookedAt, bookedAt) || other.bookedAt == bookedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.withSamagri, withSamagri) || other.withSamagri == withSamagri)&&(identical(other.paymentRail, paymentRail) || other.paymentRail == paymentRail)&&(identical(other.address, address) || other.address == address)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&const DeepCollectionEquality().equals(other.prasadPhotos, prasadPhotos)&&(identical(other.recordingUrl, recordingUrl) || other.recordingUrl == recordingUrl)&&(identical(other.priestName, priestName) || other.priestName == priestName)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason));
}


@override
int get hashCode => Object.hash(runtimeType,id,serviceId,serviceName,mode,scheduledAt,amount,sankalp,bookedAt,status,withSamagri,paymentRail,address,streamUrl,const DeepCollectionEquality().hash(prasadPhotos),recordingUrl,priestName,cancellationReason);

@override
String toString() {
  return 'PujaBooking(id: $id, serviceId: $serviceId, serviceName: $serviceName, mode: $mode, scheduledAt: $scheduledAt, amount: $amount, sankalp: $sankalp, bookedAt: $bookedAt, status: $status, withSamagri: $withSamagri, paymentRail: $paymentRail, address: $address, streamUrl: $streamUrl, prasadPhotos: $prasadPhotos, recordingUrl: $recordingUrl, priestName: $priestName, cancellationReason: $cancellationReason)';
}


}

/// @nodoc
abstract mixin class $PujaBookingCopyWith<$Res>  {
  factory $PujaBookingCopyWith(PujaBooking value, $Res Function(PujaBooking) _then) = _$PujaBookingCopyWithImpl;
@useResult
$Res call({
 String id, String serviceId, String serviceName, PujaMode mode, DateTime scheduledAt, double amount, SankalpDetails sankalp, DateTime bookedAt, PujaBookingStatus status, bool withSamagri, PaymentRail? paymentRail, String? address, String? streamUrl, List<String> prasadPhotos, String? recordingUrl, String? priestName, String? cancellationReason
});


$SankalpDetailsCopyWith<$Res> get sankalp;

}
/// @nodoc
class _$PujaBookingCopyWithImpl<$Res>
    implements $PujaBookingCopyWith<$Res> {
  _$PujaBookingCopyWithImpl(this._self, this._then);

  final PujaBooking _self;
  final $Res Function(PujaBooking) _then;

/// Create a copy of PujaBooking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serviceId = null,Object? serviceName = null,Object? mode = null,Object? scheduledAt = null,Object? amount = null,Object? sankalp = null,Object? bookedAt = null,Object? status = null,Object? withSamagri = null,Object? paymentRail = freezed,Object? address = freezed,Object? streamUrl = freezed,Object? prasadPhotos = null,Object? recordingUrl = freezed,Object? priestName = freezed,Object? cancellationReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PujaMode,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,sankalp: null == sankalp ? _self.sankalp : sankalp // ignore: cast_nullable_to_non_nullable
as SankalpDetails,bookedAt: null == bookedAt ? _self.bookedAt : bookedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PujaBookingStatus,withSamagri: null == withSamagri ? _self.withSamagri : withSamagri // ignore: cast_nullable_to_non_nullable
as bool,paymentRail: freezed == paymentRail ? _self.paymentRail : paymentRail // ignore: cast_nullable_to_non_nullable
as PaymentRail?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,streamUrl: freezed == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String?,prasadPhotos: null == prasadPhotos ? _self.prasadPhotos : prasadPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,recordingUrl: freezed == recordingUrl ? _self.recordingUrl : recordingUrl // ignore: cast_nullable_to_non_nullable
as String?,priestName: freezed == priestName ? _self.priestName : priestName // ignore: cast_nullable_to_non_nullable
as String?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PujaBooking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SankalpDetailsCopyWith<$Res> get sankalp {
  
  return $SankalpDetailsCopyWith<$Res>(_self.sankalp, (value) {
    return _then(_self.copyWith(sankalp: value));
  });
}
}



/// @nodoc


class _PujaBooking extends PujaBooking {
  const _PujaBooking({required this.id, required this.serviceId, required this.serviceName, required this.mode, required this.scheduledAt, required this.amount, required this.sankalp, required this.bookedAt, this.status = PujaBookingStatus.pendingPayment, this.withSamagri = false, this.paymentRail, this.address, this.streamUrl, final  List<String> prasadPhotos = const <String>[], this.recordingUrl, this.priestName, this.cancellationReason}): _prasadPhotos = prasadPhotos,super._();
  

@override final  String id;
@override final  String serviceId;
@override final  String serviceName;
@override final  PujaMode mode;
@override final  DateTime scheduledAt;
@override final  double amount;
@override final  SankalpDetails sankalp;
@override final  DateTime bookedAt;
@override@JsonKey() final  PujaBookingStatus status;
@override@JsonKey() final  bool withSamagri;
/// The rail the devotee paid through. Core's [PaymentRail] rather
/// than another feature's payment enum — puja must not depend on
/// the appointment feature to describe money.
@override final  PaymentRail? paymentRail;
/// Where the priest goes, for an at-home booking.
@override final  String? address;
/// Live stream, available shortly before a temple puja begins.
@override final  String? streamUrl;
/// Photos and the recording, delivered after the ritual.
 final  List<String> _prasadPhotos;
/// Photos and the recording, delivered after the ritual.
@override@JsonKey() List<String> get prasadPhotos {
  if (_prasadPhotos is EqualUnmodifiableListView) return _prasadPhotos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prasadPhotos);
}

@override final  String? recordingUrl;
@override final  String? priestName;
@override final  String? cancellationReason;

/// Create a copy of PujaBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PujaBookingCopyWith<_PujaBooking> get copyWith => __$PujaBookingCopyWithImpl<_PujaBooking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PujaBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.sankalp, sankalp) || other.sankalp == sankalp)&&(identical(other.bookedAt, bookedAt) || other.bookedAt == bookedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.withSamagri, withSamagri) || other.withSamagri == withSamagri)&&(identical(other.paymentRail, paymentRail) || other.paymentRail == paymentRail)&&(identical(other.address, address) || other.address == address)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&const DeepCollectionEquality().equals(other._prasadPhotos, _prasadPhotos)&&(identical(other.recordingUrl, recordingUrl) || other.recordingUrl == recordingUrl)&&(identical(other.priestName, priestName) || other.priestName == priestName)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason));
}


@override
int get hashCode => Object.hash(runtimeType,id,serviceId,serviceName,mode,scheduledAt,amount,sankalp,bookedAt,status,withSamagri,paymentRail,address,streamUrl,const DeepCollectionEquality().hash(_prasadPhotos),recordingUrl,priestName,cancellationReason);

@override
String toString() {
  return 'PujaBooking(id: $id, serviceId: $serviceId, serviceName: $serviceName, mode: $mode, scheduledAt: $scheduledAt, amount: $amount, sankalp: $sankalp, bookedAt: $bookedAt, status: $status, withSamagri: $withSamagri, paymentRail: $paymentRail, address: $address, streamUrl: $streamUrl, prasadPhotos: $prasadPhotos, recordingUrl: $recordingUrl, priestName: $priestName, cancellationReason: $cancellationReason)';
}


}

/// @nodoc
abstract mixin class _$PujaBookingCopyWith<$Res> implements $PujaBookingCopyWith<$Res> {
  factory _$PujaBookingCopyWith(_PujaBooking value, $Res Function(_PujaBooking) _then) = __$PujaBookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String serviceId, String serviceName, PujaMode mode, DateTime scheduledAt, double amount, SankalpDetails sankalp, DateTime bookedAt, PujaBookingStatus status, bool withSamagri, PaymentRail? paymentRail, String? address, String? streamUrl, List<String> prasadPhotos, String? recordingUrl, String? priestName, String? cancellationReason
});


@override $SankalpDetailsCopyWith<$Res> get sankalp;

}
/// @nodoc
class __$PujaBookingCopyWithImpl<$Res>
    implements _$PujaBookingCopyWith<$Res> {
  __$PujaBookingCopyWithImpl(this._self, this._then);

  final _PujaBooking _self;
  final $Res Function(_PujaBooking) _then;

/// Create a copy of PujaBooking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serviceId = null,Object? serviceName = null,Object? mode = null,Object? scheduledAt = null,Object? amount = null,Object? sankalp = null,Object? bookedAt = null,Object? status = null,Object? withSamagri = null,Object? paymentRail = freezed,Object? address = freezed,Object? streamUrl = freezed,Object? prasadPhotos = null,Object? recordingUrl = freezed,Object? priestName = freezed,Object? cancellationReason = freezed,}) {
  return _then(_PujaBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PujaMode,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,sankalp: null == sankalp ? _self.sankalp : sankalp // ignore: cast_nullable_to_non_nullable
as SankalpDetails,bookedAt: null == bookedAt ? _self.bookedAt : bookedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PujaBookingStatus,withSamagri: null == withSamagri ? _self.withSamagri : withSamagri // ignore: cast_nullable_to_non_nullable
as bool,paymentRail: freezed == paymentRail ? _self.paymentRail : paymentRail // ignore: cast_nullable_to_non_nullable
as PaymentRail?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,streamUrl: freezed == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String?,prasadPhotos: null == prasadPhotos ? _self._prasadPhotos : prasadPhotos // ignore: cast_nullable_to_non_nullable
as List<String>,recordingUrl: freezed == recordingUrl ? _self.recordingUrl : recordingUrl // ignore: cast_nullable_to_non_nullable
as String?,priestName: freezed == priestName ? _self.priestName : priestName // ignore: cast_nullable_to_non_nullable
as String?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PujaBooking
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SankalpDetailsCopyWith<$Res> get sankalp {
  
  return $SankalpDetailsCopyWith<$Res>(_self.sankalp, (value) {
    return _then(_self.copyWith(sankalp: value));
  });
}
}

// dart format on
