// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateProductParams {

 String get id; ProductDraft get draft;
/// Create a copy of UpdateProductParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProductParamsCopyWith<UpdateProductParams> get copyWith => _$UpdateProductParamsCopyWithImpl<UpdateProductParams>(this as UpdateProductParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProductParams&&(identical(other.id, id) || other.id == id)&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,id,draft);

@override
String toString() {
  return 'UpdateProductParams(id: $id, draft: $draft)';
}


}

/// @nodoc
abstract mixin class $UpdateProductParamsCopyWith<$Res>  {
  factory $UpdateProductParamsCopyWith(UpdateProductParams value, $Res Function(UpdateProductParams) _then) = _$UpdateProductParamsCopyWithImpl;
@useResult
$Res call({
 String id, ProductDraft draft
});


$ProductDraftCopyWith<$Res> get draft;

}
/// @nodoc
class _$UpdateProductParamsCopyWithImpl<$Res>
    implements $UpdateProductParamsCopyWith<$Res> {
  _$UpdateProductParamsCopyWithImpl(this._self, this._then);

  final UpdateProductParams _self;
  final $Res Function(UpdateProductParams) _then;

/// Create a copy of UpdateProductParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? draft = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ProductDraft,
  ));
}
/// Create a copy of UpdateProductParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDraftCopyWith<$Res> get draft {
  
  return $ProductDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}



/// @nodoc


class _UpdateProductParams implements UpdateProductParams {
  const _UpdateProductParams({required this.id, required this.draft});
  

@override final  String id;
@override final  ProductDraft draft;

/// Create a copy of UpdateProductParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateProductParamsCopyWith<_UpdateProductParams> get copyWith => __$UpdateProductParamsCopyWithImpl<_UpdateProductParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateProductParams&&(identical(other.id, id) || other.id == id)&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,id,draft);

@override
String toString() {
  return 'UpdateProductParams(id: $id, draft: $draft)';
}


}

/// @nodoc
abstract mixin class _$UpdateProductParamsCopyWith<$Res> implements $UpdateProductParamsCopyWith<$Res> {
  factory _$UpdateProductParamsCopyWith(_UpdateProductParams value, $Res Function(_UpdateProductParams) _then) = __$UpdateProductParamsCopyWithImpl;
@override @useResult
$Res call({
 String id, ProductDraft draft
});


@override $ProductDraftCopyWith<$Res> get draft;

}
/// @nodoc
class __$UpdateProductParamsCopyWithImpl<$Res>
    implements _$UpdateProductParamsCopyWith<$Res> {
  __$UpdateProductParamsCopyWithImpl(this._self, this._then);

  final _UpdateProductParams _self;
  final $Res Function(_UpdateProductParams) _then;

/// Create a copy of UpdateProductParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? draft = null,}) {
  return _then(_UpdateProductParams(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ProductDraft,
  ));
}

/// Create a copy of UpdateProductParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductDraftCopyWith<$Res> get draft {
  
  return $ProductDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
