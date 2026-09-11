// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_listing_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductListingState {

 ProductFilter get filter; LoadState<List<Product>> get products; LoadState<List<Category>> get categories;
/// Create a copy of ProductListingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductListingStateCopyWith<ProductListingState> get copyWith => _$ProductListingStateCopyWithImpl<ProductListingState>(this as ProductListingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductListingState&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.products, products) || other.products == products)&&(identical(other.categories, categories) || other.categories == categories));
}


@override
int get hashCode => Object.hash(runtimeType,filter,products,categories);

@override
String toString() {
  return 'ProductListingState(filter: $filter, products: $products, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $ProductListingStateCopyWith<$Res>  {
  factory $ProductListingStateCopyWith(ProductListingState value, $Res Function(ProductListingState) _then) = _$ProductListingStateCopyWithImpl;
@useResult
$Res call({
 ProductFilter filter, LoadState<List<Product>> products, LoadState<List<Category>> categories
});


$ProductFilterCopyWith<$Res> get filter;$LoadStateCopyWith<List<Product>, $Res> get products;$LoadStateCopyWith<List<Category>, $Res> get categories;

}
/// @nodoc
class _$ProductListingStateCopyWithImpl<$Res>
    implements $ProductListingStateCopyWith<$Res> {
  _$ProductListingStateCopyWithImpl(this._self, this._then);

  final ProductListingState _self;
  final $Res Function(ProductListingState) _then;

/// Create a copy of ProductListingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filter = null,Object? products = null,Object? categories = null,}) {
  return _then(_self.copyWith(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ProductFilter,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as LoadState<List<Category>>,
  ));
}
/// Create a copy of ProductListingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductFilterCopyWith<$Res> get filter {
  
  return $ProductFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}/// Create a copy of ProductListingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get products {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.products, (value) {
    return _then(_self.copyWith(products: value));
  });
}/// Create a copy of ProductListingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Category>, $Res> get categories {
  
  return $LoadStateCopyWith<List<Category>, $Res>(_self.categories, (value) {
    return _then(_self.copyWith(categories: value));
  });
}
}



/// @nodoc


class _ProductListingState extends ProductListingState {
  const _ProductListingState({this.filter = const ProductFilter(), this.products = const LoadState.idle(), this.categories = const LoadState.idle()}): super._();
  

@override@JsonKey() final  ProductFilter filter;
@override@JsonKey() final  LoadState<List<Product>> products;
@override@JsonKey() final  LoadState<List<Category>> categories;

/// Create a copy of ProductListingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductListingStateCopyWith<_ProductListingState> get copyWith => __$ProductListingStateCopyWithImpl<_ProductListingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductListingState&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.products, products) || other.products == products)&&(identical(other.categories, categories) || other.categories == categories));
}


@override
int get hashCode => Object.hash(runtimeType,filter,products,categories);

@override
String toString() {
  return 'ProductListingState(filter: $filter, products: $products, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$ProductListingStateCopyWith<$Res> implements $ProductListingStateCopyWith<$Res> {
  factory _$ProductListingStateCopyWith(_ProductListingState value, $Res Function(_ProductListingState) _then) = __$ProductListingStateCopyWithImpl;
@override @useResult
$Res call({
 ProductFilter filter, LoadState<List<Product>> products, LoadState<List<Category>> categories
});


@override $ProductFilterCopyWith<$Res> get filter;@override $LoadStateCopyWith<List<Product>, $Res> get products;@override $LoadStateCopyWith<List<Category>, $Res> get categories;

}
/// @nodoc
class __$ProductListingStateCopyWithImpl<$Res>
    implements _$ProductListingStateCopyWith<$Res> {
  __$ProductListingStateCopyWithImpl(this._self, this._then);

  final _ProductListingState _self;
  final $Res Function(_ProductListingState) _then;

/// Create a copy of ProductListingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filter = null,Object? products = null,Object? categories = null,}) {
  return _then(_ProductListingState(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ProductFilter,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as LoadState<List<Category>>,
  ));
}

/// Create a copy of ProductListingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductFilterCopyWith<$Res> get filter {
  
  return $ProductFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}/// Create a copy of ProductListingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get products {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.products, (value) {
    return _then(_self.copyWith(products: value));
  });
}/// Create a copy of ProductListingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Category>, $Res> get categories {
  
  return $LoadStateCopyWith<List<Category>, $Res>(_self.categories, (value) {
    return _then(_self.copyWith(categories: value));
  });
}
}

// dart format on
