// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeoPoint {

 double get latitude; double get longitude; String get nameEn; String get nameNe; String get nameHi;
/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeoPointCopyWith<GeoPoint> get copyWith => _$GeoPointCopyWithImpl<GeoPoint>(this as GeoPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoPoint&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameHi, nameHi) || other.nameHi == nameHi));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,nameEn,nameNe,nameHi);

@override
String toString() {
  return 'GeoPoint(latitude: $latitude, longitude: $longitude, nameEn: $nameEn, nameNe: $nameNe, nameHi: $nameHi)';
}


}

/// @nodoc
abstract mixin class $GeoPointCopyWith<$Res>  {
  factory $GeoPointCopyWith(GeoPoint value, $Res Function(GeoPoint) _then) = _$GeoPointCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, String nameEn, String nameNe, String nameHi
});




}
/// @nodoc
class _$GeoPointCopyWithImpl<$Res>
    implements $GeoPointCopyWith<$Res> {
  _$GeoPointCopyWithImpl(this._self, this._then);

  final GeoPoint _self;
  final $Res Function(GeoPoint) _then;

/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? nameEn = null,Object? nameNe = null,Object? nameHi = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameHi: null == nameHi ? _self.nameHi : nameHi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _GeoPoint extends GeoPoint {
  const _GeoPoint({required this.latitude, required this.longitude, required this.nameEn, required this.nameNe, required this.nameHi}): super._();
  

@override final  double latitude;
@override final  double longitude;
@override final  String nameEn;
@override final  String nameNe;
@override final  String nameHi;

/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeoPointCopyWith<_GeoPoint> get copyWith => __$GeoPointCopyWithImpl<_GeoPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeoPoint&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameHi, nameHi) || other.nameHi == nameHi));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,nameEn,nameNe,nameHi);

@override
String toString() {
  return 'GeoPoint(latitude: $latitude, longitude: $longitude, nameEn: $nameEn, nameNe: $nameNe, nameHi: $nameHi)';
}


}

/// @nodoc
abstract mixin class _$GeoPointCopyWith<$Res> implements $GeoPointCopyWith<$Res> {
  factory _$GeoPointCopyWith(_GeoPoint value, $Res Function(_GeoPoint) _then) = __$GeoPointCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, String nameEn, String nameNe, String nameHi
});




}
/// @nodoc
class __$GeoPointCopyWithImpl<$Res>
    implements _$GeoPointCopyWith<$Res> {
  __$GeoPointCopyWithImpl(this._self, this._then);

  final _GeoPoint _self;
  final $Res Function(_GeoPoint) _then;

/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? nameEn = null,Object? nameNe = null,Object? nameHi = null,}) {
  return _then(_GeoPoint(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameHi: null == nameHi ? _self.nameHi : nameHi // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$RegionConfig {

 Region get region; String get nameEn; String get nameNe; String get nameHi; String get flagEmoji;/// ISO 4217 code of the local currency (NPR / INR).
 String get currencyCode;/// Display symbol in Devanagari locales (रु. / ₹).
 String get currencySymbol;/// Display symbol in Latin-script locales (Rs. / ₹).
 String get currencySymbolLatin; String get currencyNameEn;/// e.g. `+977`, `+91`.
 String get phonePrefix;/// e.g. `NST`, `IST`.
 String get timeZoneLabel; Duration get utcOffset;/// Default location for weather / panchanga when GPS is unavailable.
 GeoPoint get defaultCity;/// UI languages offered for this region (first = default).
 List<String> get languageCodes; String get defaultLanguageCode;/// Traditional calendar shown alongside Gregorian.
 TraditionalCalendar get calendar; List<PaymentRail> get paymentRails;/// Bullion unit label ("tola" / "10 g").
 String get metalUnitEn; String get metalUnitLocal;/// Currency whose trend vs. local currency is charted (USD).
 String get forexBaseCurrency;/// Era systems displayed in the panchanga header, in order
/// (e.g. Nepal: BS, AD, Shaka, Nepal Sambat; India: Vikram, Shaka, AD).
 List<SamvatKind> get samvatLabels;
/// Create a copy of RegionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionConfigCopyWith<RegionConfig> get copyWith => _$RegionConfigCopyWithImpl<RegionConfig>(this as RegionConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionConfig&&(identical(other.region, region) || other.region == region)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameHi, nameHi) || other.nameHi == nameHi)&&(identical(other.flagEmoji, flagEmoji) || other.flagEmoji == flagEmoji)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.currencySymbolLatin, currencySymbolLatin) || other.currencySymbolLatin == currencySymbolLatin)&&(identical(other.currencyNameEn, currencyNameEn) || other.currencyNameEn == currencyNameEn)&&(identical(other.phonePrefix, phonePrefix) || other.phonePrefix == phonePrefix)&&(identical(other.timeZoneLabel, timeZoneLabel) || other.timeZoneLabel == timeZoneLabel)&&(identical(other.utcOffset, utcOffset) || other.utcOffset == utcOffset)&&(identical(other.defaultCity, defaultCity) || other.defaultCity == defaultCity)&&const DeepCollectionEquality().equals(other.languageCodes, languageCodes)&&(identical(other.defaultLanguageCode, defaultLanguageCode) || other.defaultLanguageCode == defaultLanguageCode)&&(identical(other.calendar, calendar) || other.calendar == calendar)&&const DeepCollectionEquality().equals(other.paymentRails, paymentRails)&&(identical(other.metalUnitEn, metalUnitEn) || other.metalUnitEn == metalUnitEn)&&(identical(other.metalUnitLocal, metalUnitLocal) || other.metalUnitLocal == metalUnitLocal)&&(identical(other.forexBaseCurrency, forexBaseCurrency) || other.forexBaseCurrency == forexBaseCurrency)&&const DeepCollectionEquality().equals(other.samvatLabels, samvatLabels));
}


@override
int get hashCode => Object.hashAll([runtimeType,region,nameEn,nameNe,nameHi,flagEmoji,currencyCode,currencySymbol,currencySymbolLatin,currencyNameEn,phonePrefix,timeZoneLabel,utcOffset,defaultCity,const DeepCollectionEquality().hash(languageCodes),defaultLanguageCode,calendar,const DeepCollectionEquality().hash(paymentRails),metalUnitEn,metalUnitLocal,forexBaseCurrency,const DeepCollectionEquality().hash(samvatLabels)]);

@override
String toString() {
  return 'RegionConfig(region: $region, nameEn: $nameEn, nameNe: $nameNe, nameHi: $nameHi, flagEmoji: $flagEmoji, currencyCode: $currencyCode, currencySymbol: $currencySymbol, currencySymbolLatin: $currencySymbolLatin, currencyNameEn: $currencyNameEn, phonePrefix: $phonePrefix, timeZoneLabel: $timeZoneLabel, utcOffset: $utcOffset, defaultCity: $defaultCity, languageCodes: $languageCodes, defaultLanguageCode: $defaultLanguageCode, calendar: $calendar, paymentRails: $paymentRails, metalUnitEn: $metalUnitEn, metalUnitLocal: $metalUnitLocal, forexBaseCurrency: $forexBaseCurrency, samvatLabels: $samvatLabels)';
}


}

/// @nodoc
abstract mixin class $RegionConfigCopyWith<$Res>  {
  factory $RegionConfigCopyWith(RegionConfig value, $Res Function(RegionConfig) _then) = _$RegionConfigCopyWithImpl;
@useResult
$Res call({
 Region region, String nameEn, String nameNe, String nameHi, String flagEmoji, String currencyCode, String currencySymbol, String currencySymbolLatin, String currencyNameEn, String phonePrefix, String timeZoneLabel, Duration utcOffset, GeoPoint defaultCity, List<String> languageCodes, String defaultLanguageCode, TraditionalCalendar calendar, List<PaymentRail> paymentRails, String metalUnitEn, String metalUnitLocal, String forexBaseCurrency, List<SamvatKind> samvatLabels
});


$GeoPointCopyWith<$Res> get defaultCity;

}
/// @nodoc
class _$RegionConfigCopyWithImpl<$Res>
    implements $RegionConfigCopyWith<$Res> {
  _$RegionConfigCopyWithImpl(this._self, this._then);

  final RegionConfig _self;
  final $Res Function(RegionConfig) _then;

/// Create a copy of RegionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? nameEn = null,Object? nameNe = null,Object? nameHi = null,Object? flagEmoji = null,Object? currencyCode = null,Object? currencySymbol = null,Object? currencySymbolLatin = null,Object? currencyNameEn = null,Object? phonePrefix = null,Object? timeZoneLabel = null,Object? utcOffset = null,Object? defaultCity = null,Object? languageCodes = null,Object? defaultLanguageCode = null,Object? calendar = null,Object? paymentRails = null,Object? metalUnitEn = null,Object? metalUnitLocal = null,Object? forexBaseCurrency = null,Object? samvatLabels = null,}) {
  return _then(_self.copyWith(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameHi: null == nameHi ? _self.nameHi : nameHi // ignore: cast_nullable_to_non_nullable
as String,flagEmoji: null == flagEmoji ? _self.flagEmoji : flagEmoji // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,currencySymbolLatin: null == currencySymbolLatin ? _self.currencySymbolLatin : currencySymbolLatin // ignore: cast_nullable_to_non_nullable
as String,currencyNameEn: null == currencyNameEn ? _self.currencyNameEn : currencyNameEn // ignore: cast_nullable_to_non_nullable
as String,phonePrefix: null == phonePrefix ? _self.phonePrefix : phonePrefix // ignore: cast_nullable_to_non_nullable
as String,timeZoneLabel: null == timeZoneLabel ? _self.timeZoneLabel : timeZoneLabel // ignore: cast_nullable_to_non_nullable
as String,utcOffset: null == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as Duration,defaultCity: null == defaultCity ? _self.defaultCity : defaultCity // ignore: cast_nullable_to_non_nullable
as GeoPoint,languageCodes: null == languageCodes ? _self.languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,defaultLanguageCode: null == defaultLanguageCode ? _self.defaultLanguageCode : defaultLanguageCode // ignore: cast_nullable_to_non_nullable
as String,calendar: null == calendar ? _self.calendar : calendar // ignore: cast_nullable_to_non_nullable
as TraditionalCalendar,paymentRails: null == paymentRails ? _self.paymentRails : paymentRails // ignore: cast_nullable_to_non_nullable
as List<PaymentRail>,metalUnitEn: null == metalUnitEn ? _self.metalUnitEn : metalUnitEn // ignore: cast_nullable_to_non_nullable
as String,metalUnitLocal: null == metalUnitLocal ? _self.metalUnitLocal : metalUnitLocal // ignore: cast_nullable_to_non_nullable
as String,forexBaseCurrency: null == forexBaseCurrency ? _self.forexBaseCurrency : forexBaseCurrency // ignore: cast_nullable_to_non_nullable
as String,samvatLabels: null == samvatLabels ? _self.samvatLabels : samvatLabels // ignore: cast_nullable_to_non_nullable
as List<SamvatKind>,
  ));
}
/// Create a copy of RegionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get defaultCity {
  
  return $GeoPointCopyWith<$Res>(_self.defaultCity, (value) {
    return _then(_self.copyWith(defaultCity: value));
  });
}
}



/// @nodoc


class _RegionConfig extends RegionConfig {
  const _RegionConfig({required this.region, required this.nameEn, required this.nameNe, required this.nameHi, required this.flagEmoji, required this.currencyCode, required this.currencySymbol, required this.currencySymbolLatin, required this.currencyNameEn, required this.phonePrefix, required this.timeZoneLabel, required this.utcOffset, required this.defaultCity, required final  List<String> languageCodes, required this.defaultLanguageCode, required this.calendar, required final  List<PaymentRail> paymentRails, required this.metalUnitEn, required this.metalUnitLocal, required this.forexBaseCurrency, required final  List<SamvatKind> samvatLabels}): _languageCodes = languageCodes,_paymentRails = paymentRails,_samvatLabels = samvatLabels,super._();
  

@override final  Region region;
@override final  String nameEn;
@override final  String nameNe;
@override final  String nameHi;
@override final  String flagEmoji;
/// ISO 4217 code of the local currency (NPR / INR).
@override final  String currencyCode;
/// Display symbol in Devanagari locales (रु. / ₹).
@override final  String currencySymbol;
/// Display symbol in Latin-script locales (Rs. / ₹).
@override final  String currencySymbolLatin;
@override final  String currencyNameEn;
/// e.g. `+977`, `+91`.
@override final  String phonePrefix;
/// e.g. `NST`, `IST`.
@override final  String timeZoneLabel;
@override final  Duration utcOffset;
/// Default location for weather / panchanga when GPS is unavailable.
@override final  GeoPoint defaultCity;
/// UI languages offered for this region (first = default).
 final  List<String> _languageCodes;
/// UI languages offered for this region (first = default).
@override List<String> get languageCodes {
  if (_languageCodes is EqualUnmodifiableListView) return _languageCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageCodes);
}

@override final  String defaultLanguageCode;
/// Traditional calendar shown alongside Gregorian.
@override final  TraditionalCalendar calendar;
 final  List<PaymentRail> _paymentRails;
@override List<PaymentRail> get paymentRails {
  if (_paymentRails is EqualUnmodifiableListView) return _paymentRails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentRails);
}

/// Bullion unit label ("tola" / "10 g").
@override final  String metalUnitEn;
@override final  String metalUnitLocal;
/// Currency whose trend vs. local currency is charted (USD).
@override final  String forexBaseCurrency;
/// Era systems displayed in the panchanga header, in order
/// (e.g. Nepal: BS, AD, Shaka, Nepal Sambat; India: Vikram, Shaka, AD).
 final  List<SamvatKind> _samvatLabels;
/// Era systems displayed in the panchanga header, in order
/// (e.g. Nepal: BS, AD, Shaka, Nepal Sambat; India: Vikram, Shaka, AD).
@override List<SamvatKind> get samvatLabels {
  if (_samvatLabels is EqualUnmodifiableListView) return _samvatLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_samvatLabels);
}


/// Create a copy of RegionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionConfigCopyWith<_RegionConfig> get copyWith => __$RegionConfigCopyWithImpl<_RegionConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionConfig&&(identical(other.region, region) || other.region == region)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameHi, nameHi) || other.nameHi == nameHi)&&(identical(other.flagEmoji, flagEmoji) || other.flagEmoji == flagEmoji)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.currencySymbolLatin, currencySymbolLatin) || other.currencySymbolLatin == currencySymbolLatin)&&(identical(other.currencyNameEn, currencyNameEn) || other.currencyNameEn == currencyNameEn)&&(identical(other.phonePrefix, phonePrefix) || other.phonePrefix == phonePrefix)&&(identical(other.timeZoneLabel, timeZoneLabel) || other.timeZoneLabel == timeZoneLabel)&&(identical(other.utcOffset, utcOffset) || other.utcOffset == utcOffset)&&(identical(other.defaultCity, defaultCity) || other.defaultCity == defaultCity)&&const DeepCollectionEquality().equals(other._languageCodes, _languageCodes)&&(identical(other.defaultLanguageCode, defaultLanguageCode) || other.defaultLanguageCode == defaultLanguageCode)&&(identical(other.calendar, calendar) || other.calendar == calendar)&&const DeepCollectionEquality().equals(other._paymentRails, _paymentRails)&&(identical(other.metalUnitEn, metalUnitEn) || other.metalUnitEn == metalUnitEn)&&(identical(other.metalUnitLocal, metalUnitLocal) || other.metalUnitLocal == metalUnitLocal)&&(identical(other.forexBaseCurrency, forexBaseCurrency) || other.forexBaseCurrency == forexBaseCurrency)&&const DeepCollectionEquality().equals(other._samvatLabels, _samvatLabels));
}


@override
int get hashCode => Object.hashAll([runtimeType,region,nameEn,nameNe,nameHi,flagEmoji,currencyCode,currencySymbol,currencySymbolLatin,currencyNameEn,phonePrefix,timeZoneLabel,utcOffset,defaultCity,const DeepCollectionEquality().hash(_languageCodes),defaultLanguageCode,calendar,const DeepCollectionEquality().hash(_paymentRails),metalUnitEn,metalUnitLocal,forexBaseCurrency,const DeepCollectionEquality().hash(_samvatLabels)]);

@override
String toString() {
  return 'RegionConfig(region: $region, nameEn: $nameEn, nameNe: $nameNe, nameHi: $nameHi, flagEmoji: $flagEmoji, currencyCode: $currencyCode, currencySymbol: $currencySymbol, currencySymbolLatin: $currencySymbolLatin, currencyNameEn: $currencyNameEn, phonePrefix: $phonePrefix, timeZoneLabel: $timeZoneLabel, utcOffset: $utcOffset, defaultCity: $defaultCity, languageCodes: $languageCodes, defaultLanguageCode: $defaultLanguageCode, calendar: $calendar, paymentRails: $paymentRails, metalUnitEn: $metalUnitEn, metalUnitLocal: $metalUnitLocal, forexBaseCurrency: $forexBaseCurrency, samvatLabels: $samvatLabels)';
}


}

/// @nodoc
abstract mixin class _$RegionConfigCopyWith<$Res> implements $RegionConfigCopyWith<$Res> {
  factory _$RegionConfigCopyWith(_RegionConfig value, $Res Function(_RegionConfig) _then) = __$RegionConfigCopyWithImpl;
@override @useResult
$Res call({
 Region region, String nameEn, String nameNe, String nameHi, String flagEmoji, String currencyCode, String currencySymbol, String currencySymbolLatin, String currencyNameEn, String phonePrefix, String timeZoneLabel, Duration utcOffset, GeoPoint defaultCity, List<String> languageCodes, String defaultLanguageCode, TraditionalCalendar calendar, List<PaymentRail> paymentRails, String metalUnitEn, String metalUnitLocal, String forexBaseCurrency, List<SamvatKind> samvatLabels
});


@override $GeoPointCopyWith<$Res> get defaultCity;

}
/// @nodoc
class __$RegionConfigCopyWithImpl<$Res>
    implements _$RegionConfigCopyWith<$Res> {
  __$RegionConfigCopyWithImpl(this._self, this._then);

  final _RegionConfig _self;
  final $Res Function(_RegionConfig) _then;

/// Create a copy of RegionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? nameEn = null,Object? nameNe = null,Object? nameHi = null,Object? flagEmoji = null,Object? currencyCode = null,Object? currencySymbol = null,Object? currencySymbolLatin = null,Object? currencyNameEn = null,Object? phonePrefix = null,Object? timeZoneLabel = null,Object? utcOffset = null,Object? defaultCity = null,Object? languageCodes = null,Object? defaultLanguageCode = null,Object? calendar = null,Object? paymentRails = null,Object? metalUnitEn = null,Object? metalUnitLocal = null,Object? forexBaseCurrency = null,Object? samvatLabels = null,}) {
  return _then(_RegionConfig(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameHi: null == nameHi ? _self.nameHi : nameHi // ignore: cast_nullable_to_non_nullable
as String,flagEmoji: null == flagEmoji ? _self.flagEmoji : flagEmoji // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,currencySymbolLatin: null == currencySymbolLatin ? _self.currencySymbolLatin : currencySymbolLatin // ignore: cast_nullable_to_non_nullable
as String,currencyNameEn: null == currencyNameEn ? _self.currencyNameEn : currencyNameEn // ignore: cast_nullable_to_non_nullable
as String,phonePrefix: null == phonePrefix ? _self.phonePrefix : phonePrefix // ignore: cast_nullable_to_non_nullable
as String,timeZoneLabel: null == timeZoneLabel ? _self.timeZoneLabel : timeZoneLabel // ignore: cast_nullable_to_non_nullable
as String,utcOffset: null == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as Duration,defaultCity: null == defaultCity ? _self.defaultCity : defaultCity // ignore: cast_nullable_to_non_nullable
as GeoPoint,languageCodes: null == languageCodes ? _self._languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,defaultLanguageCode: null == defaultLanguageCode ? _self.defaultLanguageCode : defaultLanguageCode // ignore: cast_nullable_to_non_nullable
as String,calendar: null == calendar ? _self.calendar : calendar // ignore: cast_nullable_to_non_nullable
as TraditionalCalendar,paymentRails: null == paymentRails ? _self._paymentRails : paymentRails // ignore: cast_nullable_to_non_nullable
as List<PaymentRail>,metalUnitEn: null == metalUnitEn ? _self.metalUnitEn : metalUnitEn // ignore: cast_nullable_to_non_nullable
as String,metalUnitLocal: null == metalUnitLocal ? _self.metalUnitLocal : metalUnitLocal // ignore: cast_nullable_to_non_nullable
as String,forexBaseCurrency: null == forexBaseCurrency ? _self.forexBaseCurrency : forexBaseCurrency // ignore: cast_nullable_to_non_nullable
as String,samvatLabels: null == samvatLabels ? _self._samvatLabels : samvatLabels // ignore: cast_nullable_to_non_nullable
as List<SamvatKind>,
  ));
}

/// Create a copy of RegionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get defaultCity {
  
  return $GeoPointCopyWith<$Res>(_self.defaultCity, (value) {
    return _then(_self.copyWith(defaultCity: value));
  });
}
}

// dart format on
