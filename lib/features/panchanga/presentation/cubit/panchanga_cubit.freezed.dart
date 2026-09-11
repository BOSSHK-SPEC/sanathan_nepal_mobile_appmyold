// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panchanga_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PanchangaState {

/// Civil day currently displayed (local midnight).
 DateTime get date;/// Traditional (B.S. / Saka) year and month browsed in the sait tables.
/// Follow [date] until the user navigates with prev/next.
 int get saitYear; int get saitMonth; LoadState<Panchanga> get panchanga;/// Auspicious-timing categories (loaded once, independent of [date]).
 LoadState<List<SuvaSait>> get saits; SaitView get saitView;
/// Create a copy of PanchangaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PanchangaStateCopyWith<PanchangaState> get copyWith => _$PanchangaStateCopyWithImpl<PanchangaState>(this as PanchangaState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PanchangaState&&(identical(other.date, date) || other.date == date)&&(identical(other.saitYear, saitYear) || other.saitYear == saitYear)&&(identical(other.saitMonth, saitMonth) || other.saitMonth == saitMonth)&&(identical(other.panchanga, panchanga) || other.panchanga == panchanga)&&(identical(other.saits, saits) || other.saits == saits)&&(identical(other.saitView, saitView) || other.saitView == saitView));
}


@override
int get hashCode => Object.hash(runtimeType,date,saitYear,saitMonth,panchanga,saits,saitView);

@override
String toString() {
  return 'PanchangaState(date: $date, saitYear: $saitYear, saitMonth: $saitMonth, panchanga: $panchanga, saits: $saits, saitView: $saitView)';
}


}

/// @nodoc
abstract mixin class $PanchangaStateCopyWith<$Res>  {
  factory $PanchangaStateCopyWith(PanchangaState value, $Res Function(PanchangaState) _then) = _$PanchangaStateCopyWithImpl;
@useResult
$Res call({
 DateTime date, int saitYear, int saitMonth, LoadState<Panchanga> panchanga, LoadState<List<SuvaSait>> saits, SaitView saitView
});


$LoadStateCopyWith<Panchanga, $Res> get panchanga;$LoadStateCopyWith<List<SuvaSait>, $Res> get saits;

}
/// @nodoc
class _$PanchangaStateCopyWithImpl<$Res>
    implements $PanchangaStateCopyWith<$Res> {
  _$PanchangaStateCopyWithImpl(this._self, this._then);

  final PanchangaState _self;
  final $Res Function(PanchangaState) _then;

/// Create a copy of PanchangaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? saitYear = null,Object? saitMonth = null,Object? panchanga = null,Object? saits = null,Object? saitView = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,saitYear: null == saitYear ? _self.saitYear : saitYear // ignore: cast_nullable_to_non_nullable
as int,saitMonth: null == saitMonth ? _self.saitMonth : saitMonth // ignore: cast_nullable_to_non_nullable
as int,panchanga: null == panchanga ? _self.panchanga : panchanga // ignore: cast_nullable_to_non_nullable
as LoadState<Panchanga>,saits: null == saits ? _self.saits : saits // ignore: cast_nullable_to_non_nullable
as LoadState<List<SuvaSait>>,saitView: null == saitView ? _self.saitView : saitView // ignore: cast_nullable_to_non_nullable
as SaitView,
  ));
}
/// Create a copy of PanchangaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Panchanga, $Res> get panchanga {
  
  return $LoadStateCopyWith<Panchanga, $Res>(_self.panchanga, (value) {
    return _then(_self.copyWith(panchanga: value));
  });
}/// Create a copy of PanchangaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<SuvaSait>, $Res> get saits {
  
  return $LoadStateCopyWith<List<SuvaSait>, $Res>(_self.saits, (value) {
    return _then(_self.copyWith(saits: value));
  });
}
}



/// @nodoc


class _PanchangaState extends PanchangaState {
  const _PanchangaState({required this.date, required this.saitYear, required this.saitMonth, this.panchanga = const LoadState.idle(), this.saits = const LoadState.idle(), this.saitView = SaitView.monthly}): super._();
  

/// Civil day currently displayed (local midnight).
@override final  DateTime date;
/// Traditional (B.S. / Saka) year and month browsed in the sait tables.
/// Follow [date] until the user navigates with prev/next.
@override final  int saitYear;
@override final  int saitMonth;
@override@JsonKey() final  LoadState<Panchanga> panchanga;
/// Auspicious-timing categories (loaded once, independent of [date]).
@override@JsonKey() final  LoadState<List<SuvaSait>> saits;
@override@JsonKey() final  SaitView saitView;

/// Create a copy of PanchangaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PanchangaStateCopyWith<_PanchangaState> get copyWith => __$PanchangaStateCopyWithImpl<_PanchangaState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PanchangaState&&(identical(other.date, date) || other.date == date)&&(identical(other.saitYear, saitYear) || other.saitYear == saitYear)&&(identical(other.saitMonth, saitMonth) || other.saitMonth == saitMonth)&&(identical(other.panchanga, panchanga) || other.panchanga == panchanga)&&(identical(other.saits, saits) || other.saits == saits)&&(identical(other.saitView, saitView) || other.saitView == saitView));
}


@override
int get hashCode => Object.hash(runtimeType,date,saitYear,saitMonth,panchanga,saits,saitView);

@override
String toString() {
  return 'PanchangaState(date: $date, saitYear: $saitYear, saitMonth: $saitMonth, panchanga: $panchanga, saits: $saits, saitView: $saitView)';
}


}

/// @nodoc
abstract mixin class _$PanchangaStateCopyWith<$Res> implements $PanchangaStateCopyWith<$Res> {
  factory _$PanchangaStateCopyWith(_PanchangaState value, $Res Function(_PanchangaState) _then) = __$PanchangaStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int saitYear, int saitMonth, LoadState<Panchanga> panchanga, LoadState<List<SuvaSait>> saits, SaitView saitView
});


@override $LoadStateCopyWith<Panchanga, $Res> get panchanga;@override $LoadStateCopyWith<List<SuvaSait>, $Res> get saits;

}
/// @nodoc
class __$PanchangaStateCopyWithImpl<$Res>
    implements _$PanchangaStateCopyWith<$Res> {
  __$PanchangaStateCopyWithImpl(this._self, this._then);

  final _PanchangaState _self;
  final $Res Function(_PanchangaState) _then;

/// Create a copy of PanchangaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? saitYear = null,Object? saitMonth = null,Object? panchanga = null,Object? saits = null,Object? saitView = null,}) {
  return _then(_PanchangaState(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,saitYear: null == saitYear ? _self.saitYear : saitYear // ignore: cast_nullable_to_non_nullable
as int,saitMonth: null == saitMonth ? _self.saitMonth : saitMonth // ignore: cast_nullable_to_non_nullable
as int,panchanga: null == panchanga ? _self.panchanga : panchanga // ignore: cast_nullable_to_non_nullable
as LoadState<Panchanga>,saits: null == saits ? _self.saits : saits // ignore: cast_nullable_to_non_nullable
as LoadState<List<SuvaSait>>,saitView: null == saitView ? _self.saitView : saitView // ignore: cast_nullable_to_non_nullable
as SaitView,
  ));
}

/// Create a copy of PanchangaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Panchanga, $Res> get panchanga {
  
  return $LoadStateCopyWith<Panchanga, $Res>(_self.panchanga, (value) {
    return _then(_self.copyWith(panchanga: value));
  });
}/// Create a copy of PanchangaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<SuvaSait>, $Res> get saits {
  
  return $LoadStateCopyWith<List<SuvaSait>, $Res>(_self.saits, (value) {
    return _then(_self.copyWith(saits: value));
  });
}
}

// dart format on
