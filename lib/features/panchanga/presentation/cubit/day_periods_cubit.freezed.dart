// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_periods_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DayPeriodsState {

/// Civil day being shown (local midnight).
 DateTime get date;/// Where the "now" marker sits. Held in state rather than read at build
/// time so the highlighted row cannot change between two builds of the
/// same frame.
 DateTime get now; LoadState<Panchanga> get today; LoadState<Panchanga> get tomorrow; DayPeriodView get view;/// The reader's birth pada, 0–107, or null until they choose one. Tara
/// bala and chandra bala are simply absent until then rather than being
/// counted from an assumed star.
 int? get birthPada;
/// Create a copy of DayPeriodsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayPeriodsStateCopyWith<DayPeriodsState> get copyWith => _$DayPeriodsStateCopyWithImpl<DayPeriodsState>(this as DayPeriodsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayPeriodsState&&(identical(other.date, date) || other.date == date)&&(identical(other.now, now) || other.now == now)&&(identical(other.today, today) || other.today == today)&&(identical(other.tomorrow, tomorrow) || other.tomorrow == tomorrow)&&(identical(other.view, view) || other.view == view)&&(identical(other.birthPada, birthPada) || other.birthPada == birthPada));
}


@override
int get hashCode => Object.hash(runtimeType,date,now,today,tomorrow,view,birthPada);

@override
String toString() {
  return 'DayPeriodsState(date: $date, now: $now, today: $today, tomorrow: $tomorrow, view: $view, birthPada: $birthPada)';
}


}

/// @nodoc
abstract mixin class $DayPeriodsStateCopyWith<$Res>  {
  factory $DayPeriodsStateCopyWith(DayPeriodsState value, $Res Function(DayPeriodsState) _then) = _$DayPeriodsStateCopyWithImpl;
@useResult
$Res call({
 DateTime date, DateTime now, LoadState<Panchanga> today, LoadState<Panchanga> tomorrow, DayPeriodView view, int? birthPada
});


$LoadStateCopyWith<Panchanga, $Res> get today;$LoadStateCopyWith<Panchanga, $Res> get tomorrow;

}
/// @nodoc
class _$DayPeriodsStateCopyWithImpl<$Res>
    implements $DayPeriodsStateCopyWith<$Res> {
  _$DayPeriodsStateCopyWithImpl(this._self, this._then);

  final DayPeriodsState _self;
  final $Res Function(DayPeriodsState) _then;

/// Create a copy of DayPeriodsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? now = null,Object? today = null,Object? tomorrow = null,Object? view = null,Object? birthPada = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as LoadState<Panchanga>,tomorrow: null == tomorrow ? _self.tomorrow : tomorrow // ignore: cast_nullable_to_non_nullable
as LoadState<Panchanga>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as DayPeriodView,birthPada: freezed == birthPada ? _self.birthPada : birthPada // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of DayPeriodsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Panchanga, $Res> get today {
  
  return $LoadStateCopyWith<Panchanga, $Res>(_self.today, (value) {
    return _then(_self.copyWith(today: value));
  });
}/// Create a copy of DayPeriodsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Panchanga, $Res> get tomorrow {
  
  return $LoadStateCopyWith<Panchanga, $Res>(_self.tomorrow, (value) {
    return _then(_self.copyWith(tomorrow: value));
  });
}
}



/// @nodoc


class _DayPeriodsState extends DayPeriodsState {
  const _DayPeriodsState({required this.date, required this.now, this.today = const LoadState.idle(), this.tomorrow = const LoadState.idle(), this.view = DayPeriodView.choghadiya, this.birthPada}): super._();
  

/// Civil day being shown (local midnight).
@override final  DateTime date;
/// Where the "now" marker sits. Held in state rather than read at build
/// time so the highlighted row cannot change between two builds of the
/// same frame.
@override final  DateTime now;
@override@JsonKey() final  LoadState<Panchanga> today;
@override@JsonKey() final  LoadState<Panchanga> tomorrow;
@override@JsonKey() final  DayPeriodView view;
/// The reader's birth pada, 0–107, or null until they choose one. Tara
/// bala and chandra bala are simply absent until then rather than being
/// counted from an assumed star.
@override final  int? birthPada;

/// Create a copy of DayPeriodsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayPeriodsStateCopyWith<_DayPeriodsState> get copyWith => __$DayPeriodsStateCopyWithImpl<_DayPeriodsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayPeriodsState&&(identical(other.date, date) || other.date == date)&&(identical(other.now, now) || other.now == now)&&(identical(other.today, today) || other.today == today)&&(identical(other.tomorrow, tomorrow) || other.tomorrow == tomorrow)&&(identical(other.view, view) || other.view == view)&&(identical(other.birthPada, birthPada) || other.birthPada == birthPada));
}


@override
int get hashCode => Object.hash(runtimeType,date,now,today,tomorrow,view,birthPada);

@override
String toString() {
  return 'DayPeriodsState(date: $date, now: $now, today: $today, tomorrow: $tomorrow, view: $view, birthPada: $birthPada)';
}


}

/// @nodoc
abstract mixin class _$DayPeriodsStateCopyWith<$Res> implements $DayPeriodsStateCopyWith<$Res> {
  factory _$DayPeriodsStateCopyWith(_DayPeriodsState value, $Res Function(_DayPeriodsState) _then) = __$DayPeriodsStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, DateTime now, LoadState<Panchanga> today, LoadState<Panchanga> tomorrow, DayPeriodView view, int? birthPada
});


@override $LoadStateCopyWith<Panchanga, $Res> get today;@override $LoadStateCopyWith<Panchanga, $Res> get tomorrow;

}
/// @nodoc
class __$DayPeriodsStateCopyWithImpl<$Res>
    implements _$DayPeriodsStateCopyWith<$Res> {
  __$DayPeriodsStateCopyWithImpl(this._self, this._then);

  final _DayPeriodsState _self;
  final $Res Function(_DayPeriodsState) _then;

/// Create a copy of DayPeriodsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? now = null,Object? today = null,Object? tomorrow = null,Object? view = null,Object? birthPada = freezed,}) {
  return _then(_DayPeriodsState(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as LoadState<Panchanga>,tomorrow: null == tomorrow ? _self.tomorrow : tomorrow // ignore: cast_nullable_to_non_nullable
as LoadState<Panchanga>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as DayPeriodView,birthPada: freezed == birthPada ? _self.birthPada : birthPada // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of DayPeriodsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Panchanga, $Res> get today {
  
  return $LoadStateCopyWith<Panchanga, $Res>(_self.today, (value) {
    return _then(_self.copyWith(today: value));
  });
}/// Create a copy of DayPeriodsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Panchanga, $Res> get tomorrow {
  
  return $LoadStateCopyWith<Panchanga, $Res>(_self.tomorrow, (value) {
    return _then(_self.copyWith(tomorrow: value));
  });
}
}

// dart format on
