// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarDay {

/// Date in the region's traditional calendar (BS / Saka).
 TraditionalDate get traditional; DateTime get ad;/// False for the leading/trailing filler days of adjacent months.
 bool get isCurrentMonth; bool get isToday;/// Weekly rest day of the region (Saturday in Nepal, Sunday in India) –
/// decided by `RegionConfig.weekendWeekdays`.
 bool get isWeekend;/// Approximate tithi/paksha for this day.
 LunarDay get lunarDay; List<CalendarEvent> get events;
/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarDayCopyWith<CalendarDay> get copyWith => _$CalendarDayCopyWithImpl<CalendarDay>(this as CalendarDay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarDay&&(identical(other.traditional, traditional) || other.traditional == traditional)&&(identical(other.ad, ad) || other.ad == ad)&&(identical(other.isCurrentMonth, isCurrentMonth) || other.isCurrentMonth == isCurrentMonth)&&(identical(other.isToday, isToday) || other.isToday == isToday)&&(identical(other.isWeekend, isWeekend) || other.isWeekend == isWeekend)&&(identical(other.lunarDay, lunarDay) || other.lunarDay == lunarDay)&&const DeepCollectionEquality().equals(other.events, events));
}


@override
int get hashCode => Object.hash(runtimeType,traditional,ad,isCurrentMonth,isToday,isWeekend,lunarDay,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'CalendarDay(traditional: $traditional, ad: $ad, isCurrentMonth: $isCurrentMonth, isToday: $isToday, isWeekend: $isWeekend, lunarDay: $lunarDay, events: $events)';
}


}

/// @nodoc
abstract mixin class $CalendarDayCopyWith<$Res>  {
  factory $CalendarDayCopyWith(CalendarDay value, $Res Function(CalendarDay) _then) = _$CalendarDayCopyWithImpl;
@useResult
$Res call({
 TraditionalDate traditional, DateTime ad, bool isCurrentMonth, bool isToday, bool isWeekend, LunarDay lunarDay, List<CalendarEvent> events
});


$TraditionalDateCopyWith<$Res> get traditional;$LunarDayCopyWith<$Res> get lunarDay;

}
/// @nodoc
class _$CalendarDayCopyWithImpl<$Res>
    implements $CalendarDayCopyWith<$Res> {
  _$CalendarDayCopyWithImpl(this._self, this._then);

  final CalendarDay _self;
  final $Res Function(CalendarDay) _then;

/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? traditional = null,Object? ad = null,Object? isCurrentMonth = null,Object? isToday = null,Object? isWeekend = null,Object? lunarDay = null,Object? events = null,}) {
  return _then(_self.copyWith(
traditional: null == traditional ? _self.traditional : traditional // ignore: cast_nullable_to_non_nullable
as TraditionalDate,ad: null == ad ? _self.ad : ad // ignore: cast_nullable_to_non_nullable
as DateTime,isCurrentMonth: null == isCurrentMonth ? _self.isCurrentMonth : isCurrentMonth // ignore: cast_nullable_to_non_nullable
as bool,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,isWeekend: null == isWeekend ? _self.isWeekend : isWeekend // ignore: cast_nullable_to_non_nullable
as bool,lunarDay: null == lunarDay ? _self.lunarDay : lunarDay // ignore: cast_nullable_to_non_nullable
as LunarDay,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,
  ));
}
/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TraditionalDateCopyWith<$Res> get traditional {
  
  return $TraditionalDateCopyWith<$Res>(_self.traditional, (value) {
    return _then(_self.copyWith(traditional: value));
  });
}/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LunarDayCopyWith<$Res> get lunarDay {
  
  return $LunarDayCopyWith<$Res>(_self.lunarDay, (value) {
    return _then(_self.copyWith(lunarDay: value));
  });
}
}



/// @nodoc


class _CalendarDay extends CalendarDay {
  const _CalendarDay({required this.traditional, required this.ad, required this.isCurrentMonth, required this.isToday, required this.isWeekend, required this.lunarDay, final  List<CalendarEvent> events = const <CalendarEvent>[]}): _events = events,super._();
  

/// Date in the region's traditional calendar (BS / Saka).
@override final  TraditionalDate traditional;
@override final  DateTime ad;
/// False for the leading/trailing filler days of adjacent months.
@override final  bool isCurrentMonth;
@override final  bool isToday;
/// Weekly rest day of the region (Saturday in Nepal, Sunday in India) –
/// decided by `RegionConfig.weekendWeekdays`.
@override final  bool isWeekend;
/// Approximate tithi/paksha for this day.
@override final  LunarDay lunarDay;
 final  List<CalendarEvent> _events;
@override@JsonKey() List<CalendarEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarDayCopyWith<_CalendarDay> get copyWith => __$CalendarDayCopyWithImpl<_CalendarDay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarDay&&(identical(other.traditional, traditional) || other.traditional == traditional)&&(identical(other.ad, ad) || other.ad == ad)&&(identical(other.isCurrentMonth, isCurrentMonth) || other.isCurrentMonth == isCurrentMonth)&&(identical(other.isToday, isToday) || other.isToday == isToday)&&(identical(other.isWeekend, isWeekend) || other.isWeekend == isWeekend)&&(identical(other.lunarDay, lunarDay) || other.lunarDay == lunarDay)&&const DeepCollectionEquality().equals(other._events, _events));
}


@override
int get hashCode => Object.hash(runtimeType,traditional,ad,isCurrentMonth,isToday,isWeekend,lunarDay,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'CalendarDay(traditional: $traditional, ad: $ad, isCurrentMonth: $isCurrentMonth, isToday: $isToday, isWeekend: $isWeekend, lunarDay: $lunarDay, events: $events)';
}


}

/// @nodoc
abstract mixin class _$CalendarDayCopyWith<$Res> implements $CalendarDayCopyWith<$Res> {
  factory _$CalendarDayCopyWith(_CalendarDay value, $Res Function(_CalendarDay) _then) = __$CalendarDayCopyWithImpl;
@override @useResult
$Res call({
 TraditionalDate traditional, DateTime ad, bool isCurrentMonth, bool isToday, bool isWeekend, LunarDay lunarDay, List<CalendarEvent> events
});


@override $TraditionalDateCopyWith<$Res> get traditional;@override $LunarDayCopyWith<$Res> get lunarDay;

}
/// @nodoc
class __$CalendarDayCopyWithImpl<$Res>
    implements _$CalendarDayCopyWith<$Res> {
  __$CalendarDayCopyWithImpl(this._self, this._then);

  final _CalendarDay _self;
  final $Res Function(_CalendarDay) _then;

/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? traditional = null,Object? ad = null,Object? isCurrentMonth = null,Object? isToday = null,Object? isWeekend = null,Object? lunarDay = null,Object? events = null,}) {
  return _then(_CalendarDay(
traditional: null == traditional ? _self.traditional : traditional // ignore: cast_nullable_to_non_nullable
as TraditionalDate,ad: null == ad ? _self.ad : ad // ignore: cast_nullable_to_non_nullable
as DateTime,isCurrentMonth: null == isCurrentMonth ? _self.isCurrentMonth : isCurrentMonth // ignore: cast_nullable_to_non_nullable
as bool,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,isWeekend: null == isWeekend ? _self.isWeekend : isWeekend // ignore: cast_nullable_to_non_nullable
as bool,lunarDay: null == lunarDay ? _self.lunarDay : lunarDay // ignore: cast_nullable_to_non_nullable
as LunarDay,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,
  ));
}

/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TraditionalDateCopyWith<$Res> get traditional {
  
  return $TraditionalDateCopyWith<$Res>(_self.traditional, (value) {
    return _then(_self.copyWith(traditional: value));
  });
}/// Create a copy of CalendarDay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LunarDayCopyWith<$Res> get lunarDay {
  
  return $LunarDayCopyWith<$Res>(_self.lunarDay, (value) {
    return _then(_self.copyWith(lunarDay: value));
  });
}
}

// dart format on
