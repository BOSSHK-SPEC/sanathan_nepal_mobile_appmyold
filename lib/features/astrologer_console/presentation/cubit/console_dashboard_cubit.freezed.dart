// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'console_dashboard_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsoleDashboardState {

 LoadState<DashboardStats> get stats; LoadState<Availability> get availability; LoadState<List<QueueEntry>> get queue; LoadState<List<Consultation>> get sessions;/// The request being offered right now, if any.
 IncomingRequest? get pending;/// A go-online request is in flight, so the switch shows progress instead
/// of sitting on the old value while the server decides.
 bool get togglingOnline;
/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsoleDashboardStateCopyWith<ConsoleDashboardState> get copyWith => _$ConsoleDashboardStateCopyWithImpl<ConsoleDashboardState>(this as ConsoleDashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsoleDashboardState&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.queue, queue) || other.queue == queue)&&(identical(other.sessions, sessions) || other.sessions == sessions)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.togglingOnline, togglingOnline) || other.togglingOnline == togglingOnline));
}


@override
int get hashCode => Object.hash(runtimeType,stats,availability,queue,sessions,pending,togglingOnline);

@override
String toString() {
  return 'ConsoleDashboardState(stats: $stats, availability: $availability, queue: $queue, sessions: $sessions, pending: $pending, togglingOnline: $togglingOnline)';
}


}

/// @nodoc
abstract mixin class $ConsoleDashboardStateCopyWith<$Res>  {
  factory $ConsoleDashboardStateCopyWith(ConsoleDashboardState value, $Res Function(ConsoleDashboardState) _then) = _$ConsoleDashboardStateCopyWithImpl;
@useResult
$Res call({
 LoadState<DashboardStats> stats, LoadState<Availability> availability, LoadState<List<QueueEntry>> queue, LoadState<List<Consultation>> sessions, IncomingRequest? pending, bool togglingOnline
});


$LoadStateCopyWith<DashboardStats, $Res> get stats;$LoadStateCopyWith<Availability, $Res> get availability;$LoadStateCopyWith<List<QueueEntry>, $Res> get queue;$LoadStateCopyWith<List<Consultation>, $Res> get sessions;$IncomingRequestCopyWith<$Res>? get pending;

}
/// @nodoc
class _$ConsoleDashboardStateCopyWithImpl<$Res>
    implements $ConsoleDashboardStateCopyWith<$Res> {
  _$ConsoleDashboardStateCopyWithImpl(this._self, this._then);

  final ConsoleDashboardState _self;
  final $Res Function(ConsoleDashboardState) _then;

/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stats = null,Object? availability = null,Object? queue = null,Object? sessions = null,Object? pending = freezed,Object? togglingOnline = null,}) {
  return _then(_self.copyWith(
stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as LoadState<DashboardStats>,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as LoadState<Availability>,queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as LoadState<List<QueueEntry>>,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as LoadState<List<Consultation>>,pending: freezed == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as IncomingRequest?,togglingOnline: null == togglingOnline ? _self.togglingOnline : togglingOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<DashboardStats, $Res> get stats {
  
  return $LoadStateCopyWith<DashboardStats, $Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Availability, $Res> get availability {
  
  return $LoadStateCopyWith<Availability, $Res>(_self.availability, (value) {
    return _then(_self.copyWith(availability: value));
  });
}/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<QueueEntry>, $Res> get queue {
  
  return $LoadStateCopyWith<List<QueueEntry>, $Res>(_self.queue, (value) {
    return _then(_self.copyWith(queue: value));
  });
}/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Consultation>, $Res> get sessions {
  
  return $LoadStateCopyWith<List<Consultation>, $Res>(_self.sessions, (value) {
    return _then(_self.copyWith(sessions: value));
  });
}/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IncomingRequestCopyWith<$Res>? get pending {
    if (_self.pending == null) {
    return null;
  }

  return $IncomingRequestCopyWith<$Res>(_self.pending!, (value) {
    return _then(_self.copyWith(pending: value));
  });
}
}



/// @nodoc


class _ConsoleDashboardState extends ConsoleDashboardState {
  const _ConsoleDashboardState({this.stats = const LoadState.idle(), this.availability = const LoadState.idle(), this.queue = const LoadState.idle(), this.sessions = const LoadState.idle(), this.pending, this.togglingOnline = false}): super._();
  

@override@JsonKey() final  LoadState<DashboardStats> stats;
@override@JsonKey() final  LoadState<Availability> availability;
@override@JsonKey() final  LoadState<List<QueueEntry>> queue;
@override@JsonKey() final  LoadState<List<Consultation>> sessions;
/// The request being offered right now, if any.
@override final  IncomingRequest? pending;
/// A go-online request is in flight, so the switch shows progress instead
/// of sitting on the old value while the server decides.
@override@JsonKey() final  bool togglingOnline;

/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsoleDashboardStateCopyWith<_ConsoleDashboardState> get copyWith => __$ConsoleDashboardStateCopyWithImpl<_ConsoleDashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsoleDashboardState&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.queue, queue) || other.queue == queue)&&(identical(other.sessions, sessions) || other.sessions == sessions)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.togglingOnline, togglingOnline) || other.togglingOnline == togglingOnline));
}


@override
int get hashCode => Object.hash(runtimeType,stats,availability,queue,sessions,pending,togglingOnline);

@override
String toString() {
  return 'ConsoleDashboardState(stats: $stats, availability: $availability, queue: $queue, sessions: $sessions, pending: $pending, togglingOnline: $togglingOnline)';
}


}

/// @nodoc
abstract mixin class _$ConsoleDashboardStateCopyWith<$Res> implements $ConsoleDashboardStateCopyWith<$Res> {
  factory _$ConsoleDashboardStateCopyWith(_ConsoleDashboardState value, $Res Function(_ConsoleDashboardState) _then) = __$ConsoleDashboardStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<DashboardStats> stats, LoadState<Availability> availability, LoadState<List<QueueEntry>> queue, LoadState<List<Consultation>> sessions, IncomingRequest? pending, bool togglingOnline
});


@override $LoadStateCopyWith<DashboardStats, $Res> get stats;@override $LoadStateCopyWith<Availability, $Res> get availability;@override $LoadStateCopyWith<List<QueueEntry>, $Res> get queue;@override $LoadStateCopyWith<List<Consultation>, $Res> get sessions;@override $IncomingRequestCopyWith<$Res>? get pending;

}
/// @nodoc
class __$ConsoleDashboardStateCopyWithImpl<$Res>
    implements _$ConsoleDashboardStateCopyWith<$Res> {
  __$ConsoleDashboardStateCopyWithImpl(this._self, this._then);

  final _ConsoleDashboardState _self;
  final $Res Function(_ConsoleDashboardState) _then;

/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stats = null,Object? availability = null,Object? queue = null,Object? sessions = null,Object? pending = freezed,Object? togglingOnline = null,}) {
  return _then(_ConsoleDashboardState(
stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as LoadState<DashboardStats>,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as LoadState<Availability>,queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as LoadState<List<QueueEntry>>,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as LoadState<List<Consultation>>,pending: freezed == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as IncomingRequest?,togglingOnline: null == togglingOnline ? _self.togglingOnline : togglingOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<DashboardStats, $Res> get stats {
  
  return $LoadStateCopyWith<DashboardStats, $Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Availability, $Res> get availability {
  
  return $LoadStateCopyWith<Availability, $Res>(_self.availability, (value) {
    return _then(_self.copyWith(availability: value));
  });
}/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<QueueEntry>, $Res> get queue {
  
  return $LoadStateCopyWith<List<QueueEntry>, $Res>(_self.queue, (value) {
    return _then(_self.copyWith(queue: value));
  });
}/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Consultation>, $Res> get sessions {
  
  return $LoadStateCopyWith<List<Consultation>, $Res>(_self.sessions, (value) {
    return _then(_self.copyWith(sessions: value));
  });
}/// Create a copy of ConsoleDashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IncomingRequestCopyWith<$Res>? get pending {
    if (_self.pending == null) {
    return null;
  }

  return $IncomingRequestCopyWith<$Res>(_self.pending!, (value) {
    return _then(_self.copyWith(pending: value));
  });
}
}

// dart format on
