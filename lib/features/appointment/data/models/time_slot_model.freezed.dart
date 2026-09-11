// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_slot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeSlotModel {

 String get id; int get hour; int get minute; bool get available;
/// Create a copy of TimeSlotModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeSlotModelCopyWith<TimeSlotModel> get copyWith => _$TimeSlotModelCopyWithImpl<TimeSlotModel>(this as TimeSlotModel, _$identity);

  /// Serializes this TimeSlotModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeSlotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,hour,minute,available);

@override
String toString() {
  return 'TimeSlotModel(id: $id, hour: $hour, minute: $minute, available: $available)';
}


}

/// @nodoc
abstract mixin class $TimeSlotModelCopyWith<$Res>  {
  factory $TimeSlotModelCopyWith(TimeSlotModel value, $Res Function(TimeSlotModel) _then) = _$TimeSlotModelCopyWithImpl;
@useResult
$Res call({
 String id, int hour, int minute, bool available
});




}
/// @nodoc
class _$TimeSlotModelCopyWithImpl<$Res>
    implements $TimeSlotModelCopyWith<$Res> {
  _$TimeSlotModelCopyWithImpl(this._self, this._then);

  final TimeSlotModel _self;
  final $Res Function(TimeSlotModel) _then;

/// Create a copy of TimeSlotModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? hour = null,Object? minute = null,Object? available = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _TimeSlotModel extends TimeSlotModel {
  const _TimeSlotModel({required this.id, required this.hour, this.minute = 0, this.available = true}): super._();
  factory _TimeSlotModel.fromJson(Map<String, dynamic> json) => _$TimeSlotModelFromJson(json);

@override final  String id;
@override final  int hour;
@override@JsonKey() final  int minute;
@override@JsonKey() final  bool available;

/// Create a copy of TimeSlotModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeSlotModelCopyWith<_TimeSlotModel> get copyWith => __$TimeSlotModelCopyWithImpl<_TimeSlotModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeSlotModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeSlotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,hour,minute,available);

@override
String toString() {
  return 'TimeSlotModel(id: $id, hour: $hour, minute: $minute, available: $available)';
}


}

/// @nodoc
abstract mixin class _$TimeSlotModelCopyWith<$Res> implements $TimeSlotModelCopyWith<$Res> {
  factory _$TimeSlotModelCopyWith(_TimeSlotModel value, $Res Function(_TimeSlotModel) _then) = __$TimeSlotModelCopyWithImpl;
@override @useResult
$Res call({
 String id, int hour, int minute, bool available
});




}
/// @nodoc
class __$TimeSlotModelCopyWithImpl<$Res>
    implements _$TimeSlotModelCopyWith<$Res> {
  __$TimeSlotModelCopyWithImpl(this._self, this._then);

  final _TimeSlotModel _self;
  final $Res Function(_TimeSlotModel) _then;

/// Create a copy of TimeSlotModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? hour = null,Object? minute = null,Object? available = null,}) {
  return _then(_TimeSlotModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
