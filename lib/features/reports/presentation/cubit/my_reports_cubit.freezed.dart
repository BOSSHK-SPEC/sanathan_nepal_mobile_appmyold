// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_reports_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyReportsState {

 LoadState<List<PurchasedReport>> get reports;
/// Create a copy of MyReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyReportsStateCopyWith<MyReportsState> get copyWith => _$MyReportsStateCopyWithImpl<MyReportsState>(this as MyReportsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyReportsState&&(identical(other.reports, reports) || other.reports == reports));
}


@override
int get hashCode => Object.hash(runtimeType,reports);

@override
String toString() {
  return 'MyReportsState(reports: $reports)';
}


}

/// @nodoc
abstract mixin class $MyReportsStateCopyWith<$Res>  {
  factory $MyReportsStateCopyWith(MyReportsState value, $Res Function(MyReportsState) _then) = _$MyReportsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<PurchasedReport>> reports
});


$LoadStateCopyWith<List<PurchasedReport>, $Res> get reports;

}
/// @nodoc
class _$MyReportsStateCopyWithImpl<$Res>
    implements $MyReportsStateCopyWith<$Res> {
  _$MyReportsStateCopyWithImpl(this._self, this._then);

  final MyReportsState _self;
  final $Res Function(MyReportsState) _then;

/// Create a copy of MyReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reports = null,}) {
  return _then(_self.copyWith(
reports: null == reports ? _self.reports : reports // ignore: cast_nullable_to_non_nullable
as LoadState<List<PurchasedReport>>,
  ));
}
/// Create a copy of MyReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PurchasedReport>, $Res> get reports {
  
  return $LoadStateCopyWith<List<PurchasedReport>, $Res>(_self.reports, (value) {
    return _then(_self.copyWith(reports: value));
  });
}
}



/// @nodoc


class _MyReportsState extends MyReportsState {
  const _MyReportsState({this.reports = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<List<PurchasedReport>> reports;

/// Create a copy of MyReportsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyReportsStateCopyWith<_MyReportsState> get copyWith => __$MyReportsStateCopyWithImpl<_MyReportsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyReportsState&&(identical(other.reports, reports) || other.reports == reports));
}


@override
int get hashCode => Object.hash(runtimeType,reports);

@override
String toString() {
  return 'MyReportsState(reports: $reports)';
}


}

/// @nodoc
abstract mixin class _$MyReportsStateCopyWith<$Res> implements $MyReportsStateCopyWith<$Res> {
  factory _$MyReportsStateCopyWith(_MyReportsState value, $Res Function(_MyReportsState) _then) = __$MyReportsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<PurchasedReport>> reports
});


@override $LoadStateCopyWith<List<PurchasedReport>, $Res> get reports;

}
/// @nodoc
class __$MyReportsStateCopyWithImpl<$Res>
    implements _$MyReportsStateCopyWith<$Res> {
  __$MyReportsStateCopyWithImpl(this._self, this._then);

  final _MyReportsState _self;
  final $Res Function(_MyReportsState) _then;

/// Create a copy of MyReportsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reports = null,}) {
  return _then(_MyReportsState(
reports: null == reports ? _self.reports : reports // ignore: cast_nullable_to_non_nullable
as LoadState<List<PurchasedReport>>,
  ));
}

/// Create a copy of MyReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PurchasedReport>, $Res> get reports {
  
  return $LoadStateCopyWith<List<PurchasedReport>, $Res>(_self.reports, (value) {
    return _then(_self.copyWith(reports: value));
  });
}
}

// dart format on
