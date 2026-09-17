// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_panchanga.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PanchangaText {

 String get en; String get ne; String get hi;
/// Create a copy of PanchangaText
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<PanchangaText> get copyWith => _$PanchangaTextCopyWithImpl<PanchangaText>(this as PanchangaText, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PanchangaText&&(identical(other.en, en) || other.en == en)&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.hi, hi) || other.hi == hi));
}


@override
int get hashCode => Object.hash(runtimeType,en,ne,hi);

@override
String toString() {
  return 'PanchangaText(en: $en, ne: $ne, hi: $hi)';
}


}

/// @nodoc
abstract mixin class $PanchangaTextCopyWith<$Res>  {
  factory $PanchangaTextCopyWith(PanchangaText value, $Res Function(PanchangaText) _then) = _$PanchangaTextCopyWithImpl;
@useResult
$Res call({
 String en, String ne, String hi
});




}
/// @nodoc
class _$PanchangaTextCopyWithImpl<$Res>
    implements $PanchangaTextCopyWith<$Res> {
  _$PanchangaTextCopyWithImpl(this._self, this._then);

  final PanchangaText _self;
  final $Res Function(PanchangaText) _then;

/// Create a copy of PanchangaText
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? en = null,Object? ne = null,Object? hi = null,}) {
  return _then(_self.copyWith(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,ne: null == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String,hi: null == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _PanchangaText extends PanchangaText {
  const _PanchangaText({required this.en, required this.ne, this.hi = ''}): super._();
  

@override final  String en;
@override final  String ne;
@override@JsonKey() final  String hi;

/// Create a copy of PanchangaText
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PanchangaTextCopyWith<_PanchangaText> get copyWith => __$PanchangaTextCopyWithImpl<_PanchangaText>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PanchangaText&&(identical(other.en, en) || other.en == en)&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.hi, hi) || other.hi == hi));
}


@override
int get hashCode => Object.hash(runtimeType,en,ne,hi);

@override
String toString() {
  return 'PanchangaText(en: $en, ne: $ne, hi: $hi)';
}


}

/// @nodoc
abstract mixin class _$PanchangaTextCopyWith<$Res> implements $PanchangaTextCopyWith<$Res> {
  factory _$PanchangaTextCopyWith(_PanchangaText value, $Res Function(_PanchangaText) _then) = __$PanchangaTextCopyWithImpl;
@override @useResult
$Res call({
 String en, String ne, String hi
});




}
/// @nodoc
class __$PanchangaTextCopyWithImpl<$Res>
    implements _$PanchangaTextCopyWith<$Res> {
  __$PanchangaTextCopyWithImpl(this._self, this._then);

  final _PanchangaText _self;
  final $Res Function(_PanchangaText) _then;

/// Create a copy of PanchangaText
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? en = null,Object? ne = null,Object? hi = null,}) {
  return _then(_PanchangaText(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,ne: null == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String,hi: null == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DayPanchanga {

 DateTime get date;/// 0–29: 0–14 Shukla (14 = Purnima), 15–29 Krishna (29 = Amavasya).
 int get tithiIndex; PanchangaText get tithi; Paksha get paksha;/// When the sunrise tithi gives way to the next; unknown for an estimate.
 DateTime? get tithiEndsAt; PanchangaText get nakshatra; PanchangaText get yoga; PanchangaText get karana; PanchangaText get moonRashi;/// Purnimanta lunar month — the naming festival tithis use.
 PanchangaText get lunarMonth; bool get isAdhikaMonth; List<VratKind> get vrat; DateTime get sunrise; DateTime get sunset; bool get isApproximate;
/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayPanchangaCopyWith<DayPanchanga> get copyWith => _$DayPanchangaCopyWithImpl<DayPanchanga>(this as DayPanchanga, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayPanchanga&&(identical(other.date, date) || other.date == date)&&(identical(other.tithiIndex, tithiIndex) || other.tithiIndex == tithiIndex)&&(identical(other.tithi, tithi) || other.tithi == tithi)&&(identical(other.paksha, paksha) || other.paksha == paksha)&&(identical(other.tithiEndsAt, tithiEndsAt) || other.tithiEndsAt == tithiEndsAt)&&(identical(other.nakshatra, nakshatra) || other.nakshatra == nakshatra)&&(identical(other.yoga, yoga) || other.yoga == yoga)&&(identical(other.karana, karana) || other.karana == karana)&&(identical(other.moonRashi, moonRashi) || other.moonRashi == moonRashi)&&(identical(other.lunarMonth, lunarMonth) || other.lunarMonth == lunarMonth)&&(identical(other.isAdhikaMonth, isAdhikaMonth) || other.isAdhikaMonth == isAdhikaMonth)&&const DeepCollectionEquality().equals(other.vrat, vrat)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.isApproximate, isApproximate) || other.isApproximate == isApproximate));
}


@override
int get hashCode => Object.hash(runtimeType,date,tithiIndex,tithi,paksha,tithiEndsAt,nakshatra,yoga,karana,moonRashi,lunarMonth,isAdhikaMonth,const DeepCollectionEquality().hash(vrat),sunrise,sunset,isApproximate);

@override
String toString() {
  return 'DayPanchanga(date: $date, tithiIndex: $tithiIndex, tithi: $tithi, paksha: $paksha, tithiEndsAt: $tithiEndsAt, nakshatra: $nakshatra, yoga: $yoga, karana: $karana, moonRashi: $moonRashi, lunarMonth: $lunarMonth, isAdhikaMonth: $isAdhikaMonth, vrat: $vrat, sunrise: $sunrise, sunset: $sunset, isApproximate: $isApproximate)';
}


}

/// @nodoc
abstract mixin class $DayPanchangaCopyWith<$Res>  {
  factory $DayPanchangaCopyWith(DayPanchanga value, $Res Function(DayPanchanga) _then) = _$DayPanchangaCopyWithImpl;
@useResult
$Res call({
 DateTime date, int tithiIndex, PanchangaText tithi, Paksha paksha, DateTime? tithiEndsAt, PanchangaText nakshatra, PanchangaText yoga, PanchangaText karana, PanchangaText moonRashi, PanchangaText lunarMonth, bool isAdhikaMonth, List<VratKind> vrat, DateTime sunrise, DateTime sunset, bool isApproximate
});


$PanchangaTextCopyWith<$Res> get tithi;$PanchangaTextCopyWith<$Res> get nakshatra;$PanchangaTextCopyWith<$Res> get yoga;$PanchangaTextCopyWith<$Res> get karana;$PanchangaTextCopyWith<$Res> get moonRashi;$PanchangaTextCopyWith<$Res> get lunarMonth;

}
/// @nodoc
class _$DayPanchangaCopyWithImpl<$Res>
    implements $DayPanchangaCopyWith<$Res> {
  _$DayPanchangaCopyWithImpl(this._self, this._then);

  final DayPanchanga _self;
  final $Res Function(DayPanchanga) _then;

/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? tithiIndex = null,Object? tithi = null,Object? paksha = null,Object? tithiEndsAt = freezed,Object? nakshatra = null,Object? yoga = null,Object? karana = null,Object? moonRashi = null,Object? lunarMonth = null,Object? isAdhikaMonth = null,Object? vrat = null,Object? sunrise = null,Object? sunset = null,Object? isApproximate = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,tithiIndex: null == tithiIndex ? _self.tithiIndex : tithiIndex // ignore: cast_nullable_to_non_nullable
as int,tithi: null == tithi ? _self.tithi : tithi // ignore: cast_nullable_to_non_nullable
as PanchangaText,paksha: null == paksha ? _self.paksha : paksha // ignore: cast_nullable_to_non_nullable
as Paksha,tithiEndsAt: freezed == tithiEndsAt ? _self.tithiEndsAt : tithiEndsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nakshatra: null == nakshatra ? _self.nakshatra : nakshatra // ignore: cast_nullable_to_non_nullable
as PanchangaText,yoga: null == yoga ? _self.yoga : yoga // ignore: cast_nullable_to_non_nullable
as PanchangaText,karana: null == karana ? _self.karana : karana // ignore: cast_nullable_to_non_nullable
as PanchangaText,moonRashi: null == moonRashi ? _self.moonRashi : moonRashi // ignore: cast_nullable_to_non_nullable
as PanchangaText,lunarMonth: null == lunarMonth ? _self.lunarMonth : lunarMonth // ignore: cast_nullable_to_non_nullable
as PanchangaText,isAdhikaMonth: null == isAdhikaMonth ? _self.isAdhikaMonth : isAdhikaMonth // ignore: cast_nullable_to_non_nullable
as bool,vrat: null == vrat ? _self.vrat : vrat // ignore: cast_nullable_to_non_nullable
as List<VratKind>,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,isApproximate: null == isApproximate ? _self.isApproximate : isApproximate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get tithi {
  
  return $PanchangaTextCopyWith<$Res>(_self.tithi, (value) {
    return _then(_self.copyWith(tithi: value));
  });
}/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get nakshatra {
  
  return $PanchangaTextCopyWith<$Res>(_self.nakshatra, (value) {
    return _then(_self.copyWith(nakshatra: value));
  });
}/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get yoga {
  
  return $PanchangaTextCopyWith<$Res>(_self.yoga, (value) {
    return _then(_self.copyWith(yoga: value));
  });
}/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get karana {
  
  return $PanchangaTextCopyWith<$Res>(_self.karana, (value) {
    return _then(_self.copyWith(karana: value));
  });
}/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get moonRashi {
  
  return $PanchangaTextCopyWith<$Res>(_self.moonRashi, (value) {
    return _then(_self.copyWith(moonRashi: value));
  });
}/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get lunarMonth {
  
  return $PanchangaTextCopyWith<$Res>(_self.lunarMonth, (value) {
    return _then(_self.copyWith(lunarMonth: value));
  });
}
}



/// @nodoc


class _DayPanchanga extends DayPanchanga {
  const _DayPanchanga({required this.date, required this.tithiIndex, required this.tithi, required this.paksha, this.tithiEndsAt, required this.nakshatra, required this.yoga, required this.karana, required this.moonRashi, required this.lunarMonth, this.isAdhikaMonth = false, final  List<VratKind> vrat = const <VratKind>[], required this.sunrise, required this.sunset, this.isApproximate = false}): _vrat = vrat,super._();
  

@override final  DateTime date;
/// 0–29: 0–14 Shukla (14 = Purnima), 15–29 Krishna (29 = Amavasya).
@override final  int tithiIndex;
@override final  PanchangaText tithi;
@override final  Paksha paksha;
/// When the sunrise tithi gives way to the next; unknown for an estimate.
@override final  DateTime? tithiEndsAt;
@override final  PanchangaText nakshatra;
@override final  PanchangaText yoga;
@override final  PanchangaText karana;
@override final  PanchangaText moonRashi;
/// Purnimanta lunar month — the naming festival tithis use.
@override final  PanchangaText lunarMonth;
@override@JsonKey() final  bool isAdhikaMonth;
 final  List<VratKind> _vrat;
@override@JsonKey() List<VratKind> get vrat {
  if (_vrat is EqualUnmodifiableListView) return _vrat;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vrat);
}

@override final  DateTime sunrise;
@override final  DateTime sunset;
@override@JsonKey() final  bool isApproximate;

/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayPanchangaCopyWith<_DayPanchanga> get copyWith => __$DayPanchangaCopyWithImpl<_DayPanchanga>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayPanchanga&&(identical(other.date, date) || other.date == date)&&(identical(other.tithiIndex, tithiIndex) || other.tithiIndex == tithiIndex)&&(identical(other.tithi, tithi) || other.tithi == tithi)&&(identical(other.paksha, paksha) || other.paksha == paksha)&&(identical(other.tithiEndsAt, tithiEndsAt) || other.tithiEndsAt == tithiEndsAt)&&(identical(other.nakshatra, nakshatra) || other.nakshatra == nakshatra)&&(identical(other.yoga, yoga) || other.yoga == yoga)&&(identical(other.karana, karana) || other.karana == karana)&&(identical(other.moonRashi, moonRashi) || other.moonRashi == moonRashi)&&(identical(other.lunarMonth, lunarMonth) || other.lunarMonth == lunarMonth)&&(identical(other.isAdhikaMonth, isAdhikaMonth) || other.isAdhikaMonth == isAdhikaMonth)&&const DeepCollectionEquality().equals(other._vrat, _vrat)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.isApproximate, isApproximate) || other.isApproximate == isApproximate));
}


@override
int get hashCode => Object.hash(runtimeType,date,tithiIndex,tithi,paksha,tithiEndsAt,nakshatra,yoga,karana,moonRashi,lunarMonth,isAdhikaMonth,const DeepCollectionEquality().hash(_vrat),sunrise,sunset,isApproximate);

@override
String toString() {
  return 'DayPanchanga(date: $date, tithiIndex: $tithiIndex, tithi: $tithi, paksha: $paksha, tithiEndsAt: $tithiEndsAt, nakshatra: $nakshatra, yoga: $yoga, karana: $karana, moonRashi: $moonRashi, lunarMonth: $lunarMonth, isAdhikaMonth: $isAdhikaMonth, vrat: $vrat, sunrise: $sunrise, sunset: $sunset, isApproximate: $isApproximate)';
}


}

/// @nodoc
abstract mixin class _$DayPanchangaCopyWith<$Res> implements $DayPanchangaCopyWith<$Res> {
  factory _$DayPanchangaCopyWith(_DayPanchanga value, $Res Function(_DayPanchanga) _then) = __$DayPanchangaCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int tithiIndex, PanchangaText tithi, Paksha paksha, DateTime? tithiEndsAt, PanchangaText nakshatra, PanchangaText yoga, PanchangaText karana, PanchangaText moonRashi, PanchangaText lunarMonth, bool isAdhikaMonth, List<VratKind> vrat, DateTime sunrise, DateTime sunset, bool isApproximate
});


@override $PanchangaTextCopyWith<$Res> get tithi;@override $PanchangaTextCopyWith<$Res> get nakshatra;@override $PanchangaTextCopyWith<$Res> get yoga;@override $PanchangaTextCopyWith<$Res> get karana;@override $PanchangaTextCopyWith<$Res> get moonRashi;@override $PanchangaTextCopyWith<$Res> get lunarMonth;

}
/// @nodoc
class __$DayPanchangaCopyWithImpl<$Res>
    implements _$DayPanchangaCopyWith<$Res> {
  __$DayPanchangaCopyWithImpl(this._self, this._then);

  final _DayPanchanga _self;
  final $Res Function(_DayPanchanga) _then;

/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? tithiIndex = null,Object? tithi = null,Object? paksha = null,Object? tithiEndsAt = freezed,Object? nakshatra = null,Object? yoga = null,Object? karana = null,Object? moonRashi = null,Object? lunarMonth = null,Object? isAdhikaMonth = null,Object? vrat = null,Object? sunrise = null,Object? sunset = null,Object? isApproximate = null,}) {
  return _then(_DayPanchanga(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,tithiIndex: null == tithiIndex ? _self.tithiIndex : tithiIndex // ignore: cast_nullable_to_non_nullable
as int,tithi: null == tithi ? _self.tithi : tithi // ignore: cast_nullable_to_non_nullable
as PanchangaText,paksha: null == paksha ? _self.paksha : paksha // ignore: cast_nullable_to_non_nullable
as Paksha,tithiEndsAt: freezed == tithiEndsAt ? _self.tithiEndsAt : tithiEndsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nakshatra: null == nakshatra ? _self.nakshatra : nakshatra // ignore: cast_nullable_to_non_nullable
as PanchangaText,yoga: null == yoga ? _self.yoga : yoga // ignore: cast_nullable_to_non_nullable
as PanchangaText,karana: null == karana ? _self.karana : karana // ignore: cast_nullable_to_non_nullable
as PanchangaText,moonRashi: null == moonRashi ? _self.moonRashi : moonRashi // ignore: cast_nullable_to_non_nullable
as PanchangaText,lunarMonth: null == lunarMonth ? _self.lunarMonth : lunarMonth // ignore: cast_nullable_to_non_nullable
as PanchangaText,isAdhikaMonth: null == isAdhikaMonth ? _self.isAdhikaMonth : isAdhikaMonth // ignore: cast_nullable_to_non_nullable
as bool,vrat: null == vrat ? _self._vrat : vrat // ignore: cast_nullable_to_non_nullable
as List<VratKind>,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,isApproximate: null == isApproximate ? _self.isApproximate : isApproximate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get tithi {
  
  return $PanchangaTextCopyWith<$Res>(_self.tithi, (value) {
    return _then(_self.copyWith(tithi: value));
  });
}/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get nakshatra {
  
  return $PanchangaTextCopyWith<$Res>(_self.nakshatra, (value) {
    return _then(_self.copyWith(nakshatra: value));
  });
}/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get yoga {
  
  return $PanchangaTextCopyWith<$Res>(_self.yoga, (value) {
    return _then(_self.copyWith(yoga: value));
  });
}/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get karana {
  
  return $PanchangaTextCopyWith<$Res>(_self.karana, (value) {
    return _then(_self.copyWith(karana: value));
  });
}/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get moonRashi {
  
  return $PanchangaTextCopyWith<$Res>(_self.moonRashi, (value) {
    return _then(_self.copyWith(moonRashi: value));
  });
}/// Create a copy of DayPanchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaTextCopyWith<$Res> get lunarMonth {
  
  return $PanchangaTextCopyWith<$Res>(_self.lunarMonth, (value) {
    return _then(_self.copyWith(lunarMonth: value));
  });
}
}

// dart format on
