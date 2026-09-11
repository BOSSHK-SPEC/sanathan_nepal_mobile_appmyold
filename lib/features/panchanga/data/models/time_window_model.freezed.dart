// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_window_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeWindowModel {

@JsonKey(unknownEnumValue: TimeWindowKind.choghadiya) TimeWindowKind get kind; DateTime get start; DateTime get end; String get nameNe; String get nameEn;@JsonKey(unknownEnumValue: ChoghadiyaQuality.neutral) ChoghadiyaQuality get quality;
/// Create a copy of TimeWindowModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeWindowModelCopyWith<TimeWindowModel> get copyWith => _$TimeWindowModelCopyWithImpl<TimeWindowModel>(this as TimeWindowModel, _$identity);

  /// Serializes this TimeWindowModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeWindowModel&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.quality, quality) || other.quality == quality));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,start,end,nameNe,nameEn,quality);

@override
String toString() {
  return 'TimeWindowModel(kind: $kind, start: $start, end: $end, nameNe: $nameNe, nameEn: $nameEn, quality: $quality)';
}


}

/// @nodoc
abstract mixin class $TimeWindowModelCopyWith<$Res>  {
  factory $TimeWindowModelCopyWith(TimeWindowModel value, $Res Function(TimeWindowModel) _then) = _$TimeWindowModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: TimeWindowKind.choghadiya) TimeWindowKind kind, DateTime start, DateTime end, String nameNe, String nameEn,@JsonKey(unknownEnumValue: ChoghadiyaQuality.neutral) ChoghadiyaQuality quality
});




}
/// @nodoc
class _$TimeWindowModelCopyWithImpl<$Res>
    implements $TimeWindowModelCopyWith<$Res> {
  _$TimeWindowModelCopyWithImpl(this._self, this._then);

  final TimeWindowModel _self;
  final $Res Function(TimeWindowModel) _then;

/// Create a copy of TimeWindowModel
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
@JsonSerializable()

class _TimeWindowModel extends TimeWindowModel {
  const _TimeWindowModel({@JsonKey(unknownEnumValue: TimeWindowKind.choghadiya) this.kind = TimeWindowKind.choghadiya, required this.start, required this.end, this.nameNe = '', this.nameEn = '', @JsonKey(unknownEnumValue: ChoghadiyaQuality.neutral) this.quality = ChoghadiyaQuality.neutral}): super._();
  factory _TimeWindowModel.fromJson(Map<String, dynamic> json) => _$TimeWindowModelFromJson(json);

@override@JsonKey(unknownEnumValue: TimeWindowKind.choghadiya) final  TimeWindowKind kind;
@override final  DateTime start;
@override final  DateTime end;
@override@JsonKey() final  String nameNe;
@override@JsonKey() final  String nameEn;
@override@JsonKey(unknownEnumValue: ChoghadiyaQuality.neutral) final  ChoghadiyaQuality quality;

/// Create a copy of TimeWindowModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeWindowModelCopyWith<_TimeWindowModel> get copyWith => __$TimeWindowModelCopyWithImpl<_TimeWindowModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeWindowModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeWindowModel&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.quality, quality) || other.quality == quality));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,start,end,nameNe,nameEn,quality);

@override
String toString() {
  return 'TimeWindowModel(kind: $kind, start: $start, end: $end, nameNe: $nameNe, nameEn: $nameEn, quality: $quality)';
}


}

/// @nodoc
abstract mixin class _$TimeWindowModelCopyWith<$Res> implements $TimeWindowModelCopyWith<$Res> {
  factory _$TimeWindowModelCopyWith(_TimeWindowModel value, $Res Function(_TimeWindowModel) _then) = __$TimeWindowModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: TimeWindowKind.choghadiya) TimeWindowKind kind, DateTime start, DateTime end, String nameNe, String nameEn,@JsonKey(unknownEnumValue: ChoghadiyaQuality.neutral) ChoghadiyaQuality quality
});




}
/// @nodoc
class __$TimeWindowModelCopyWithImpl<$Res>
    implements _$TimeWindowModelCopyWith<$Res> {
  __$TimeWindowModelCopyWithImpl(this._self, this._then);

  final _TimeWindowModel _self;
  final $Res Function(_TimeWindowModel) _then;

/// Create a copy of TimeWindowModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? start = null,Object? end = null,Object? nameNe = null,Object? nameEn = null,Object? quality = null,}) {
  return _then(_TimeWindowModel(
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
