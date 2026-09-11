// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BusinessItem {

 String get id; String get title; String get description; String get priceLabel; String get category; bool get isService; String? get imageUrl;/// External purchase / website link for the item (optional).
 String get purchaseLink;/// TikTok / YouTube video links (product related, optional).
 String get tiktokLink; String get youtubeLink; bool get negotiable;
/// Create a copy of BusinessItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessItemCopyWith<BusinessItem> get copyWith => _$BusinessItemCopyWithImpl<BusinessItem>(this as BusinessItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceLabel, priceLabel) || other.priceLabel == priceLabel)&&(identical(other.category, category) || other.category == category)&&(identical(other.isService, isService) || other.isService == isService)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.purchaseLink, purchaseLink) || other.purchaseLink == purchaseLink)&&(identical(other.tiktokLink, tiktokLink) || other.tiktokLink == tiktokLink)&&(identical(other.youtubeLink, youtubeLink) || other.youtubeLink == youtubeLink)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,priceLabel,category,isService,imageUrl,purchaseLink,tiktokLink,youtubeLink,negotiable);

@override
String toString() {
  return 'BusinessItem(id: $id, title: $title, description: $description, priceLabel: $priceLabel, category: $category, isService: $isService, imageUrl: $imageUrl, purchaseLink: $purchaseLink, tiktokLink: $tiktokLink, youtubeLink: $youtubeLink, negotiable: $negotiable)';
}


}

/// @nodoc
abstract mixin class $BusinessItemCopyWith<$Res>  {
  factory $BusinessItemCopyWith(BusinessItem value, $Res Function(BusinessItem) _then) = _$BusinessItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String priceLabel, String category, bool isService, String? imageUrl, String purchaseLink, String tiktokLink, String youtubeLink, bool negotiable
});




}
/// @nodoc
class _$BusinessItemCopyWithImpl<$Res>
    implements $BusinessItemCopyWith<$Res> {
  _$BusinessItemCopyWithImpl(this._self, this._then);

  final BusinessItem _self;
  final $Res Function(BusinessItem) _then;

/// Create a copy of BusinessItem
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


class _BusinessItem implements BusinessItem {
  const _BusinessItem({required this.id, required this.title, required this.description, required this.priceLabel, required this.category, this.isService = false, this.imageUrl, this.purchaseLink = '', this.tiktokLink = '', this.youtubeLink = '', this.negotiable = false});
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String priceLabel;
@override final  String category;
@override@JsonKey() final  bool isService;
@override final  String? imageUrl;
/// External purchase / website link for the item (optional).
@override@JsonKey() final  String purchaseLink;
/// TikTok / YouTube video links (product related, optional).
@override@JsonKey() final  String tiktokLink;
@override@JsonKey() final  String youtubeLink;
@override@JsonKey() final  bool negotiable;

/// Create a copy of BusinessItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessItemCopyWith<_BusinessItem> get copyWith => __$BusinessItemCopyWithImpl<_BusinessItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceLabel, priceLabel) || other.priceLabel == priceLabel)&&(identical(other.category, category) || other.category == category)&&(identical(other.isService, isService) || other.isService == isService)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.purchaseLink, purchaseLink) || other.purchaseLink == purchaseLink)&&(identical(other.tiktokLink, tiktokLink) || other.tiktokLink == tiktokLink)&&(identical(other.youtubeLink, youtubeLink) || other.youtubeLink == youtubeLink)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,priceLabel,category,isService,imageUrl,purchaseLink,tiktokLink,youtubeLink,negotiable);

@override
String toString() {
  return 'BusinessItem(id: $id, title: $title, description: $description, priceLabel: $priceLabel, category: $category, isService: $isService, imageUrl: $imageUrl, purchaseLink: $purchaseLink, tiktokLink: $tiktokLink, youtubeLink: $youtubeLink, negotiable: $negotiable)';
}


}

/// @nodoc
abstract mixin class _$BusinessItemCopyWith<$Res> implements $BusinessItemCopyWith<$Res> {
  factory _$BusinessItemCopyWith(_BusinessItem value, $Res Function(_BusinessItem) _then) = __$BusinessItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String priceLabel, String category, bool isService, String? imageUrl, String purchaseLink, String tiktokLink, String youtubeLink, bool negotiable
});




}
/// @nodoc
class __$BusinessItemCopyWithImpl<$Res>
    implements _$BusinessItemCopyWith<$Res> {
  __$BusinessItemCopyWithImpl(this._self, this._then);

  final _BusinessItem _self;
  final $Res Function(_BusinessItem) _then;

/// Create a copy of BusinessItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? priceLabel = null,Object? category = null,Object? isService = null,Object? imageUrl = freezed,Object? purchaseLink = null,Object? tiktokLink = null,Object? youtubeLink = null,Object? negotiable = null,}) {
  return _then(_BusinessItem(
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
mixin _$BusinessReview {

 String get id; String get author; int get rating; DateTime get date; String get text; int get helpfulCount;
/// Create a copy of BusinessReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessReviewCopyWith<BusinessReview> get copyWith => _$BusinessReviewCopyWithImpl<BusinessReview>(this as BusinessReview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessReview&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.date, date) || other.date == date)&&(identical(other.text, text) || other.text == text)&&(identical(other.helpfulCount, helpfulCount) || other.helpfulCount == helpfulCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,author,rating,date,text,helpfulCount);

@override
String toString() {
  return 'BusinessReview(id: $id, author: $author, rating: $rating, date: $date, text: $text, helpfulCount: $helpfulCount)';
}


}

/// @nodoc
abstract mixin class $BusinessReviewCopyWith<$Res>  {
  factory $BusinessReviewCopyWith(BusinessReview value, $Res Function(BusinessReview) _then) = _$BusinessReviewCopyWithImpl;
@useResult
$Res call({
 String id, String author, int rating, DateTime date, String text, int helpfulCount
});




}
/// @nodoc
class _$BusinessReviewCopyWithImpl<$Res>
    implements $BusinessReviewCopyWith<$Res> {
  _$BusinessReviewCopyWithImpl(this._self, this._then);

  final BusinessReview _self;
  final $Res Function(BusinessReview) _then;

/// Create a copy of BusinessReview
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


class _BusinessReview implements BusinessReview {
  const _BusinessReview({required this.id, required this.author, required this.rating, required this.date, required this.text, this.helpfulCount = 0});
  

@override final  String id;
@override final  String author;
@override final  int rating;
@override final  DateTime date;
@override final  String text;
@override@JsonKey() final  int helpfulCount;

/// Create a copy of BusinessReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessReviewCopyWith<_BusinessReview> get copyWith => __$BusinessReviewCopyWithImpl<_BusinessReview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessReview&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.date, date) || other.date == date)&&(identical(other.text, text) || other.text == text)&&(identical(other.helpfulCount, helpfulCount) || other.helpfulCount == helpfulCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,author,rating,date,text,helpfulCount);

@override
String toString() {
  return 'BusinessReview(id: $id, author: $author, rating: $rating, date: $date, text: $text, helpfulCount: $helpfulCount)';
}


}

/// @nodoc
abstract mixin class _$BusinessReviewCopyWith<$Res> implements $BusinessReviewCopyWith<$Res> {
  factory _$BusinessReviewCopyWith(_BusinessReview value, $Res Function(_BusinessReview) _then) = __$BusinessReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String author, int rating, DateTime date, String text, int helpfulCount
});




}
/// @nodoc
class __$BusinessReviewCopyWithImpl<$Res>
    implements _$BusinessReviewCopyWith<$Res> {
  __$BusinessReviewCopyWithImpl(this._self, this._then);

  final _BusinessReview _self;
  final $Res Function(_BusinessReview) _then;

/// Create a copy of BusinessReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? rating = null,Object? date = null,Object? text = null,Object? helpfulCount = null,}) {
  return _then(_BusinessReview(
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
mixin _$BusinessProfile {

 String get id; String get name; String get category; String get tagline; String get description; String get email; String get phone; String get whatsapp; String get website; String get address; String get mapLink; String get workingHours;/// Tax registration number – PAN/VAT for Nepal, GSTIN for India (optional).
 String get taxId; String? get logoUrl; String? get coverUrl; bool get verified; double get rating; int get reviewCount; int get recommendedPercent; int get followers; List<BusinessItem> get items; List<BusinessReview> get reviews;/// Names of uploaded verification documents.
 List<String> get documents; BusinessStatus get status;/// Reason entered by the admin when rejecting (shown to the owner).
 String get moderationNote;
/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessProfileCopyWith<BusinessProfile> get copyWith => _$BusinessProfileCopyWithImpl<BusinessProfile>(this as BusinessProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.website, website) || other.website == website)&&(identical(other.address, address) || other.address == address)&&(identical(other.mapLink, mapLink) || other.mapLink == mapLink)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.recommendedPercent, recommendedPercent) || other.recommendedPercent == recommendedPercent)&&(identical(other.followers, followers) || other.followers == followers)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&const DeepCollectionEquality().equals(other.documents, documents)&&(identical(other.status, status) || other.status == status)&&(identical(other.moderationNote, moderationNote) || other.moderationNote == moderationNote));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,category,tagline,description,email,phone,whatsapp,website,address,mapLink,workingHours,taxId,logoUrl,coverUrl,verified,rating,reviewCount,recommendedPercent,followers,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(reviews),const DeepCollectionEquality().hash(documents),status,moderationNote]);

@override
String toString() {
  return 'BusinessProfile(id: $id, name: $name, category: $category, tagline: $tagline, description: $description, email: $email, phone: $phone, whatsapp: $whatsapp, website: $website, address: $address, mapLink: $mapLink, workingHours: $workingHours, taxId: $taxId, logoUrl: $logoUrl, coverUrl: $coverUrl, verified: $verified, rating: $rating, reviewCount: $reviewCount, recommendedPercent: $recommendedPercent, followers: $followers, items: $items, reviews: $reviews, documents: $documents, status: $status, moderationNote: $moderationNote)';
}


}

/// @nodoc
abstract mixin class $BusinessProfileCopyWith<$Res>  {
  factory $BusinessProfileCopyWith(BusinessProfile value, $Res Function(BusinessProfile) _then) = _$BusinessProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String tagline, String description, String email, String phone, String whatsapp, String website, String address, String mapLink, String workingHours, String taxId, String? logoUrl, String? coverUrl, bool verified, double rating, int reviewCount, int recommendedPercent, int followers, List<BusinessItem> items, List<BusinessReview> reviews, List<String> documents, BusinessStatus status, String moderationNote
});




}
/// @nodoc
class _$BusinessProfileCopyWithImpl<$Res>
    implements $BusinessProfileCopyWith<$Res> {
  _$BusinessProfileCopyWithImpl(this._self, this._then);

  final BusinessProfile _self;
  final $Res Function(BusinessProfile) _then;

/// Create a copy of BusinessProfile
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
as List<BusinessItem>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<BusinessReview>,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BusinessStatus,moderationNote: null == moderationNote ? _self.moderationNote : moderationNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _BusinessProfile extends BusinessProfile {
  const _BusinessProfile({required this.id, required this.name, required this.category, this.tagline = '', this.description = '', this.email = '', this.phone = '', this.whatsapp = '', this.website = '', this.address = '', this.mapLink = '', this.workingHours = '', this.taxId = '', this.logoUrl, this.coverUrl, this.verified = false, this.rating = 0, this.reviewCount = 0, this.recommendedPercent = 0, this.followers = 0, final  List<BusinessItem> items = const [], final  List<BusinessReview> reviews = const [], final  List<String> documents = const [], this.status = BusinessStatus.pending, this.moderationNote = ''}): _items = items,_reviews = reviews,_documents = documents,super._();
  

@override final  String id;
@override final  String name;
@override final  String category;
@override@JsonKey() final  String tagline;
@override@JsonKey() final  String description;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String whatsapp;
@override@JsonKey() final  String website;
@override@JsonKey() final  String address;
@override@JsonKey() final  String mapLink;
@override@JsonKey() final  String workingHours;
/// Tax registration number – PAN/VAT for Nepal, GSTIN for India (optional).
@override@JsonKey() final  String taxId;
@override final  String? logoUrl;
@override final  String? coverUrl;
@override@JsonKey() final  bool verified;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;
@override@JsonKey() final  int recommendedPercent;
@override@JsonKey() final  int followers;
 final  List<BusinessItem> _items;
@override@JsonKey() List<BusinessItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<BusinessReview> _reviews;
@override@JsonKey() List<BusinessReview> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

/// Names of uploaded verification documents.
 final  List<String> _documents;
/// Names of uploaded verification documents.
@override@JsonKey() List<String> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

@override@JsonKey() final  BusinessStatus status;
/// Reason entered by the admin when rejecting (shown to the owner).
@override@JsonKey() final  String moderationNote;

/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessProfileCopyWith<_BusinessProfile> get copyWith => __$BusinessProfileCopyWithImpl<_BusinessProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.whatsapp, whatsapp) || other.whatsapp == whatsapp)&&(identical(other.website, website) || other.website == website)&&(identical(other.address, address) || other.address == address)&&(identical(other.mapLink, mapLink) || other.mapLink == mapLink)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.recommendedPercent, recommendedPercent) || other.recommendedPercent == recommendedPercent)&&(identical(other.followers, followers) || other.followers == followers)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&const DeepCollectionEquality().equals(other._documents, _documents)&&(identical(other.status, status) || other.status == status)&&(identical(other.moderationNote, moderationNote) || other.moderationNote == moderationNote));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,category,tagline,description,email,phone,whatsapp,website,address,mapLink,workingHours,taxId,logoUrl,coverUrl,verified,rating,reviewCount,recommendedPercent,followers,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_reviews),const DeepCollectionEquality().hash(_documents),status,moderationNote]);

@override
String toString() {
  return 'BusinessProfile(id: $id, name: $name, category: $category, tagline: $tagline, description: $description, email: $email, phone: $phone, whatsapp: $whatsapp, website: $website, address: $address, mapLink: $mapLink, workingHours: $workingHours, taxId: $taxId, logoUrl: $logoUrl, coverUrl: $coverUrl, verified: $verified, rating: $rating, reviewCount: $reviewCount, recommendedPercent: $recommendedPercent, followers: $followers, items: $items, reviews: $reviews, documents: $documents, status: $status, moderationNote: $moderationNote)';
}


}

/// @nodoc
abstract mixin class _$BusinessProfileCopyWith<$Res> implements $BusinessProfileCopyWith<$Res> {
  factory _$BusinessProfileCopyWith(_BusinessProfile value, $Res Function(_BusinessProfile) _then) = __$BusinessProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String tagline, String description, String email, String phone, String whatsapp, String website, String address, String mapLink, String workingHours, String taxId, String? logoUrl, String? coverUrl, bool verified, double rating, int reviewCount, int recommendedPercent, int followers, List<BusinessItem> items, List<BusinessReview> reviews, List<String> documents, BusinessStatus status, String moderationNote
});




}
/// @nodoc
class __$BusinessProfileCopyWithImpl<$Res>
    implements _$BusinessProfileCopyWith<$Res> {
  __$BusinessProfileCopyWithImpl(this._self, this._then);

  final _BusinessProfile _self;
  final $Res Function(_BusinessProfile) _then;

/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? tagline = null,Object? description = null,Object? email = null,Object? phone = null,Object? whatsapp = null,Object? website = null,Object? address = null,Object? mapLink = null,Object? workingHours = null,Object? taxId = null,Object? logoUrl = freezed,Object? coverUrl = freezed,Object? verified = null,Object? rating = null,Object? reviewCount = null,Object? recommendedPercent = null,Object? followers = null,Object? items = null,Object? reviews = null,Object? documents = null,Object? status = null,Object? moderationNote = null,}) {
  return _then(_BusinessProfile(
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
as List<BusinessItem>,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<BusinessReview>,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BusinessStatus,moderationNote: null == moderationNote ? _self.moderationNote : moderationNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
