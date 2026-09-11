// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusinessItemModel {

 String get id; String get title; String get description; String get priceLabel; String get category; bool get isService; String? get imageUrl; String get purchaseLink; String get tiktokLink; String get youtubeLink; bool get negotiable;
/// Create a copy of BusinessItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessItemModelCopyWith<BusinessItemModel> get copyWith => _$BusinessItemModelCopyWithImpl<BusinessItemModel>(this as BusinessItemModel, _$identity);

  /// Serializes this BusinessItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceLabel, priceLabel) || other.priceLabel == priceLabel)&&(identical(other.category, category) || other.category == category)&&(identical(other.isService, isService) || other.isService == isService)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.purchaseLink, purchaseLink) || other.purchaseLink == purchaseLink)&&(identical(other.tiktokLink, tiktokLink) || other.tiktokLink == tiktokLink)&&(identical(other.youtubeLink, youtubeLink) || other.youtubeLink == youtubeLink)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,priceLabel,category,isService,imageUrl,purchaseLink,tiktokLink,youtubeLink,negotiable);

@override
String toString() {
  return 'BusinessItemModel(id: $id, title: $title, description: $description, priceLabel: $priceLabel, category: $category, isService: $isService, imageUrl: $imageUrl, purchaseLink: $purchaseLink, tiktokLink: $tiktokLink, youtubeLink: $youtubeLink, negotiable: $negotiable)';
}


}

/// @nodoc
abstract mixin class $BusinessItemModelCopyWith<$Res>  {
  factory $BusinessItemModelCopyWith(BusinessItemModel value, $Res Function(BusinessItemModel) _then) = _$BusinessItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String priceLabel, String category, bool isService, String? imageUrl, String purchaseLink, String tiktokLink, String youtubeLink, bool negotiable
});




}
/// @nodoc
class _$BusinessItemModelCopyWithImpl<$Res>
    implements $BusinessItemModelCopyWith<$Res> {
  _$BusinessItemModelCopyWithImpl(this._self, this._then);

  final BusinessItemModel _self;
  final $Res Function(BusinessItemModel) _then;

/// Create a copy of BusinessItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? priceLabel = null,Object? category = null,Object? isService = null,Object? imageUrl = freezed,Object? purchaseLink = null,Object? tiktokLink = null,Object? youtubeLink = null,Object? negotiable = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceLabel: null == priceLabel ? _self.priceLabel : priceLabel // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,isService: null == isService ? _self.isService : isService // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,purchaseLink: null == purchaseLink ? _self.purchaseLink : purchaseLink // ignore: cast_nullable_to_non_nullable
as String,tiktokLink: null == tiktokLink ? _self.tiktokLink : tiktokLink // ignore: cast_nullable_to_non_nullable
as String,youtubeLink: null == youtubeLink ? _self.youtubeLink : youtubeLink // ignore: cast_nullable_to_non_nullable
as String,negotiable: null == negotiable ? _self.negotiable : negotiable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _BusinessItemModel extends BusinessItemModel {
  const _BusinessItemModel({required this.id, this.title = '', this.description = '', this.priceLabel = '', this.category = '', this.isService = false, this.imageUrl, this.purchaseLink = '', this.tiktokLink = '', this.youtubeLink = '', this.negotiable = false}): super._();
  factory _BusinessItemModel.fromJson(Map<String, dynamic> json) => _$BusinessItemModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String priceLabel;
@override@JsonKey() final  String category;
@override@JsonKey() final  bool isService;
@override final  String? imageUrl;
@override@JsonKey() final  String purchaseLink;
@override@JsonKey() final  String tiktokLink;
@override@JsonKey() final  String youtubeLink;
@override@JsonKey() final  bool negotiable;

/// Create a copy of BusinessItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessItemModelCopyWith<_BusinessItemModel> get copyWith => __$BusinessItemModelCopyWithImpl<_BusinessItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceLabel, priceLabel) || other.priceLabel == priceLabel)&&(identical(other.category, category) || other.category == category)&&(identical(other.isService, isService) || other.isService == isService)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.purchaseLink, purchaseLink) || other.purchaseLink == purchaseLink)&&(identical(other.tiktokLink, tiktokLink) || other.tiktokLink == tiktokLink)&&(identical(other.youtubeLink, youtubeLink) || other.youtubeLink == youtubeLink)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,priceLabel,category,isService,imageUrl,purchaseLink,tiktokLink,youtubeLink,negotiable);

@override
String toString() {
  return 'BusinessItemModel(id: $id, title: $title, description: $description, priceLabel: $priceLabel, category: $category, isService: $isService, imageUrl: $imageUrl, purchaseLink: $purchaseLink, tiktokLink: $tiktokLink, youtubeLink: $youtubeLink, negotiable: $negotiable)';
}


}

/// @nodoc
abstract mixin class _$BusinessItemModelCopyWith<$Res> implements $BusinessItemModelCopyWith<$Res> {
  factory _$BusinessItemModelCopyWith(_BusinessItemModel value, $Res Function(_BusinessItemModel) _then) = __$BusinessItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String priceLabel, String category, bool isService, String? imageUrl, String purchaseLink, String tiktokLink, String youtubeLink, bool negotiable
});




}
/// @nodoc
class __$BusinessItemModelCopyWithImpl<$Res>
    implements _$BusinessItemModelCopyWith<$Res> {
  __$BusinessItemModelCopyWithImpl(this._self, this._then);

  final _BusinessItemModel _self;
  final $Res Function(_BusinessItemModel) _then;

/// Create a copy of BusinessItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? priceLabel = null,Object? category = null,Object? isService = null,Object? imageUrl = freezed,Object? purchaseLink = null,Object? tiktokLink = null,Object? youtubeLink = null,Object? negotiable = null,}) {
  return _then(_BusinessItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceLabel: null == priceLabel ? _self.priceLabel : priceLabel // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,isService: null == isService ? _self.isService : isService // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,purchaseLink: null == purchaseLink ? _self.purchaseLink : purchaseLink // ignore: cast_nullable_to_non_nullable
as String,tiktokLink: null == tiktokLink ? _self.tiktokLink : tiktokLink // ignore: cast_nullable_to_non_nullable
as String,youtubeLink: null == youtubeLink ? _self.youtubeLink : youtubeLink // ignore: cast_nullable_to_non_nullable
as String,negotiable: null == negotiable ? _self.negotiable : negotiable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$BusinessReviewModel {

 String get id; String get author; int get rating; DateTime get date; String get text; int get helpfulCount;
/// Create a copy of BusinessReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessReviewModelCopyWith<BusinessReviewModel> get copyWith => _$BusinessReviewModelCopyWithImpl<BusinessReviewModel>(this as BusinessReviewModel, _$identity);

  /// Serializes this BusinessReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.date, date) || other.date == date)&&(identical(other.text, text) || other.text == text)&&(identical(other.helpfulCount, helpfulCount) || other.helpfulCount == helpfulCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,rating,date,text,helpfulCount);

@override
String toString() {
  return 'BusinessReviewModel(id: $id, author: $author, rating: $rating, date: $date, text: $text, helpfulCount: $helpfulCount)';
}


}

/// @nodoc
abstract mixin class $BusinessReviewModelCopyWith<$Res>  {
  factory $BusinessReviewModelCopyWith(BusinessReviewModel value, $Res Function(BusinessReviewModel) _then) = _$BusinessReviewModelCopyWithImpl;
@useResult
$Res call({
 String id, String author, int rating, DateTime date, String text, int helpfulCount
});




}
/// @nodoc
class _$BusinessReviewModelCopyWithImpl<$Res>
    implements $BusinessReviewModelCopyWith<$Res> {
  _$BusinessReviewModelCopyWithImpl(this._self, this._then);

  final BusinessReviewModel _self;
  final $Res Function(BusinessReviewModel) _then;

/// Create a copy of BusinessReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? rating = null,Object? date = null,Object? text = null,Object? helpfulCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,helpfulCount: null == helpfulCount ? _self.helpfulCount : helpfulCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _BusinessReviewModel extends BusinessReviewModel {
  const _BusinessReviewModel({required this.id, this.author = '', this.rating = 0, required this.date, this.text = '', this.helpfulCount = 0}): super._();
  factory _BusinessReviewModel.fromJson(Map<String, dynamic> json) => _$BusinessReviewModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String author;
@override@JsonKey() final  int rating;
@override final  DateTime date;
@override@JsonKey() final  String text;
@override@JsonKey() final  int helpfulCount;

/// Create a copy of BusinessReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessReviewModelCopyWith<_BusinessReviewModel> get copyWith => __$BusinessReviewModelCopyWithImpl<_BusinessReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.date, date) || other.date == date)&&(identical(other.text, text) || other.text == text)&&(identical(other.helpfulCount, helpfulCount) || other.helpfulCount == helpfulCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,rating,date,text,helpfulCount);

@override
String toString() {
  return 'BusinessReviewModel(id: $id, author: $author, rating: $rating, date: $date, text: $text, helpfulCount: $helpfulCount)';
}


}

/// @nodoc
abstract mixin class _$BusinessReviewModelCopyWith<$Res> implements $BusinessReviewModelCopyWith<$Res> {
  factory _$BusinessReviewModelCopyWith(_BusinessReviewModel value, $Res Function(_BusinessReviewModel) _then) = __$BusinessReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String author, int rating, DateTime date, String text, int helpfulCount
});




}
/// @nodoc
class __$BusinessReviewModelCopyWithImpl<$Res>
    implements _$BusinessReviewModelCopyWith<$Res> {
  __$BusinessReviewModelCopyWithImpl(this._self, this._then);

  final _BusinessReviewModel _self;
  final $Res Function(_BusinessReviewModel) _then;

/// Create a copy of BusinessReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? rating = null,Object? date = null,Object? text = null,Object? helpfulCount = null,}) {
  return _then(_BusinessReviewModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,helpfulCount: null == helpfulCount ? _self.helpfulCount : helpfulCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BusinessProfileModel {

 String get id; String get name; String get category; String get tagline; String get description; String get email; String get phone; String get whatsapp; String get website; String get address; String get mapLink; String get workingHours; String get taxId; String? get logoUrl; String? get coverUrl; bool get verified; double get rating; int get reviewCount; int get recommendedPercent; int get followers; List<BusinessItemModel> get items; List<BusinessReviewModel> get reviews; List<String> get documents;@JsonKey(unknownEnumValue: BusinessStatus.pending) BusinessStatus get status; String get moderationNote;
/// Create a copy of BusinessProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessProfileModelCopyWith<BusinessProfileModel> get copyWith => _$BusinessProfileModelCopyWithImpl<BusinessProfileModel>(this as BusinessProfileModel, _$identity);

  /// Serializes this BusinessProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.website, website) || other.website == website)&&(identical(other.address, address) || other.address == address)&&(identical(other.mapLink, mapLink) || other.mapLink == mapLink)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.recommendedPercent, recommendedPercent) || other.recommendedPercent == recommendedPercent)&&(identical(other.followers, followers) || other.followers == followers)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&const DeepCollectionEquality().equals(other.documents, documents)&&(identical(other.status, status) || other.status == status)&&(identical(other.moderationNote, moderationNote) || other.moderationNote == moderationNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,category,tagline,description,email,phone,whatsapp,website,address,mapLink,workingHours,taxId,logoUrl,coverUrl,verified,rating,reviewCount,recommendedPercent,followers,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(reviews),const DeepCollectionEquality().hash(documents),status,moderationNote]);

@override
String toString() {
  return 'BusinessProfileModel(id: $id, name: $name, category: $category, tagline: $tagline, description: $description, email: $email, phone: $phone, whatsapp: $whatsapp, website: $website, address: $address, mapLink: $mapLink, workingHours: $workingHours, taxId: $taxId, logoUrl: $logoUrl, coverUrl: $coverUrl, verified: $verified, rating: $rating, reviewCount: $reviewCount, recommendedPercent: $recommendedPercent, followers: $followers, items: $items, reviews: $reviews, documents: $documents, status: $status, moderationNote: $moderationNote)';
}


}

/// @nodoc
abstract mixin class $BusinessProfileModelCopyWith<$Res>  {
  factory $BusinessProfileModelCopyWith(BusinessProfileModel value, $Res Function(BusinessProfileModel) _then) = _$BusinessProfileModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String tagline, String description, String email, String phone, String whatsapp, String website, String address, String mapLink, String workingHours, String taxId, String? logoUrl, String? coverUrl, bool verified, double rating, int reviewCount, int recommendedPercent, int followers, List<BusinessItemModel> items, List<BusinessReviewModel> reviews, List<String> documents,@JsonKey(unknownEnumValue: BusinessStatus.pending) BusinessStatus status, String moderationNote
});




}
/// @nodoc
class _$BusinessProfileModelCopyWithImpl<$Res>
    implements $BusinessProfileModelCopyWith<$Res> {
  _$BusinessProfileModelCopyWithImpl(this._self, this._then);

  final BusinessProfileModel _self;
  final $Res Function(BusinessProfileModel) _then;

/// Create a copy of BusinessProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? tagline = null,Object? description = null,Object? email = null,Object? phone = null,Object? whatsapp = null,Object? website = null,Object? address = null,Object? mapLink = null,Object? workingHours = null,Object? taxId = null,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? verified = null,Object? rating = null,Object? reviewCount = null,Object? recommendedPercent = null,Object? followers = null,Object? items = null,Object? reviews = null,Object? documents = null,Object? status = null,Object? moderationNote = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,whatsapp: null == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,mapLink: null == mapLink ? _self.mapLink : mapLink // ignore: cast_nullable_to_non_nullable
as String,workingHours: null == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as String,taxId: null == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,recommendedPercent: null == recommendedPercent ? _self.recommendedPercent : recommendedPercent // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<BusinessItemModel>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<BusinessReviewModel>,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BusinessStatus,moderationNote: null == moderationNote ? _self.moderationNote : moderationNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _BusinessProfileModel extends BusinessProfileModel {
  const _BusinessProfileModel({required this.id, this.name = '', this.category = '', this.tagline = '', this.description = '', this.email = '', this.phone = '', this.whatsapp = '', this.website = '', this.address = '', this.mapLink = '', this.workingHours = '', this.taxId = '', this.logoUrl, this.coverUrl, this.verified = false, this.rating = 0, this.reviewCount = 0, this.recommendedPercent = 0, this.followers = 0, final  List<BusinessItemModel> items = const [], final  List<BusinessReviewModel> reviews = const [], final  List<String> documents = const [], @JsonKey(unknownEnumValue: BusinessStatus.pending) this.status = BusinessStatus.pending, this.moderationNote = ''}): _items = items,_reviews = reviews,_documents = documents,super._();
  factory _BusinessProfileModel.fromJson(Map<String, dynamic> json) => _$BusinessProfileModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String category;
@override@JsonKey() final  String tagline;
@override@JsonKey() final  String description;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String whatsapp;
@override@JsonKey() final  String website;
@override@JsonKey() final  String address;
@override@JsonKey() final  String mapLink;
@override@JsonKey() final  String workingHours;
@override@JsonKey() final  String taxId;
@override final  String? logoUrl;
@override final  String? coverUrl;
@override@JsonKey() final  bool verified;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;
@override@JsonKey() final  int recommendedPercent;
@override@JsonKey() final  int followers;
 final  List<BusinessItemModel> _items;
@override@JsonKey() List<BusinessItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<BusinessReviewModel> _reviews;
@override@JsonKey() List<BusinessReviewModel> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

 final  List<String> _documents;
@override@JsonKey() List<String> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

@override@JsonKey(unknownEnumValue: BusinessStatus.pending) final  BusinessStatus status;
@override@JsonKey() final  String moderationNote;

/// Create a copy of BusinessProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessProfileModelCopyWith<_BusinessProfileModel> get copyWith => __$BusinessProfileModelCopyWithImpl<_BusinessProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.website, website) || other.website == website)&&(identical(other.address, address) || other.address == address)&&(identical(other.mapLink, mapLink) || other.mapLink == mapLink)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.recommendedPercent, recommendedPercent) || other.recommendedPercent == recommendedPercent)&&(identical(other.followers, followers) || other.followers == followers)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&const DeepCollectionEquality().equals(other._documents, _documents)&&(identical(other.status, status) || other.status == status)&&(identical(other.moderationNote, moderationNote) || other.moderationNote == moderationNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,category,tagline,description,email,phone,whatsapp,website,address,mapLink,workingHours,taxId,logoUrl,coverUrl,verified,rating,reviewCount,recommendedPercent,followers,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_reviews),const DeepCollectionEquality().hash(_documents),status,moderationNote]);

@override
String toString() {
  return 'BusinessProfileModel(id: $id, name: $name, category: $category, tagline: $tagline, description: $description, email: $email, phone: $phone, whatsapp: $whatsapp, website: $website, address: $address, mapLink: $mapLink, workingHours: $workingHours, taxId: $taxId, logoUrl: $logoUrl, coverUrl: $coverUrl, verified: $verified, rating: $rating, reviewCount: $reviewCount, recommendedPercent: $recommendedPercent, followers: $followers, items: $items, reviews: $reviews, documents: $documents, status: $status, moderationNote: $moderationNote)';
}


}

/// @nodoc
abstract mixin class _$BusinessProfileModelCopyWith<$Res> implements $BusinessProfileModelCopyWith<$Res> {
  factory _$BusinessProfileModelCopyWith(_BusinessProfileModel value, $Res Function(_BusinessProfileModel) _then) = __$BusinessProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String tagline, String description, String email, String phone, String whatsapp, String website, String address, String mapLink, String workingHours, String taxId, String? logoUrl, String? coverUrl, bool verified, double rating, int reviewCount, int recommendedPercent, int followers, List<BusinessItemModel> items, List<BusinessReviewModel> reviews, List<String> documents,@JsonKey(unknownEnumValue: BusinessStatus.pending) BusinessStatus status, String moderationNote
});




}
/// @nodoc
class __$BusinessProfileModelCopyWithImpl<$Res>
    implements _$BusinessProfileModelCopyWith<$Res> {
  __$BusinessProfileModelCopyWithImpl(this._self, this._then);

  final _BusinessProfileModel _self;
  final $Res Function(_BusinessProfileModel) _then;

/// Create a copy of BusinessProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? tagline = null,Object? description = null,Object? email = null,Object? phone = null,Object? whatsapp = null,Object? website = null,Object? address = null,Object? mapLink = null,Object? workingHours = null,Object? taxId = null,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? verified = null,Object? rating = null,Object? reviewCount = null,Object? recommendedPercent = null,Object? followers = null,Object? items = null,Object? reviews = null,Object? documents = null,Object? status = null,Object? moderationNote = null,}) {
  return _then(_BusinessProfileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,whatsapp: null == whatsapp ? _self.whatsapp : whatsapp // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,mapLink: null == mapLink ? _self.mapLink : mapLink // ignore: cast_nullable_to_non_nullable
as String,workingHours: null == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as String,taxId: null == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,recommendedPercent: null == recommendedPercent ? _self.recommendedPercent : recommendedPercent // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<BusinessItemModel>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<BusinessReviewModel>,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BusinessStatus,moderationNote: null == moderationNote ? _self.moderationNote : moderationNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
