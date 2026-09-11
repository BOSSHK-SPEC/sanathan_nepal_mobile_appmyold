// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_threads_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessageThreadsState {

 LoadState<List<MessageThread>> get threads; bool get showArchived;
/// Create a copy of MessageThreadsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageThreadsStateCopyWith<MessageThreadsState> get copyWith => _$MessageThreadsStateCopyWithImpl<MessageThreadsState>(this as MessageThreadsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageThreadsState&&(identical(other.threads, threads) || other.threads == threads)&&(identical(other.showArchived, showArchived) || other.showArchived == showArchived));
}


@override
int get hashCode => Object.hash(runtimeType,threads,showArchived);

@override
String toString() {
  return 'MessageThreadsState(threads: $threads, showArchived: $showArchived)';
}


}

/// @nodoc
abstract mixin class $MessageThreadsStateCopyWith<$Res>  {
  factory $MessageThreadsStateCopyWith(MessageThreadsState value, $Res Function(MessageThreadsState) _then) = _$MessageThreadsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<MessageThread>> threads, bool showArchived
});


$LoadStateCopyWith<List<MessageThread>, $Res> get threads;

}
/// @nodoc
class _$MessageThreadsStateCopyWithImpl<$Res>
    implements $MessageThreadsStateCopyWith<$Res> {
  _$MessageThreadsStateCopyWithImpl(this._self, this._then);

  final MessageThreadsState _self;
  final $Res Function(MessageThreadsState) _then;

/// Create a copy of MessageThreadsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? threads = null,Object? showArchived = null,}) {
  return _then(_self.copyWith(
threads: null == threads ? _self.threads : threads // ignore: cast_nullable_to_non_nullable
as LoadState<List<MessageThread>>,showArchived: null == showArchived ? _self.showArchived : showArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of MessageThreadsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<MessageThread>, $Res> get threads {
  
  return $LoadStateCopyWith<List<MessageThread>, $Res>(_self.threads, (value) {
    return _then(_self.copyWith(threads: value));
  });
}
}



/// @nodoc


class _MessageThreadsState extends MessageThreadsState {
  const _MessageThreadsState({this.threads = const LoadState<List<MessageThread>>.idle(), this.showArchived = false}): super._();
  

@override@JsonKey() final  LoadState<List<MessageThread>> threads;
@override@JsonKey() final  bool showArchived;

/// Create a copy of MessageThreadsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageThreadsStateCopyWith<_MessageThreadsState> get copyWith => __$MessageThreadsStateCopyWithImpl<_MessageThreadsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageThreadsState&&(identical(other.threads, threads) || other.threads == threads)&&(identical(other.showArchived, showArchived) || other.showArchived == showArchived));
}


@override
int get hashCode => Object.hash(runtimeType,threads,showArchived);

@override
String toString() {
  return 'MessageThreadsState(threads: $threads, showArchived: $showArchived)';
}


}

/// @nodoc
abstract mixin class _$MessageThreadsStateCopyWith<$Res> implements $MessageThreadsStateCopyWith<$Res> {
  factory _$MessageThreadsStateCopyWith(_MessageThreadsState value, $Res Function(_MessageThreadsState) _then) = __$MessageThreadsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<MessageThread>> threads, bool showArchived
});


@override $LoadStateCopyWith<List<MessageThread>, $Res> get threads;

}
/// @nodoc
class __$MessageThreadsStateCopyWithImpl<$Res>
    implements _$MessageThreadsStateCopyWith<$Res> {
  __$MessageThreadsStateCopyWithImpl(this._self, this._then);

  final _MessageThreadsState _self;
  final $Res Function(_MessageThreadsState) _then;

/// Create a copy of MessageThreadsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? threads = null,Object? showArchived = null,}) {
  return _then(_MessageThreadsState(
threads: null == threads ? _self.threads : threads // ignore: cast_nullable_to_non_nullable
as LoadState<List<MessageThread>>,showArchived: null == showArchived ? _self.showArchived : showArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of MessageThreadsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<MessageThread>, $Res> get threads {
  
  return $LoadStateCopyWith<List<MessageThread>, $Res>(_self.threads, (value) {
    return _then(_self.copyWith(threads: value));
  });
}
}

// dart format on
