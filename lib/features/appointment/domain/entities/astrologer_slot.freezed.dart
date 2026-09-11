// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AstrologerSlot {

 String get id; DateTime get startsAt; DateTime get endsAt; bool get available;
/// Create a copy of AstrologerSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerSlotCopyWith<AstrologerSlot> get copyWith => _$AstrologerSlotCopyWithImpl<AstrologerSlot>(this as AstrologerSlot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.available, available) || other.available == available));
}


@override
int get hashCode => Object.hash(runtimeType,id,startsAt,endsAt,available);

@override
String toString() {
  return 'AstrologerSlot(id: $id, startsAt: $startsAt, endsAt: $endsAt, available: $available)';
}


}

/// @nodoc
abstract mixin class $AstrologerSlotCopyWith<$Res>  {
  factory $AstrologerSlotCopyWith(AstrologerSlot value, $Res Function(AstrologerSlot) _then) = _$AstrologerSlotCopyWithImpl;
@useResult
$Res call({
 String id, DateTime startsAt, DateTime endsAt, bool available
});




}
/// @nodoc
class _$AstrologerSlotCopyWithImpl<$Res>
    implements $AstrologerSlotCopyWith<$Res> {
  _$AstrologerSlotCopyWithImpl(this._self, this._then);

  final AstrologerSlot _self;
  final $Res Function(AstrologerSlot) _then;

/// Create a copy of AstrologerSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startsAt = null,Object? endsAt = null,Object? available = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _AstrologerSlot extends AstrologerSlot {
  const _AstrologerSlot({required this.id, required this.startsAt, required this.endsAt, this.available = true}): super._();
  

@override final  String id;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override@JsonKey() final  bool available;

/// Create a copy of AstrologerSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerSlotCopyWith<_AstrologerSlot> get copyWith => __$AstrologerSlotCopyWithImpl<_AstrologerSlot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.available, available) || other.available == available));
}


@override
int get hashCode => Object.hash(runtimeType,id,startsAt,endsAt,available);

@override
String toString() {
  return 'AstrologerSlot(id: $id, startsAt: $startsAt, endsAt: $endsAt, available: $available)';
}


}

/// @nodoc
abstract mixin class _$AstrologerSlotCopyWith<$Res> implements $AstrologerSlotCopyWith<$Res> {
  factory _$AstrologerSlotCopyWith(_AstrologerSlot value, $Res Function(_AstrologerSlot) _then) = __$AstrologerSlotCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime startsAt, DateTime endsAt, bool available
});




}
/// @nodoc
class __$AstrologerSlotCopyWithImpl<$Res>
    implements _$AstrologerSlotCopyWith<$Res> {
  __$AstrologerSlotCopyWithImpl(this._self, this._then);

  final _AstrologerSlot _self;
  final $Res Function(_AstrologerSlot) _then;

/// Create a copy of AstrologerSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startsAt = null,Object? endsAt = null,Object? available = null,}) {
  return _then(_AstrologerSlot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
