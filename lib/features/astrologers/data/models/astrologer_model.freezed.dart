// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AstrologerModel {

 String get id; LocalizedTextModel get name; LocalizedTextModel get headline; LocalizedTextModel get about; List<String> get specialties; List<String> get languageCodes; int get experienceYears; double get rating; int get reviewCount; Map<String, double> get ratePerMinute; int get consultationCount; int get followers; int get recommendedPercent; bool get isOnline; bool get isVerified; int get queueLength; bool get isFollowing; String? get avatarAsset; LocalizedTextModel? get location; Map<String, int> get ratingBreakdown;
/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerModelCopyWith<AstrologerModel> get copyWith => _$AstrologerModelCopyWithImpl<AstrologerModel>(this as AstrologerModel, _$identity);

  /// Serializes this AstrologerModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other.specialties, specialties)&&const DeepCollectionEquality().equals(other.languageCodes, languageCodes)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other.ratePerMinute, ratePerMinute)&&(identical(other.consultationCount, consultationCount) || other.consultationCount == consultationCount)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.recommendedPercent, recommendedPercent) || other.recommendedPercent == recommendedPercent)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.queueLength, queueLength) || other.queueLength == queueLength)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.avatarAsset, avatarAsset) || other.avatarAsset == avatarAsset)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.ratingBreakdown, ratingBreakdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,headline,about,const DeepCollectionEquality().hash(specialties),const DeepCollectionEquality().hash(languageCodes),experienceYears,rating,reviewCount,const DeepCollectionEquality().hash(ratePerMinute),consultationCount,followers,recommendedPercent,isOnline,isVerified,queueLength,isFollowing,avatarAsset,location,const DeepCollectionEquality().hash(ratingBreakdown)]);

@override
String toString() {
  return 'AstrologerModel(id: $id, name: $name, headline: $headline, about: $about, specialties: $specialties, languageCodes: $languageCodes, experienceYears: $experienceYears, rating: $rating, reviewCount: $reviewCount, ratePerMinute: $ratePerMinute, consultationCount: $consultationCount, followers: $followers, recommendedPercent: $recommendedPercent, isOnline: $isOnline, isVerified: $isVerified, queueLength: $queueLength, isFollowing: $isFollowing, avatarAsset: $avatarAsset, location: $location, ratingBreakdown: $ratingBreakdown)';
}


}

/// @nodoc
abstract mixin class $AstrologerModelCopyWith<$Res>  {
  factory $AstrologerModelCopyWith(AstrologerModel value, $Res Function(AstrologerModel) _then) = _$AstrologerModelCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextModel name, LocalizedTextModel headline, LocalizedTextModel about, List<String> specialties, List<String> languageCodes, int experienceYears, double rating, int reviewCount, Map<String, double> ratePerMinute, int consultationCount, int followers, int recommendedPercent, bool isOnline, bool isVerified, int queueLength, bool isFollowing, String? avatarAsset, LocalizedTextModel? location, Map<String, int> ratingBreakdown
});


$LocalizedTextModelCopyWith<$Res> get name;$LocalizedTextModelCopyWith<$Res> get headline;$LocalizedTextModelCopyWith<$Res> get about;$LocalizedTextModelCopyWith<$Res>? get location;

}
/// @nodoc
class _$AstrologerModelCopyWithImpl<$Res>
    implements $AstrologerModelCopyWith<$Res> {
  _$AstrologerModelCopyWithImpl(this._self, this._then);

  final AstrologerModel _self;
  final $Res Function(AstrologerModel) _then;

/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? headline = null,Object? about = null,Object? specialties = null,Object? languageCodes = null,Object? experienceYears = null,Object? rating = null,Object? reviewCount = null,Object? ratePerMinute = null,Object? consultationCount = null,Object? followers = null,Object? recommendedPercent = null,Object? isOnline = null,Object? isVerified = null,Object? queueLength = null,Object? isFollowing = null,Object? avatarAsset = freezed,Object? location = freezed,Object? ratingBreakdown = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,specialties: null == specialties ? _self.specialties : specialties // ignore: cast_nullable_to_non_nullable
as List<String>,languageCodes: null == languageCodes ? _self.languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as Map<String, double>,consultationCount: null == consultationCount ? _self.consultationCount : consultationCount // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,recommendedPercent: null == recommendedPercent ? _self.recommendedPercent : recommendedPercent // ignore: cast_nullable_to_non_nullable
as int,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,queueLength: null == queueLength ? _self.queueLength : queueLength // ignore: cast_nullable_to_non_nullable
as int,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,avatarAsset: freezed == avatarAsset ? _self.avatarAsset : avatarAsset // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel?,ratingBreakdown: null == ratingBreakdown ? _self.ratingBreakdown : ratingBreakdown // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}
/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get name {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get headline {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.headline, (value) {
    return _then(_self.copyWith(headline: value));
  });
}/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get about {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.about, (value) {
    return _then(_self.copyWith(about: value));
  });
}/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $LocalizedTextModelCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _AstrologerModel extends AstrologerModel {
  const _AstrologerModel({required this.id, required this.name, required this.headline, required this.about, final  List<String> specialties = const [], final  List<String> languageCodes = const [], this.experienceYears = 0, this.rating = 0, this.reviewCount = 0, final  Map<String, double> ratePerMinute = const {}, this.consultationCount = 0, this.followers = 0, this.recommendedPercent = 0, this.isOnline = false, this.isVerified = false, this.queueLength = 0, this.isFollowing = false, this.avatarAsset, this.location, final  Map<String, int> ratingBreakdown = const {}}): _specialties = specialties,_languageCodes = languageCodes,_ratePerMinute = ratePerMinute,_ratingBreakdown = ratingBreakdown,super._();
  factory _AstrologerModel.fromJson(Map<String, dynamic> json) => _$AstrologerModelFromJson(json);

@override final  String id;
@override final  LocalizedTextModel name;
@override final  LocalizedTextModel headline;
@override final  LocalizedTextModel about;
 final  List<String> _specialties;
@override@JsonKey() List<String> get specialties {
  if (_specialties is EqualUnmodifiableListView) return _specialties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specialties);
}

 final  List<String> _languageCodes;
@override@JsonKey() List<String> get languageCodes {
  if (_languageCodes is EqualUnmodifiableListView) return _languageCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageCodes);
}

@override@JsonKey() final  int experienceYears;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;
 final  Map<String, double> _ratePerMinute;
@override@JsonKey() Map<String, double> get ratePerMinute {
  if (_ratePerMinute is EqualUnmodifiableMapView) return _ratePerMinute;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratePerMinute);
}

@override@JsonKey() final  int consultationCount;
@override@JsonKey() final  int followers;
@override@JsonKey() final  int recommendedPercent;
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  bool isVerified;
@override@JsonKey() final  int queueLength;
@override@JsonKey() final  bool isFollowing;
@override final  String? avatarAsset;
@override final  LocalizedTextModel? location;
 final  Map<String, int> _ratingBreakdown;
@override@JsonKey() Map<String, int> get ratingBreakdown {
  if (_ratingBreakdown is EqualUnmodifiableMapView) return _ratingBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratingBreakdown);
}


/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerModelCopyWith<_AstrologerModel> get copyWith => __$AstrologerModelCopyWithImpl<_AstrologerModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AstrologerModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other._specialties, _specialties)&&const DeepCollectionEquality().equals(other._languageCodes, _languageCodes)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other._ratePerMinute, _ratePerMinute)&&(identical(other.consultationCount, consultationCount) || other.consultationCount == consultationCount)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.recommendedPercent, recommendedPercent) || other.recommendedPercent == recommendedPercent)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.queueLength, queueLength) || other.queueLength == queueLength)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.avatarAsset, avatarAsset) || other.avatarAsset == avatarAsset)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._ratingBreakdown, _ratingBreakdown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,headline,about,const DeepCollectionEquality().hash(_specialties),const DeepCollectionEquality().hash(_languageCodes),experienceYears,rating,reviewCount,const DeepCollectionEquality().hash(_ratePerMinute),consultationCount,followers,recommendedPercent,isOnline,isVerified,queueLength,isFollowing,avatarAsset,location,const DeepCollectionEquality().hash(_ratingBreakdown)]);

@override
String toString() {
  return 'AstrologerModel(id: $id, name: $name, headline: $headline, about: $about, specialties: $specialties, languageCodes: $languageCodes, experienceYears: $experienceYears, rating: $rating, reviewCount: $reviewCount, ratePerMinute: $ratePerMinute, consultationCount: $consultationCount, followers: $followers, recommendedPercent: $recommendedPercent, isOnline: $isOnline, isVerified: $isVerified, queueLength: $queueLength, isFollowing: $isFollowing, avatarAsset: $avatarAsset, location: $location, ratingBreakdown: $ratingBreakdown)';
}


}

/// @nodoc
abstract mixin class _$AstrologerModelCopyWith<$Res> implements $AstrologerModelCopyWith<$Res> {
  factory _$AstrologerModelCopyWith(_AstrologerModel value, $Res Function(_AstrologerModel) _then) = __$AstrologerModelCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextModel name, LocalizedTextModel headline, LocalizedTextModel about, List<String> specialties, List<String> languageCodes, int experienceYears, double rating, int reviewCount, Map<String, double> ratePerMinute, int consultationCount, int followers, int recommendedPercent, bool isOnline, bool isVerified, int queueLength, bool isFollowing, String? avatarAsset, LocalizedTextModel? location, Map<String, int> ratingBreakdown
});


@override $LocalizedTextModelCopyWith<$Res> get name;@override $LocalizedTextModelCopyWith<$Res> get headline;@override $LocalizedTextModelCopyWith<$Res> get about;@override $LocalizedTextModelCopyWith<$Res>? get location;

}
/// @nodoc
class __$AstrologerModelCopyWithImpl<$Res>
    implements _$AstrologerModelCopyWith<$Res> {
  __$AstrologerModelCopyWithImpl(this._self, this._then);

  final _AstrologerModel _self;
  final $Res Function(_AstrologerModel) _then;

/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? headline = null,Object? about = null,Object? specialties = null,Object? languageCodes = null,Object? experienceYears = null,Object? rating = null,Object? reviewCount = null,Object? ratePerMinute = null,Object? consultationCount = null,Object? followers = null,Object? recommendedPercent = null,Object? isOnline = null,Object? isVerified = null,Object? queueLength = null,Object? isFollowing = null,Object? avatarAsset = freezed,Object? location = freezed,Object? ratingBreakdown = null,}) {
  return _then(_AstrologerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,specialties: null == specialties ? _self._specialties : specialties // ignore: cast_nullable_to_non_nullable
as List<String>,languageCodes: null == languageCodes ? _self._languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,ratePerMinute: null == ratePerMinute ? _self._ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as Map<String, double>,consultationCount: null == consultationCount ? _self.consultationCount : consultationCount // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,recommendedPercent: null == recommendedPercent ? _self.recommendedPercent : recommendedPercent // ignore: cast_nullable_to_non_nullable
as int,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,queueLength: null == queueLength ? _self.queueLength : queueLength // ignore: cast_nullable_to_non_nullable
as int,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,avatarAsset: freezed == avatarAsset ? _self.avatarAsset : avatarAsset // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel?,ratingBreakdown: null == ratingBreakdown ? _self._ratingBreakdown : ratingBreakdown // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get name {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get headline {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.headline, (value) {
    return _then(_self.copyWith(headline: value));
  });
}/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get about {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.about, (value) {
    return _then(_self.copyWith(about: value));
  });
}/// Create a copy of AstrologerModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $LocalizedTextModelCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
