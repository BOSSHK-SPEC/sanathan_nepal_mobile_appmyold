// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_window.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimeWindow {

 TimeWindowKind get kind; DateTime get start; DateTime get end;/// Segment name (Choghadiya: अमृत / Amrit …). Empty for kaal windows whose
/// label comes from [kind].
 String get nameNe; String get nameEn; ChoghadiyaQuality get quality;
/// Create a copy of TimeWindow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeWindowCopyWith<TimeWindow> get copyWith => _$TimeWindowCopyWithImpl<TimeWindow>(this as TimeWindow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeWindow&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.quality, quality) || other.quality == quality));
}


@override
int get hashCode => Object.hash(runtimeType,kind,start,end,nameNe,nameEn,quality);

@override
String toString() {
  return 'TimeWindow(kind: $kind, start: $start, end: $end, nameNe: $nameNe, nameEn: $nameEn, quality: $quality)';
}


}

/// @nodoc
abstract mixin class $TimeWindowCopyWith<$Res>  {
  factory $TimeWindowCopyWith(TimeWindow value, $Res Function(TimeWindow) _then) = _$TimeWindowCopyWithImpl;
@useResult
$Res call({
 TimeWindowKind kind, DateTime start, DateTime end, String nameNe, String nameEn, ChoghadiyaQuality quality
});




}
/// @nodoc
class _$TimeWindowCopyWithImpl<$Res>
    implements $TimeWindowCopyWith<$Res> {
  _$TimeWindowCopyWithImpl(this._self, this._then);

  final TimeWindow _self;
  final $Res Function(TimeWindow) _then;

/// Create a copy of TimeWindow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? start = null,Object? end = null,Object? nameNe = null,Object? nameEn = null,Object? quality = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TimeWindowKind,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as ChoghadiyaQuality,
  ));
}

}



/// @nodoc


class _TimeWindow extends TimeWindow {
  const _TimeWindow({required this.kind, required this.start, required this.end, this.nameNe = '', this.nameEn = '', this.quality = ChoghadiyaQuality.neutral}): super._();
  

@override final  TimeWindowKind kind;
@override final  DateTime start;
@override final  DateTime end;
/// Segment name (Choghadiya: अमृत / Amrit …). Empty for kaal windows whose
/// label comes from [kind].
@override@JsonKey() final  String nameNe;
@override@JsonKey() final  String nameEn;
@override@JsonKey() final  ChoghadiyaQuality quality;

/// Create a copy of TimeWindow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeWindowCopyWith<_TimeWindow> get copyWith => __$TimeWindowCopyWithImpl<_TimeWindow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeWindow&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.quality, quality) || other.quality == quality));
}


@override
int get hashCode => Object.hash(runtimeType,kind,start,end,nameNe,nameEn,quality);

@override
String toString() {
  return 'TimeWindow(kind: $kind, start: $start, end: $end, nameNe: $nameNe, nameEn: $nameEn, quality: $quality)';
}


}

/// @nodoc
abstract mixin class _$TimeWindowCopyWith<$Res> implements $TimeWindowCopyWith<$Res> {
  factory _$TimeWindowCopyWith(_TimeWindow value, $Res Function(_TimeWindow) _then) = __$TimeWindowCopyWithImpl;
@override @useResult
$Res call({
 TimeWindowKind kind, DateTime start, DateTime end, String nameNe, String nameEn, ChoghadiyaQuality quality
});




}
/// @nodoc
class __$TimeWindowCopyWithImpl<$Res>
    implements _$TimeWindowCopyWith<$Res> {
  __$TimeWindowCopyWithImpl(this._self, this._then);

  final _TimeWindow _self;
  final $Res Function(_TimeWindow) _then;

/// Create a copy of TimeWindow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? start = null,Object? end = null,Object? nameNe = null,Object? nameEn = null,Object? quality = null,}) {
  return _then(_TimeWindow(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as TimeWindowKind,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as ChoghadiyaQuality,
  ));
}


}

// dart format on
