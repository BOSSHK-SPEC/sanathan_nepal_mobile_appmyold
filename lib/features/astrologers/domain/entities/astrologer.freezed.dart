// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Astrologer {

 String get id; LocalizedText get name;/// One-line practice summary, e.g. "Vedic astrology & Vaastu".
 LocalizedText get headline; LocalizedText get about; List<Specialty> get specialties;/// BCP-47 codes the astrologer consults in (`ne`, `en`, `hi`).
 List<String> get languageCodes; int get experienceYears; double get rating; int get reviewCount;/// Per-minute price by channel. A missing channel is not offered.
 Map<ConsultChannel, double> get ratePerMinute; int get consultationCount; int get followers;/// Share of reviewers who would recommend, 0–100.
 int get recommendedPercent; bool get isOnline; bool get isVerified;/// People currently waiting. Only meaningful while [isOnline].
 int get queueLength; bool get isFollowing; String? get avatarAsset; LocalizedText? get location;/// star (1–5) → number of reviews with that star.
 Map<int, int> get ratingBreakdown;
/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerCopyWith<Astrologer> get copyWith => _$AstrologerCopyWithImpl<Astrologer>(this as Astrologer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Astrologer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other.specialties, specialties)&&const DeepCollectionEquality().equals(other.languageCodes, languageCodes)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other.ratePerMinute, ratePerMinute)&&(identical(other.consultationCount, consultationCount) || other.consultationCount == consultationCount)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.recommendedPercent, recommendedPercent) || other.recommendedPercent == recommendedPercent)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.queueLength, queueLength) || other.queueLength == queueLength)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.avatarAsset, avatarAsset) || other.avatarAsset == avatarAsset)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.ratingBreakdown, ratingBreakdown));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,headline,about,const DeepCollectionEquality().hash(specialties),const DeepCollectionEquality().hash(languageCodes),experienceYears,rating,reviewCount,const DeepCollectionEquality().hash(ratePerMinute),consultationCount,followers,recommendedPercent,isOnline,isVerified,queueLength,isFollowing,avatarAsset,location,const DeepCollectionEquality().hash(ratingBreakdown)]);

@override
String toString() {
  return 'Astrologer(id: $id, name: $name, headline: $headline, about: $about, specialties: $specialties, languageCodes: $languageCodes, experienceYears: $experienceYears, rating: $rating, reviewCount: $reviewCount, ratePerMinute: $ratePerMinute, consultationCount: $consultationCount, followers: $followers, recommendedPercent: $recommendedPercent, isOnline: $isOnline, isVerified: $isVerified, queueLength: $queueLength, isFollowing: $isFollowing, avatarAsset: $avatarAsset, location: $location, ratingBreakdown: $ratingBreakdown)';
}


}

/// @nodoc
abstract mixin class $AstrologerCopyWith<$Res>  {
  factory $AstrologerCopyWith(Astrologer value, $Res Function(Astrologer) _then) = _$AstrologerCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText name, LocalizedText headline, LocalizedText about, List<Specialty> specialties, List<String> languageCodes, int experienceYears, double rating, int reviewCount, Map<ConsultChannel, double> ratePerMinute, int consultationCount, int followers, int recommendedPercent, bool isOnline, bool isVerified, int queueLength, bool isFollowing, String? avatarAsset, LocalizedText? location, Map<int, int> ratingBreakdown
});


$LocalizedTextCopyWith<$Res> get name;$LocalizedTextCopyWith<$Res> get headline;$LocalizedTextCopyWith<$Res> get about;$LocalizedTextCopyWith<$Res>? get location;

}
/// @nodoc
class _$AstrologerCopyWithImpl<$Res>
    implements $AstrologerCopyWith<$Res> {
  _$AstrologerCopyWithImpl(this._self, this._then);

  final Astrologer _self;
  final $Res Function(Astrologer) _then;

/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? headline = null,Object? about = null,Object? specialties = null,Object? languageCodes = null,Object? experienceYears = null,Object? rating = null,Object? reviewCount = null,Object? ratePerMinute = null,Object? consultationCount = null,Object? followers = null,Object? recommendedPercent = null,Object? isOnline = null,Object? isVerified = null,Object? queueLength = null,Object? isFollowing = null,Object? avatarAsset = freezed,Object? location = freezed,Object? ratingBreakdown = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as LocalizedText,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as LocalizedText,specialties: null == specialties ? _self.specialties : specialties // ignore: cast_nullable_to_non_nullable
as List<Specialty>,languageCodes: null == languageCodes ? _self.languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as Map<ConsultChannel, double>,consultationCount: null == consultationCount ? _self.consultationCount : consultationCount // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,recommendedPercent: null == recommendedPercent ? _self.recommendedPercent : recommendedPercent // ignore: cast_nullable_to_non_nullable
as int,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,queueLength: null == queueLength ? _self.queueLength : queueLength // ignore: cast_nullable_to_non_nullable
as int,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,avatarAsset: freezed == avatarAsset ? _self.avatarAsset : avatarAsset // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocalizedText?,ratingBreakdown: null == ratingBreakdown ? _self.ratingBreakdown : ratingBreakdown // ignore: cast_nullable_to_non_nullable
as Map<int, int>,
  ));
}
/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get headline {
  
  return $LocalizedTextCopyWith<$Res>(_self.headline, (value) {
    return _then(_self.copyWith(headline: value));
  });
}/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get about {
  
  return $LocalizedTextCopyWith<$Res>(_self.about, (value) {
    return _then(_self.copyWith(about: value));
  });
}/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}



/// @nodoc


class _Astrologer extends Astrologer {
  const _Astrologer({required this.id, required this.name, required this.headline, required this.about, required final  List<Specialty> specialties, required final  List<String> languageCodes, required this.experienceYears, required this.rating, required this.reviewCount, required final  Map<ConsultChannel, double> ratePerMinute, this.consultationCount = 0, this.followers = 0, this.recommendedPercent = 0, this.isOnline = false, this.isVerified = false, this.queueLength = 0, this.isFollowing = false, this.avatarAsset, this.location, final  Map<int, int> ratingBreakdown = const {}}): _specialties = specialties,_languageCodes = languageCodes,_ratePerMinute = ratePerMinute,_ratingBreakdown = ratingBreakdown,super._();
  

@override final  String id;
@override final  LocalizedText name;
/// One-line practice summary, e.g. "Vedic astrology & Vaastu".
@override final  LocalizedText headline;
@override final  LocalizedText about;
 final  List<Specialty> _specialties;
@override List<Specialty> get specialties {
  if (_specialties is EqualUnmodifiableListView) return _specialties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specialties);
}

/// BCP-47 codes the astrologer consults in (`ne`, `en`, `hi`).
 final  List<String> _languageCodes;
/// BCP-47 codes the astrologer consults in (`ne`, `en`, `hi`).
@override List<String> get languageCodes {
  if (_languageCodes is EqualUnmodifiableListView) return _languageCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageCodes);
}

@override final  int experienceYears;
@override final  double rating;
@override final  int reviewCount;
/// Per-minute price by channel. A missing channel is not offered.
 final  Map<ConsultChannel, double> _ratePerMinute;
/// Per-minute price by channel. A missing channel is not offered.
@override Map<ConsultChannel, double> get ratePerMinute {
  if (_ratePerMinute is EqualUnmodifiableMapView) return _ratePerMinute;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratePerMinute);
}

@override@JsonKey() final  int consultationCount;
@override@JsonKey() final  int followers;
/// Share of reviewers who would recommend, 0–100.
@override@JsonKey() final  int recommendedPercent;
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  bool isVerified;
/// People currently waiting. Only meaningful while [isOnline].
@override@JsonKey() final  int queueLength;
@override@JsonKey() final  bool isFollowing;
@override final  String? avatarAsset;
@override final  LocalizedText? location;
/// star (1–5) → number of reviews with that star.
 final  Map<int, int> _ratingBreakdown;
/// star (1–5) → number of reviews with that star.
@override@JsonKey() Map<int, int> get ratingBreakdown {
  if (_ratingBreakdown is EqualUnmodifiableMapView) return _ratingBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratingBreakdown);
}


/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerCopyWith<_Astrologer> get copyWith => __$AstrologerCopyWithImpl<_Astrologer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Astrologer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other._specialties, _specialties)&&const DeepCollectionEquality().equals(other._languageCodes, _languageCodes)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other._ratePerMinute, _ratePerMinute)&&(identical(other.consultationCount, consultationCount) || other.consultationCount == consultationCount)&&(identical(other.followers, followers) || other.followers == followers)&&(identical(other.recommendedPercent, recommendedPercent) || other.recommendedPercent == recommendedPercent)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.queueLength, queueLength) || other.queueLength == queueLength)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.avatarAsset, avatarAsset) || other.avatarAsset == avatarAsset)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._ratingBreakdown, _ratingBreakdown));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,headline,about,const DeepCollectionEquality().hash(_specialties),const DeepCollectionEquality().hash(_languageCodes),experienceYears,rating,reviewCount,const DeepCollectionEquality().hash(_ratePerMinute),consultationCount,followers,recommendedPercent,isOnline,isVerified,queueLength,isFollowing,avatarAsset,location,const DeepCollectionEquality().hash(_ratingBreakdown)]);

@override
String toString() {
  return 'Astrologer(id: $id, name: $name, headline: $headline, about: $about, specialties: $specialties, languageCodes: $languageCodes, experienceYears: $experienceYears, rating: $rating, reviewCount: $reviewCount, ratePerMinute: $ratePerMinute, consultationCount: $consultationCount, followers: $followers, recommendedPercent: $recommendedPercent, isOnline: $isOnline, isVerified: $isVerified, queueLength: $queueLength, isFollowing: $isFollowing, avatarAsset: $avatarAsset, location: $location, ratingBreakdown: $ratingBreakdown)';
}


}

/// @nodoc
abstract mixin class _$AstrologerCopyWith<$Res> implements $AstrologerCopyWith<$Res> {
  factory _$AstrologerCopyWith(_Astrologer value, $Res Function(_Astrologer) _then) = __$AstrologerCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText name, LocalizedText headline, LocalizedText about, List<Specialty> specialties, List<String> languageCodes, int experienceYears, double rating, int reviewCount, Map<ConsultChannel, double> ratePerMinute, int consultationCount, int followers, int recommendedPercent, bool isOnline, bool isVerified, int queueLength, bool isFollowing, String? avatarAsset, LocalizedText? location, Map<int, int> ratingBreakdown
});


@override $LocalizedTextCopyWith<$Res> get name;@override $LocalizedTextCopyWith<$Res> get headline;@override $LocalizedTextCopyWith<$Res> get about;@override $LocalizedTextCopyWith<$Res>? get location;

}
/// @nodoc
class __$AstrologerCopyWithImpl<$Res>
    implements _$AstrologerCopyWith<$Res> {
  __$AstrologerCopyWithImpl(this._self, this._then);

  final _Astrologer _self;
  final $Res Function(_Astrologer) _then;

/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? headline = null,Object? about = null,Object? specialties = null,Object? languageCodes = null,Object? experienceYears = null,Object? rating = null,Object? reviewCount = null,Object? ratePerMinute = null,Object? consultationCount = null,Object? followers = null,Object? recommendedPercent = null,Object? isOnline = null,Object? isVerified = null,Object? queueLength = null,Object? isFollowing = null,Object? avatarAsset = freezed,Object? location = freezed,Object? ratingBreakdown = null,}) {
  return _then(_Astrologer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as LocalizedText,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as LocalizedText,specialties: null == specialties ? _self._specialties : specialties // ignore: cast_nullable_to_non_nullable
as List<Specialty>,languageCodes: null == languageCodes ? _self._languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,ratePerMinute: null == ratePerMinute ? _self._ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as Map<ConsultChannel, double>,consultationCount: null == consultationCount ? _self.consultationCount : consultationCount // ignore: cast_nullable_to_non_nullable
as int,followers: null == followers ? _self.followers : followers // ignore: cast_nullable_to_non_nullable
as int,recommendedPercent: null == recommendedPercent ? _self.recommendedPercent : recommendedPercent // ignore: cast_nullable_to_non_nullable
as int,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,queueLength: null == queueLength ? _self.queueLength : queueLength // ignore: cast_nullable_to_non_nullable
as int,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,avatarAsset: freezed == avatarAsset ? _self.avatarAsset : avatarAsset // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocalizedText?,ratingBreakdown: null == ratingBreakdown ? _self._ratingBreakdown : ratingBreakdown // ignore: cast_nullable_to_non_nullable
as Map<int, int>,
  ));
}

/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get headline {
  
  return $LocalizedTextCopyWith<$Res>(_self.headline, (value) {
    return _then(_self.copyWith(headline: value));
  });
}/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get about {
  
  return $LocalizedTextCopyWith<$Res>(_self.about, (value) {
    return _then(_self.copyWith(about: value));
  });
}/// Create a copy of Astrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
