// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favourite_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavouriteProduct {

 String get id; String get name; String get description;/// e.g. `रु. 10,000 - 20,000` / `₹8,000 - ₹16,000` (region currency).
 String get priceLabel;/// e.g. `Brand New`.
 String get condition; String get sellerName; String get location; int get views; int get sold;/// 0–5.
 double get rating; DateTime get postedAt; String? get imageUrl;
/// Create a copy of FavouriteProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavouriteProductCopyWith<FavouriteProduct> get copyWith => _$FavouriteProductCopyWithImpl<FavouriteProduct>(this as FavouriteProduct, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavouriteProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceLabel, priceLabel) || other.priceLabel == priceLabel)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.location, location) || other.location == location)&&(identical(other.views, views) || other.views == views)&&(identical(other.sold, sold) || other.sold == sold)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,priceLabel,condition,sellerName,location,views,sold,rating,postedAt,imageUrl);

@override
String toString() {
  return 'FavouriteProduct(id: $id, name: $name, description: $description, priceLabel: $priceLabel, condition: $condition, sellerName: $sellerName, location: $location, views: $views, sold: $sold, rating: $rating, postedAt: $postedAt, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $FavouriteProductCopyWith<$Res>  {
  factory $FavouriteProductCopyWith(FavouriteProduct value, $Res Function(FavouriteProduct) _then) = _$FavouriteProductCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String priceLabel, String condition, String sellerName, String location, int views, int sold, double rating, DateTime postedAt, String? imageUrl
});




}
/// @nodoc
class _$FavouriteProductCopyWithImpl<$Res>
    implements $FavouriteProductCopyWith<$Res> {
  _$FavouriteProductCopyWithImpl(this._self, this._then);

  final FavouriteProduct _self;
  final $Res Function(FavouriteProduct) _then;

/// Create a copy of FavouriteProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? priceLabel = null,Object? condition = null,Object? sellerName = null,Object? location = null,Object? views = null,Object? sold = null,Object? rating = null,Object? postedAt = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceLabel: null == priceLabel ? _self.priceLabel : priceLabel // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,sold: null == sold ? _self.sold : sold // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _FavouriteProduct implements FavouriteProduct {
  const _FavouriteProduct({required this.id, required this.name, required this.description, required this.priceLabel, required this.condition, required this.sellerName, required this.location, required this.views, required this.sold, required this.rating, required this.postedAt, this.imageUrl});
  

@override final  String id;
@override final  String name;
@override final  String description;
/// e.g. `रु. 10,000 - 20,000` / `₹8,000 - ₹16,000` (region currency).
@override final  String priceLabel;
/// e.g. `Brand New`.
@override final  String condition;
@override final  String sellerName;
@override final  String location;
@override final  int views;
@override final  int sold;
/// 0–5.
@override final  double rating;
@override final  DateTime postedAt;
@override final  String? imageUrl;

/// Create a copy of FavouriteProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavouriteProductCopyWith<_FavouriteProduct> get copyWith => __$FavouriteProductCopyWithImpl<_FavouriteProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavouriteProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceLabel, priceLabel) || other.priceLabel == priceLabel)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.location, location) || other.location == location)&&(identical(other.views, views) || other.views == views)&&(identical(other.sold, sold) || other.sold == sold)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,priceLabel,condition,sellerName,location,views,sold,rating,postedAt,imageUrl);

@override
String toString() {
  return 'FavouriteProduct(id: $id, name: $name, description: $description, priceLabel: $priceLabel, condition: $condition, sellerName: $sellerName, location: $location, views: $views, sold: $sold, rating: $rating, postedAt: $postedAt, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$FavouriteProductCopyWith<$Res> implements $FavouriteProductCopyWith<$Res> {
  factory _$FavouriteProductCopyWith(_FavouriteProduct value, $Res Function(_FavouriteProduct) _then) = __$FavouriteProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String priceLabel, String condition, String sellerName, String location, int views, int sold, double rating, DateTime postedAt, String? imageUrl
});




}
/// @nodoc
class __$FavouriteProductCopyWithImpl<$Res>
    implements _$FavouriteProductCopyWith<$Res> {
  __$FavouriteProductCopyWithImpl(this._self, this._then);

  final _FavouriteProduct _self;
  final $Res Function(_FavouriteProduct) _then;

/// Create a copy of FavouriteProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? priceLabel = null,Object? condition = null,Object? sellerName = null,Object? location = null,Object? views = null,Object? sold = null,Object? rating = null,Object? postedAt = null,Object? imageUrl = freezed,}) {
  return _then(_FavouriteProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceLabel: null == priceLabel ? _self.priceLabel : priceLabel // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,sold: null == sold ? _self.sold : sold // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
