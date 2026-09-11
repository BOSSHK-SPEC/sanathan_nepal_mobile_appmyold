// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panchanga_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PanchangaModel {

 DateTime get date; int get shakaSamvat; int get nepalSamvat; String get nepalSamvatMonthNe; String get nepalSamvatMonthEn; String get tithiTitleNe; String get tithiTitleEn; PanchangaElementModel get tithi; PanchangaElementModel get nakshatra; PanchangaElementModel get karana; PanchangaElementModel get yoga; DateTime get sunrise; DateTime get sunset; DateTime get moonrise; DateTime get moonset; List<PanchangaDetailModel> get dayDetails; String get chandraRashiNe; String get chandraRashiEn; String get anandadiYogaNe; String get anandadiYogaEn; List<PlanetPositionModel> get planets; TimeWindowModel? get rahuKaal; TimeWindowModel? get yamaganda; TimeWindowModel? get gulikaKaal; TimeWindowModel? get abhijitMuhurat; List<TimeWindowModel> get choghadiya;
/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PanchangaModelCopyWith<PanchangaModel> get copyWith => _$PanchangaModelCopyWithImpl<PanchangaModel>(this as PanchangaModel, _$identity);

  /// Serializes this PanchangaModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PanchangaModel&&(identical(other.date, date) || other.date == date)&&(identical(other.shakaSamvat, shakaSamvat) || other.shakaSamvat == shakaSamvat)&&(identical(other.nepalSamvat, nepalSamvat) || other.nepalSamvat == nepalSamvat)&&(identical(other.nepalSamvatMonthNe, nepalSamvatMonthNe) || other.nepalSamvatMonthNe == nepalSamvatMonthNe)&&(identical(other.nepalSamvatMonthEn, nepalSamvatMonthEn) || other.nepalSamvatMonthEn == nepalSamvatMonthEn)&&(identical(other.tithiTitleNe, tithiTitleNe) || other.tithiTitleNe == tithiTitleNe)&&(identical(other.tithiTitleEn, tithiTitleEn) || other.tithiTitleEn == tithiTitleEn)&&(identical(other.tithi, tithi) || other.tithi == tithi)&&(identical(other.nakshatra, nakshatra) || other.nakshatra == nakshatra)&&(identical(other.karana, karana) || other.karana == karana)&&(identical(other.yoga, yoga) || other.yoga == yoga)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.moonrise, moonrise) || other.moonrise == moonrise)&&(identical(other.moonset, moonset) || other.moonset == moonset)&&const DeepCollectionEquality().equals(other.dayDetails, dayDetails)&&(identical(other.chandraRashiNe, chandraRashiNe) || other.chandraRashiNe == chandraRashiNe)&&(identical(other.chandraRashiEn, chandraRashiEn) || other.chandraRashiEn == chandraRashiEn)&&(identical(other.anandadiYogaNe, anandadiYogaNe) || other.anandadiYogaNe == anandadiYogaNe)&&(identical(other.anandadiYogaEn, anandadiYogaEn) || other.anandadiYogaEn == anandadiYogaEn)&&const DeepCollectionEquality().equals(other.planets, planets)&&(identical(other.rahuKaal, rahuKaal) || other.rahuKaal == rahuKaal)&&(identical(other.yamaganda, yamaganda) || other.yamaganda == yamaganda)&&(identical(other.gulikaKaal, gulikaKaal) || other.gulikaKaal == gulikaKaal)&&(identical(other.abhijitMuhurat, abhijitMuhurat) || other.abhijitMuhurat == abhijitMuhurat)&&const DeepCollectionEquality().equals(other.choghadiya, choghadiya));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,date,shakaSamvat,nepalSamvat,nepalSamvatMonthNe,nepalSamvatMonthEn,tithiTitleNe,tithiTitleEn,tithi,nakshatra,karana,yoga,sunrise,sunset,moonrise,moonset,const DeepCollectionEquality().hash(dayDetails),chandraRashiNe,chandraRashiEn,anandadiYogaNe,anandadiYogaEn,const DeepCollectionEquality().hash(planets),rahuKaal,yamaganda,gulikaKaal,abhijitMuhurat,const DeepCollectionEquality().hash(choghadiya)]);

@override
String toString() {
  return 'PanchangaModel(date: $date, shakaSamvat: $shakaSamvat, nepalSamvat: $nepalSamvat, nepalSamvatMonthNe: $nepalSamvatMonthNe, nepalSamvatMonthEn: $nepalSamvatMonthEn, tithiTitleNe: $tithiTitleNe, tithiTitleEn: $tithiTitleEn, tithi: $tithi, nakshatra: $nakshatra, karana: $karana, yoga: $yoga, sunrise: $sunrise, sunset: $sunset, moonrise: $moonrise, moonset: $moonset, dayDetails: $dayDetails, chandraRashiNe: $chandraRashiNe, chandraRashiEn: $chandraRashiEn, anandadiYogaNe: $anandadiYogaNe, anandadiYogaEn: $anandadiYogaEn, planets: $planets, rahuKaal: $rahuKaal, yamaganda: $yamaganda, gulikaKaal: $gulikaKaal, abhijitMuhurat: $abhijitMuhurat, choghadiya: $choghadiya)';
}


}

/// @nodoc
abstract mixin class $PanchangaModelCopyWith<$Res>  {
  factory $PanchangaModelCopyWith(PanchangaModel value, $Res Function(PanchangaModel) _then) = _$PanchangaModelCopyWithImpl;
@useResult
$Res call({
 DateTime date, int shakaSamvat, int nepalSamvat, String nepalSamvatMonthNe, String nepalSamvatMonthEn, String tithiTitleNe, String tithiTitleEn, PanchangaElementModel tithi, PanchangaElementModel nakshatra, PanchangaElementModel karana, PanchangaElementModel yoga, DateTime sunrise, DateTime sunset, DateTime moonrise, DateTime moonset, List<PanchangaDetailModel> dayDetails, String chandraRashiNe, String chandraRashiEn, String anandadiYogaNe, String anandadiYogaEn, List<PlanetPositionModel> planets, TimeWindowModel? rahuKaal, TimeWindowModel? yamaganda, TimeWindowModel? gulikaKaal, TimeWindowModel? abhijitMuhurat, List<TimeWindowModel> choghadiya
});


$PanchangaElementModelCopyWith<$Res> get tithi;$PanchangaElementModelCopyWith<$Res> get nakshatra;$PanchangaElementModelCopyWith<$Res> get karana;$PanchangaElementModelCopyWith<$Res> get yoga;$TimeWindowModelCopyWith<$Res>? get rahuKaal;$TimeWindowModelCopyWith<$Res>? get yamaganda;$TimeWindowModelCopyWith<$Res>? get gulikaKaal;$TimeWindowModelCopyWith<$Res>? get abhijitMuhurat;

}
/// @nodoc
class _$PanchangaModelCopyWithImpl<$Res>
    implements $PanchangaModelCopyWith<$Res> {
  _$PanchangaModelCopyWithImpl(this._self, this._then);

  final PanchangaModel _self;
  final $Res Function(PanchangaModel) _then;

/// Create a copy of PanchangaModel
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
as PanchangaElementModel,nakshatra: null == nakshatra ? _self.nakshatra : nakshatra // ignore: cast_nullable_to_non_nullable
as PanchangaElementModel,karana: null == karana ? _self.karana : karana // ignore: cast_nullable_to_non_nullable
as PanchangaElementModel,yoga: null == yoga ? _self.yoga : yoga // ignore: cast_nullable_to_non_nullable
as PanchangaElementModel,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,moonrise: null == moonrise ? _self.moonrise : moonrise // ignore: cast_nullable_to_non_nullable
as DateTime,moonset: null == moonset ? _self.moonset : moonset // ignore: cast_nullable_to_non_nullable
as DateTime,dayDetails: null == dayDetails ? _self.dayDetails : dayDetails // ignore: cast_nullable_to_non_nullable
as List<PanchangaDetailModel>,chandraRashiNe: null == chandraRashiNe ? _self.chandraRashiNe : chandraRashiNe // ignore: cast_nullable_to_non_nullable
as String,chandraRashiEn: null == chandraRashiEn ? _self.chandraRashiEn : chandraRashiEn // ignore: cast_nullable_to_non_nullable
as String,anandadiYogaNe: null == anandadiYogaNe ? _self.anandadiYogaNe : anandadiYogaNe // ignore: cast_nullable_to_non_nullable
as String,anandadiYogaEn: null == anandadiYogaEn ? _self.anandadiYogaEn : anandadiYogaEn // ignore: cast_nullable_to_non_nullable
as String,planets: null == planets ? _self.planets : planets // ignore: cast_nullable_to_non_nullable
as List<PlanetPositionModel>,rahuKaal: freezed == rahuKaal ? _self.rahuKaal : rahuKaal // ignore: cast_nullable_to_non_nullable
as TimeWindowModel?,yamaganda: freezed == yamaganda ? _self.yamaganda : yamaganda // ignore: cast_nullable_to_non_nullable
as TimeWindowModel?,gulikaKaal: freezed == gulikaKaal ? _self.gulikaKaal : gulikaKaal // ignore: cast_nullable_to_non_nullable
as TimeWindowModel?,abhijitMuhurat: freezed == abhijitMuhurat ? _self.abhijitMuhurat : abhijitMuhurat // ignore: cast_nullable_to_non_nullable
as TimeWindowModel?,choghadiya: null == choghadiya ? _self.choghadiya : choghadiya // ignore: cast_nullable_to_non_nullable
as List<TimeWindowModel>,
  ));
}
/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementModelCopyWith<$Res> get tithi {
  
  return $PanchangaElementModelCopyWith<$Res>(_self.tithi, (value) {
    return _then(_self.copyWith(tithi: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementModelCopyWith<$Res> get nakshatra {
  
  return $PanchangaElementModelCopyWith<$Res>(_self.nakshatra, (value) {
    return _then(_self.copyWith(nakshatra: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementModelCopyWith<$Res> get karana {
  
  return $PanchangaElementModelCopyWith<$Res>(_self.karana, (value) {
    return _then(_self.copyWith(karana: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementModelCopyWith<$Res> get yoga {
  
  return $PanchangaElementModelCopyWith<$Res>(_self.yoga, (value) {
    return _then(_self.copyWith(yoga: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowModelCopyWith<$Res>? get rahuKaal {
    if (_self.rahuKaal == null) {
    return null;
  }

  return $TimeWindowModelCopyWith<$Res>(_self.rahuKaal!, (value) {
    return _then(_self.copyWith(rahuKaal: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowModelCopyWith<$Res>? get yamaganda {
    if (_self.yamaganda == null) {
    return null;
  }

  return $TimeWindowModelCopyWith<$Res>(_self.yamaganda!, (value) {
    return _then(_self.copyWith(yamaganda: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowModelCopyWith<$Res>? get gulikaKaal {
    if (_self.gulikaKaal == null) {
    return null;
  }

  return $TimeWindowModelCopyWith<$Res>(_self.gulikaKaal!, (value) {
    return _then(_self.copyWith(gulikaKaal: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowModelCopyWith<$Res>? get abhijitMuhurat {
    if (_self.abhijitMuhurat == null) {
    return null;
  }

  return $TimeWindowModelCopyWith<$Res>(_self.abhijitMuhurat!, (value) {
    return _then(_self.copyWith(abhijitMuhurat: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _PanchangaModel extends PanchangaModel {
  const _PanchangaModel({required this.date, required this.shakaSamvat, required this.nepalSamvat, this.nepalSamvatMonthNe = '', this.nepalSamvatMonthEn = '', this.tithiTitleNe = '', this.tithiTitleEn = '', required this.tithi, required this.nakshatra, required this.karana, required this.yoga, required this.sunrise, required this.sunset, required this.moonrise, required this.moonset, final  List<PanchangaDetailModel> dayDetails = const [], this.chandraRashiNe = '', this.chandraRashiEn = '', this.anandadiYogaNe = '', this.anandadiYogaEn = '', final  List<PlanetPositionModel> planets = const [], this.rahuKaal, this.yamaganda, this.gulikaKaal, this.abhijitMuhurat, final  List<TimeWindowModel> choghadiya = const []}): _dayDetails = dayDetails,_planets = planets,_choghadiya = choghadiya,super._();
  factory _PanchangaModel.fromJson(Map<String, dynamic> json) => _$PanchangaModelFromJson(json);

@override final  DateTime date;
@override final  int shakaSamvat;
@override final  int nepalSamvat;
@override@JsonKey() final  String nepalSamvatMonthNe;
@override@JsonKey() final  String nepalSamvatMonthEn;
@override@JsonKey() final  String tithiTitleNe;
@override@JsonKey() final  String tithiTitleEn;
@override final  PanchangaElementModel tithi;
@override final  PanchangaElementModel nakshatra;
@override final  PanchangaElementModel karana;
@override final  PanchangaElementModel yoga;
@override final  DateTime sunrise;
@override final  DateTime sunset;
@override final  DateTime moonrise;
@override final  DateTime moonset;
 final  List<PanchangaDetailModel> _dayDetails;
@override@JsonKey() List<PanchangaDetailModel> get dayDetails {
  if (_dayDetails is EqualUnmodifiableListView) return _dayDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dayDetails);
}

@override@JsonKey() final  String chandraRashiNe;
@override@JsonKey() final  String chandraRashiEn;
@override@JsonKey() final  String anandadiYogaNe;
@override@JsonKey() final  String anandadiYogaEn;
 final  List<PlanetPositionModel> _planets;
@override@JsonKey() List<PlanetPositionModel> get planets {
  if (_planets is EqualUnmodifiableListView) return _planets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_planets);
}

@override final  TimeWindowModel? rahuKaal;
@override final  TimeWindowModel? yamaganda;
@override final  TimeWindowModel? gulikaKaal;
@override final  TimeWindowModel? abhijitMuhurat;
 final  List<TimeWindowModel> _choghadiya;
@override@JsonKey() List<TimeWindowModel> get choghadiya {
  if (_choghadiya is EqualUnmodifiableListView) return _choghadiya;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choghadiya);
}


/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PanchangaModelCopyWith<_PanchangaModel> get copyWith => __$PanchangaModelCopyWithImpl<_PanchangaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PanchangaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PanchangaModel&&(identical(other.date, date) || other.date == date)&&(identical(other.shakaSamvat, shakaSamvat) || other.shakaSamvat == shakaSamvat)&&(identical(other.nepalSamvat, nepalSamvat) || other.nepalSamvat == nepalSamvat)&&(identical(other.nepalSamvatMonthNe, nepalSamvatMonthNe) || other.nepalSamvatMonthNe == nepalSamvatMonthNe)&&(identical(other.nepalSamvatMonthEn, nepalSamvatMonthEn) || other.nepalSamvatMonthEn == nepalSamvatMonthEn)&&(identical(other.tithiTitleNe, tithiTitleNe) || other.tithiTitleNe == tithiTitleNe)&&(identical(other.tithiTitleEn, tithiTitleEn) || other.tithiTitleEn == tithiTitleEn)&&(identical(other.tithi, tithi) || other.tithi == tithi)&&(identical(other.nakshatra, nakshatra) || other.nakshatra == nakshatra)&&(identical(other.karana, karana) || other.karana == karana)&&(identical(other.yoga, yoga) || other.yoga == yoga)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.moonrise, moonrise) || other.moonrise == moonrise)&&(identical(other.moonset, moonset) || other.moonset == moonset)&&const DeepCollectionEquality().equals(other._dayDetails, _dayDetails)&&(identical(other.chandraRashiNe, chandraRashiNe) || other.chandraRashiNe == chandraRashiNe)&&(identical(other.chandraRashiEn, chandraRashiEn) || other.chandraRashiEn == chandraRashiEn)&&(identical(other.anandadiYogaNe, anandadiYogaNe) || other.anandadiYogaNe == anandadiYogaNe)&&(identical(other.anandadiYogaEn, anandadiYogaEn) || other.anandadiYogaEn == anandadiYogaEn)&&const DeepCollectionEquality().equals(other._planets, _planets)&&(identical(other.rahuKaal, rahuKaal) || other.rahuKaal == rahuKaal)&&(identical(other.yamaganda, yamaganda) || other.yamaganda == yamaganda)&&(identical(other.gulikaKaal, gulikaKaal) || other.gulikaKaal == gulikaKaal)&&(identical(other.abhijitMuhurat, abhijitMuhurat) || other.abhijitMuhurat == abhijitMuhurat)&&const DeepCollectionEquality().equals(other._choghadiya, _choghadiya));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,date,shakaSamvat,nepalSamvat,nepalSamvatMonthNe,nepalSamvatMonthEn,tithiTitleNe,tithiTitleEn,tithi,nakshatra,karana,yoga,sunrise,sunset,moonrise,moonset,const DeepCollectionEquality().hash(_dayDetails),chandraRashiNe,chandraRashiEn,anandadiYogaNe,anandadiYogaEn,const DeepCollectionEquality().hash(_planets),rahuKaal,yamaganda,gulikaKaal,abhijitMuhurat,const DeepCollectionEquality().hash(_choghadiya)]);

@override
String toString() {
  return 'PanchangaModel(date: $date, shakaSamvat: $shakaSamvat, nepalSamvat: $nepalSamvat, nepalSamvatMonthNe: $nepalSamvatMonthNe, nepalSamvatMonthEn: $nepalSamvatMonthEn, tithiTitleNe: $tithiTitleNe, tithiTitleEn: $tithiTitleEn, tithi: $tithi, nakshatra: $nakshatra, karana: $karana, yoga: $yoga, sunrise: $sunrise, sunset: $sunset, moonrise: $moonrise, moonset: $moonset, dayDetails: $dayDetails, chandraRashiNe: $chandraRashiNe, chandraRashiEn: $chandraRashiEn, anandadiYogaNe: $anandadiYogaNe, anandadiYogaEn: $anandadiYogaEn, planets: $planets, rahuKaal: $rahuKaal, yamaganda: $yamaganda, gulikaKaal: $gulikaKaal, abhijitMuhurat: $abhijitMuhurat, choghadiya: $choghadiya)';
}


}

/// @nodoc
abstract mixin class _$PanchangaModelCopyWith<$Res> implements $PanchangaModelCopyWith<$Res> {
  factory _$PanchangaModelCopyWith(_PanchangaModel value, $Res Function(_PanchangaModel) _then) = __$PanchangaModelCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int shakaSamvat, int nepalSamvat, String nepalSamvatMonthNe, String nepalSamvatMonthEn, String tithiTitleNe, String tithiTitleEn, PanchangaElementModel tithi, PanchangaElementModel nakshatra, PanchangaElementModel karana, PanchangaElementModel yoga, DateTime sunrise, DateTime sunset, DateTime moonrise, DateTime moonset, List<PanchangaDetailModel> dayDetails, String chandraRashiNe, String chandraRashiEn, String anandadiYogaNe, String anandadiYogaEn, List<PlanetPositionModel> planets, TimeWindowModel? rahuKaal, TimeWindowModel? yamaganda, TimeWindowModel? gulikaKaal, TimeWindowModel? abhijitMuhurat, List<TimeWindowModel> choghadiya
});


@override $PanchangaElementModelCopyWith<$Res> get tithi;@override $PanchangaElementModelCopyWith<$Res> get nakshatra;@override $PanchangaElementModelCopyWith<$Res> get karana;@override $PanchangaElementModelCopyWith<$Res> get yoga;@override $TimeWindowModelCopyWith<$Res>? get rahuKaal;@override $TimeWindowModelCopyWith<$Res>? get yamaganda;@override $TimeWindowModelCopyWith<$Res>? get gulikaKaal;@override $TimeWindowModelCopyWith<$Res>? get abhijitMuhurat;

}
/// @nodoc
class __$PanchangaModelCopyWithImpl<$Res>
    implements _$PanchangaModelCopyWith<$Res> {
  __$PanchangaModelCopyWithImpl(this._self, this._then);

  final _PanchangaModel _self;
  final $Res Function(_PanchangaModel) _then;

/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? shakaSamvat = null,Object? nepalSamvat = null,Object? nepalSamvatMonthNe = null,Object? nepalSamvatMonthEn = null,Object? tithiTitleNe = null,Object? tithiTitleEn = null,Object? tithi = null,Object? nakshatra = null,Object? karana = null,Object? yoga = null,Object? sunrise = null,Object? sunset = null,Object? moonrise = null,Object? moonset = null,Object? dayDetails = null,Object? chandraRashiNe = null,Object? chandraRashiEn = null,Object? anandadiYogaNe = null,Object? anandadiYogaEn = null,Object? planets = null,Object? rahuKaal = freezed,Object? yamaganda = freezed,Object? gulikaKaal = freezed,Object? abhijitMuhurat = freezed,Object? choghadiya = null,}) {
  return _then(_PanchangaModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,shakaSamvat: null == shakaSamvat ? _self.shakaSamvat : shakaSamvat // ignore: cast_nullable_to_non_nullable
as int,nepalSamvat: null == nepalSamvat ? _self.nepalSamvat : nepalSamvat // ignore: cast_nullable_to_non_nullable
as int,nepalSamvatMonthNe: null == nepalSamvatMonthNe ? _self.nepalSamvatMonthNe : nepalSamvatMonthNe // ignore: cast_nullable_to_non_nullable
as String,nepalSamvatMonthEn: null == nepalSamvatMonthEn ? _self.nepalSamvatMonthEn : nepalSamvatMonthEn // ignore: cast_nullable_to_non_nullable
as String,tithiTitleNe: null == tithiTitleNe ? _self.tithiTitleNe : tithiTitleNe // ignore: cast_nullable_to_non_nullable
as String,tithiTitleEn: null == tithiTitleEn ? _self.tithiTitleEn : tithiTitleEn // ignore: cast_nullable_to_non_nullable
as String,tithi: null == tithi ? _self.tithi : tithi // ignore: cast_nullable_to_non_nullable
as PanchangaElementModel,nakshatra: null == nakshatra ? _self.nakshatra : nakshatra // ignore: cast_nullable_to_non_nullable
as PanchangaElementModel,karana: null == karana ? _self.karana : karana // ignore: cast_nullable_to_non_nullable
as PanchangaElementModel,yoga: null == yoga ? _self.yoga : yoga // ignore: cast_nullable_to_non_nullable
as PanchangaElementModel,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,moonrise: null == moonrise ? _self.moonrise : moonrise // ignore: cast_nullable_to_non_nullable
as DateTime,moonset: null == moonset ? _self.moonset : moonset // ignore: cast_nullable_to_non_nullable
as DateTime,dayDetails: null == dayDetails ? _self._dayDetails : dayDetails // ignore: cast_nullable_to_non_nullable
as List<PanchangaDetailModel>,chandraRashiNe: null == chandraRashiNe ? _self.chandraRashiNe : chandraRashiNe // ignore: cast_nullable_to_non_nullable
as String,chandraRashiEn: null == chandraRashiEn ? _self.chandraRashiEn : chandraRashiEn // ignore: cast_nullable_to_non_nullable
as String,anandadiYogaNe: null == anandadiYogaNe ? _self.anandadiYogaNe : anandadiYogaNe // ignore: cast_nullable_to_non_nullable
as String,anandadiYogaEn: null == anandadiYogaEn ? _self.anandadiYogaEn : anandadiYogaEn // ignore: cast_nullable_to_non_nullable
as String,planets: null == planets ? _self._planets : planets // ignore: cast_nullable_to_non_nullable
as List<PlanetPositionModel>,rahuKaal: freezed == rahuKaal ? _self.rahuKaal : rahuKaal // ignore: cast_nullable_to_non_nullable
as TimeWindowModel?,yamaganda: freezed == yamaganda ? _self.yamaganda : yamaganda // ignore: cast_nullable_to_non_nullable
as TimeWindowModel?,gulikaKaal: freezed == gulikaKaal ? _self.gulikaKaal : gulikaKaal // ignore: cast_nullable_to_non_nullable
as TimeWindowModel?,abhijitMuhurat: freezed == abhijitMuhurat ? _self.abhijitMuhurat : abhijitMuhurat // ignore: cast_nullable_to_non_nullable
as TimeWindowModel?,choghadiya: null == choghadiya ? _self._choghadiya : choghadiya // ignore: cast_nullable_to_non_nullable
as List<TimeWindowModel>,
  ));
}

/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementModelCopyWith<$Res> get tithi {
  
  return $PanchangaElementModelCopyWith<$Res>(_self.tithi, (value) {
    return _then(_self.copyWith(tithi: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementModelCopyWith<$Res> get nakshatra {
  
  return $PanchangaElementModelCopyWith<$Res>(_self.nakshatra, (value) {
    return _then(_self.copyWith(nakshatra: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementModelCopyWith<$Res> get karana {
  
  return $PanchangaElementModelCopyWith<$Res>(_self.karana, (value) {
    return _then(_self.copyWith(karana: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaElementModelCopyWith<$Res> get yoga {
  
  return $PanchangaElementModelCopyWith<$Res>(_self.yoga, (value) {
    return _then(_self.copyWith(yoga: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowModelCopyWith<$Res>? get rahuKaal {
    if (_self.rahuKaal == null) {
    return null;
  }

  return $TimeWindowModelCopyWith<$Res>(_self.rahuKaal!, (value) {
    return _then(_self.copyWith(rahuKaal: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowModelCopyWith<$Res>? get yamaganda {
    if (_self.yamaganda == null) {
    return null;
  }

  return $TimeWindowModelCopyWith<$Res>(_self.yamaganda!, (value) {
    return _then(_self.copyWith(yamaganda: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowModelCopyWith<$Res>? get gulikaKaal {
    if (_self.gulikaKaal == null) {
    return null;
  }

  return $TimeWindowModelCopyWith<$Res>(_self.gulikaKaal!, (value) {
    return _then(_self.copyWith(gulikaKaal: value));
  });
}/// Create a copy of PanchangaModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeWindowModelCopyWith<$Res>? get abhijitMuhurat {
    if (_self.abhijitMuhurat == null) {
    return null;
  }

  return $TimeWindowModelCopyWith<$Res>(_self.abhijitMuhurat!, (value) {
    return _then(_self.copyWith(abhijitMuhurat: value));
  });
}
}

// dart format on
