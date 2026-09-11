// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'load_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoadState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoadState<$T>()';
}


}

/// @nodoc
class $LoadStateCopyWith<T,$Res>  {
$LoadStateCopyWith(LoadState<T> _, $Res Function(LoadState<T>) __);
}



/// @nodoc


class Idle<T> extends LoadState<T> {
  const Idle(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Idle<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoadState<$T>.idle()';
}


}




/// @nodoc


class Loading<T> extends LoadState<T> {
  const Loading({this.previous}): super._();
  

 final  T? previous;

/// Create a copy of LoadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadingCopyWith<T, Loading<T>> get copyWith => _$LoadingCopyWithImpl<T, Loading<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading<T>&&const DeepCollectionEquality().equals(other.previous, previous));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(previous));

@override
String toString() {
  return 'LoadState<$T>.loading(previous: $previous)';
}


}

/// @nodoc
abstract mixin class $LoadingCopyWith<T,$Res> implements $LoadStateCopyWith<T, $Res> {
  factory $LoadingCopyWith(Loading<T> value, $Res Function(Loading<T>) _then) = _$LoadingCopyWithImpl;
@useResult
$Res call({
 T? previous
});




}
/// @nodoc
class _$LoadingCopyWithImpl<T,$Res>
    implements $LoadingCopyWith<T, $Res> {
  _$LoadingCopyWithImpl(this._self, this._then);

  final Loading<T> _self;
  final $Res Function(Loading<T>) _then;

/// Create a copy of LoadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? previous = freezed,}) {
  return _then(Loading<T>(
previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}


}

/// @nodoc


class Loaded<T> extends LoadState<T> {
  const Loaded(this.data): super._();
  

 final  T data;

/// Create a copy of LoadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<T, Loaded<T>> get copyWith => _$LoadedCopyWithImpl<T, Loaded<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'LoadState<$T>.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<T,$Res> implements $LoadStateCopyWith<T, $Res> {
  factory $LoadedCopyWith(Loaded<T> value, $Res Function(Loaded<T>) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$LoadedCopyWithImpl<T,$Res>
    implements $LoadedCopyWith<T, $Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded<T> _self;
  final $Res Function(Loaded<T>) _then;

/// Create a copy of LoadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(Loaded<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class Failed<T> extends LoadState<T> {
  const Failed(this.failure, {this.previous}): super._();
  

 final  Failure failure;
 final  T? previous;

/// Create a copy of LoadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailedCopyWith<T, Failed<T>> get copyWith => _$FailedCopyWithImpl<T, Failed<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failed<T>&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.previous, previous));
}


@override
int get hashCode => Object.hash(runtimeType,failure,const DeepCollectionEquality().hash(previous));

@override
String toString() {
  return 'LoadState<$T>.failed(failure: $failure, previous: $previous)';
}


}

/// @nodoc
abstract mixin class $FailedCopyWith<T,$Res> implements $LoadStateCopyWith<T, $Res> {
  factory $FailedCopyWith(Failed<T> value, $Res Function(Failed<T>) _then) = _$FailedCopyWithImpl;
@useResult
$Res call({
 Failure failure, T? previous
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$FailedCopyWithImpl<T,$Res>
    implements $FailedCopyWith<T, $Res> {
  _$FailedCopyWithImpl(this._self, this._then);

  final Failed<T> _self;
  final $Res Function(Failed<T>) _then;

/// Create a copy of LoadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? previous = freezed,}) {
  return _then(Failed<T>(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}

/// Create a copy of LoadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
