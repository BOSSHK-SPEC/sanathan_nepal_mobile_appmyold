// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consult_intake.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsultIntake {

 String get astrologerId; ConsultChannel get channel; String get name;/// Gregorian date of birth.
 DateTime? get birthDate;/// Local time of birth; null when unknown.
 String? get birthTime; bool get birthTimeUnknown; String get birthPlace; String get question;
/// Create a copy of ConsultIntake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsultIntakeCopyWith<ConsultIntake> get copyWith => _$ConsultIntakeCopyWithImpl<ConsultIntake>(this as ConsultIntake, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsultIntake&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.name, name) || other.name == name)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.birthTimeUnknown, birthTimeUnknown) || other.birthTimeUnknown == birthTimeUnknown)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.question, question) || other.question == question));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,channel,name,birthDate,birthTime,birthTimeUnknown,birthPlace,question);

@override
String toString() {
  return 'ConsultIntake(astrologerId: $astrologerId, channel: $channel, name: $name, birthDate: $birthDate, birthTime: $birthTime, birthTimeUnknown: $birthTimeUnknown, birthPlace: $birthPlace, question: $question)';
}


}

/// @nodoc
abstract mixin class $ConsultIntakeCopyWith<$Res>  {
  factory $ConsultIntakeCopyWith(ConsultIntake value, $Res Function(ConsultIntake) _then) = _$ConsultIntakeCopyWithImpl;
@useResult
$Res call({
 String astrologerId, ConsultChannel channel, String name, DateTime? birthDate, String? birthTime, bool birthTimeUnknown, String birthPlace, String question
});




}
/// @nodoc
class _$ConsultIntakeCopyWithImpl<$Res>
    implements $ConsultIntakeCopyWith<$Res> {
  _$ConsultIntakeCopyWithImpl(this._self, this._then);

  final ConsultIntake _self;
  final $Res Function(ConsultIntake) _then;

/// Create a copy of ConsultIntake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? astrologerId = null,Object? channel = null,Object? name = null,Object? birthDate = freezed,Object? birthTime = freezed,Object? birthTimeUnknown = null,Object? birthPlace = null,Object? question = null,}) {
  return _then(_self.copyWith(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ConsultChannel,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,birthTimeUnknown: null == birthTimeUnknown ? _self.birthTimeUnknown : birthTimeUnknown // ignore: cast_nullable_to_non_nullable
as bool,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _ConsultIntake extends ConsultIntake {
  const _ConsultIntake({required this.astrologerId, required this.channel, this.name = '', this.birthDate, this.birthTime, this.birthTimeUnknown = false, this.birthPlace = '', this.question = ''}): super._();
  

@override final  String astrologerId;
@override final  ConsultChannel channel;
@override@JsonKey() final  String name;
/// Gregorian date of birth.
@override final  DateTime? birthDate;
/// Local time of birth; null when unknown.
@override final  String? birthTime;
@override@JsonKey() final  bool birthTimeUnknown;
@override@JsonKey() final  String birthPlace;
@override@JsonKey() final  String question;

/// Create a copy of ConsultIntake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsultIntakeCopyWith<_ConsultIntake> get copyWith => __$ConsultIntakeCopyWithImpl<_ConsultIntake>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsultIntake&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.name, name) || other.name == name)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.birthTimeUnknown, birthTimeUnknown) || other.birthTimeUnknown == birthTimeUnknown)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.question, question) || other.question == question));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,channel,name,birthDate,birthTime,birthTimeUnknown,birthPlace,question);

@override
String toString() {
  return 'ConsultIntake(astrologerId: $astrologerId, channel: $channel, name: $name, birthDate: $birthDate, birthTime: $birthTime, birthTimeUnknown: $birthTimeUnknown, birthPlace: $birthPlace, question: $question)';
}


}

/// @nodoc
abstract mixin class _$ConsultIntakeCopyWith<$Res> implements $ConsultIntakeCopyWith<$Res> {
  factory _$ConsultIntakeCopyWith(_ConsultIntake value, $Res Function(_ConsultIntake) _then) = __$ConsultIntakeCopyWithImpl;
@override @useResult
$Res call({
 String astrologerId, ConsultChannel channel, String name, DateTime? birthDate, String? birthTime, bool birthTimeUnknown, String birthPlace, String question
});




}
/// @nodoc
class __$ConsultIntakeCopyWithImpl<$Res>
    implements _$ConsultIntakeCopyWith<$Res> {
  __$ConsultIntakeCopyWithImpl(this._self, this._then);

  final _ConsultIntake _self;
  final $Res Function(_ConsultIntake) _then;

/// Create a copy of ConsultIntake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? astrologerId = null,Object? channel = null,Object? name = null,Object? birthDate = freezed,Object? birthTime = freezed,Object? birthTimeUnknown = null,Object? birthPlace = null,Object? question = null,}) {
  return _then(_ConsultIntake(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ConsultChannel,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,birthTimeUnknown: null == birthTimeUnknown ? _self.birthTimeUnknown : birthTimeUnknown // ignore: cast_nullable_to_non_nullable
as bool,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
