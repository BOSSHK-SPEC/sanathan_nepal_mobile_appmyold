// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panchanga.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Panchanga {

/// Gregorian civil date (midnight, local).
 DateTime get date; int get shakaSamvat; int get nepalSamvat; String get nepalSamvatMonthNe; String get nepalSamvatMonthEn;/// e.g. "फागुन शुक्ल पूर्णिमा" / "Falgun Shukla Purnima".
 String get tithiTitleNe; String get tithiTitleEn; PanchangaElement get tithi; PanchangaElement get nakshatra; PanchangaElement get karana; PanchangaElement get yoga; DateTime get sunrise; DateTime get sunset; DateTime get moonrise; DateTime get moonset;/// Rows of the day-level "थप जानकारी" table.
 List<PanchangaDetail> get dayDetails; String get chandraRashiNe; String get chandraRashiEn; String get anandadiYogaNe; String get anandadiYogaEn;/// सूर्योदयकालीन स्पष्ट ग्रहहरू (मंगल, बुध, बृहस्पति, शुक्र, शनि, राहु).
 List<PlanetPosition> get planets;/// Inauspicious weekday-based 1/8th-day windows between sunrise and sunset
/// (shown in India; computed for every region).
 TimeWindow? get rahuKaal; TimeWindow? get yamaganda; TimeWindow? get gulikaKaal;/// Auspicious midday window (solar noon ± 24 min).
 TimeWindow? get abhijitMuhurat;/// Eight daytime Choghadiya segments (sunrise → sunset), ascending.
 List<TimeWindow> get choghadiya;
/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PanchangaCopyWith<Panchanga> get copyWith => _$PanchangaCopyWithImpl<Panchanga>(this as Panchanga, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Panchanga&&(identical(other.date, date) || other.date == date)&&(identical(other.shakaSamvat, shakaSamvat) || other.shakaSamvat == shakaSamvat)&&(identical(other.nepalSamvat, nepalSamvat) || other.nepalSamvat == nepalSamvat)&&(identical(other.nepalSamvatMonthNe, nepalSamvatMonthNe) || other.nepalSamvatMonthNe == nepalSamvatMonthNe)&&(identical(other.nepalSamvatMonthEn, nepalSamvatMonthEn) || other.nepalSamvatMonthEn == nepalSamvatMonthEn)&&(identical(other.tithiTitleNe, tithiTitleNe) || other.tithiTitleNe == tithiTitleNe)&&(identical(other.tithiTitleEn, tithiTitleEn) || other.tithiTitleEn == tithiTitleEn)&&(identical(other.tithi, tithi) || other.tithi == tithi)&&(identical(other.nakshatra, nakshatra) || other.nakshatra == nakshatra)&&(identical(other.karana, karana) || other.karana == karana)&&(identical(other.yoga, yoga) || other.yoga == yoga)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.moonrise, moonrise) || other.moonrise == moonrise)&&(identical(other.moonset, moonset) || other.moonset == moonset)&&const DeepCollectionEquality().equals(other.dayDetails, dayDetails)&&(identical(other.chandraRashiNe, chandraRashiNe) || other.chandraRashiNe == chandraRashiNe)&&(identical(other.chandraRashiEn, chandraRashiEn) || other.chandraRashiEn == chandraRashiEn)&&(identical(other.anandadiYogaNe, anandadiYogaNe) || other.anandadiYogaNe == anandadiYogaNe)&&(identical(other.anandadiYogaEn, anandadiYogaEn) || other.anandadiYogaEn == anandadiYogaEn)&&const DeepCollectionEquality().equals(other.planets, planets)&&(identical(other.rahuKaal, rahuKaal) || other.rahuKaal == rahuKaal)&&(identical(other.yamaganda, yamaganda) || other.yamaganda == yamaganda)&&(identical(other.gulikaKaal, gulikaKaal) || other.gulikaKaal == gulikaKaal)&&(identical(other.abhijitMuhurat, abhijitMuhurat) || other.abhijitMuhurat == abhijitMuhurat)&&const DeepCollectionEquality().equals(other.choghadiya, choghadiya));
}


@override
int get hashCode => Object.hashAll([runtimeType,date,shakaSamvat,nepalSamvat,nepalSamvatMonthNe,nepalSamvatMonthEn,tithiTitleNe,tithiTitleEn,tithi,nakshatra,karana,yoga,sunrise,sunset,moonrise,moonset,const DeepCollectionEquality().hash(dayDetails),chandraRashiNe,chandraRashiEn,anandadiYogaNe,anandadiYogaEn,const DeepCollectionEquality().hash(planets),rahuKaal,yamaganda,gulikaKaal,abhijitMuhurat,const DeepCollectionEquality().hash(choghadiya)]);

@override
String toString() {
  return 'Panchanga(date: $date, shakaSamvat: $shakaSamvat, nepalSamvat: $nepalSamvat, nepalSamvatMonthNe: $nepalSamvatMonthNe, nepalSamvatMonthEn: $nepalSamvatMonthEn, tithiTitleNe: $tithiTitleNe, tithiTitleEn: $tithiTitleEn, tithi: $tithi, nakshatra: $nakshatra, karana: $karana, yoga: $yoga, sunrise: $sunrise, sunset: $sunset, moonrise: $moonrise, moonset: $moonset, dayDetails: $dayDetails, chandraRashiNe: $chandraRashiNe, chandraRashiEn: $chandraRashiEn, anandadiYogaNe: $anandadiYogaNe, anandadiYogaEn: $anandadiYogaEn, planets: $planets, rahuKaal: $rahuKaal, yamaganda: $yamaganda, gulikaKaal: $gulikaKaal, abhijitMuhurat: $abhijitMuhurat, choghadiya: $choghadiya)';
}


}

/// @nodoc
abstract mixin class $PanchangaCopyWith<$Res>  {
  factory $PanchangaCopyWith(Panchanga value, $Res Function(Panchanga) _then) = _$PanchangaCopyWithImpl;
@useResult
$Res call({
 DateTime date, int shakaSamvat, int nepalSamvat, String nepalSamvatMonthNe, String nepalSamvatMonthEn, String tithiTitleNe, String tithiTitleEn, PanchangaElement tithi, PanchangaElement nakshatra, PanchangaElement karana, PanchangaElement yoga, DateTime sunrise, DateTime sunset, DateTime moonrise, DateTime moonset, List<PanchangaDetail> dayDetails, String chandraRashiNe, String chandraRashiEn, String anandadiYogaNe, String anandadiYogaEn, List<PlanetPosition> planets, TimeWindow? rahuKaal, TimeWindow? yamaganda, TimeWindow? gulikaKaal, TimeWindow? abhijitMuhurat, List<TimeWindow> choghadiya
});


$PanchangaElementCopyWith<$Res> get tithi;$PanchangaElementCopyWith<$Res> get nakshatra;$PanchangaElementCopyWith<$Res> get karana;$PanchangaElementCopyWith<$Res> get yoga;$TimeWindowCopyWith<$Res>? get rahuKaal;$TimeWindowCopyWith<$Res>? get yamaganda;$TimeWindowCopyWith<$Res>? get gulikaKaal;$TimeWindowCopyWith<$Res>? get abhijitMuhurat;

}
/// @nodoc
class _$PanchangaCopyWithImpl<$Res>
    implements $PanchangaCopyWith<$Res> {
  _$PanchangaCopyWithImpl(this._self, this._then);

  final Panchanga _self;
  final $Res Function(Panchanga) _then;

/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? shakaSamvat = null,Object? nepalSamvat = null,Object? nepalSamvatMonthNe = null,Object? nepalSamvatMonthEn = null,Object? tithiTitleNe = null,Object? tithiTitleEn = null,Object? tithi = null,Object? nakshatra = null,Object? karana = null,Object? yoga = null,Object? sunrise = null,Object? sunset = null,Object? moonrise = null,Object? moonset = null,Object? dayDetails = null,Object? chandraRashiNe = null,Object? chandraRashiEn = null,Object? anandadiYogaNe = null,Object? anandadiYogaEn = null,Object? planets = null,Object? rahuKaal = freezed,Object? yamaganda = freezed,Object? gulikaKaal = freezed,Object? abhijitMuhurat = freezed,Object? choghadiya = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,shakaSamvat: null == shakaSamvat ? _self.shakaSamvat : shakaSamvat // ignore: cast_nullable_to_non_nullable
as int,nepalSamvat: null == nepalSamvat ? _self.nepalSamvat : nepalSamvat // ignore: cast_nullable_to_non_nullable
as int,nepalSamvatMonthNe: null == nepalSamvatMonthNe ? _self.nepalSamvatMonthNe : nepalSamvatMonthNe // ignore: cast_nullable_to_non_nullable
as String,nepalSamvatMonthEn: null == nepalSamvatMonthEn ? _self.nepalSamvatMonthEn : nepalSamvatMonthEn // ignore: cast_nullable_to_non_nullable
as String,tithiTitleNe: null == tithiTitleNe ? _self.tithiTitleNe : tithiTitleNe // ignore: cast_nullable_to_non_nullable
as String,tithiTitleEn: null == tithiTitleEn ? _self.tithiTitleEn : tithiTitleEn // ignore: cast_nullable_to_non_nullable
as String,tithi: null == tithi ? _self.tithi : tithi // ignore: cast_nullable_to_non_nullable
as PanchangaElement,nakshatra: null == nakshatra ? _self.nakshatra : nakshatra // ignore: cast_nullable_to_non_nullable
as PanchangaElement,karana: null == karana ? _self.karana : karana // ignore: cast_nullable_to_non_nullable
as PanchangaElement,yoga: null == yoga ? _self.yoga : yoga // ignore: cast_nullable_to_non_nullable
as PanchangaElement,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,moonrise: null == moonrise ? _self.moonrise : moonrise // ignore: cast_nullable_to_non_nullable
as DateTime,moonset: null == moonset ? _self.moonset : moonset // ignore: cast_nullable_to_non_nullable
as DateTime,dayDetails: null == dayDetails ? _self.dayDetails : dayDetails // ignore: cast_nullable_to_non_nullable
as List<PanchangaDetail>,chandraRashiNe: null == chandraRashiNe ? _self.chandraRashiNe : chandraRashiNe // ignore: cast_nullable_to_non_nullable
as String,chandraRashiEn: null == chandraRashiEn ? _self.chandraRashiEn : chandraRashiEn // ignore: cast_nullable_to_non_nullable
as String,anandadiYogaNe: null == anandadiYogaNe ? _self.anandadiYogaNe : anandadiYogaNe // ignore: cast_nullable_to_non_nullable
as String,anandadiYogaEn: null == anandadiYogaEn ? _self.anandadiYogaEn : anandadiYogaEn // ignore: cast_nullable_to_non_nullable
as String,planets: null == planets ? _self.planets : planets // ignore: cast_nullable_to_non_nullable
as List<PlanetPosition>,rahuKaal: freezed == rahuKaal ? _self.rahuKaal : rahuKaal // ignore: cast_nullable_to_non_nullable
as TimeWindow?,yamaganda: freezed == yamaganda ? _self.yamaganda : yamaganda // ignore: cast_nullable_to_non_nullable
as TimeWindow?,gulikaKaal: freezed == gulikaKaal ? _self.gulikaKaal : gulikaKaal // ignore: cast_nullable_to_non_nullable
as TimeWindow?,abhijitMuhurat: freezed == abhijitMuhurat ? _self.abhijitMuhurat : abhijitMuhurat // ignore: cast_nullable_to_non_nullable
as TimeWindow?,choghadiya: null == choghadiya ? _self.choghadiya : choghadiya // ignore: cast_nullable_to_non_nullable
as List<TimeWindow>,
  ));
}
/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementCopyWith<$Res> get tithi {
  
  return $PanchangaElementCopyWith<$Res>(_self.tithi, (value) {
    return _then(_self.copyWith(tithi: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementCopyWith<$Res> get nakshatra {
  
  return $PanchangaElementCopyWith<$Res>(_self.nakshatra, (value) {
    return _then(_self.copyWith(nakshatra: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementCopyWith<$Res> get karana {
  
  return $PanchangaElementCopyWith<$Res>(_self.karana, (value) {
    return _then(_self.copyWith(karana: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementCopyWith<$Res> get yoga {
  
  return $PanchangaElementCopyWith<$Res>(_self.yoga, (value) {
    return _then(_self.copyWith(yoga: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowCopyWith<$Res>? get rahuKaal {
    if (_self.rahuKaal == null) {
    return null;
  }

  return $TimeWindowCopyWith<$Res>(_self.rahuKaal!, (value) {
    return _then(_self.copyWith(rahuKaal: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowCopyWith<$Res>? get yamaganda {
    if (_self.yamaganda == null) {
    return null;
  }

  return $TimeWindowCopyWith<$Res>(_self.yamaganda!, (value) {
    return _then(_self.copyWith(yamaganda: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowCopyWith<$Res>? get gulikaKaal {
    if (_self.gulikaKaal == null) {
    return null;
  }

  return $TimeWindowCopyWith<$Res>(_self.gulikaKaal!, (value) {
    return _then(_self.copyWith(gulikaKaal: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowCopyWith<$Res>? get abhijitMuhurat {
    if (_self.abhijitMuhurat == null) {
    return null;
  }

  return $TimeWindowCopyWith<$Res>(_self.abhijitMuhurat!, (value) {
    return _then(_self.copyWith(abhijitMuhurat: value));
  });
}
}



/// @nodoc


class _Panchanga extends Panchanga {
  const _Panchanga({required this.date, required this.shakaSamvat, required this.nepalSamvat, required this.nepalSamvatMonthNe, required this.nepalSamvatMonthEn, required this.tithiTitleNe, required this.tithiTitleEn, required this.tithi, required this.nakshatra, required this.karana, required this.yoga, required this.sunrise, required this.sunset, required this.moonrise, required this.moonset, required final  List<PanchangaDetail> dayDetails, required this.chandraRashiNe, required this.chandraRashiEn, required this.anandadiYogaNe, required this.anandadiYogaEn, required final  List<PlanetPosition> planets, this.rahuKaal, this.yamaganda, this.gulikaKaal, this.abhijitMuhurat, final  List<TimeWindow> choghadiya = const []}): _dayDetails = dayDetails,_planets = planets,_choghadiya = choghadiya,super._();
  

/// Gregorian civil date (midnight, local).
@override final  DateTime date;
@override final  int shakaSamvat;
@override final  int nepalSamvat;
@override final  String nepalSamvatMonthNe;
@override final  String nepalSamvatMonthEn;
/// e.g. "फागुन शुक्ल पूर्णिमा" / "Falgun Shukla Purnima".
@override final  String tithiTitleNe;
@override final  String tithiTitleEn;
@override final  PanchangaElement tithi;
@override final  PanchangaElement nakshatra;
@override final  PanchangaElement karana;
@override final  PanchangaElement yoga;
@override final  DateTime sunrise;
@override final  DateTime sunset;
@override final  DateTime moonrise;
@override final  DateTime moonset;
/// Rows of the day-level "थप जानकारी" table.
 final  List<PanchangaDetail> _dayDetails;
/// Rows of the day-level "थप जानकारी" table.
@override List<PanchangaDetail> get dayDetails {
  if (_dayDetails is EqualUnmodifiableListView) return _dayDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dayDetails);
}

@override final  String chandraRashiNe;
@override final  String chandraRashiEn;
@override final  String anandadiYogaNe;
@override final  String anandadiYogaEn;
/// सूर्योदयकालीन स्पष्ट ग्रहहरू (मंगल, बुध, बृहस्पति, शुक्र, शनि, राहु).
 final  List<PlanetPosition> _planets;
/// सूर्योदयकालीन स्पष्ट ग्रहहरू (मंगल, बुध, बृहस्पति, शुक्र, शनि, राहु).
@override List<PlanetPosition> get planets {
  if (_planets is EqualUnmodifiableListView) return _planets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_planets);
}

/// Inauspicious weekday-based 1/8th-day windows between sunrise and sunset
/// (shown in India; computed for every region).
@override final  TimeWindow? rahuKaal;
@override final  TimeWindow? yamaganda;
@override final  TimeWindow? gulikaKaal;
/// Auspicious midday window (solar noon ± 24 min).
@override final  TimeWindow? abhijitMuhurat;
/// Eight daytime Choghadiya segments (sunrise → sunset), ascending.
 final  List<TimeWindow> _choghadiya;
/// Eight daytime Choghadiya segments (sunrise → sunset), ascending.
@override@JsonKey() List<TimeWindow> get choghadiya {
  if (_choghadiya is EqualUnmodifiableListView) return _choghadiya;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choghadiya);
}


/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PanchangaCopyWith<_Panchanga> get copyWith => __$PanchangaCopyWithImpl<_Panchanga>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Panchanga&&(identical(other.date, date) || other.date == date)&&(identical(other.shakaSamvat, shakaSamvat) || other.shakaSamvat == shakaSamvat)&&(identical(other.nepalSamvat, nepalSamvat) || other.nepalSamvat == nepalSamvat)&&(identical(other.nepalSamvatMonthNe, nepalSamvatMonthNe) || other.nepalSamvatMonthNe == nepalSamvatMonthNe)&&(identical(other.nepalSamvatMonthEn, nepalSamvatMonthEn) || other.nepalSamvatMonthEn == nepalSamvatMonthEn)&&(identical(other.tithiTitleNe, tithiTitleNe) || other.tithiTitleNe == tithiTitleNe)&&(identical(other.tithiTitleEn, tithiTitleEn) || other.tithiTitleEn == tithiTitleEn)&&(identical(other.tithi, tithi) || other.tithi == tithi)&&(identical(other.nakshatra, nakshatra) || other.nakshatra == nakshatra)&&(identical(other.karana, karana) || other.karana == karana)&&(identical(other.yoga, yoga) || other.yoga == yoga)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.moonrise, moonrise) || other.moonrise == moonrise)&&(identical(other.moonset, moonset) || other.moonset == moonset)&&const DeepCollectionEquality().equals(other._dayDetails, _dayDetails)&&(identical(other.chandraRashiNe, chandraRashiNe) || other.chandraRashiNe == chandraRashiNe)&&(identical(other.chandraRashiEn, chandraRashiEn) || other.chandraRashiEn == chandraRashiEn)&&(identical(other.anandadiYogaNe, anandadiYogaNe) || other.anandadiYogaNe == anandadiYogaNe)&&(identical(other.anandadiYogaEn, anandadiYogaEn) || other.anandadiYogaEn == anandadiYogaEn)&&const DeepCollectionEquality().equals(other._planets, _planets)&&(identical(other.rahuKaal, rahuKaal) || other.rahuKaal == rahuKaal)&&(identical(other.yamaganda, yamaganda) || other.yamaganda == yamaganda)&&(identical(other.gulikaKaal, gulikaKaal) || other.gulikaKaal == gulikaKaal)&&(identical(other.abhijitMuhurat, abhijitMuhurat) || other.abhijitMuhurat == abhijitMuhurat)&&const DeepCollectionEquality().equals(other._choghadiya, _choghadiya));
}


@override
int get hashCode => Object.hashAll([runtimeType,date,shakaSamvat,nepalSamvat,nepalSamvatMonthNe,nepalSamvatMonthEn,tithiTitleNe,tithiTitleEn,tithi,nakshatra,karana,yoga,sunrise,sunset,moonrise,moonset,const DeepCollectionEquality().hash(_dayDetails),chandraRashiNe,chandraRashiEn,anandadiYogaNe,anandadiYogaEn,const DeepCollectionEquality().hash(_planets),rahuKaal,yamaganda,gulikaKaal,abhijitMuhurat,const DeepCollectionEquality().hash(_choghadiya)]);

@override
String toString() {
  return 'Panchanga(date: $date, shakaSamvat: $shakaSamvat, nepalSamvat: $nepalSamvat, nepalSamvatMonthNe: $nepalSamvatMonthNe, nepalSamvatMonthEn: $nepalSamvatMonthEn, tithiTitleNe: $tithiTitleNe, tithiTitleEn: $tithiTitleEn, tithi: $tithi, nakshatra: $nakshatra, karana: $karana, yoga: $yoga, sunrise: $sunrise, sunset: $sunset, moonrise: $moonrise, moonset: $moonset, dayDetails: $dayDetails, chandraRashiNe: $chandraRashiNe, chandraRashiEn: $chandraRashiEn, anandadiYogaNe: $anandadiYogaNe, anandadiYogaEn: $anandadiYogaEn, planets: $planets, rahuKaal: $rahuKaal, yamaganda: $yamaganda, gulikaKaal: $gulikaKaal, abhijitMuhurat: $abhijitMuhurat, choghadiya: $choghadiya)';
}


}

/// @nodoc
abstract mixin class _$PanchangaCopyWith<$Res> implements $PanchangaCopyWith<$Res> {
  factory _$PanchangaCopyWith(_Panchanga value, $Res Function(_Panchanga) _then) = __$PanchangaCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int shakaSamvat, int nepalSamvat, String nepalSamvatMonthNe, String nepalSamvatMonthEn, String tithiTitleNe, String tithiTitleEn, PanchangaElement tithi, PanchangaElement nakshatra, PanchangaElement karana, PanchangaElement yoga, DateTime sunrise, DateTime sunset, DateTime moonrise, DateTime moonset, List<PanchangaDetail> dayDetails, String chandraRashiNe, String chandraRashiEn, String anandadiYogaNe, String anandadiYogaEn, List<PlanetPosition> planets, TimeWindow? rahuKaal, TimeWindow? yamaganda, TimeWindow? gulikaKaal, TimeWindow? abhijitMuhurat, List<TimeWindow> choghadiya
});


@override $PanchangaElementCopyWith<$Res> get tithi;@override $PanchangaElementCopyWith<$Res> get nakshatra;@override $PanchangaElementCopyWith<$Res> get karana;@override $PanchangaElementCopyWith<$Res> get yoga;@override $TimeWindowCopyWith<$Res>? get rahuKaal;@override $TimeWindowCopyWith<$Res>? get yamaganda;@override $TimeWindowCopyWith<$Res>? get gulikaKaal;@override $TimeWindowCopyWith<$Res>? get abhijitMuhurat;

}
/// @nodoc
class __$PanchangaCopyWithImpl<$Res>
    implements _$PanchangaCopyWith<$Res> {
  __$PanchangaCopyWithImpl(this._self, this._then);

  final _Panchanga _self;
  final $Res Function(_Panchanga) _then;

/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? shakaSamvat = null,Object? nepalSamvat = null,Object? nepalSamvatMonthNe = null,Object? nepalSamvatMonthEn = null,Object? tithiTitleNe = null,Object? tithiTitleEn = null,Object? tithi = null,Object? nakshatra = null,Object? karana = null,Object? yoga = null,Object? sunrise = null,Object? sunset = null,Object? moonrise = null,Object? moonset = null,Object? dayDetails = null,Object? chandraRashiNe = null,Object? chandraRashiEn = null,Object? anandadiYogaNe = null,Object? anandadiYogaEn = null,Object? planets = null,Object? rahuKaal = freezed,Object? yamaganda = freezed,Object? gulikaKaal = freezed,Object? abhijitMuhurat = freezed,Object? choghadiya = null,}) {
  return _then(_Panchanga(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,shakaSamvat: null == shakaSamvat ? _self.shakaSamvat : shakaSamvat // ignore: cast_nullable_to_non_nullable
as int,nepalSamvat: null == nepalSamvat ? _self.nepalSamvat : nepalSamvat // ignore: cast_nullable_to_non_nullable
as int,nepalSamvatMonthNe: null == nepalSamvatMonthNe ? _self.nepalSamvatMonthNe : nepalSamvatMonthNe // ignore: cast_nullable_to_non_nullable
as String,nepalSamvatMonthEn: null == nepalSamvatMonthEn ? _self.nepalSamvatMonthEn : nepalSamvatMonthEn // ignore: cast_nullable_to_non_nullable
as String,tithiTitleNe: null == tithiTitleNe ? _self.tithiTitleNe : tithiTitleNe // ignore: cast_nullable_to_non_nullable
as String,tithiTitleEn: null == tithiTitleEn ? _self.tithiTitleEn : tithiTitleEn // ignore: cast_nullable_to_non_nullable
as String,tithi: null == tithi ? _self.tithi : tithi // ignore: cast_nullable_to_non_nullable
as PanchangaElement,nakshatra: null == nakshatra ? _self.nakshatra : nakshatra // ignore: cast_nullable_to_non_nullable
as PanchangaElement,karana: null == karana ? _self.karana : karana // ignore: cast_nullable_to_non_nullable
as PanchangaElement,yoga: null == yoga ? _self.yoga : yoga // ignore: cast_nullable_to_non_nullable
as PanchangaElement,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,moonrise: null == moonrise ? _self.moonrise : moonrise // ignore: cast_nullable_to_non_nullable
as DateTime,moonset: null == moonset ? _self.moonset : moonset // ignore: cast_nullable_to_non_nullable
as DateTime,dayDetails: null == dayDetails ? _self._dayDetails : dayDetails // ignore: cast_nullable_to_non_nullable
as List<PanchangaDetail>,chandraRashiNe: null == chandraRashiNe ? _self.chandraRashiNe : chandraRashiNe // ignore: cast_nullable_to_non_nullable
as String,chandraRashiEn: null == chandraRashiEn ? _self.chandraRashiEn : chandraRashiEn // ignore: cast_nullable_to_non_nullable
as String,anandadiYogaNe: null == anandadiYogaNe ? _self.anandadiYogaNe : anandadiYogaNe // ignore: cast_nullable_to_non_nullable
as String,anandadiYogaEn: null == anandadiYogaEn ? _self.anandadiYogaEn : anandadiYogaEn // ignore: cast_nullable_to_non_nullable
as String,planets: null == planets ? _self._planets : planets // ignore: cast_nullable_to_non_nullable
as List<PlanetPosition>,rahuKaal: freezed == rahuKaal ? _self.rahuKaal : rahuKaal // ignore: cast_nullable_to_non_nullable
as TimeWindow?,yamaganda: freezed == yamaganda ? _self.yamaganda : yamaganda // ignore: cast_nullable_to_non_nullable
as TimeWindow?,gulikaKaal: freezed == gulikaKaal ? _self.gulikaKaal : gulikaKaal // ignore: cast_nullable_to_non_nullable
as TimeWindow?,abhijitMuhurat: freezed == abhijitMuhurat ? _self.abhijitMuhurat : abhijitMuhurat // ignore: cast_nullable_to_non_nullable
as TimeWindow?,choghadiya: null == choghadiya ? _self._choghadiya : choghadiya // ignore: cast_nullable_to_non_nullable
as List<TimeWindow>,
  ));
}

/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementCopyWith<$Res> get tithi {
  
  return $PanchangaElementCopyWith<$Res>(_self.tithi, (value) {
    return _then(_self.copyWith(tithi: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementCopyWith<$Res> get nakshatra {
  
  return $PanchangaElementCopyWith<$Res>(_self.nakshatra, (value) {
    return _then(_self.copyWith(nakshatra: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementCopyWith<$Res> get karana {
  
  return $PanchangaElementCopyWith<$Res>(_self.karana, (value) {
    return _then(_self.copyWith(karana: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementCopyWith<$Res> get yoga {
  
  return $PanchangaElementCopyWith<$Res>(_self.yoga, (value) {
    return _then(_self.copyWith(yoga: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowCopyWith<$Res>? get rahuKaal {
    if (_self.rahuKaal == null) {
    return null;
  }

  return $TimeWindowCopyWith<$Res>(_self.rahuKaal!, (value) {
    return _then(_self.copyWith(rahuKaal: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowCopyWith<$Res>? get yamaganda {
    if (_self.yamaganda == null) {
    return null;
  }

  return $TimeWindowCopyWith<$Res>(_self.yamaganda!, (value) {
    return _then(_self.copyWith(yamaganda: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowCopyWith<$Res>? get gulikaKaal {
    if (_self.gulikaKaal == null) {
    return null;
  }

  return $TimeWindowCopyWith<$Res>(_self.gulikaKaal!, (value) {
    return _then(_self.copyWith(gulikaKaal: value));
  });
}/// Create a copy of Panchanga
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowCopyWith<$Res>? get abhijitMuhurat {
    if (_self.abhijitMuhurat == null) {
    return null;
  }

  return $TimeWindowCopyWith<$Res>(_self.abhijitMuhurat!, (value) {
    return _then(_self.copyWith(abhijitMuhurat: value));
  });
}
}

// dart format on
