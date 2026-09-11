// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gun_milan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KootaScore {

 Koota get koota; int get points;
/// Create a copy of KootaScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KootaScoreCopyWith<KootaScore> get copyWith => _$KootaScoreCopyWithImpl<KootaScore>(this as KootaScore, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KootaScore&&(identical(other.koota, koota) || other.koota == koota)&&(identical(other.points, points) || other.points == points));
}


@override
int get hashCode => Object.hash(runtimeType,koota,points);

@override
String toString() {
  return 'KootaScore(koota: $koota, points: $points)';
}


}

/// @nodoc
abstract mixin class $KootaScoreCopyWith<$Res>  {
  factory $KootaScoreCopyWith(KootaScore value, $Res Function(KootaScore) _then) = _$KootaScoreCopyWithImpl;
@useResult
$Res call({
 Koota koota, int points
});




}
/// @nodoc
class _$KootaScoreCopyWithImpl<$Res>
    implements $KootaScoreCopyWith<$Res> {
  _$KootaScoreCopyWithImpl(this._self, this._then);

  final KootaScore _self;
  final $Res Function(KootaScore) _then;

/// Create a copy of KootaScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? koota = null,Object? points = null,}) {
  return _then(_self.copyWith(
koota: null == koota ? _self.koota : koota // ignore: cast_nullable_to_non_nullable
as Koota,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _KootaScore extends KootaScore {
  const _KootaScore({required this.koota, required this.points}): super._();
  

@override final  Koota koota;
@override final  int points;

/// Create a copy of KootaScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KootaScoreCopyWith<_KootaScore> get copyWith => __$KootaScoreCopyWithImpl<_KootaScore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KootaScore&&(identical(other.koota, koota) || other.koota == koota)&&(identical(other.points, points) || other.points == points));
}


@override
int get hashCode => Object.hash(runtimeType,koota,points);

@override
String toString() {
  return 'KootaScore(koota: $koota, points: $points)';
}


}

/// @nodoc
abstract mixin class _$KootaScoreCopyWith<$Res> implements $KootaScoreCopyWith<$Res> {
  factory _$KootaScoreCopyWith(_KootaScore value, $Res Function(_KootaScore) _then) = __$KootaScoreCopyWithImpl;
@override @useResult
$Res call({
 Koota koota, int points
});




}
/// @nodoc
class __$KootaScoreCopyWithImpl<$Res>
    implements _$KootaScoreCopyWith<$Res> {
  __$KootaScoreCopyWithImpl(this._self, this._then);

  final _KootaScore _self;
  final $Res Function(_KootaScore) _then;

/// Create a copy of KootaScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? koota = null,Object? points = null,}) {
  return _then(_KootaScore(
koota: null == koota ? _self.koota : koota // ignore: cast_nullable_to_non_nullable
as Koota,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$GunMilanResult {

 String get brideProfileId; String get groomProfileId; List<KootaScore> get scores; DoshaReading get brideManglik; DoshaReading get groomManglik;
/// Create a copy of GunMilanResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GunMilanResultCopyWith<GunMilanResult> get copyWith => _$GunMilanResultCopyWithImpl<GunMilanResult>(this as GunMilanResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GunMilanResult&&(identical(other.brideProfileId, brideProfileId) || other.brideProfileId == brideProfileId)&&(identical(other.groomProfileId, groomProfileId) || other.groomProfileId == groomProfileId)&&const DeepCollectionEquality().equals(other.scores, scores)&&(identical(other.brideManglik, brideManglik) || other.brideManglik == brideManglik)&&(identical(other.groomManglik, groomManglik) || other.groomManglik == groomManglik));
}


@override
int get hashCode => Object.hash(runtimeType,brideProfileId,groomProfileId,const DeepCollectionEquality().hash(scores),brideManglik,groomManglik);

@override
String toString() {
  return 'GunMilanResult(brideProfileId: $brideProfileId, groomProfileId: $groomProfileId, scores: $scores, brideManglik: $brideManglik, groomManglik: $groomManglik)';
}


}

/// @nodoc
abstract mixin class $GunMilanResultCopyWith<$Res>  {
  factory $GunMilanResultCopyWith(GunMilanResult value, $Res Function(GunMilanResult) _then) = _$GunMilanResultCopyWithImpl;
@useResult
$Res call({
 String brideProfileId, String groomProfileId, List<KootaScore> scores, DoshaReading brideManglik, DoshaReading groomManglik
});


$DoshaReadingCopyWith<$Res> get brideManglik;$DoshaReadingCopyWith<$Res> get groomManglik;

}
/// @nodoc
class _$GunMilanResultCopyWithImpl<$Res>
    implements $GunMilanResultCopyWith<$Res> {
  _$GunMilanResultCopyWithImpl(this._self, this._then);

  final GunMilanResult _self;
  final $Res Function(GunMilanResult) _then;

/// Create a copy of GunMilanResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? brideProfileId = null,Object? groomProfileId = null,Object? scores = null,Object? brideManglik = null,Object? groomManglik = null,}) {
  return _then(_self.copyWith(
brideProfileId: null == brideProfileId ? _self.brideProfileId : brideProfileId // ignore: cast_nullable_to_non_nullable
as String,groomProfileId: null == groomProfileId ? _self.groomProfileId : groomProfileId // ignore: cast_nullable_to_non_nullable
as String,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as List<KootaScore>,brideManglik: null == brideManglik ? _self.brideManglik : brideManglik // ignore: cast_nullable_to_non_nullable
as DoshaReading,groomManglik: null == groomManglik ? _self.groomManglik : groomManglik // ignore: cast_nullable_to_non_nullable
as DoshaReading,
  ));
}
/// Create a copy of GunMilanResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DoshaReadingCopyWith<$Res> get brideManglik {
  
  return $DoshaReadingCopyWith<$Res>(_self.brideManglik, (value) {
    return _then(_self.copyWith(brideManglik: value));
  });
}/// Create a copy of GunMilanResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DoshaReadingCopyWith<$Res> get groomManglik {
  
  return $DoshaReadingCopyWith<$Res>(_self.groomManglik, (value) {
    return _then(_self.copyWith(groomManglik: value));
  });
}
}



/// @nodoc


class _GunMilanResult extends GunMilanResult {
  const _GunMilanResult({required this.brideProfileId, required this.groomProfileId, required final  List<KootaScore> scores, required this.brideManglik, required this.groomManglik}): _scores = scores,super._();
  

@override final  String brideProfileId;
@override final  String groomProfileId;
 final  List<KootaScore> _scores;
@override List<KootaScore> get scores {
  if (_scores is EqualUnmodifiableListView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scores);
}

@override final  DoshaReading brideManglik;
@override final  DoshaReading groomManglik;

/// Create a copy of GunMilanResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GunMilanResultCopyWith<_GunMilanResult> get copyWith => __$GunMilanResultCopyWithImpl<_GunMilanResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GunMilanResult&&(identical(other.brideProfileId, brideProfileId) || other.brideProfileId == brideProfileId)&&(identical(other.groomProfileId, groomProfileId) || other.groomProfileId == groomProfileId)&&const DeepCollectionEquality().equals(other._scores, _scores)&&(identical(other.brideManglik, brideManglik) || other.brideManglik == brideManglik)&&(identical(other.groomManglik, groomManglik) || other.groomManglik == groomManglik));
}


@override
int get hashCode => Object.hash(runtimeType,brideProfileId,groomProfileId,const DeepCollectionEquality().hash(_scores),brideManglik,groomManglik);

@override
String toString() {
  return 'GunMilanResult(brideProfileId: $brideProfileId, groomProfileId: $groomProfileId, scores: $scores, brideManglik: $brideManglik, groomManglik: $groomManglik)';
}


}

/// @nodoc
abstract mixin class _$GunMilanResultCopyWith<$Res> implements $GunMilanResultCopyWith<$Res> {
  factory _$GunMilanResultCopyWith(_GunMilanResult value, $Res Function(_GunMilanResult) _then) = __$GunMilanResultCopyWithImpl;
@override @useResult
$Res call({
 String brideProfileId, String groomProfileId, List<KootaScore> scores, DoshaReading brideManglik, DoshaReading groomManglik
});


@override $DoshaReadingCopyWith<$Res> get brideManglik;@override $DoshaReadingCopyWith<$Res> get groomManglik;

}
/// @nodoc
class __$GunMilanResultCopyWithImpl<$Res>
    implements _$GunMilanResultCopyWith<$Res> {
  __$GunMilanResultCopyWithImpl(this._self, this._then);

  final _GunMilanResult _self;
  final $Res Function(_GunMilanResult) _then;

/// Create a copy of GunMilanResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? brideProfileId = null,Object? groomProfileId = null,Object? scores = null,Object? brideManglik = null,Object? groomManglik = null,}) {
  return _then(_GunMilanResult(
brideProfileId: null == brideProfileId ? _self.brideProfileId : brideProfileId // ignore: cast_nullable_to_non_nullable
as String,groomProfileId: null == groomProfileId ? _self.groomProfileId : groomProfileId // ignore: cast_nullable_to_non_nullable
as String,scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as List<KootaScore>,brideManglik: null == brideManglik ? _self.brideManglik : brideManglik // ignore: cast_nullable_to_non_nullable
as DoshaReading,groomManglik: null == groomManglik ? _self.groomManglik : groomManglik // ignore: cast_nullable_to_non_nullable
as DoshaReading,
  ));
}

/// Create a copy of GunMilanResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DoshaReadingCopyWith<$Res> get brideManglik {
  
  return $DoshaReadingCopyWith<$Res>(_self.brideManglik, (value) {
    return _then(_self.copyWith(brideManglik: value));
  });
}/// Create a copy of GunMilanResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DoshaReadingCopyWith<$Res> get groomManglik {
  
  return $DoshaReadingCopyWith<$Res>(_self.groomManglik, (value) {
    return _then(_self.copyWith(groomManglik: value));
  });
}
}

// dart format on
