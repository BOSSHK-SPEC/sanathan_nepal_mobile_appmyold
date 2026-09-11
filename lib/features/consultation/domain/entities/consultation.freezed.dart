// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consultation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Consultation {

 String get id; String get astrologerId; LocalizedText get astrologerName; ConsultChannel get channel; ConsultationStatus get status; double get ratePerMinute; DateTime get createdAt; String? get astrologerAvatar;/// What the seeker wants to ask, captured at intake.
 String get question;/// Set when the astrologer accepts and billing starts.
 DateTime? get startedAt; DateTime? get endedAt;/// Billed seconds, fixed at the end so the receipt cannot drift.
 int get billedSeconds; double get amountCharged;/// People ahead at the moment the session was created.
///
/// Stored as-is for the whole life of the session; screens receive a
/// copy carrying the *remaining* count, so nothing derived from the
/// original position is lost as the queue drains.
 int get queuePosition;
/// Create a copy of Consultation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsultationCopyWith<Consultation> get copyWith => _$ConsultationCopyWithImpl<Consultation>(this as Consultation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Consultation&&(identical(other.id, id) || other.id == id)&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.astrologerName, astrologerName) || other.astrologerName == astrologerName)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.status, status) || other.status == status)&&(identical(other.ratePerMinute, ratePerMinute) || other.ratePerMinute == ratePerMinute)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.astrologerAvatar, astrologerAvatar) || other.astrologerAvatar == astrologerAvatar)&&(identical(other.question, question) || other.question == question)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.billedSeconds, billedSeconds) || other.billedSeconds == billedSeconds)&&(identical(other.amountCharged, amountCharged) || other.amountCharged == amountCharged)&&(identical(other.queuePosition, queuePosition) || other.queuePosition == queuePosition));
}


@override
int get hashCode => Object.hash(runtimeType,id,astrologerId,astrologerName,channel,status,ratePerMinute,createdAt,astrologerAvatar,question,startedAt,endedAt,billedSeconds,amountCharged,queuePosition);

@override
String toString() {
  return 'Consultation(id: $id, astrologerId: $astrologerId, astrologerName: $astrologerName, channel: $channel, status: $status, ratePerMinute: $ratePerMinute, createdAt: $createdAt, astrologerAvatar: $astrologerAvatar, question: $question, startedAt: $startedAt, endedAt: $endedAt, billedSeconds: $billedSeconds, amountCharged: $amountCharged, queuePosition: $queuePosition)';
}


}

/// @nodoc
abstract mixin class $ConsultationCopyWith<$Res>  {
  factory $ConsultationCopyWith(Consultation value, $Res Function(Consultation) _then) = _$ConsultationCopyWithImpl;
@useResult
$Res call({
 String id, String astrologerId, LocalizedText astrologerName, ConsultChannel channel, ConsultationStatus status, double ratePerMinute, DateTime createdAt, String? astrologerAvatar, String question, DateTime? startedAt, DateTime? endedAt, int billedSeconds, double amountCharged, int queuePosition
});


$LocalizedTextCopyWith<$Res> get astrologerName;

}
/// @nodoc
class _$ConsultationCopyWithImpl<$Res>
    implements $ConsultationCopyWith<$Res> {
  _$ConsultationCopyWithImpl(this._self, this._then);

  final Consultation _self;
  final $Res Function(Consultation) _then;

/// Create a copy of Consultation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? astrologerId = null,Object? astrologerName = null,Object? channel = null,Object? status = null,Object? ratePerMinute = null,Object? createdAt = null,Object? astrologerAvatar = freezed,Object? question = null,Object? startedAt = freezed,Object? endedAt = freezed,Object? billedSeconds = null,Object? amountCharged = null,Object? queuePosition = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,astrologerName: null == astrologerName ? _self.astrologerName : astrologerName // ignore: cast_nullable_to_non_nullable
as LocalizedText,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ConsultChannel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ConsultationStatus,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,astrologerAvatar: freezed == astrologerAvatar ? _self.astrologerAvatar : astrologerAvatar // ignore: cast_nullable_to_non_nullable
as String?,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,billedSeconds: null == billedSeconds ? _self.billedSeconds : billedSeconds // ignore: cast_nullable_to_non_nullable
as int,amountCharged: null == amountCharged ? _self.amountCharged : amountCharged // ignore: cast_nullable_to_non_nullable
as double,queuePosition: null == queuePosition ? _self.queuePosition : queuePosition // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Consultation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get astrologerName {
  
  return $LocalizedTextCopyWith<$Res>(_self.astrologerName, (value) {
    return _then(_self.copyWith(astrologerName: value));
  });
}
}



/// @nodoc


class _Consultation extends Consultation {
  const _Consultation({required this.id, required this.astrologerId, required this.astrologerName, required this.channel, required this.status, required this.ratePerMinute, required this.createdAt, this.astrologerAvatar, this.question = '', this.startedAt, this.endedAt, this.billedSeconds = 0, this.amountCharged = 0, this.queuePosition = 0}): super._();
  

@override final  String id;
@override final  String astrologerId;
@override final  LocalizedText astrologerName;
@override final  ConsultChannel channel;
@override final  ConsultationStatus status;
@override final  double ratePerMinute;
@override final  DateTime createdAt;
@override final  String? astrologerAvatar;
/// What the seeker wants to ask, captured at intake.
@override@JsonKey() final  String question;
/// Set when the astrologer accepts and billing starts.
@override final  DateTime? startedAt;
@override final  DateTime? endedAt;
/// Billed seconds, fixed at the end so the receipt cannot drift.
@override@JsonKey() final  int billedSeconds;
@override@JsonKey() final  double amountCharged;
/// People ahead at the moment the session was created.
///
/// Stored as-is for the whole life of the session; screens receive a
/// copy carrying the *remaining* count, so nothing derived from the
/// original position is lost as the queue drains.
@override@JsonKey() final  int queuePosition;

/// Create a copy of Consultation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsultationCopyWith<_Consultation> get copyWith => __$ConsultationCopyWithImpl<_Consultation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Consultation&&(identical(other.id, id) || other.id == id)&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.astrologerName, astrologerName) || other.astrologerName == astrologerName)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.status, status) || other.status == status)&&(identical(other.ratePerMinute, ratePerMinute) || other.ratePerMinute == ratePerMinute)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.astrologerAvatar, astrologerAvatar) || other.astrologerAvatar == astrologerAvatar)&&(identical(other.question, question) || other.question == question)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.billedSeconds, billedSeconds) || other.billedSeconds == billedSeconds)&&(identical(other.amountCharged, amountCharged) || other.amountCharged == amountCharged)&&(identical(other.queuePosition, queuePosition) || other.queuePosition == queuePosition));
}


@override
int get hashCode => Object.hash(runtimeType,id,astrologerId,astrologerName,channel,status,ratePerMinute,createdAt,astrologerAvatar,question,startedAt,endedAt,billedSeconds,amountCharged,queuePosition);

@override
String toString() {
  return 'Consultation(id: $id, astrologerId: $astrologerId, astrologerName: $astrologerName, channel: $channel, status: $status, ratePerMinute: $ratePerMinute, createdAt: $createdAt, astrologerAvatar: $astrologerAvatar, question: $question, startedAt: $startedAt, endedAt: $endedAt, billedSeconds: $billedSeconds, amountCharged: $amountCharged, queuePosition: $queuePosition)';
}


}

/// @nodoc
abstract mixin class _$ConsultationCopyWith<$Res> implements $ConsultationCopyWith<$Res> {
  factory _$ConsultationCopyWith(_Consultation value, $Res Function(_Consultation) _then) = __$ConsultationCopyWithImpl;
@override @useResult
$Res call({
 String id, String astrologerId, LocalizedText astrologerName, ConsultChannel channel, ConsultationStatus status, double ratePerMinute, DateTime createdAt, String? astrologerAvatar, String question, DateTime? startedAt, DateTime? endedAt, int billedSeconds, double amountCharged, int queuePosition
});


@override $LocalizedTextCopyWith<$Res> get astrologerName;

}
/// @nodoc
class __$ConsultationCopyWithImpl<$Res>
    implements _$ConsultationCopyWith<$Res> {
  __$ConsultationCopyWithImpl(this._self, this._then);

  final _Consultation _self;
  final $Res Function(_Consultation) _then;

/// Create a copy of Consultation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? astrologerId = null,Object? astrologerName = null,Object? channel = null,Object? status = null,Object? ratePerMinute = null,Object? createdAt = null,Object? astrologerAvatar = freezed,Object? question = null,Object? startedAt = freezed,Object? endedAt = freezed,Object? billedSeconds = null,Object? amountCharged = null,Object? queuePosition = null,}) {
  return _then(_Consultation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,astrologerName: null == astrologerName ? _self.astrologerName : astrologerName // ignore: cast_nullable_to_non_nullable
as LocalizedText,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ConsultChannel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ConsultationStatus,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,astrologerAvatar: freezed == astrologerAvatar ? _self.astrologerAvatar : astrologerAvatar // ignore: cast_nullable_to_non_nullable
as String?,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,billedSeconds: null == billedSeconds ? _self.billedSeconds : billedSeconds // ignore: cast_nullable_to_non_nullable
as int,amountCharged: null == amountCharged ? _self.amountCharged : amountCharged // ignore: cast_nullable_to_non_nullable
as double,queuePosition: null == queuePosition ? _self.queuePosition : queuePosition // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Consultation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get astrologerName {
  
  return $LocalizedTextCopyWith<$Res>(_self.astrologerName, (value) {
    return _then(_self.copyWith(astrologerName: value));
  });
}
}

// dart format on
