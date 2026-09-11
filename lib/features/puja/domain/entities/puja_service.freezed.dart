// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'puja_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PujaService {

 String get id; LocalizedText get name; LocalizedText get summary; PujaPurpose get purpose; double get basePrice;/// How long the ritual itself takes, so a devotee attending live knows
/// what they are setting aside.
 Duration get duration;/// Modes actually offered. A ritual needing a fire pit may be at-home
/// only; one needing a specific temple may be online only.
 List<PujaMode> get modes;/// Where a temple puja is performed.
 LocalizedText? get templeName;/// Steps of the ritual, shown before booking.
 List<LocalizedText> get procedure;/// Materials the priest brings, as an optional add-on.
 double get samagriPrice;/// Surcharge for a priest travelling to the devotee.
 double get atHomeSurcharge;/// Number of priests performing it — a real price driver in listings.
 int get priestCount; int get bookingsThisMonth; bool get isPopular;
/// Create a copy of PujaService
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PujaServiceCopyWith<PujaService> get copyWith => _$PujaServiceCopyWithImpl<PujaService>(this as PujaService, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PujaService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.modes, modes)&&(identical(other.templeName, templeName) || other.templeName == templeName)&&const DeepCollectionEquality().equals(other.procedure, procedure)&&(identical(other.samagriPrice, samagriPrice) || other.samagriPrice == samagriPrice)&&(identical(other.atHomeSurcharge, atHomeSurcharge) || other.atHomeSurcharge == atHomeSurcharge)&&(identical(other.priestCount, priestCount) || other.priestCount == priestCount)&&(identical(other.bookingsThisMonth, bookingsThisMonth) || other.bookingsThisMonth == bookingsThisMonth)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,summary,purpose,basePrice,duration,const DeepCollectionEquality().hash(modes),templeName,const DeepCollectionEquality().hash(procedure),samagriPrice,atHomeSurcharge,priestCount,bookingsThisMonth,isPopular);

@override
String toString() {
  return 'PujaService(id: $id, name: $name, summary: $summary, purpose: $purpose, basePrice: $basePrice, duration: $duration, modes: $modes, templeName: $templeName, procedure: $procedure, samagriPrice: $samagriPrice, atHomeSurcharge: $atHomeSurcharge, priestCount: $priestCount, bookingsThisMonth: $bookingsThisMonth, isPopular: $isPopular)';
}


}

/// @nodoc
abstract mixin class $PujaServiceCopyWith<$Res>  {
  factory $PujaServiceCopyWith(PujaService value, $Res Function(PujaService) _then) = _$PujaServiceCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText name, LocalizedText summary, PujaPurpose purpose, double basePrice, Duration duration, List<PujaMode> modes, LocalizedText? templeName, List<LocalizedText> procedure, double samagriPrice, double atHomeSurcharge, int priestCount, int bookingsThisMonth, bool isPopular
});


$LocalizedTextCopyWith<$Res> get name;$LocalizedTextCopyWith<$Res> get summary;$LocalizedTextCopyWith<$Res>? get templeName;

}
/// @nodoc
class _$PujaServiceCopyWithImpl<$Res>
    implements $PujaServiceCopyWith<$Res> {
  _$PujaServiceCopyWithImpl(this._self, this._then);

  final PujaService _self;
  final $Res Function(PujaService) _then;

/// Create a copy of PujaService
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? summary = null,Object? purpose = null,Object? basePrice = null,Object? duration = null,Object? modes = null,Object? templeName = freezed,Object? procedure = null,Object? samagriPrice = null,Object? atHomeSurcharge = null,Object? priestCount = null,Object? bookingsThisMonth = null,Object? isPopular = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as PujaPurpose,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,modes: null == modes ? _self.modes : modes // ignore: cast_nullable_to_non_nullable
as List<PujaMode>,templeName: freezed == templeName ? _self.templeName : templeName // ignore: cast_nullable_to_non_nullable
as LocalizedText?,procedure: null == procedure ? _self.procedure : procedure // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,samagriPrice: null == samagriPrice ? _self.samagriPrice : samagriPrice // ignore: cast_nullable_to_non_nullable
as double,atHomeSurcharge: null == atHomeSurcharge ? _self.atHomeSurcharge : atHomeSurcharge // ignore: cast_nullable_to_non_nullable
as double,priestCount: null == priestCount ? _self.priestCount : priestCount // ignore: cast_nullable_to_non_nullable
as int,bookingsThisMonth: null == bookingsThisMonth ? _self.bookingsThisMonth : bookingsThisMonth // ignore: cast_nullable_to_non_nullable
as int,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PujaService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of PujaService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of PujaService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get templeName {
    if (_self.templeName == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.templeName!, (value) {
    return _then(_self.copyWith(templeName: value));
  });
}
}



/// @nodoc


class _PujaService extends PujaService {
  const _PujaService({required this.id, required this.name, required this.summary, required this.purpose, required this.basePrice, required this.duration, final  List<PujaMode> modes = const <PujaMode>[PujaMode.templeOnline], this.templeName, final  List<LocalizedText> procedure = const <LocalizedText>[], this.samagriPrice = 0, this.atHomeSurcharge = 0, this.priestCount = 1, this.bookingsThisMonth = 0, this.isPopular = false}): _modes = modes,_procedure = procedure,super._();
  

@override final  String id;
@override final  LocalizedText name;
@override final  LocalizedText summary;
@override final  PujaPurpose purpose;
@override final  double basePrice;
/// How long the ritual itself takes, so a devotee attending live knows
/// what they are setting aside.
@override final  Duration duration;
/// Modes actually offered. A ritual needing a fire pit may be at-home
/// only; one needing a specific temple may be online only.
 final  List<PujaMode> _modes;
/// Modes actually offered. A ritual needing a fire pit may be at-home
/// only; one needing a specific temple may be online only.
@override@JsonKey() List<PujaMode> get modes {
  if (_modes is EqualUnmodifiableListView) return _modes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_modes);
}

/// Where a temple puja is performed.
@override final  LocalizedText? templeName;
/// Steps of the ritual, shown before booking.
 final  List<LocalizedText> _procedure;
/// Steps of the ritual, shown before booking.
@override@JsonKey() List<LocalizedText> get procedure {
  if (_procedure is EqualUnmodifiableListView) return _procedure;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_procedure);
}

/// Materials the priest brings, as an optional add-on.
@override@JsonKey() final  double samagriPrice;
/// Surcharge for a priest travelling to the devotee.
@override@JsonKey() final  double atHomeSurcharge;
/// Number of priests performing it — a real price driver in listings.
@override@JsonKey() final  int priestCount;
@override@JsonKey() final  int bookingsThisMonth;
@override@JsonKey() final  bool isPopular;

/// Create a copy of PujaService
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PujaServiceCopyWith<_PujaService> get copyWith => __$PujaServiceCopyWithImpl<_PujaService>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PujaService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.purpose, purpose) || other.purpose == purpose)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other._modes, _modes)&&(identical(other.templeName, templeName) || other.templeName == templeName)&&const DeepCollectionEquality().equals(other._procedure, _procedure)&&(identical(other.samagriPrice, samagriPrice) || other.samagriPrice == samagriPrice)&&(identical(other.atHomeSurcharge, atHomeSurcharge) || other.atHomeSurcharge == atHomeSurcharge)&&(identical(other.priestCount, priestCount) || other.priestCount == priestCount)&&(identical(other.bookingsThisMonth, bookingsThisMonth) || other.bookingsThisMonth == bookingsThisMonth)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,summary,purpose,basePrice,duration,const DeepCollectionEquality().hash(_modes),templeName,const DeepCollectionEquality().hash(_procedure),samagriPrice,atHomeSurcharge,priestCount,bookingsThisMonth,isPopular);

@override
String toString() {
  return 'PujaService(id: $id, name: $name, summary: $summary, purpose: $purpose, basePrice: $basePrice, duration: $duration, modes: $modes, templeName: $templeName, procedure: $procedure, samagriPrice: $samagriPrice, atHomeSurcharge: $atHomeSurcharge, priestCount: $priestCount, bookingsThisMonth: $bookingsThisMonth, isPopular: $isPopular)';
}


}

/// @nodoc
abstract mixin class _$PujaServiceCopyWith<$Res> implements $PujaServiceCopyWith<$Res> {
  factory _$PujaServiceCopyWith(_PujaService value, $Res Function(_PujaService) _then) = __$PujaServiceCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText name, LocalizedText summary, PujaPurpose purpose, double basePrice, Duration duration, List<PujaMode> modes, LocalizedText? templeName, List<LocalizedText> procedure, double samagriPrice, double atHomeSurcharge, int priestCount, int bookingsThisMonth, bool isPopular
});


@override $LocalizedTextCopyWith<$Res> get name;@override $LocalizedTextCopyWith<$Res> get summary;@override $LocalizedTextCopyWith<$Res>? get templeName;

}
/// @nodoc
class __$PujaServiceCopyWithImpl<$Res>
    implements _$PujaServiceCopyWith<$Res> {
  __$PujaServiceCopyWithImpl(this._self, this._then);

  final _PujaService _self;
  final $Res Function(_PujaService) _then;

/// Create a copy of PujaService
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? summary = null,Object? purpose = null,Object? basePrice = null,Object? duration = null,Object? modes = null,Object? templeName = freezed,Object? procedure = null,Object? samagriPrice = null,Object? atHomeSurcharge = null,Object? priestCount = null,Object? bookingsThisMonth = null,Object? isPopular = null,}) {
  return _then(_PujaService(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,purpose: null == purpose ? _self.purpose : purpose // ignore: cast_nullable_to_non_nullable
as PujaPurpose,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,modes: null == modes ? _self._modes : modes // ignore: cast_nullable_to_non_nullable
as List<PujaMode>,templeName: freezed == templeName ? _self.templeName : templeName // ignore: cast_nullable_to_non_nullable
as LocalizedText?,procedure: null == procedure ? _self._procedure : procedure // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,samagriPrice: null == samagriPrice ? _self.samagriPrice : samagriPrice // ignore: cast_nullable_to_non_nullable
as double,atHomeSurcharge: null == atHomeSurcharge ? _self.atHomeSurcharge : atHomeSurcharge // ignore: cast_nullable_to_non_nullable
as double,priestCount: null == priestCount ? _self.priestCount : priestCount // ignore: cast_nullable_to_non_nullable
as int,bookingsThisMonth: null == bookingsThisMonth ? _self.bookingsThisMonth : bookingsThisMonth // ignore: cast_nullable_to_non_nullable
as int,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PujaService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of PujaService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of PujaService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get templeName {
    if (_self.templeName == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.templeName!, (value) {
    return _then(_self.copyWith(templeName: value));
  });
}
}

// dart format on
