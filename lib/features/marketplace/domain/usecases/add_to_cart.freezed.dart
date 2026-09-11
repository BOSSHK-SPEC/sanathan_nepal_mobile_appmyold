// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_to_cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddToCartParams {

 Product get product; int get quantity; Map<String, String> get selectedOptions;
/// Create a copy of AddToCartParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddToCartParamsCopyWith<AddToCartParams> get copyWith => _$AddToCartParamsCopyWithImpl<AddToCartParams>(this as AddToCartParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddToCartParams&&(identical(other.product, product) || other.product == product)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&const DeepCollectionEquality().equals(other.selectedOptions, selectedOptions));
}


@override
int get hashCode => Object.hash(runtimeType,product,quantity,const DeepCollectionEquality().hash(selectedOptions));

@override
String toString() {
  return 'AddToCartParams(product: $product, quantity: $quantity, selectedOptions: $selectedOptions)';
}


}

/// @nodoc
abstract mixin class $AddToCartParamsCopyWith<$Res>  {
  factory $AddToCartParamsCopyWith(AddToCartParams value, $Res Function(AddToCartParams) _then) = _$AddToCartParamsCopyWithImpl;
@useResult
$Res call({
 Product product, int quantity, Map<String, String> selectedOptions
});


$ProductCopyWith<$Res> get product;

}
/// @nodoc
class _$AddToCartParamsCopyWithImpl<$Res>
    implements $AddToCartParamsCopyWith<$Res> {
  _$AddToCartParamsCopyWithImpl(this._self, this._then);

  final AddToCartParams _self;
  final $Res Function(AddToCartParams) _then;

/// Create a copy of AddToCartParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? product = null,Object? quantity = null,Object? selectedOptions = null,}) {
  return _then(_self.copyWith(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedOptions: null == selectedOptions ? _self.selectedOptions : selectedOptions // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}
/// Create a copy of AddToCartParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCopyWith<$Res> get product {
  
  return $ProductCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}



/// @nodoc


class _AddToCartParams implements AddToCartParams {
  const _AddToCartParams({required this.product, this.quantity = 1, final  Map<String, String> selectedOptions = const {}}): _selectedOptions = selectedOptions;
  

@override final  Product product;
@override@JsonKey() final  int quantity;
 final  Map<String, String> _selectedOptions;
@override@JsonKey() Map<String, String> get selectedOptions {
  if (_selectedOptions is EqualUnmodifiableMapView) return _selectedOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectedOptions);
}


/// Create a copy of AddToCartParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddToCartParamsCopyWith<_AddToCartParams> get copyWith => __$AddToCartParamsCopyWithImpl<_AddToCartParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddToCartParams&&(identical(other.product, product) || other.product == product)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&const DeepCollectionEquality().equals(other._selectedOptions, _selectedOptions));
}


@override
int get hashCode => Object.hash(runtimeType,product,quantity,const DeepCollectionEquality().hash(_selectedOptions));

@override
String toString() {
  return 'AddToCartParams(product: $product, quantity: $quantity, selectedOptions: $selectedOptions)';
}


}

/// @nodoc
abstract mixin class _$AddToCartParamsCopyWith<$Res> implements $AddToCartParamsCopyWith<$Res> {
  factory _$AddToCartParamsCopyWith(_AddToCartParams value, $Res Function(_AddToCartParams) _then) = __$AddToCartParamsCopyWithImpl;
@override @useResult
$Res call({
 Product product, int quantity, Map<String, String> selectedOptions
});


@override $ProductCopyWith<$Res> get product;

}
/// @nodoc
class __$AddToCartParamsCopyWithImpl<$Res>
    implements _$AddToCartParamsCopyWith<$Res> {
  __$AddToCartParamsCopyWithImpl(this._self, this._then);

  final _AddToCartParams _self;
  final $Res Function(_AddToCartParams) _then;

/// Create a copy of AddToCartParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? product = null,Object? quantity = null,Object? selectedOptions = null,}) {
  return _then(_AddToCartParams(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,selectedOptions: null == selectedOptions ? _self._selectedOptions : selectedOptions // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

/// Create a copy of AddToCartParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCopyWith<$Res> get product {
  
  return $ProductCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}

// dart format on
