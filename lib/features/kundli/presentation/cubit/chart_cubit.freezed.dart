// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChartState {

 LoadState<KundliChart> get chart; LoadState<List<DashaPeriod>> get dashas; LoadState<List<DoshaReading>> get doshas; ChartStyle get style; int get tabIndex; String? get expandedDasha;
/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartStateCopyWith<ChartState> get copyWith => _$ChartStateCopyWithImpl<ChartState>(this as ChartState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartState&&(identical(other.chart, chart) || other.chart == chart)&&(identical(other.dashas, dashas) || other.dashas == dashas)&&(identical(other.doshas, doshas) || other.doshas == doshas)&&(identical(other.style, style) || other.style == style)&&(identical(other.tabIndex, tabIndex) || other.tabIndex == tabIndex)&&(identical(other.expandedDasha, expandedDasha) || other.expandedDasha == expandedDasha));
}


@override
int get hashCode => Object.hash(runtimeType,chart,dashas,doshas,style,tabIndex,expandedDasha);

@override
String toString() {
  return 'ChartState(chart: $chart, dashas: $dashas, doshas: $doshas, style: $style, tabIndex: $tabIndex, expandedDasha: $expandedDasha)';
}


}

/// @nodoc
abstract mixin class $ChartStateCopyWith<$Res>  {
  factory $ChartStateCopyWith(ChartState value, $Res Function(ChartState) _then) = _$ChartStateCopyWithImpl;
@useResult
$Res call({
 LoadState<KundliChart> chart, LoadState<List<DashaPeriod>> dashas, LoadState<List<DoshaReading>> doshas, ChartStyle style, int tabIndex, String? expandedDasha
});


$LoadStateCopyWith<KundliChart, $Res> get chart;$LoadStateCopyWith<List<DashaPeriod>, $Res> get dashas;$LoadStateCopyWith<List<DoshaReading>, $Res> get doshas;

}
/// @nodoc
class _$ChartStateCopyWithImpl<$Res>
    implements $ChartStateCopyWith<$Res> {
  _$ChartStateCopyWithImpl(this._self, this._then);

  final ChartState _self;
  final $Res Function(ChartState) _then;

/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chart = null,Object? dashas = null,Object? doshas = null,Object? style = null,Object? tabIndex = null,Object? expandedDasha = freezed,}) {
  return _then(_self.copyWith(
chart: null == chart ? _self.chart : chart // ignore: cast_nullable_to_non_nullable
as LoadState<KundliChart>,dashas: null == dashas ? _self.dashas : dashas // ignore: cast_nullable_to_non_nullable
as LoadState<List<DashaPeriod>>,doshas: null == doshas ? _self.doshas : doshas // ignore: cast_nullable_to_non_nullable
as LoadState<List<DoshaReading>>,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as ChartStyle,tabIndex: null == tabIndex ? _self.tabIndex : tabIndex // ignore: cast_nullable_to_non_nullable
as int,expandedDasha: freezed == expandedDasha ? _self.expandedDasha : expandedDasha // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<KundliChart, $Res> get chart {
  
  return $LoadStateCopyWith<KundliChart, $Res>(_self.chart, (value) {
    return _then(_self.copyWith(chart: value));
  });
}/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<DashaPeriod>, $Res> get dashas {
  
  return $LoadStateCopyWith<List<DashaPeriod>, $Res>(_self.dashas, (value) {
    return _then(_self.copyWith(dashas: value));
  });
}/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<DoshaReading>, $Res> get doshas {
  
  return $LoadStateCopyWith<List<DoshaReading>, $Res>(_self.doshas, (value) {
    return _then(_self.copyWith(doshas: value));
  });
}
}



/// @nodoc


class _ChartState extends ChartState {
  const _ChartState({this.chart = const LoadState.idle(), this.dashas = const LoadState.idle(), this.doshas = const LoadState.idle(), this.style = ChartStyle.north, this.tabIndex = 0, this.expandedDasha}): super._();
  

@override@JsonKey() final  LoadState<KundliChart> chart;
@override@JsonKey() final  LoadState<List<DashaPeriod>> dashas;
@override@JsonKey() final  LoadState<List<DoshaReading>> doshas;
@override@JsonKey() final  ChartStyle style;
@override@JsonKey() final  int tabIndex;
@override final  String? expandedDasha;

/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChartStateCopyWith<_ChartState> get copyWith => __$ChartStateCopyWithImpl<_ChartState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChartState&&(identical(other.chart, chart) || other.chart == chart)&&(identical(other.dashas, dashas) || other.dashas == dashas)&&(identical(other.doshas, doshas) || other.doshas == doshas)&&(identical(other.style, style) || other.style == style)&&(identical(other.tabIndex, tabIndex) || other.tabIndex == tabIndex)&&(identical(other.expandedDasha, expandedDasha) || other.expandedDasha == expandedDasha));
}


@override
int get hashCode => Object.hash(runtimeType,chart,dashas,doshas,style,tabIndex,expandedDasha);

@override
String toString() {
  return 'ChartState(chart: $chart, dashas: $dashas, doshas: $doshas, style: $style, tabIndex: $tabIndex, expandedDasha: $expandedDasha)';
}


}

/// @nodoc
abstract mixin class _$ChartStateCopyWith<$Res> implements $ChartStateCopyWith<$Res> {
  factory _$ChartStateCopyWith(_ChartState value, $Res Function(_ChartState) _then) = __$ChartStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<KundliChart> chart, LoadState<List<DashaPeriod>> dashas, LoadState<List<DoshaReading>> doshas, ChartStyle style, int tabIndex, String? expandedDasha
});


@override $LoadStateCopyWith<KundliChart, $Res> get chart;@override $LoadStateCopyWith<List<DashaPeriod>, $Res> get dashas;@override $LoadStateCopyWith<List<DoshaReading>, $Res> get doshas;

}
/// @nodoc
class __$ChartStateCopyWithImpl<$Res>
    implements _$ChartStateCopyWith<$Res> {
  __$ChartStateCopyWithImpl(this._self, this._then);

  final _ChartState _self;
  final $Res Function(_ChartState) _then;

/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chart = null,Object? dashas = null,Object? doshas = null,Object? style = null,Object? tabIndex = null,Object? expandedDasha = freezed,}) {
  return _then(_ChartState(
chart: null == chart ? _self.chart : chart // ignore: cast_nullable_to_non_nullable
as LoadState<KundliChart>,dashas: null == dashas ? _self.dashas : dashas // ignore: cast_nullable_to_non_nullable
as LoadState<List<DashaPeriod>>,doshas: null == doshas ? _self.doshas : doshas // ignore: cast_nullable_to_non_nullable
as LoadState<List<DoshaReading>>,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as ChartStyle,tabIndex: null == tabIndex ? _self.tabIndex : tabIndex // ignore: cast_nullable_to_non_nullable
as int,expandedDasha: freezed == expandedDasha ? _self.expandedDasha : expandedDasha // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<KundliChart, $Res> get chart {
  
  return $LoadStateCopyWith<KundliChart, $Res>(_self.chart, (value) {
    return _then(_self.copyWith(chart: value));
  });
}/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<DashaPeriod>, $Res> get dashas {
  
  return $LoadStateCopyWith<List<DashaPeriod>, $Res>(_self.dashas, (value) {
    return _then(_self.copyWith(dashas: value));
  });
}/// Create a copy of ChartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<DoshaReading>, $Res> get doshas {
  
  return $LoadStateCopyWith<List<DoshaReading>, $Res>(_self.doshas, (value) {
    return _then(_self.copyWith(doshas: value));
  });
}
}

// dart format on
