// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDraft {

 String get title; String get titleLocal; String get categoryId; String get description; String get descriptionLocal; double get price; ProductCondition get condition; bool get isService; bool get negotiable; List<String> get images; String get location; String get locationLocal; String get phone; String? get websiteLink; int get expiryDays;
/// Create a copy of ProductDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDraftCopyWith<ProductDraft> get copyWith => _$ProductDraftCopyWithImpl<ProductDraft>(this as ProductDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.titleLocal, titleLocal) || other.titleLocal == titleLocal)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.description, description) || other.description == description)&&(identical(other.descriptionLocal, descriptionLocal) || other.descriptionLocal == descriptionLocal)&&(identical(other.price, price) || other.price == price)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.isService, isService) || other.isService == isService)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.location, location) || other.location == location)&&(identical(other.locationLocal, locationLocal) || other.locationLocal == locationLocal)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.websiteLink, websiteLink) || other.websiteLink == websiteLink)&&(identical(other.expiryDays, expiryDays) || other.expiryDays == expiryDays));
}


@override
int get hashCode => Object.hash(runtimeType,title,titleLocal,categoryId,description,descriptionLocal,price,condition,isService,negotiable,const DeepCollectionEquality().hash(images),location,locationLocal,phone,websiteLink,expiryDays);

@override
String toString() {
  return 'ProductDraft(title: $title, titleLocal: $titleLocal, categoryId: $categoryId, description: $description, descriptionLocal: $descriptionLocal, price: $price, condition: $condition, isService: $isService, negotiable: $negotiable, images: $images, location: $location, locationLocal: $locationLocal, phone: $phone, websiteLink: $websiteLink, expiryDays: $expiryDays)';
}


}

/// @nodoc
abstract mixin class $ProductDraftCopyWith<$Res>  {
  factory $ProductDraftCopyWith(ProductDraft value, $Res Function(ProductDraft) _then) = _$ProductDraftCopyWithImpl;
@useResult
$Res call({
 String title, String titleLocal, String categoryId, String description, String descriptionLocal, double price, ProductCondition condition, bool isService, bool negotiable, List<String> images, String location, String locationLocal, String phone, String? websiteLink, int expiryDays
});




}
/// @nodoc
class _$ProductDraftCopyWithImpl<$Res>
    implements $ProductDraftCopyWith<$Res> {
  _$ProductDraftCopyWithImpl(this._self, this._then);

  final ProductDraft _self;
  final $Res Function(ProductDraft) _then;

/// Create a copy of ProductDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? titleLocal = null,Object? categoryId = null,Object? description = null,Object? descriptionLocal = null,Object? price = null,Object? condition = null,Object? isService = null,Object? negotiable = null,Object? images = null,Object? location = null,Object? locationLocal = null,Object? phone = null,Object? websiteLink = freezed,Object? expiryDays = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,titleLocal: null == titleLocal ? _self.titleLocal : titleLocal // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,descriptionLocal: null == descriptionLocal ? _self.descriptionLocal : descriptionLocal // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ProductCondition,isService: null == isService ? _self.isService : isService // ignore: cast_nullable_to_non_nullable
as bool,negotiable: null == negotiable ? _self.negotiable : negotiable // ignore: cast_nullable_to_non_nullable
as bool,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,locationLocal: null == locationLocal ? _self.locationLocal : locationLocal // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,websiteLink: freezed == websiteLink ? _self.websiteLink : websiteLink // ignore: cast_nullable_to_non_nullable
as String?,expiryDays: null == expiryDays ? _self.expiryDays : expiryDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _ProductDraft extends ProductDraft {
  const _ProductDraft({this.title = '', this.titleLocal = '', this.categoryId = '', this.description = '', this.descriptionLocal = '', this.price = 0, this.condition = ProductCondition.used, this.isService = false, this.negotiable = false, final  List<String> images = const [], this.location = '', this.locationLocal = '', this.phone = '', this.websiteLink, this.expiryDays = 30}): _images = images,super._();
  

@override@JsonKey() final  String title;
@override@JsonKey() final  String titleLocal;
@override@JsonKey() final  String categoryId;
@override@JsonKey() final  String description;
@override@JsonKey() final  String descriptionLocal;
@override@JsonKey() final  double price;
@override@JsonKey() final  ProductCondition condition;
@override@JsonKey() final  bool isService;
@override@JsonKey() final  bool negotiable;
 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  String location;
@override@JsonKey() final  String locationLocal;
@override@JsonKey() final  String phone;
@override final  String? websiteLink;
@override@JsonKey() final  int expiryDays;

/// Create a copy of ProductDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDraftCopyWith<_ProductDraft> get copyWith => __$ProductDraftCopyWithImpl<_ProductDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.titleLocal, titleLocal) || other.titleLocal == titleLocal)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.description, description) || other.description == description)&&(identical(other.descriptionLocal, descriptionLocal) || other.descriptionLocal == descriptionLocal)&&(identical(other.price, price) || other.price == price)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.isService, isService) || other.isService == isService)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.location, location) || other.location == location)&&(identical(other.locationLocal, locationLocal) || other.locationLocal == locationLocal)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.websiteLink, websiteLink) || other.websiteLink == websiteLink)&&(identical(other.expiryDays, expiryDays) || other.expiryDays == expiryDays));
}


@override
int get hashCode => Object.hash(runtimeType,title,titleLocal,categoryId,description,descriptionLocal,price,condition,isService,negotiable,const DeepCollectionEquality().hash(_images),location,locationLocal,phone,websiteLink,expiryDays);

@override
String toString() {
  return 'ProductDraft(title: $title, titleLocal: $titleLocal, categoryId: $categoryId, description: $description, descriptionLocal: $descriptionLocal, price: $price, condition: $condition, isService: $isService, negotiable: $negotiable, images: $images, location: $location, locationLocal: $locationLocal, phone: $phone, websiteLink: $websiteLink, expiryDays: $expiryDays)';
}


}

/// @nodoc
abstract mixin class _$ProductDraftCopyWith<$Res> implements $ProductDraftCopyWith<$Res> {
  factory _$ProductDraftCopyWith(_ProductDraft value, $Res Function(_ProductDraft) _then) = __$ProductDraftCopyWithImpl;
@override @useResult
$Res call({
 String title, String titleLocal, String categoryId, String description, String descriptionLocal, double price, ProductCondition condition, bool isService, bool negotiable, List<String> images, String location, String locationLocal, String phone, String? websiteLink, int expiryDays
});




}
/// @nodoc
class __$ProductDraftCopyWithImpl<$Res>
    implements _$ProductDraftCopyWith<$Res> {
  __$ProductDraftCopyWithImpl(this._self, this._then);

  final _ProductDraft _self;
  final $Res Function(_ProductDraft) _then;

/// Create a copy of ProductDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? titleLocal = null,Object? categoryId = null,Object? description = null,Object? descriptionLocal = null,Object? price = null,Object? condition = null,Object? isService = null,Object? negotiable = null,Object? images = null,Object? location = null,Object? locationLocal = null,Object? phone = null,Object? websiteLink = freezed,Object? expiryDays = null,}) {
  return _then(_ProductDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,titleLocal: null == titleLocal ? _self.titleLocal : titleLocal // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,descriptionLocal: null == descriptionLocal ? _self.descriptionLocal : descriptionLocal // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ProductCondition,isService: null == isService ? _self.isService : isService // ignore: cast_nullable_to_non_nullable
as bool,negotiable: null == negotiable ? _self.negotiable : negotiable // ignore: cast_nullable_to_non_nullable
as bool,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,locationLocal: null == locationLocal ? _self.locationLocal : locationLocal // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,websiteLink: freezed == websiteLink ? _self.websiteLink : websiteLink // ignore: cast_nullable_to_non_nullable
as String?,expiryDays: null == expiryDays ? _self.expiryDays : expiryDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
