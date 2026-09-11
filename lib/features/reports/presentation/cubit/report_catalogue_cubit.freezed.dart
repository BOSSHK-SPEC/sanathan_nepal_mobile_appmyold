// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_catalogue_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportCatalogueState {

 LoadState<List<ReportProduct>> get products;
/// Create a copy of ReportCatalogueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportCatalogueStateCopyWith<ReportCatalogueState> get copyWith => _$ReportCatalogueStateCopyWithImpl<ReportCatalogueState>(this as ReportCatalogueState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportCatalogueState&&(identical(other.products, products) || other.products == products));
}


@override
int get hashCode => Object.hash(runtimeType,products);

@override
String toString() {
  return 'ReportCatalogueState(products: $products)';
}


}

/// @nodoc
abstract mixin class $ReportCatalogueStateCopyWith<$Res>  {
  factory $ReportCatalogueStateCopyWith(ReportCatalogueState value, $Res Function(ReportCatalogueState) _then) = _$ReportCatalogueStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<ReportProduct>> products
});


$LoadStateCopyWith<List<ReportProduct>, $Res> get products;

}
/// @nodoc
class _$ReportCatalogueStateCopyWithImpl<$Res>
    implements $ReportCatalogueStateCopyWith<$Res> {
  _$ReportCatalogueStateCopyWithImpl(this._self, this._then);

  final ReportCatalogueState _self;
  final $Res Function(ReportCatalogueState) _then;

/// Create a copy of ReportCatalogueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,}) {
  return _then(_self.copyWith(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as LoadState<List<ReportProduct>>,
  ));
}
/// Create a copy of ReportCatalogueState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ReportProduct>, $Res> get products {
  
  return $LoadStateCopyWith<List<ReportProduct>, $Res>(_self.products, (value) {
    return _then(_self.copyWith(products: value));
  });
}
}



/// @nodoc


class _ReportCatalogueState extends ReportCatalogueState {
  const _ReportCatalogueState({this.products = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<List<ReportProduct>> products;

/// Create a copy of ReportCatalogueState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportCatalogueStateCopyWith<_ReportCatalogueState> get copyWith => __$ReportCatalogueStateCopyWithImpl<_ReportCatalogueState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportCatalogueState&&(identical(other.products, products) || other.products == products));
}


@override
int get hashCode => Object.hash(runtimeType,products);

@override
String toString() {
  return 'ReportCatalogueState(products: $products)';
}


}

/// @nodoc
abstract mixin class _$ReportCatalogueStateCopyWith<$Res> implements $ReportCatalogueStateCopyWith<$Res> {
  factory _$ReportCatalogueStateCopyWith(_ReportCatalogueState value, $Res Function(_ReportCatalogueState) _then) = __$ReportCatalogueStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<ReportProduct>> products
});


@override $LoadStateCopyWith<List<ReportProduct>, $Res> get products;

}
/// @nodoc
class __$ReportCatalogueStateCopyWithImpl<$Res>
    implements _$ReportCatalogueStateCopyWith<$Res> {
  __$ReportCatalogueStateCopyWithImpl(this._self, this._then);

  final _ReportCatalogueState _self;
  final $Res Function(_ReportCatalogueState) _then;

/// Create a copy of ReportCatalogueState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,}) {
  return _then(_ReportCatalogueState(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as LoadState<List<ReportProduct>>,
  ));
}

/// Create a copy of ReportCatalogueState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ReportProduct>, $Res> get products {
  
  return $LoadStateCopyWith<List<ReportProduct>, $Res>(_self.products, (value) {
    return _then(_self.copyWith(products: value));
  });
}
}

// dart format on
