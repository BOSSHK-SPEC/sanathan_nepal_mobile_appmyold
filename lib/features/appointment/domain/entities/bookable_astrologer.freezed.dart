// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookable_astrologer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookableAstrologer {

 String get id; LocalizedText get name;/// Headline, e.g. "Vedic astrologer, 15 years".
 LocalizedText get title; double get rating; int get reviewCount;/// The sittings on offer, cheapest first.
 List<SittingOption> get services;/// Live right now. Offline astrologers are still bookable — that is the
/// whole point of the slot calendar — so this only changes the wording.
 bool get isOnline; bool get isVerified; String? get avatarAsset;
/// Create a copy of BookableAstrologer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookableAstrologerCopyWith<BookableAstrologer> get copyWith => _$BookableAstrologerCopyWithImpl<BookableAstrologer>(this as BookableAstrologer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookableAstrologer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other.services, services)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.avatarAsset, avatarAsset) || other.avatarAsset == avatarAsset));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,title,rating,reviewCount,const DeepCollectionEquality().hash(services),isOnline,isVerified,avatarAsset);

@override
String toString() {
  return 'BookableAstrologer(id: $id, name: $name, title: $title, rating: $rating, reviewCount: $reviewCount, services: $services, isOnline: $isOnline, isVerified: $isVerified, avatarAsset: $avatarAsset)';
}


}

/// @nodoc
abstract mixin class $BookableAstrologerCopyWith<$Res>  {
  factory $BookableAstrologerCopyWith(BookableAstrologer value, $Res Function(BookableAstrologer) _then) = _$BookableAstrologerCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText name, LocalizedText title, double rating, int reviewCount, List<SittingOption> services, bool isOnline, bool isVerified, String? avatarAsset
});


$LocalizedTextCopyWith<$Res> get name;$LocalizedTextCopyWith<$Res> get title;

}
/// @nodoc
class _$BookableAstrologerCopyWithImpl<$Res>
    implements $BookableAstrologerCopyWith<$Res> {
  _$BookableAstrologerCopyWithImpl(this._self, this._then);

  final BookableAstrologer _self;
  final $Res Function(BookableAstrologer) _then;

/// Create a copy of BookableAstrologer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? title = null,Object? rating = null,Object? reviewCount = null,Object? services = null,Object? isOnline = null,Object? isVerified = null,Object? avatarAsset = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<SittingOption>,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,avatarAsset: freezed == avatarAsset ? _self.avatarAsset : avatarAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BookableAstrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of BookableAstrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}



/// @nodoc


class _BookableAstrologer extends BookableAstrologer {
  const _BookableAstrologer({required this.id, required this.name, required this.title, required this.rating, required this.reviewCount, required final  List<SittingOption> services, this.isOnline = false, this.isVerified = false, this.avatarAsset}): _services = services,super._();
  

@override final  String id;
@override final  LocalizedText name;
/// Headline, e.g. "Vedic astrologer, 15 years".
@override final  LocalizedText title;
@override final  double rating;
@override final  int reviewCount;
/// The sittings on offer, cheapest first.
 final  List<SittingOption> _services;
/// The sittings on offer, cheapest first.
@override List<SittingOption> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

/// Live right now. Offline astrologers are still bookable — that is the
/// whole point of the slot calendar — so this only changes the wording.
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  bool isVerified;
@override final  String? avatarAsset;

/// Create a copy of BookableAstrologer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookableAstrologerCopyWith<_BookableAstrologer> get copyWith => __$BookableAstrologerCopyWithImpl<_BookableAstrologer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookableAstrologer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&const DeepCollectionEquality().equals(other._services, _services)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.avatarAsset, avatarAsset) || other.avatarAsset == avatarAsset));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,title,rating,reviewCount,const DeepCollectionEquality().hash(_services),isOnline,isVerified,avatarAsset);

@override
String toString() {
  return 'BookableAstrologer(id: $id, name: $name, title: $title, rating: $rating, reviewCount: $reviewCount, services: $services, isOnline: $isOnline, isVerified: $isVerified, avatarAsset: $avatarAsset)';
}


}

/// @nodoc
abstract mixin class _$BookableAstrologerCopyWith<$Res> implements $BookableAstrologerCopyWith<$Res> {
  factory _$BookableAstrologerCopyWith(_BookableAstrologer value, $Res Function(_BookableAstrologer) _then) = __$BookableAstrologerCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText name, LocalizedText title, double rating, int reviewCount, List<SittingOption> services, bool isOnline, bool isVerified, String? avatarAsset
});


@override $LocalizedTextCopyWith<$Res> get name;@override $LocalizedTextCopyWith<$Res> get title;

}
/// @nodoc
class __$BookableAstrologerCopyWithImpl<$Res>
    implements _$BookableAstrologerCopyWith<$Res> {
  __$BookableAstrologerCopyWithImpl(this._self, this._then);

  final _BookableAstrologer _self;
  final $Res Function(_BookableAstrologer) _then;

/// Create a copy of BookableAstrologer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? title = null,Object? rating = null,Object? reviewCount = null,Object? services = null,Object? isOnline = null,Object? isVerified = null,Object? avatarAsset = freezed,}) {
  return _then(_BookableAstrologer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<SittingOption>,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,avatarAsset: freezed == avatarAsset ? _self.avatarAsset : avatarAsset // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BookableAstrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of BookableAstrologer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}

// dart format on
