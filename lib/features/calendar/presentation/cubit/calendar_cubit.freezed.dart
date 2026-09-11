// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarState {

/// Which calendar system [year]/[month] refer to.
 CalendarViewMode get viewMode; int get year; int get month; LoadState<CalendarMonth> get calendarMonth; CalendarDay? get selectedDay;
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarStateCopyWith<CalendarState> get copyWith => _$CalendarStateCopyWithImpl<CalendarState>(this as CalendarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarState&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.calendarMonth, calendarMonth) || other.calendarMonth == calendarMonth)&&(identical(other.selectedDay, selectedDay) || other.selectedDay == selectedDay));
}


@override
int get hashCode => Object.hash(runtimeType,viewMode,year,month,calendarMonth,selectedDay);

@override
String toString() {
  return 'CalendarState(viewMode: $viewMode, year: $year, month: $month, calendarMonth: $calendarMonth, selectedDay: $selectedDay)';
}


}

/// @nodoc
abstract mixin class $CalendarStateCopyWith<$Res>  {
  factory $CalendarStateCopyWith(CalendarState value, $Res Function(CalendarState) _then) = _$CalendarStateCopyWithImpl;
@useResult
$Res call({
 CalendarViewMode viewMode, int year, int month, LoadState<CalendarMonth> calendarMonth, CalendarDay? selectedDay
});


$LoadStateCopyWith<CalendarMonth, $Res> get calendarMonth;$CalendarDayCopyWith<$Res>? get selectedDay;

}
/// @nodoc
class _$CalendarStateCopyWithImpl<$Res>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._self, this._then);

  final CalendarState _self;
  final $Res Function(CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? viewMode = null,Object? year = null,Object? month = null,Object? calendarMonth = null,Object? selectedDay = freezed,}) {
  return _then(_self.copyWith(
viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as CalendarViewMode,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,calendarMonth: null == calendarMonth ? _self.calendarMonth : calendarMonth // ignore: cast_nullable_to_non_nullable
as LoadState<CalendarMonth>,selectedDay: freezed == selectedDay ? _self.selectedDay : selectedDay // ignore: cast_nullable_to_non_nullable
as CalendarDay?,
  ));
}
/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<CalendarMonth, $Res> get calendarMonth {
  
  return $LoadStateCopyWith<CalendarMonth, $Res>(_self.calendarMonth, (value) {
    return _then(_self.copyWith(calendarMonth: value));
  });
}/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalendarDayCopyWith<$Res>? get selectedDay {
    if (_self.selectedDay == null) {
    return null;
  }

  return $CalendarDayCopyWith<$Res>(_self.selectedDay!, (value) {
    return _then(_self.copyWith(selectedDay: value));
  });
}
}



/// @nodoc


class _CalendarState extends CalendarState {
  const _CalendarState({this.viewMode = CalendarViewMode.traditional, required this.year, required this.month, this.calendarMonth = const LoadState.idle(), this.selectedDay}): super._();
  

/// Which calendar system [year]/[month] refer to.
@override@JsonKey() final  CalendarViewMode viewMode;
@override final  int year;
@override final  int month;
@override@JsonKey() final  LoadState<CalendarMonth> calendarMonth;
@override final  CalendarDay? selectedDay;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarStateCopyWith<_CalendarState> get copyWith => __$CalendarStateCopyWithImpl<_CalendarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarState&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.calendarMonth, calendarMonth) || other.calendarMonth == calendarMonth)&&(identical(other.selectedDay, selectedDay) || other.selectedDay == selectedDay));
}


@override
int get hashCode => Object.hash(runtimeType,viewMode,year,month,calendarMonth,selectedDay);

@override
String toString() {
  return 'CalendarState(viewMode: $viewMode, year: $year, month: $month, calendarMonth: $calendarMonth, selectedDay: $selectedDay)';
}


}

/// @nodoc
abstract mixin class _$CalendarStateCopyWith<$Res> implements $CalendarStateCopyWith<$Res> {
  factory _$CalendarStateCopyWith(_CalendarState value, $Res Function(_CalendarState) _then) = __$CalendarStateCopyWithImpl;
@override @useResult
$Res call({
 CalendarViewMode viewMode, int year, int month, LoadState<CalendarMonth> calendarMonth, CalendarDay? selectedDay
});


@override $LoadStateCopyWith<CalendarMonth, $Res> get calendarMonth;@override $CalendarDayCopyWith<$Res>? get selectedDay;

}
/// @nodoc
class __$CalendarStateCopyWithImpl<$Res>
    implements _$CalendarStateCopyWith<$Res> {
  __$CalendarStateCopyWithImpl(this._self, this._then);

  final _CalendarState _self;
  final $Res Function(_CalendarState) _then;

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? viewMode = null,Object? year = null,Object? month = null,Object? calendarMonth = null,Object? selectedDay = freezed,}) {
  return _then(_CalendarState(
viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as CalendarViewMode,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,calendarMonth: null == calendarMonth ? _self.calendarMonth : calendarMonth // ignore: cast_nullable_to_non_nullable
as LoadState<CalendarMonth>,selectedDay: freezed == selectedDay ? _self.selectedDay : selectedDay // ignore: cast_nullable_to_non_nullable
as CalendarDay?,
  ));
}

/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<CalendarMonth, $Res> get calendarMonth {
  
  return $LoadStateCopyWith<CalendarMonth, $Res>(_self.calendarMonth, (value) {
    return _then(_self.copyWith(calendarMonth: value));
  });
}/// Create a copy of CalendarState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CalendarDayCopyWith<$Res>? get selectedDay {
    if (_self.selectedDay == null) {
    return null;
  }

  return $CalendarDayCopyWith<$Res>(_self.selectedDay!, (value) {
    return _then(_self.copyWith(selectedDay: value));
  });
}
}

// dart format on
