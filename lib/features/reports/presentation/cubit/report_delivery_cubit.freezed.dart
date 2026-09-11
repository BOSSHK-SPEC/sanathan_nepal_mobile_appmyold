// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_delivery_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportDeliveryState {

 LoadState<PurchasedReport> get report;
/// Create a copy of ReportDeliveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportDeliveryStateCopyWith<ReportDeliveryState> get copyWith => _$ReportDeliveryStateCopyWithImpl<ReportDeliveryState>(this as ReportDeliveryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportDeliveryState&&(identical(other.report, report) || other.report == report));
}


@override
int get hashCode => Object.hash(runtimeType,report);

@override
String toString() {
  return 'ReportDeliveryState(report: $report)';
}


}

/// @nodoc
abstract mixin class $ReportDeliveryStateCopyWith<$Res>  {
  factory $ReportDeliveryStateCopyWith(ReportDeliveryState value, $Res Function(ReportDeliveryState) _then) = _$ReportDeliveryStateCopyWithImpl;
@useResult
$Res call({
 LoadState<PurchasedReport> report
});


$LoadStateCopyWith<PurchasedReport, $Res> get report;

}
/// @nodoc
class _$ReportDeliveryStateCopyWithImpl<$Res>
    implements $ReportDeliveryStateCopyWith<$Res> {
  _$ReportDeliveryStateCopyWithImpl(this._self, this._then);

  final ReportDeliveryState _self;
  final $Res Function(ReportDeliveryState) _then;

/// Create a copy of ReportDeliveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? report = null,}) {
  return _then(_self.copyWith(
report: null == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as LoadState<PurchasedReport>,
  ));
}
/// Create a copy of ReportDeliveryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PurchasedReport, $Res> get report {
  
  return $LoadStateCopyWith<PurchasedReport, $Res>(_self.report, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}



/// @nodoc


class _ReportDeliveryState extends ReportDeliveryState {
  const _ReportDeliveryState({this.report = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<PurchasedReport> report;

/// Create a copy of ReportDeliveryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportDeliveryStateCopyWith<_ReportDeliveryState> get copyWith => __$ReportDeliveryStateCopyWithImpl<_ReportDeliveryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportDeliveryState&&(identical(other.report, report) || other.report == report));
}


@override
int get hashCode => Object.hash(runtimeType,report);

@override
String toString() {
  return 'ReportDeliveryState(report: $report)';
}


}

/// @nodoc
abstract mixin class _$ReportDeliveryStateCopyWith<$Res> implements $ReportDeliveryStateCopyWith<$Res> {
  factory _$ReportDeliveryStateCopyWith(_ReportDeliveryState value, $Res Function(_ReportDeliveryState) _then) = __$ReportDeliveryStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<PurchasedReport> report
});


@override $LoadStateCopyWith<PurchasedReport, $Res> get report;

}
/// @nodoc
class __$ReportDeliveryStateCopyWithImpl<$Res>
    implements _$ReportDeliveryStateCopyWith<$Res> {
  __$ReportDeliveryStateCopyWithImpl(this._self, this._then);

  final _ReportDeliveryState _self;
  final $Res Function(_ReportDeliveryState) _then;

/// Create a copy of ReportDeliveryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? report = null,}) {
  return _then(_ReportDeliveryState(
report: null == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as LoadState<PurchasedReport>,
  ));
}

/// Create a copy of ReportDeliveryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PurchasedReport, $Res> get report {
  
  return $LoadStateCopyWith<PurchasedReport, $Res>(_self.report, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}

// dart format on
