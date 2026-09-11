// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'converted_date.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConvertedDate {

 ConversionDirection get direction;/// Date in the region's traditional calendar (BS / Saka).
 TraditionalDate get traditional; DateTime get ad; PanchangaInfo get panchanga;/// Reference "today" (AD, date only) used for the difference / age section.
 DateTime get today;/// Region weekend day (Saturday in Nepal, Sunday in India).
 bool get isWeekend; List<CalendarEvent> get events;
/// Create a copy of ConvertedDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConvertedDateCopyWith<ConvertedDate> get copyWith => _$ConvertedDateCopyWithImpl<ConvertedDate>(this as ConvertedDate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConvertedDate&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.traditional, traditional) || other.traditional == traditional)&&(identical(other.ad, ad) || other.ad == ad)&&(identical(other.panchanga, panchanga) || other.panchanga == panchanga)&&(identical(other.today, today) || other.today == today)&&(identical(other.isWeekend, isWeekend) || other.isWeekend == isWeekend)&&const DeepCollectionEquality().equals(other.events, events));
}


@override
int get hashCode => Object.hash(runtimeType,direction,traditional,ad,panchanga,today,isWeekend,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'ConvertedDate(direction: $direction, traditional: $traditional, ad: $ad, panchanga: $panchanga, today: $today, isWeekend: $isWeekend, events: $events)';
}


}

/// @nodoc
abstract mixin class $ConvertedDateCopyWith<$Res>  {
  factory $ConvertedDateCopyWith(ConvertedDate value, $Res Function(ConvertedDate) _then) = _$ConvertedDateCopyWithImpl;
@useResult
$Res call({
 ConversionDirection direction, TraditionalDate traditional, DateTime ad, PanchangaInfo panchanga, DateTime today, bool isWeekend, List<CalendarEvent> events
});


$TraditionalDateCopyWith<$Res> get traditional;$PanchangaInfoCopyWith<$Res> get panchanga;

}
/// @nodoc
class _$ConvertedDateCopyWithImpl<$Res>
    implements $ConvertedDateCopyWith<$Res> {
  _$ConvertedDateCopyWithImpl(this._self, this._then);

  final ConvertedDate _self;
  final $Res Function(ConvertedDate) _then;

/// Create a copy of ConvertedDate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? direction = null,Object? traditional = null,Object? ad = null,Object? panchanga = null,Object? today = null,Object? isWeekend = null,Object? events = null,}) {
  return _then(_self.copyWith(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as ConversionDirection,traditional: null == traditional ? _self.traditional : traditional // ignore: cast_nullable_to_non_nullable
as TraditionalDate,ad: null == ad ? _self.ad : ad // ignore: cast_nullable_to_non_nullable
as DateTime,panchanga: null == panchanga ? _self.panchanga : panchanga // ignore: cast_nullable_to_non_nullable
as PanchangaInfo,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as DateTime,isWeekend: null == isWeekend ? _self.isWeekend : isWeekend // ignore: cast_nullable_to_non_nullable
as bool,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,
  ));
}
/// Create a copy of ConvertedDate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TraditionalDateCopyWith<$Res> get traditional {
  
  return $TraditionalDateCopyWith<$Res>(_self.traditional, (value) {
    return _then(_self.copyWith(traditional: value));
  });
}/// Create a copy of ConvertedDate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaInfoCopyWith<$Res> get panchanga {
  
  return $PanchangaInfoCopyWith<$Res>(_self.panchanga, (value) {
    return _then(_self.copyWith(panchanga: value));
  });
}
}



/// @nodoc


class _ConvertedDate extends ConvertedDate {
  const _ConvertedDate({required this.direction, required this.traditional, required this.ad, required this.panchanga, required this.today, required this.isWeekend, final  List<CalendarEvent> events = const <CalendarEvent>[]}): _events = events,super._();
  

@override final  ConversionDirection direction;
/// Date in the region's traditional calendar (BS / Saka).
@override final  TraditionalDate traditional;
@override final  DateTime ad;
@override final  PanchangaInfo panchanga;
/// Reference "today" (AD, date only) used for the difference / age section.
@override final  DateTime today;
/// Region weekend day (Saturday in Nepal, Sunday in India).
@override final  bool isWeekend;
 final  List<CalendarEvent> _events;
@override@JsonKey() List<CalendarEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of ConvertedDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConvertedDateCopyWith<_ConvertedDate> get copyWith => __$ConvertedDateCopyWithImpl<_ConvertedDate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConvertedDate&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.traditional, traditional) || other.traditional == traditional)&&(identical(other.ad, ad) || other.ad == ad)&&(identical(other.panchanga, panchanga) || other.panchanga == panchanga)&&(identical(other.today, today) || other.today == today)&&(identical(other.isWeekend, isWeekend) || other.isWeekend == isWeekend)&&const DeepCollectionEquality().equals(other._events, _events));
}


@override
int get hashCode => Object.hash(runtimeType,direction,traditional,ad,panchanga,today,isWeekend,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'ConvertedDate(direction: $direction, traditional: $traditional, ad: $ad, panchanga: $panchanga, today: $today, isWeekend: $isWeekend, events: $events)';
}


}

/// @nodoc
abstract mixin class _$ConvertedDateCopyWith<$Res> implements $ConvertedDateCopyWith<$Res> {
  factory _$ConvertedDateCopyWith(_ConvertedDate value, $Res Function(_ConvertedDate) _then) = __$ConvertedDateCopyWithImpl;
@override @useResult
$Res call({
 ConversionDirection direction, TraditionalDate traditional, DateTime ad, PanchangaInfo panchanga, DateTime today, bool isWeekend, List<CalendarEvent> events
});


@override $TraditionalDateCopyWith<$Res> get traditional;@override $PanchangaInfoCopyWith<$Res> get panchanga;

}
/// @nodoc
class __$ConvertedDateCopyWithImpl<$Res>
    implements _$ConvertedDateCopyWith<$Res> {
  __$ConvertedDateCopyWithImpl(this._self, this._then);

  final _ConvertedDate _self;
  final $Res Function(_ConvertedDate) _then;

/// Create a copy of ConvertedDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? direction = null,Object? traditional = null,Object? ad = null,Object? panchanga = null,Object? today = null,Object? isWeekend = null,Object? events = null,}) {
  return _then(_ConvertedDate(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as ConversionDirection,traditional: null == traditional ? _self.traditional : traditional // ignore: cast_nullable_to_non_nullable
as TraditionalDate,ad: null == ad ? _self.ad : ad // ignore: cast_nullable_to_non_nullable
as DateTime,panchanga: null == panchanga ? _self.panchanga : panchanga // ignore: cast_nullable_to_non_nullable
as PanchangaInfo,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as DateTime,isWeekend: null == isWeekend ? _self.isWeekend : isWeekend // ignore: cast_nullable_to_non_nullable
as bool,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,
  ));
}

/// Create a copy of ConvertedDate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TraditionalDateCopyWith<$Res> get traditional {
  
  return $TraditionalDateCopyWith<$Res>(_self.traditional, (value) {
    return _then(_self.copyWith(traditional: value));
  });
}/// Create a copy of ConvertedDate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PanchangaInfoCopyWith<$Res> get panchanga {
  
  return $PanchangaInfoCopyWith<$Res>(_self.panchanga, (value) {
    return _then(_self.copyWith(panchanga: value));
  });
}
}

// dart format on
