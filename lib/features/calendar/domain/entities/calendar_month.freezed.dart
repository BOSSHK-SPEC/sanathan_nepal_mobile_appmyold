// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_month.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarMonth {

/// Which system [year]/[month] refer to.
 CalendarViewMode get mode; int get year; int get month;/// Always 42 cells (6 rows × 7 columns) starting on Sunday.
 List<CalendarDay> get days;/// Events falling in this month (current-month cells only), sorted by day.
 List<CalendarEvent> get events;
/// Create a copy of CalendarMonth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarMonthCopyWith<CalendarMonth> get copyWith => _$CalendarMonthCopyWithImpl<CalendarMonth>(this as CalendarMonth, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarMonth&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.days, days)&&const DeepCollectionEquality().equals(other.events, events));
}


@override
int get hashCode => Object.hash(runtimeType,mode,year,month,const DeepCollectionEquality().hash(days),const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'CalendarMonth(mode: $mode, year: $year, month: $month, days: $days, events: $events)';
}


}

/// @nodoc
abstract mixin class $CalendarMonthCopyWith<$Res>  {
  factory $CalendarMonthCopyWith(CalendarMonth value, $Res Function(CalendarMonth) _then) = _$CalendarMonthCopyWithImpl;
@useResult
$Res call({
 CalendarViewMode mode, int year, int month, List<CalendarDay> days, List<CalendarEvent> events
});




}
/// @nodoc
class _$CalendarMonthCopyWithImpl<$Res>
    implements $CalendarMonthCopyWith<$Res> {
  _$CalendarMonthCopyWithImpl(this._self, this._then);

  final CalendarMonth _self;
  final $Res Function(CalendarMonth) _then;

/// Create a copy of CalendarMonth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? year = null,Object? month = null,Object? days = null,Object? events = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as CalendarViewMode,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<CalendarDay>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,
  ));
}

}



/// @nodoc


class _CalendarMonth extends CalendarMonth {
  const _CalendarMonth({required this.mode, required this.year, required this.month, required final  List<CalendarDay> days, required final  List<CalendarEvent> events}): _days = days,_events = events,super._();
  

/// Which system [year]/[month] refer to.
@override final  CalendarViewMode mode;
@override final  int year;
@override final  int month;
/// Always 42 cells (6 rows × 7 columns) starting on Sunday.
 final  List<CalendarDay> _days;
/// Always 42 cells (6 rows × 7 columns) starting on Sunday.
@override List<CalendarDay> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

/// Events falling in this month (current-month cells only), sorted by day.
 final  List<CalendarEvent> _events;
/// Events falling in this month (current-month cells only), sorted by day.
@override List<CalendarEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of CalendarMonth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarMonthCopyWith<_CalendarMonth> get copyWith => __$CalendarMonthCopyWithImpl<_CalendarMonth>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarMonth&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other._days, _days)&&const DeepCollectionEquality().equals(other._events, _events));
}


@override
int get hashCode => Object.hash(runtimeType,mode,year,month,const DeepCollectionEquality().hash(_days),const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'CalendarMonth(mode: $mode, year: $year, month: $month, days: $days, events: $events)';
}


}

/// @nodoc
abstract mixin class _$CalendarMonthCopyWith<$Res> implements $CalendarMonthCopyWith<$Res> {
  factory _$CalendarMonthCopyWith(_CalendarMonth value, $Res Function(_CalendarMonth) _then) = __$CalendarMonthCopyWithImpl;
@override @useResult
$Res call({
 CalendarViewMode mode, int year, int month, List<CalendarDay> days, List<CalendarEvent> events
});




}
/// @nodoc
class __$CalendarMonthCopyWithImpl<$Res>
    implements _$CalendarMonthCopyWith<$Res> {
  __$CalendarMonthCopyWithImpl(this._self, this._then);

  final _CalendarMonth _self;
  final $Res Function(_CalendarMonth) _then;

/// Create a copy of CalendarMonth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? year = null,Object? month = null,Object? days = null,Object? events = null,}) {
  return _then(_CalendarMonth(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as CalendarViewMode,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<CalendarDay>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<CalendarEvent>,
  ));
}


}

// dart format on
