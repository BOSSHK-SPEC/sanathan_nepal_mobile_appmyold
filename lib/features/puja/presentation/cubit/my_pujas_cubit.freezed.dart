// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_pujas_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyPujasState {

 LoadState<List<PujaBooking>> get bookings; String? get busyId; String? get actionError;
/// Create a copy of MyPujasState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyPujasStateCopyWith<MyPujasState> get copyWith => _$MyPujasStateCopyWithImpl<MyPujasState>(this as MyPujasState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyPujasState&&(identical(other.bookings, bookings) || other.bookings == bookings)&&(identical(other.busyId, busyId) || other.busyId == busyId)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,bookings,busyId,actionError);

@override
String toString() {
  return 'MyPujasState(bookings: $bookings, busyId: $busyId, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $MyPujasStateCopyWith<$Res>  {
  factory $MyPujasStateCopyWith(MyPujasState value, $Res Function(MyPujasState) _then) = _$MyPujasStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<PujaBooking>> bookings, String? busyId, String? actionError
});


$LoadStateCopyWith<List<PujaBooking>, $Res> get bookings;

}
/// @nodoc
class _$MyPujasStateCopyWithImpl<$Res>
    implements $MyPujasStateCopyWith<$Res> {
  _$MyPujasStateCopyWithImpl(this._self, this._then);

  final MyPujasState _self;
  final $Res Function(MyPujasState) _then;

/// Create a copy of MyPujasState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookings = null,Object? busyId = freezed,Object? actionError = freezed,}) {
  return _then(_self.copyWith(
bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as LoadState<List<PujaBooking>>,busyId: freezed == busyId ? _self.busyId : busyId // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MyPujasState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PujaBooking>, $Res> get bookings {
  
  return $LoadStateCopyWith<List<PujaBooking>, $Res>(_self.bookings, (value) {
    return _then(_self.copyWith(bookings: value));
  });
}
}



/// @nodoc


class _MyPujasState extends MyPujasState {
  const _MyPujasState({this.bookings = const LoadState.idle(), this.busyId, this.actionError}): super._();
  

@override@JsonKey() final  LoadState<List<PujaBooking>> bookings;
@override final  String? busyId;
@override final  String? actionError;

/// Create a copy of MyPujasState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyPujasStateCopyWith<_MyPujasState> get copyWith => __$MyPujasStateCopyWithImpl<_MyPujasState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyPujasState&&(identical(other.bookings, bookings) || other.bookings == bookings)&&(identical(other.busyId, busyId) || other.busyId == busyId)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,bookings,busyId,actionError);

@override
String toString() {
  return 'MyPujasState(bookings: $bookings, busyId: $busyId, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class _$MyPujasStateCopyWith<$Res> implements $MyPujasStateCopyWith<$Res> {
  factory _$MyPujasStateCopyWith(_MyPujasState value, $Res Function(_MyPujasState) _then) = __$MyPujasStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<PujaBooking>> bookings, String? busyId, String? actionError
});


@override $LoadStateCopyWith<List<PujaBooking>, $Res> get bookings;

}
/// @nodoc
class __$MyPujasStateCopyWithImpl<$Res>
    implements _$MyPujasStateCopyWith<$Res> {
  __$MyPujasStateCopyWithImpl(this._self, this._then);

  final _MyPujasState _self;
  final $Res Function(_MyPujasState) _then;

/// Create a copy of MyPujasState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookings = null,Object? busyId = freezed,Object? actionError = freezed,}) {
  return _then(_MyPujasState(
bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as LoadState<List<PujaBooking>>,busyId: freezed == busyId ? _self.busyId : busyId // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MyPujasState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PujaBooking>, $Res> get bookings {
  
  return $LoadStateCopyWith<List<PujaBooking>, $Res>(_self.bookings, (value) {
    return _then(_self.copyWith(bookings: value));
  });
}
}

// dart format on
