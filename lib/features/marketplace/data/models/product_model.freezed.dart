// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductModel {

 String get id; String get title; String get titleNe; String get description; String get descriptionNe; double get price; String get categoryId; List<String> get images; SellerModel get seller; String get location; String get locationNe; DateTime get postedAt; String get currency;@JsonKey(unknownEnumValue: ProductCondition.used) ProductCondition get condition; int get views; int get likes; double get rating; bool get isBoosted; bool get isFavourite; bool get isMine; String? get businessId; bool get negotiable; bool get isService; String? get websiteLink; DateTime? get expiresAt; Map<String, String> get specs; Map<String, List<String>> get options; List<ProductCommentModel> get comments; List<String> get videos;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.description, description) || other.description == description)&&(identical(other.descriptionNe, descriptionNe) || other.descriptionNe == descriptionNe)&&(identical(other.price, price) || other.price == price)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.seller, seller) || other.seller == seller)&&(identical(other.location, location) || other.location == location)&&(identical(other.locationNe, locationNe) || other.locationNe == locationNe)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.views, views) || other.views == views)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.isBoosted, isBoosted) || other.isBoosted == isBoosted)&&(identical(other.isFavourite, isFavourite) || other.isFavourite == isFavourite)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable)&&(identical(other.isService, isService) || other.isService == isService)&&(identical(other.websiteLink, websiteLink) || other.websiteLink == websiteLink)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other.specs, specs)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.comments, comments)&&const DeepCollectionEquality().equals(other.videos, videos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,titleNe,description,descriptionNe,price,categoryId,const DeepCollectionEquality().hash(images),seller,location,locationNe,postedAt,currency,condition,views,likes,rating,isBoosted,isFavourite,isMine,businessId,negotiable,isService,websiteLink,expiresAt,const DeepCollectionEquality().hash(specs),const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(comments),const DeepCollectionEquality().hash(videos)]);

@override
String toString() {
  return 'ProductModel(id: $id, title: $title, titleNe: $titleNe, description: $description, descriptionNe: $descriptionNe, price: $price, categoryId: $categoryId, images: $images, seller: $seller, location: $location, locationNe: $locationNe, postedAt: $postedAt, currency: $currency, condition: $condition, views: $views, likes: $likes, rating: $rating, isBoosted: $isBoosted, isFavourite: $isFavourite, isMine: $isMine, businessId: $businessId, negotiable: $negotiable, isService: $isService, websiteLink: $websiteLink, expiresAt: $expiresAt, specs: $specs, options: $options, comments: $comments, videos: $videos)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String titleNe, String description, String descriptionNe, double price, String categoryId, List<String> images, SellerModel seller, String location, String locationNe, DateTime postedAt, String currency,@JsonKey(unknownEnumValue: ProductCondition.used) ProductCondition condition, int views, int likes, double rating, bool isBoosted, bool isFavourite, bool isMine, String? businessId, bool negotiable, bool isService, String? websiteLink, DateTime? expiresAt, Map<String, String> specs, Map<String, List<String>> options, List<ProductCommentModel> comments, List<String> videos
});


$SellerModelCopyWith<$Res> get seller;

}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? titleNe = null,Object? description = null,Object? descriptionNe = null,Object? price = null,Object? categoryId = null,Object? images = null,Object? seller = null,Object? location = null,Object? locationNe = null,Object? postedAt = null,Object? currency = null,Object? condition = null,Object? views = null,Object? likes = null,Object? rating = null,Object? isBoosted = null,Object? isFavourite = null,Object? isMine = null,Object? businessId = freezed,Object? negotiable = null,Object? isService = null,Object? websiteLink = freezed,Object? expiresAt = freezed,Object? specs = null,Object? options = null,Object? comments = null,Object? videos = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,descriptionNe: null == descriptionNe ? _self.descriptionNe : descriptionNe // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,seller: null == seller ? _self.seller : seller // ignore: cast_nullable_to_non_nullable
as SellerModel,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,locationNe: null == locationNe ? _self.locationNe : locationNe // ignore: cast_nullable_to_non_nullable
as String,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ProductCondition,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,isBoosted: null == isBoosted ? _self.isBoosted : isBoosted // ignore: cast_nullable_to_non_nullable
as bool,isFavourite: null == isFavourite ? _self.isFavourite : isFavourite // ignore: cast_nullable_to_non_nullable
as bool,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,businessId: freezed == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String?,negotiable: null == negotiable ? _self.negotiable : negotiable // ignore: cast_nullable_to_non_nullable
as bool,isService: null == isService ? _self.isService : isService // ignore: cast_nullable_to_non_nullable
as bool,websiteLink: freezed == websiteLink ? _self.websiteLink : websiteLink // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,specs: null == specs ? _self.specs : specs // ignore: cast_nullable_to_non_nullable
as Map<String, String>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<ProductCommentModel>,videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SellerModelCopyWith<$Res> get seller {
  
  return $SellerModelCopyWith<$Res>(_self.seller, (value) {
    return _then(_self.copyWith(seller: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _ProductModel extends ProductModel {
  const _ProductModel({required this.id, required this.title, required this.titleNe, required this.description, required this.descriptionNe, required this.price, required this.categoryId, required final  List<String> images, required this.seller, required this.location, required this.locationNe, required this.postedAt, this.currency = 'NPR', @JsonKey(unknownEnumValue: ProductCondition.used) this.condition = ProductCondition.used, this.views = 0, this.likes = 0, this.rating = 0, this.isBoosted = false, this.isFavourite = false, this.isMine = false, this.businessId, this.negotiable = false, this.isService = false, this.websiteLink, this.expiresAt, final  Map<String, String> specs = const {}, final  Map<String, List<String>> options = const {}, final  List<ProductCommentModel> comments = const [], final  List<String> videos = const []}): _images = images,_specs = specs,_options = options,_comments = comments,_videos = videos,super._();
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String titleNe;
@override final  String description;
@override final  String descriptionNe;
@override final  double price;
@override final  String categoryId;
 final  List<String> _images;
@override List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  SellerModel seller;
@override final  String location;
@override final  String locationNe;
@override final  DateTime postedAt;
@override@JsonKey() final  String currency;
@override@JsonKey(unknownEnumValue: ProductCondition.used) final  ProductCondition condition;
@override@JsonKey() final  int views;
@override@JsonKey() final  int likes;
@override@JsonKey() final  double rating;
@override@JsonKey() final  bool isBoosted;
@override@JsonKey() final  bool isFavourite;
@override@JsonKey() final  bool isMine;
@override final  String? businessId;
@override@JsonKey() final  bool negotiable;
@override@JsonKey() final  bool isService;
@override final  String? websiteLink;
@override final  DateTime? expiresAt;
 final  Map<String, String> _specs;
@override@JsonKey() Map<String, String> get specs {
  if (_specs is EqualUnmodifiableMapView) return _specs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_specs);
}

 final  Map<String, List<String>> _options;
@override@JsonKey() Map<String, List<String>> get options {
  if (_options is EqualUnmodifiableMapView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_options);
}

 final  List<ProductCommentModel> _comments;
@override@JsonKey() List<ProductCommentModel> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

 final  List<String> _videos;
@override@JsonKey() List<String> get videos {
  if (_videos is EqualUnmodifiableListView) return _videos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_videos);
}


/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.description, description) || other.description == description)&&(identical(other.descriptionNe, descriptionNe) || other.descriptionNe == descriptionNe)&&(identical(other.price, price) || other.price == price)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.seller, seller) || other.seller == seller)&&(identical(other.location, location) || other.location == location)&&(identical(other.locationNe, locationNe) || other.locationNe == locationNe)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.views, views) || other.views == views)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.isBoosted, isBoosted) || other.isBoosted == isBoosted)&&(identical(other.isFavourite, isFavourite) || other.isFavourite == isFavourite)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable)&&(identical(other.isService, isService) || other.isService == isService)&&(identical(other.websiteLink, websiteLink) || other.websiteLink == websiteLink)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other._specs, _specs)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._comments, _comments)&&const DeepCollectionEquality().equals(other._videos, _videos));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,titleNe,description,descriptionNe,price,categoryId,const DeepCollectionEquality().hash(_images),seller,location,locationNe,postedAt,currency,condition,views,likes,rating,isBoosted,isFavourite,isMine,businessId,negotiable,isService,websiteLink,expiresAt,const DeepCollectionEquality().hash(_specs),const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_comments),const DeepCollectionEquality().hash(_videos)]);

@override
String toString() {
  return 'ProductModel(id: $id, title: $title, titleNe: $titleNe, description: $description, descriptionNe: $descriptionNe, price: $price, categoryId: $categoryId, images: $images, seller: $seller, location: $location, locationNe: $locationNe, postedAt: $postedAt, currency: $currency, condition: $condition, views: $views, likes: $likes, rating: $rating, isBoosted: $isBoosted, isFavourite: $isFavourite, isMine: $isMine, businessId: $businessId, negotiable: $negotiable, isService: $isService, websiteLink: $websiteLink, expiresAt: $expiresAt, specs: $specs, options: $options, comments: $comments, videos: $videos)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String titleNe, String description, String descriptionNe, double price, String categoryId, List<String> images, SellerModel seller, String location, String locationNe, DateTime postedAt, String currency,@JsonKey(unknownEnumValue: ProductCondition.used) ProductCondition condition, int views, int likes, double rating, bool isBoosted, bool isFavourite, bool isMine, String? businessId, bool negotiable, bool isService, String? websiteLink, DateTime? expiresAt, Map<String, String> specs, Map<String, List<String>> options, List<ProductCommentModel> comments, List<String> videos
});


@override $SellerModelCopyWith<$Res> get seller;

}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? titleNe = null,Object? description = null,Object? descriptionNe = null,Object? price = null,Object? categoryId = null,Object? images = null,Object? seller = null,Object? location = null,Object? locationNe = null,Object? postedAt = null,Object? currency = null,Object? condition = null,Object? views = null,Object? likes = null,Object? rating = null,Object? isBoosted = null,Object? isFavourite = null,Object? isMine = null,Object? businessId = freezed,Object? negotiable = null,Object? isService = null,Object? websiteLink = freezed,Object? expiresAt = freezed,Object? specs = null,Object? options = null,Object? comments = null,Object? videos = null,}) {
  return _then(_ProductModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,descriptionNe: null == descriptionNe ? _self.descriptionNe : descriptionNe // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,seller: null == seller ? _self.seller : seller // ignore: cast_nullable_to_non_nullable
as SellerModel,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,locationNe: null == locationNe ? _self.locationNe : locationNe // ignore: cast_nullable_to_non_nullable
as String,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ProductCondition,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,isBoosted: null == isBoosted ? _self.isBoosted : isBoosted // ignore: cast_nullable_to_non_nullable
as bool,isFavourite: null == isFavourite ? _self.isFavourite : isFavourite // ignore: cast_nullable_to_non_nullable
as bool,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,businessId: freezed == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String?,negotiable: null == negotiable ? _self.negotiable : negotiable // ignore: cast_nullable_to_non_nullable
as bool,isService: null == isService ? _self.isService : isService // ignore: cast_nullable_to_non_nullable
as bool,websiteLink: freezed == websiteLink ? _self.websiteLink : websiteLink // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,specs: null == specs ? _self._specs : specs // ignore: cast_nullable_to_non_nullable
as Map<String, String>,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<ProductCommentModel>,videos: null == videos ? _self._videos : videos // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SellerModelCopyWith<$Res> get seller {
  
  return $SellerModelCopyWith<$Res>(_self.seller, (value) {
    return _then(_self.copyWith(seller: value));
  });
}
}

// dart format on
