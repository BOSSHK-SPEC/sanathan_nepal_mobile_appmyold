// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDetailsState {

 LoadState<Product> get product; LoadState<List<Product>> get similar; int get selectedImage; Map<String, String> get selectedOptions; DetailsTab get tab;/// Outcome of the last "Add to cart" / "Buy now" tap
/// (loading → loaded / failed).
 LoadState<Cart> get addToCart;/// True when the last add-to-cart came from "Buy now" – the page then
/// continues to checkout once it succeeds.
 bool get buyNow;
/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailsStateCopyWith<ProductDetailsState> get copyWith => _$ProductDetailsStateCopyWithImpl<ProductDetailsState>(this as ProductDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailsState&&(identical(other.product, product) || other.product == product)&&(identical(other.similar, similar) || other.similar == similar)&&(identical(other.selectedImage, selectedImage) || other.selectedImage == selectedImage)&&const DeepCollectionEquality().equals(other.selectedOptions, selectedOptions)&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.addToCart, addToCart) || other.addToCart == addToCart)&&(identical(other.buyNow, buyNow) || other.buyNow == buyNow));
}


@override
int get hashCode => Object.hash(runtimeType,product,similar,selectedImage,const DeepCollectionEquality().hash(selectedOptions),tab,addToCart,buyNow);

@override
String toString() {
  return 'ProductDetailsState(product: $product, similar: $similar, selectedImage: $selectedImage, selectedOptions: $selectedOptions, tab: $tab, addToCart: $addToCart, buyNow: $buyNow)';
}


}

/// @nodoc
abstract mixin class $ProductDetailsStateCopyWith<$Res>  {
  factory $ProductDetailsStateCopyWith(ProductDetailsState value, $Res Function(ProductDetailsState) _then) = _$ProductDetailsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Product> product, LoadState<List<Product>> similar, int selectedImage, Map<String, String> selectedOptions, DetailsTab tab, LoadState<Cart> addToCart, bool buyNow
});


$LoadStateCopyWith<Product, $Res> get product;$LoadStateCopyWith<List<Product>, $Res> get similar;$LoadStateCopyWith<Cart, $Res> get addToCart;

}
/// @nodoc
class _$ProductDetailsStateCopyWithImpl<$Res>
    implements $ProductDetailsStateCopyWith<$Res> {
  _$ProductDetailsStateCopyWithImpl(this._self, this._then);

  final ProductDetailsState _self;
  final $Res Function(ProductDetailsState) _then;

/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? product = null,Object? similar = null,Object? selectedImage = null,Object? selectedOptions = null,Object? tab = null,Object? addToCart = null,Object? buyNow = null,}) {
  return _then(_self.copyWith(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as LoadState<Product>,similar: null == similar ? _self.similar : similar // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,selectedImage: null == selectedImage ? _self.selectedImage : selectedImage // ignore: cast_nullable_to_non_nullable
as int,selectedOptions: null == selectedOptions ? _self.selectedOptions : selectedOptions // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as DetailsTab,addToCart: null == addToCart ? _self.addToCart : addToCart // ignore: cast_nullable_to_non_nullable
as LoadState<Cart>,buyNow: null == buyNow ? _self.buyNow : buyNow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Product, $Res> get product {
  
  return $LoadStateCopyWith<Product, $Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get similar {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.similar, (value) {
    return _then(_self.copyWith(similar: value));
  });
}/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Cart, $Res> get addToCart {
  
  return $LoadStateCopyWith<Cart, $Res>(_self.addToCart, (value) {
    return _then(_self.copyWith(addToCart: value));
  });
}
}



/// @nodoc


class _ProductDetailsState implements ProductDetailsState {
  const _ProductDetailsState({this.product = const LoadState.idle(), this.similar = const LoadState.idle(), this.selectedImage = 0, final  Map<String, String> selectedOptions = const {}, this.tab = DetailsTab.description, this.addToCart = const LoadState.idle(), this.buyNow = false}): _selectedOptions = selectedOptions;
  

@override@JsonKey() final  LoadState<Product> product;
@override@JsonKey() final  LoadState<List<Product>> similar;
@override@JsonKey() final  int selectedImage;
 final  Map<String, String> _selectedOptions;
@override@JsonKey() Map<String, String> get selectedOptions {
  if (_selectedOptions is EqualUnmodifiableMapView) return _selectedOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectedOptions);
}

@override@JsonKey() final  DetailsTab tab;
/// Outcome of the last "Add to cart" / "Buy now" tap
/// (loading → loaded / failed).
@override@JsonKey() final  LoadState<Cart> addToCart;
/// True when the last add-to-cart came from "Buy now" – the page then
/// continues to checkout once it succeeds.
@override@JsonKey() final  bool buyNow;

/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDetailsStateCopyWith<_ProductDetailsState> get copyWith => __$ProductDetailsStateCopyWithImpl<_ProductDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDetailsState&&(identical(other.product, product) || other.product == product)&&(identical(other.similar, similar) || other.similar == similar)&&(identical(other.selectedImage, selectedImage) || other.selectedImage == selectedImage)&&const DeepCollectionEquality().equals(other._selectedOptions, _selectedOptions)&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.addToCart, addToCart) || other.addToCart == addToCart)&&(identical(other.buyNow, buyNow) || other.buyNow == buyNow));
}


@override
int get hashCode => Object.hash(runtimeType,product,similar,selectedImage,const DeepCollectionEquality().hash(_selectedOptions),tab,addToCart,buyNow);

@override
String toString() {
  return 'ProductDetailsState(product: $product, similar: $similar, selectedImage: $selectedImage, selectedOptions: $selectedOptions, tab: $tab, addToCart: $addToCart, buyNow: $buyNow)';
}


}

/// @nodoc
abstract mixin class _$ProductDetailsStateCopyWith<$Res> implements $ProductDetailsStateCopyWith<$Res> {
  factory _$ProductDetailsStateCopyWith(_ProductDetailsState value, $Res Function(_ProductDetailsState) _then) = __$ProductDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Product> product, LoadState<List<Product>> similar, int selectedImage, Map<String, String> selectedOptions, DetailsTab tab, LoadState<Cart> addToCart, bool buyNow
});


@override $LoadStateCopyWith<Product, $Res> get product;@override $LoadStateCopyWith<List<Product>, $Res> get similar;@override $LoadStateCopyWith<Cart, $Res> get addToCart;

}
/// @nodoc
class __$ProductDetailsStateCopyWithImpl<$Res>
    implements _$ProductDetailsStateCopyWith<$Res> {
  __$ProductDetailsStateCopyWithImpl(this._self, this._then);

  final _ProductDetailsState _self;
  final $Res Function(_ProductDetailsState) _then;

/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? product = null,Object? similar = null,Object? selectedImage = null,Object? selectedOptions = null,Object? tab = null,Object? addToCart = null,Object? buyNow = null,}) {
  return _then(_ProductDetailsState(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as LoadState<Product>,similar: null == similar ? _self.similar : similar // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,selectedImage: null == selectedImage ? _self.selectedImage : selectedImage // ignore: cast_nullable_to_non_nullable
as int,selectedOptions: null == selectedOptions ? _self._selectedOptions : selectedOptions // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as DetailsTab,addToCart: null == addToCart ? _self.addToCart : addToCart // ignore: cast_nullable_to_non_nullable
as LoadState<Cart>,buyNow: null == buyNow ? _self.buyNow : buyNow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Product, $Res> get product {
  
  return $LoadStateCopyWith<Product, $Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get similar {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.similar, (value) {
    return _then(_self.copyWith(similar: value));
  });
}/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Cart, $Res> get addToCart {
  
  return $LoadStateCopyWith<Cart, $Res>(_self.addToCart, (value) {
    return _then(_self.copyWith(addToCart: value));
  });
}
}

// dart format on
