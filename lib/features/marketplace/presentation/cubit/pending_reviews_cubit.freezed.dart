// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_reviews_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PendingReviewsState {

 LoadState<List<PendingReview>> get pending;
/// Create a copy of PendingReviewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingReviewsStateCopyWith<PendingReviewsState> get copyWith => _$PendingReviewsStateCopyWithImpl<PendingReviewsState>(this as PendingReviewsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingReviewsState&&(identical(other.pending, pending) || other.pending == pending));
}


@override
int get hashCode => Object.hash(runtimeType,pending);

@override
String toString() {
  return 'PendingReviewsState(pending: $pending)';
}


}

/// @nodoc
abstract mixin class $PendingReviewsStateCopyWith<$Res>  {
  factory $PendingReviewsStateCopyWith(PendingReviewsState value, $Res Function(PendingReviewsState) _then) = _$PendingReviewsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<PendingReview>> pending
});


$LoadStateCopyWith<List<PendingReview>, $Res> get pending;

}
/// @nodoc
class _$PendingReviewsStateCopyWithImpl<$Res>
    implements $PendingReviewsStateCopyWith<$Res> {
  _$PendingReviewsStateCopyWithImpl(this._self, this._then);

  final PendingReviewsState _self;
  final $Res Function(PendingReviewsState) _then;

/// Create a copy of PendingReviewsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pending = null,}) {
  return _then(_self.copyWith(
pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as LoadState<List<PendingReview>>,
  ));
}
/// Create a copy of PendingReviewsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PendingReview>, $Res> get pending {
  
  return $LoadStateCopyWith<List<PendingReview>, $Res>(_self.pending, (value) {
    return _then(_self.copyWith(pending: value));
  });
}
}



/// @nodoc


class _PendingReviewsState extends PendingReviewsState {
  const _PendingReviewsState({this.pending = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<List<PendingReview>> pending;

/// Create a copy of PendingReviewsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingReviewsStateCopyWith<_PendingReviewsState> get copyWith => __$PendingReviewsStateCopyWithImpl<_PendingReviewsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingReviewsState&&(identical(other.pending, pending) || other.pending == pending));
}


@override
int get hashCode => Object.hash(runtimeType,pending);

@override
String toString() {
  return 'PendingReviewsState(pending: $pending)';
}


}

/// @nodoc
abstract mixin class _$PendingReviewsStateCopyWith<$Res> implements $PendingReviewsStateCopyWith<$Res> {
  factory _$PendingReviewsStateCopyWith(_PendingReviewsState value, $Res Function(_PendingReviewsState) _then) = __$PendingReviewsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<PendingReview>> pending
});


@override $LoadStateCopyWith<List<PendingReview>, $Res> get pending;

}
/// @nodoc
class __$PendingReviewsStateCopyWithImpl<$Res>
    implements _$PendingReviewsStateCopyWith<$Res> {
  __$PendingReviewsStateCopyWithImpl(this._self, this._then);

  final _PendingReviewsState _self;
  final $Res Function(_PendingReviewsState) _then;

/// Create a copy of PendingReviewsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pending = null,}) {
  return _then(_PendingReviewsState(
pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as LoadState<List<PendingReview>>,
  ));
}

/// Create a copy of PendingReviewsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PendingReview>, $Res> get pending {
  
  return $LoadStateCopyWith<List<PendingReview>, $Res>(_self.pending, (value) {
    return _then(_self.copyWith(pending: value));
  });
}
}

// dart format on
