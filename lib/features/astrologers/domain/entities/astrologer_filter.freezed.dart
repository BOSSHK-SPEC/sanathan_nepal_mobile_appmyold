// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AstrologerFilter {

 String get query; Set<Specialty> get specialties; Set<String> get languageCodes; Set<ConsultChannel> get channels;/// Per-minute price ceiling; null means no ceiling.
 double? get maxRate; double get minRating; int get minExperience; bool get onlineOnly;/// Restricts to astrologers the seeker follows. Set by the Following
/// screen rather than the filter sheet, so it is deliberately absent
/// from [activeCount] and survives [cleared].
 bool get followingOnly; AstrologerSort get sort;
/// Create a copy of AstrologerFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerFilterCopyWith<AstrologerFilter> get copyWith => _$AstrologerFilterCopyWithImpl<AstrologerFilter>(this as AstrologerFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerFilter&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.specialties, specialties)&&const DeepCollectionEquality().equals(other.languageCodes, languageCodes)&&const DeepCollectionEquality().equals(other.channels, channels)&&(identical(other.maxRate, maxRate) || other.maxRate == maxRate)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.minExperience, minExperience) || other.minExperience == minExperience)&&(identical(other.onlineOnly, onlineOnly) || other.onlineOnly == onlineOnly)&&(identical(other.followingOnly, followingOnly) || other.followingOnly == followingOnly)&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(specialties),const DeepCollectionEquality().hash(languageCodes),const DeepCollectionEquality().hash(channels),maxRate,minRating,minExperience,onlineOnly,followingOnly,sort);

@override
String toString() {
  return 'AstrologerFilter(query: $query, specialties: $specialties, languageCodes: $languageCodes, channels: $channels, maxRate: $maxRate, minRating: $minRating, minExperience: $minExperience, onlineOnly: $onlineOnly, followingOnly: $followingOnly, sort: $sort)';
}


}

/// @nodoc
abstract mixin class $AstrologerFilterCopyWith<$Res>  {
  factory $AstrologerFilterCopyWith(AstrologerFilter value, $Res Function(AstrologerFilter) _then) = _$AstrologerFilterCopyWithImpl;
@useResult
$Res call({
 String query, Set<Specialty> specialties, Set<String> languageCodes, Set<ConsultChannel> channels, double? maxRate, double minRating, int minExperience, bool onlineOnly, bool followingOnly, AstrologerSort sort
});




}
/// @nodoc
class _$AstrologerFilterCopyWithImpl<$Res>
    implements $AstrologerFilterCopyWith<$Res> {
  _$AstrologerFilterCopyWithImpl(this._self, this._then);

  final AstrologerFilter _self;
  final $Res Function(AstrologerFilter) _then;

/// Create a copy of AstrologerFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? specialties = null,Object? languageCodes = null,Object? channels = null,Object? maxRate = freezed,Object? minRating = null,Object? minExperience = null,Object? onlineOnly = null,Object? followingOnly = null,Object? sort = null,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,specialties: null == specialties ? _self.specialties : specialties // ignore: cast_nullable_to_non_nullable
as Set<Specialty>,languageCodes: null == languageCodes ? _self.languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as Set<String>,channels: null == channels ? _self.channels : channels // ignore: cast_nullable_to_non_nullable
as Set<ConsultChannel>,maxRate: freezed == maxRate ? _self.maxRate : maxRate // ignore: cast_nullable_to_non_nullable
as double?,minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double,minExperience: null == minExperience ? _self.minExperience : minExperience // ignore: cast_nullable_to_non_nullable
as int,onlineOnly: null == onlineOnly ? _self.onlineOnly : onlineOnly // ignore: cast_nullable_to_non_nullable
as bool,followingOnly: null == followingOnly ? _self.followingOnly : followingOnly // ignore: cast_nullable_to_non_nullable
as bool,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as AstrologerSort,
  ));
}

}



/// @nodoc


class _AstrologerFilter extends AstrologerFilter {
  const _AstrologerFilter({this.query = '', final  Set<Specialty> specialties = const {}, final  Set<String> languageCodes = const {}, final  Set<ConsultChannel> channels = const {}, this.maxRate, this.minRating = 0, this.minExperience = 0, this.onlineOnly = false, this.followingOnly = false, this.sort = AstrologerSort.recommended}): _specialties = specialties,_languageCodes = languageCodes,_channels = channels,super._();
  

@override@JsonKey() final  String query;
 final  Set<Specialty> _specialties;
@override@JsonKey() Set<Specialty> get specialties {
  if (_specialties is EqualUnmodifiableSetView) return _specialties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_specialties);
}

 final  Set<String> _languageCodes;
@override@JsonKey() Set<String> get languageCodes {
  if (_languageCodes is EqualUnmodifiableSetView) return _languageCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_languageCodes);
}

 final  Set<ConsultChannel> _channels;
@override@JsonKey() Set<ConsultChannel> get channels {
  if (_channels is EqualUnmodifiableSetView) return _channels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_channels);
}

/// Per-minute price ceiling; null means no ceiling.
@override final  double? maxRate;
@override@JsonKey() final  double minRating;
@override@JsonKey() final  int minExperience;
@override@JsonKey() final  bool onlineOnly;
/// Restricts to astrologers the seeker follows. Set by the Following
/// screen rather than the filter sheet, so it is deliberately absent
/// from [activeCount] and survives [cleared].
@override@JsonKey() final  bool followingOnly;
@override@JsonKey() final  AstrologerSort sort;

/// Create a copy of AstrologerFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerFilterCopyWith<_AstrologerFilter> get copyWith => __$AstrologerFilterCopyWithImpl<_AstrologerFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerFilter&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._specialties, _specialties)&&const DeepCollectionEquality().equals(other._languageCodes, _languageCodes)&&const DeepCollectionEquality().equals(other._channels, _channels)&&(identical(other.maxRate, maxRate) || other.maxRate == maxRate)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.minExperience, minExperience) || other.minExperience == minExperience)&&(identical(other.onlineOnly, onlineOnly) || other.onlineOnly == onlineOnly)&&(identical(other.followingOnly, followingOnly) || other.followingOnly == followingOnly)&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_specialties),const DeepCollectionEquality().hash(_languageCodes),const DeepCollectionEquality().hash(_channels),maxRate,minRating,minExperience,onlineOnly,followingOnly,sort);

@override
String toString() {
  return 'AstrologerFilter(query: $query, specialties: $specialties, languageCodes: $languageCodes, channels: $channels, maxRate: $maxRate, minRating: $minRating, minExperience: $minExperience, onlineOnly: $onlineOnly, followingOnly: $followingOnly, sort: $sort)';
}


}

/// @nodoc
abstract mixin class _$AstrologerFilterCopyWith<$Res> implements $AstrologerFilterCopyWith<$Res> {
  factory _$AstrologerFilterCopyWith(_AstrologerFilter value, $Res Function(_AstrologerFilter) _then) = __$AstrologerFilterCopyWithImpl;
@override @useResult
$Res call({
 String query, Set<Specialty> specialties, Set<String> languageCodes, Set<ConsultChannel> channels, double? maxRate, double minRating, int minExperience, bool onlineOnly, bool followingOnly, AstrologerSort sort
});




}
/// @nodoc
class __$AstrologerFilterCopyWithImpl<$Res>
    implements _$AstrologerFilterCopyWith<$Res> {
  __$AstrologerFilterCopyWithImpl(this._self, this._then);

  final _AstrologerFilter _self;
  final $Res Function(_AstrologerFilter) _then;

/// Create a copy of AstrologerFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? specialties = null,Object? languageCodes = null,Object? channels = null,Object? maxRate = freezed,Object? minRating = null,Object? minExperience = null,Object? onlineOnly = null,Object? followingOnly = null,Object? sort = null,}) {
  return _then(_AstrologerFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,specialties: null == specialties ? _self._specialties : specialties // ignore: cast_nullable_to_non_nullable
as Set<Specialty>,languageCodes: null == languageCodes ? _self._languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as Set<String>,channels: null == channels ? _self._channels : channels // ignore: cast_nullable_to_non_nullable
as Set<ConsultChannel>,maxRate: freezed == maxRate ? _self.maxRate : maxRate // ignore: cast_nullable_to_non_nullable
as double?,minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double,minExperience: null == minExperience ? _self.minExperience : minExperience // ignore: cast_nullable_to_non_nullable
as int,onlineOnly: null == onlineOnly ? _self.onlineOnly : onlineOnly // ignore: cast_nullable_to_non_nullable
as bool,followingOnly: null == followingOnly ? _self.followingOnly : followingOnly // ignore: cast_nullable_to_non_nullable
as bool,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as AstrologerSort,
  ));
}


}

// dart format on
