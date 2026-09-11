// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppointmentSummary {

 String get id; String get titleEn; String get titleNe; String get doctorName; String get serviceEn; String get serviceNe; DateTime get dateTime;
/// Create a copy of AppointmentSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentSummaryCopyWith<AppointmentSummary> get copyWith => _$AppointmentSummaryCopyWithImpl<AppointmentSummary>(this as AppointmentSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.doctorName, doctorName) || other.doctorName == doctorName)&&(identical(other.serviceEn, serviceEn) || other.serviceEn == serviceEn)&&(identical(other.serviceNe, serviceNe) || other.serviceNe == serviceNe)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,titleEn,titleNe,doctorName,serviceEn,serviceNe,dateTime);

@override
String toString() {
  return 'AppointmentSummary(id: $id, titleEn: $titleEn, titleNe: $titleNe, doctorName: $doctorName, serviceEn: $serviceEn, serviceNe: $serviceNe, dateTime: $dateTime)';
}


}

/// @nodoc
abstract mixin class $AppointmentSummaryCopyWith<$Res>  {
  factory $AppointmentSummaryCopyWith(AppointmentSummary value, $Res Function(AppointmentSummary) _then) = _$AppointmentSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String titleEn, String titleNe, String doctorName, String serviceEn, String serviceNe, DateTime dateTime
});




}
/// @nodoc
class _$AppointmentSummaryCopyWithImpl<$Res>
    implements $AppointmentSummaryCopyWith<$Res> {
  _$AppointmentSummaryCopyWithImpl(this._self, this._then);

  final AppointmentSummary _self;
  final $Res Function(AppointmentSummary) _then;

/// Create a copy of AppointmentSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleEn = null,Object? titleNe = null,Object? doctorName = null,Object? serviceEn = null,Object? serviceNe = null,Object? dateTime = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,doctorName: null == doctorName ? _self.doctorName : doctorName // ignore: cast_nullable_to_non_nullable
as String,serviceEn: null == serviceEn ? _self.serviceEn : serviceEn // ignore: cast_nullable_to_non_nullable
as String,serviceNe: null == serviceNe ? _self.serviceNe : serviceNe // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}



/// @nodoc


class _AppointmentSummary implements AppointmentSummary {
  const _AppointmentSummary({required this.id, required this.titleEn, required this.titleNe, required this.doctorName, required this.serviceEn, required this.serviceNe, required this.dateTime});
  

@override final  String id;
@override final  String titleEn;
@override final  String titleNe;
@override final  String doctorName;
@override final  String serviceEn;
@override final  String serviceNe;
@override final  DateTime dateTime;

/// Create a copy of AppointmentSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentSummaryCopyWith<_AppointmentSummary> get copyWith => __$AppointmentSummaryCopyWithImpl<_AppointmentSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.doctorName, doctorName) || other.doctorName == doctorName)&&(identical(other.serviceEn, serviceEn) || other.serviceEn == serviceEn)&&(identical(other.serviceNe, serviceNe) || other.serviceNe == serviceNe)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,titleEn,titleNe,doctorName,serviceEn,serviceNe,dateTime);

@override
String toString() {
  return 'AppointmentSummary(id: $id, titleEn: $titleEn, titleNe: $titleNe, doctorName: $doctorName, serviceEn: $serviceEn, serviceNe: $serviceNe, dateTime: $dateTime)';
}


}

/// @nodoc
abstract mixin class _$AppointmentSummaryCopyWith<$Res> implements $AppointmentSummaryCopyWith<$Res> {
  factory _$AppointmentSummaryCopyWith(_AppointmentSummary value, $Res Function(_AppointmentSummary) _then) = __$AppointmentSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleEn, String titleNe, String doctorName, String serviceEn, String serviceNe, DateTime dateTime
});




}
/// @nodoc
class __$AppointmentSummaryCopyWithImpl<$Res>
    implements _$AppointmentSummaryCopyWith<$Res> {
  __$AppointmentSummaryCopyWithImpl(this._self, this._then);

  final _AppointmentSummary _self;
  final $Res Function(_AppointmentSummary) _then;

/// Create a copy of AppointmentSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleEn = null,Object? titleNe = null,Object? doctorName = null,Object? serviceEn = null,Object? serviceNe = null,Object? dateTime = null,}) {
  return _then(_AppointmentSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,doctorName: null == doctorName ? _self.doctorName : doctorName // ignore: cast_nullable_to_non_nullable
as String,serviceEn: null == serviceEn ? _self.serviceEn : serviceEn // ignore: cast_nullable_to_non_nullable
as String,serviceNe: null == serviceNe ? _self.serviceNe : serviceNe // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
