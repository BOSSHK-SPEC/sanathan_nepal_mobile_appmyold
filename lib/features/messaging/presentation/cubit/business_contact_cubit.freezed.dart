// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_contact_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BusinessContactState {

 LoadState<MessageThread> get sending;
/// Create a copy of BusinessContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessContactStateCopyWith<BusinessContactState> get copyWith => _$BusinessContactStateCopyWithImpl<BusinessContactState>(this as BusinessContactState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessContactState&&(identical(other.sending, sending) || other.sending == sending));
}


@override
int get hashCode => Object.hash(runtimeType,sending);

@override
String toString() {
  return 'BusinessContactState(sending: $sending)';
}


}

/// @nodoc
abstract mixin class $BusinessContactStateCopyWith<$Res>  {
  factory $BusinessContactStateCopyWith(BusinessContactState value, $Res Function(BusinessContactState) _then) = _$BusinessContactStateCopyWithImpl;
@useResult
$Res call({
 LoadState<MessageThread> sending
});


$LoadStateCopyWith<MessageThread, $Res> get sending;

}
/// @nodoc
class _$BusinessContactStateCopyWithImpl<$Res>
    implements $BusinessContactStateCopyWith<$Res> {
  _$BusinessContactStateCopyWithImpl(this._self, this._then);

  final BusinessContactState _self;
  final $Res Function(BusinessContactState) _then;

/// Create a copy of BusinessContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sending = null,}) {
  return _then(_self.copyWith(
sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as LoadState<MessageThread>,
  ));
}
/// Create a copy of BusinessContactState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<MessageThread, $Res> get sending {
  
  return $LoadStateCopyWith<MessageThread, $Res>(_self.sending, (value) {
    return _then(_self.copyWith(sending: value));
  });
}
}



/// @nodoc


class _BusinessContactState extends BusinessContactState {
  const _BusinessContactState({this.sending = const LoadState<MessageThread>.idle()}): super._();
  

@override@JsonKey() final  LoadState<MessageThread> sending;

/// Create a copy of BusinessContactState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessContactStateCopyWith<_BusinessContactState> get copyWith => __$BusinessContactStateCopyWithImpl<_BusinessContactState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessContactState&&(identical(other.sending, sending) || other.sending == sending));
}


@override
int get hashCode => Object.hash(runtimeType,sending);

@override
String toString() {
  return 'BusinessContactState(sending: $sending)';
}


}

/// @nodoc
abstract mixin class _$BusinessContactStateCopyWith<$Res> implements $BusinessContactStateCopyWith<$Res> {
  factory _$BusinessContactStateCopyWith(_BusinessContactState value, $Res Function(_BusinessContactState) _then) = __$BusinessContactStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<MessageThread> sending
});


@override $LoadStateCopyWith<MessageThread, $Res> get sending;

}
/// @nodoc
class __$BusinessContactStateCopyWithImpl<$Res>
    implements _$BusinessContactStateCopyWith<$Res> {
  __$BusinessContactStateCopyWithImpl(this._self, this._then);

  final _BusinessContactState _self;
  final $Res Function(_BusinessContactState) _then;

/// Create a copy of BusinessContactState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sending = null,}) {
  return _then(_BusinessContactState(
sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as LoadState<MessageThread>,
  ));
}

/// Create a copy of BusinessContactState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<MessageThread, $Res> get sending {
  
  return $LoadStateCopyWith<MessageThread, $Res>(_self.sending, (value) {
    return _then(_self.copyWith(sending: value));
  });
}
}

// dart format on
