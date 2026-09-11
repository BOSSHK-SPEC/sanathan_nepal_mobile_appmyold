// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SellerModel {

 String get id; String get name; String? get avatar; bool get verified; String? get phone; String? get handle;
/// Create a copy of SellerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerModelCopyWith<SellerModel> get copyWith => _$SellerModelCopyWithImpl<SellerModel>(this as SellerModel, _$identity);

  /// Serializes this SellerModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.handle, handle) || other.handle == handle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatar,verified,phone,handle);

@override
String toString() {
  return 'SellerModel(id: $id, name: $name, avatar: $avatar, verified: $verified, phone: $phone, handle: $handle)';
}


}

/// @nodoc
abstract mixin class $SellerModelCopyWith<$Res>  {
  factory $SellerModelCopyWith(SellerModel value, $Res Function(SellerModel) _then) = _$SellerModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? avatar, bool verified, String? phone, String? handle
});




}
/// @nodoc
class _$SellerModelCopyWithImpl<$Res>
    implements $SellerModelCopyWith<$Res> {
  _$SellerModelCopyWithImpl(this._self, this._then);

  final SellerModel _self;
  final $Res Function(SellerModel) _then;

/// Create a copy of SellerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? avatar = freezed,Object? verified = null,Object? phone = freezed,Object? handle = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _SellerModel extends SellerModel {
  const _SellerModel({required this.id, required this.name, this.avatar, this.verified = false, this.phone, this.handle}): super._();
  factory _SellerModel.fromJson(Map<String, dynamic> json) => _$SellerModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? avatar;
@override@JsonKey() final  bool verified;
@override final  String? phone;
@override final  String? handle;

/// Create a copy of SellerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerModelCopyWith<_SellerModel> get copyWith => __$SellerModelCopyWithImpl<_SellerModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SellerModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.handle, handle) || other.handle == handle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatar,verified,phone,handle);

@override
String toString() {
  return 'SellerModel(id: $id, name: $name, avatar: $avatar, verified: $verified, phone: $phone, handle: $handle)';
}


}

/// @nodoc
abstract mixin class _$SellerModelCopyWith<$Res> implements $SellerModelCopyWith<$Res> {
  factory _$SellerModelCopyWith(_SellerModel value, $Res Function(_SellerModel) _then) = __$SellerModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? avatar, bool verified, String? phone, String? handle
});




}
/// @nodoc
class __$SellerModelCopyWithImpl<$Res>
    implements _$SellerModelCopyWith<$Res> {
  __$SellerModelCopyWithImpl(this._self, this._then);

  final _SellerModel _self;
  final $Res Function(_SellerModel) _then;

/// Create a copy of SellerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatar = freezed,Object? verified = null,Object? phone = freezed,Object? handle = freezed,}) {
  return _then(_SellerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,handle: freezed == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
