// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AstrologerProfileDraft {

 String get displayName; String get headline; String get about; List<Specialty> get specialties; List<String> get languageCodes; int get experienceYears; String? get avatarRef; String? get introVideoRef;/// Hides the profile from discovery without giving up the account —
/// what an astrologer taking extended leave actually needs.
 bool get hiddenFromSearch;
/// Create a copy of AstrologerProfileDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerProfileDraftCopyWith<AstrologerProfileDraft> get copyWith => _$AstrologerProfileDraftCopyWithImpl<AstrologerProfileDraft>(this as AstrologerProfileDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerProfileDraft&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other.specialties, specialties)&&const DeepCollectionEquality().equals(other.languageCodes, languageCodes)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.avatarRef, avatarRef) || other.avatarRef == avatarRef)&&(identical(other.introVideoRef, introVideoRef) || other.introVideoRef == introVideoRef)&&(identical(other.hiddenFromSearch, hiddenFromSearch) || other.hiddenFromSearch == hiddenFromSearch));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,headline,about,const DeepCollectionEquality().hash(specialties),const DeepCollectionEquality().hash(languageCodes),experienceYears,avatarRef,introVideoRef,hiddenFromSearch);

@override
String toString() {
  return 'AstrologerProfileDraft(displayName: $displayName, headline: $headline, about: $about, specialties: $specialties, languageCodes: $languageCodes, experienceYears: $experienceYears, avatarRef: $avatarRef, introVideoRef: $introVideoRef, hiddenFromSearch: $hiddenFromSearch)';
}


}

/// @nodoc
abstract mixin class $AstrologerProfileDraftCopyWith<$Res>  {
  factory $AstrologerProfileDraftCopyWith(AstrologerProfileDraft value, $Res Function(AstrologerProfileDraft) _then) = _$AstrologerProfileDraftCopyWithImpl;
@useResult
$Res call({
 String displayName, String headline, String about, List<Specialty> specialties, List<String> languageCodes, int experienceYears, String? avatarRef, String? introVideoRef, bool hiddenFromSearch
});




}
/// @nodoc
class _$AstrologerProfileDraftCopyWithImpl<$Res>
    implements $AstrologerProfileDraftCopyWith<$Res> {
  _$AstrologerProfileDraftCopyWithImpl(this._self, this._then);

  final AstrologerProfileDraft _self;
  final $Res Function(AstrologerProfileDraft) _then;

/// Create a copy of AstrologerProfileDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? headline = null,Object? about = null,Object? specialties = null,Object? languageCodes = null,Object? experienceYears = null,Object? avatarRef = freezed,Object? introVideoRef = freezed,Object? hiddenFromSearch = null,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,specialties: null == specialties ? _self.specialties : specialties // ignore: cast_nullable_to_non_nullable
as List<Specialty>,languageCodes: null == languageCodes ? _self.languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,avatarRef: freezed == avatarRef ? _self.avatarRef : avatarRef // ignore: cast_nullable_to_non_nullable
as String?,introVideoRef: freezed == introVideoRef ? _self.introVideoRef : introVideoRef // ignore: cast_nullable_to_non_nullable
as String?,hiddenFromSearch: null == hiddenFromSearch ? _self.hiddenFromSearch : hiddenFromSearch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _AstrologerProfileDraft extends AstrologerProfileDraft {
  const _AstrologerProfileDraft({this.displayName = '', this.headline = '', this.about = '', final  List<Specialty> specialties = const <Specialty>[], final  List<String> languageCodes = const <String>[], this.experienceYears = 0, this.avatarRef, this.introVideoRef, this.hiddenFromSearch = false}): _specialties = specialties,_languageCodes = languageCodes,super._();
  

@override@JsonKey() final  String displayName;
@override@JsonKey() final  String headline;
@override@JsonKey() final  String about;
 final  List<Specialty> _specialties;
@override@JsonKey() List<Specialty> get specialties {
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
@override final  String? avatarRef;
@override final  String? introVideoRef;
/// Hides the profile from discovery without giving up the account —
/// what an astrologer taking extended leave actually needs.
@override@JsonKey() final  bool hiddenFromSearch;

/// Create a copy of AstrologerProfileDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerProfileDraftCopyWith<_AstrologerProfileDraft> get copyWith => __$AstrologerProfileDraftCopyWithImpl<_AstrologerProfileDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerProfileDraft&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other._specialties, _specialties)&&const DeepCollectionEquality().equals(other._languageCodes, _languageCodes)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.avatarRef, avatarRef) || other.avatarRef == avatarRef)&&(identical(other.introVideoRef, introVideoRef) || other.introVideoRef == introVideoRef)&&(identical(other.hiddenFromSearch, hiddenFromSearch) || other.hiddenFromSearch == hiddenFromSearch));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,headline,about,const DeepCollectionEquality().hash(_specialties),const DeepCollectionEquality().hash(_languageCodes),experienceYears,avatarRef,introVideoRef,hiddenFromSearch);

@override
String toString() {
  return 'AstrologerProfileDraft(displayName: $displayName, headline: $headline, about: $about, specialties: $specialties, languageCodes: $languageCodes, experienceYears: $experienceYears, avatarRef: $avatarRef, introVideoRef: $introVideoRef, hiddenFromSearch: $hiddenFromSearch)';
}


}

/// @nodoc
abstract mixin class _$AstrologerProfileDraftCopyWith<$Res> implements $AstrologerProfileDraftCopyWith<$Res> {
  factory _$AstrologerProfileDraftCopyWith(_AstrologerProfileDraft value, $Res Function(_AstrologerProfileDraft) _then) = __$AstrologerProfileDraftCopyWithImpl;
@override @useResult
$Res call({
 String displayName, String headline, String about, List<Specialty> specialties, List<String> languageCodes, int experienceYears, String? avatarRef, String? introVideoRef, bool hiddenFromSearch
});




}
/// @nodoc
class __$AstrologerProfileDraftCopyWithImpl<$Res>
    implements _$AstrologerProfileDraftCopyWith<$Res> {
  __$AstrologerProfileDraftCopyWithImpl(this._self, this._then);

  final _AstrologerProfileDraft _self;
  final $Res Function(_AstrologerProfileDraft) _then;

/// Create a copy of AstrologerProfileDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? headline = null,Object? about = null,Object? specialties = null,Object? languageCodes = null,Object? experienceYears = null,Object? avatarRef = freezed,Object? introVideoRef = freezed,Object? hiddenFromSearch = null,}) {
  return _then(_AstrologerProfileDraft(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,specialties: null == specialties ? _self._specialties : specialties // ignore: cast_nullable_to_non_nullable
as List<Specialty>,languageCodes: null == languageCodes ? _self._languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,avatarRef: freezed == avatarRef ? _self.avatarRef : avatarRef // ignore: cast_nullable_to_non_nullable
as String?,introVideoRef: freezed == introVideoRef ? _self.introVideoRef : introVideoRef // ignore: cast_nullable_to_non_nullable
as String?,hiddenFromSearch: null == hiddenFromSearch ? _self.hiddenFromSearch : hiddenFromSearch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
