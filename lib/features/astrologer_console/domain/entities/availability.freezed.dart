// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'availability.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AvailabilityWindow {

/// 1 = Monday … 7 = Sunday, matching `DateTime.weekday`.
 int get weekday;/// Minutes from midnight, local time.
 int get startMinute; int get endMinute;/// Channels offered in this window; empty means all of them.
 Set<ConsultChannel> get channels;
/// Create a copy of AvailabilityWindow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityWindowCopyWith<AvailabilityWindow> get copyWith => _$AvailabilityWindowCopyWithImpl<AvailabilityWindow>(this as AvailabilityWindow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilityWindow&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.endMinute, endMinute) || other.endMinute == endMinute)&&const DeepCollectionEquality().equals(other.channels, channels));
}


@override
int get hashCode => Object.hash(runtimeType,weekday,startMinute,endMinute,const DeepCollectionEquality().hash(channels));

@override
String toString() {
  return 'AvailabilityWindow(weekday: $weekday, startMinute: $startMinute, endMinute: $endMinute, channels: $channels)';
}


}

/// @nodoc
abstract mixin class $AvailabilityWindowCopyWith<$Res>  {
  factory $AvailabilityWindowCopyWith(AvailabilityWindow value, $Res Function(AvailabilityWindow) _then) = _$AvailabilityWindowCopyWithImpl;
@useResult
$Res call({
 int weekday, int startMinute, int endMinute, Set<ConsultChannel> channels
});




}
/// @nodoc
class _$AvailabilityWindowCopyWithImpl<$Res>
    implements $AvailabilityWindowCopyWith<$Res> {
  _$AvailabilityWindowCopyWithImpl(this._self, this._then);

  final AvailabilityWindow _self;
  final $Res Function(AvailabilityWindow) _then;

/// Create a copy of AvailabilityWindow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekday = null,Object? startMinute = null,Object? endMinute = null,Object? channels = null,}) {
  return _then(_self.copyWith(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,channels: null == channels ? _self.channels : channels // ignore: cast_nullable_to_non_nullable
as Set<ConsultChannel>,
  ));
}

}



/// @nodoc


class _AvailabilityWindow extends AvailabilityWindow {
  const _AvailabilityWindow({required this.weekday, required this.startMinute, required this.endMinute, final  Set<ConsultChannel> channels = const <ConsultChannel>{}}): _channels = channels,super._();
  

/// 1 = Monday … 7 = Sunday, matching `DateTime.weekday`.
@override final  int weekday;
/// Minutes from midnight, local time.
@override final  int startMinute;
@override final  int endMinute;
/// Channels offered in this window; empty means all of them.
 final  Set<ConsultChannel> _channels;
/// Channels offered in this window; empty means all of them.
@override@JsonKey() Set<ConsultChannel> get channels {
  if (_channels is EqualUnmodifiableSetView) return _channels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_channels);
}


/// Create a copy of AvailabilityWindow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilityWindowCopyWith<_AvailabilityWindow> get copyWith => __$AvailabilityWindowCopyWithImpl<_AvailabilityWindow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilityWindow&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.endMinute, endMinute) || other.endMinute == endMinute)&&const DeepCollectionEquality().equals(other._channels, _channels));
}


@override
int get hashCode => Object.hash(runtimeType,weekday,startMinute,endMinute,const DeepCollectionEquality().hash(_channels));

@override
String toString() {
  return 'AvailabilityWindow(weekday: $weekday, startMinute: $startMinute, endMinute: $endMinute, channels: $channels)';
}


}

/// @nodoc
abstract mixin class _$AvailabilityWindowCopyWith<$Res> implements $AvailabilityWindowCopyWith<$Res> {
  factory _$AvailabilityWindowCopyWith(_AvailabilityWindow value, $Res Function(_AvailabilityWindow) _then) = __$AvailabilityWindowCopyWithImpl;
@override @useResult
$Res call({
 int weekday, int startMinute, int endMinute, Set<ConsultChannel> channels
});




}
/// @nodoc
class __$AvailabilityWindowCopyWithImpl<$Res>
    implements _$AvailabilityWindowCopyWith<$Res> {
  __$AvailabilityWindowCopyWithImpl(this._self, this._then);

  final _AvailabilityWindow _self;
  final $Res Function(_AvailabilityWindow) _then;

/// Create a copy of AvailabilityWindow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekday = null,Object? startMinute = null,Object? endMinute = null,Object? channels = null,}) {
  return _then(_AvailabilityWindow(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,channels: null == channels ? _self._channels : channels // ignore: cast_nullable_to_non_nullable
as Set<ConsultChannel>,
  ));
}


}

/// @nodoc
mixin _$BlackoutDate {

 DateTime get date; String get reason;
/// Create a copy of BlackoutDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlackoutDateCopyWith<BlackoutDate> get copyWith => _$BlackoutDateCopyWithImpl<BlackoutDate>(this as BlackoutDate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlackoutDate&&(identical(other.date, date) || other.date == date)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,date,reason);

@override
String toString() {
  return 'BlackoutDate(date: $date, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $BlackoutDateCopyWith<$Res>  {
  factory $BlackoutDateCopyWith(BlackoutDate value, $Res Function(BlackoutDate) _then) = _$BlackoutDateCopyWithImpl;
@useResult
$Res call({
 DateTime date, String reason
});




}
/// @nodoc
class _$BlackoutDateCopyWithImpl<$Res>
    implements $BlackoutDateCopyWith<$Res> {
  _$BlackoutDateCopyWithImpl(this._self, this._then);

  final BlackoutDate _self;
  final $Res Function(BlackoutDate) _then;

/// Create a copy of BlackoutDate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? reason = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _BlackoutDate implements BlackoutDate {
  const _BlackoutDate({required this.date, this.reason = ''});
  

@override final  DateTime date;
@override@JsonKey() final  String reason;

/// Create a copy of BlackoutDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlackoutDateCopyWith<_BlackoutDate> get copyWith => __$BlackoutDateCopyWithImpl<_BlackoutDate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlackoutDate&&(identical(other.date, date) || other.date == date)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,date,reason);

@override
String toString() {
  return 'BlackoutDate(date: $date, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$BlackoutDateCopyWith<$Res> implements $BlackoutDateCopyWith<$Res> {
  factory _$BlackoutDateCopyWith(_BlackoutDate value, $Res Function(_BlackoutDate) _then) = __$BlackoutDateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, String reason
});




}
/// @nodoc
class __$BlackoutDateCopyWithImpl<$Res>
    implements _$BlackoutDateCopyWith<$Res> {
  __$BlackoutDateCopyWithImpl(this._self, this._then);

  final _BlackoutDate _self;
  final $Res Function(_BlackoutDate) _then;

/// Create a copy of BlackoutDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? reason = null,}) {
  return _then(_BlackoutDate(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$Availability {

 List<AvailabilityWindow> get windows; List<BlackoutDate> get blackouts;/// Manual online switch. Being scheduled and being online are different:
/// a scheduled astrologer who has not gone online is not taking calls.
 bool get isOnline;/// Minutes of breathing room booked between sessions.
 int get bufferMinutes;
/// Create a copy of Availability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityCopyWith<Availability> get copyWith => _$AvailabilityCopyWithImpl<Availability>(this as Availability, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Availability&&const DeepCollectionEquality().equals(other.windows, windows)&&const DeepCollectionEquality().equals(other.blackouts, blackouts)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.bufferMinutes, bufferMinutes) || other.bufferMinutes == bufferMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(windows),const DeepCollectionEquality().hash(blackouts),isOnline,bufferMinutes);

@override
String toString() {
  return 'Availability(windows: $windows, blackouts: $blackouts, isOnline: $isOnline, bufferMinutes: $bufferMinutes)';
}


}

/// @nodoc
abstract mixin class $AvailabilityCopyWith<$Res>  {
  factory $AvailabilityCopyWith(Availability value, $Res Function(Availability) _then) = _$AvailabilityCopyWithImpl;
@useResult
$Res call({
 List<AvailabilityWindow> windows, List<BlackoutDate> blackouts, bool isOnline, int bufferMinutes
});




}
/// @nodoc
class _$AvailabilityCopyWithImpl<$Res>
    implements $AvailabilityCopyWith<$Res> {
  _$AvailabilityCopyWithImpl(this._self, this._then);

  final Availability _self;
  final $Res Function(Availability) _then;

/// Create a copy of Availability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? windows = null,Object? blackouts = null,Object? isOnline = null,Object? bufferMinutes = null,}) {
  return _then(_self.copyWith(
windows: null == windows ? _self.windows : windows // ignore: cast_nullable_to_non_nullable
as List<AvailabilityWindow>,blackouts: null == blackouts ? _self.blackouts : blackouts // ignore: cast_nullable_to_non_nullable
as List<BlackoutDate>,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,bufferMinutes: null == bufferMinutes ? _self.bufferMinutes : bufferMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _Availability extends Availability {
  const _Availability({final  List<AvailabilityWindow> windows = const <AvailabilityWindow>[], final  List<BlackoutDate> blackouts = const <BlackoutDate>[], this.isOnline = false, this.bufferMinutes = 5}): _windows = windows,_blackouts = blackouts,super._();
  

 final  List<AvailabilityWindow> _windows;
@override@JsonKey() List<AvailabilityWindow> get windows {
  if (_windows is EqualUnmodifiableListView) return _windows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_windows);
}

 final  List<BlackoutDate> _blackouts;
@override@JsonKey() List<BlackoutDate> get blackouts {
  if (_blackouts is EqualUnmodifiableListView) return _blackouts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blackouts);
}

/// Manual online switch. Being scheduled and being online are different:
/// a scheduled astrologer who has not gone online is not taking calls.
@override@JsonKey() final  bool isOnline;
/// Minutes of breathing room booked between sessions.
@override@JsonKey() final  int bufferMinutes;

/// Create a copy of Availability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilityCopyWith<_Availability> get copyWith => __$AvailabilityCopyWithImpl<_Availability>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Availability&&const DeepCollectionEquality().equals(other._windows, _windows)&&const DeepCollectionEquality().equals(other._blackouts, _blackouts)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.bufferMinutes, bufferMinutes) || other.bufferMinutes == bufferMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_windows),const DeepCollectionEquality().hash(_blackouts),isOnline,bufferMinutes);

@override
String toString() {
  return 'Availability(windows: $windows, blackouts: $blackouts, isOnline: $isOnline, bufferMinutes: $bufferMinutes)';
}


}

/// @nodoc
abstract mixin class _$AvailabilityCopyWith<$Res> implements $AvailabilityCopyWith<$Res> {
  factory _$AvailabilityCopyWith(_Availability value, $Res Function(_Availability) _then) = __$AvailabilityCopyWithImpl;
@override @useResult
$Res call({
 List<AvailabilityWindow> windows, List<BlackoutDate> blackouts, bool isOnline, int bufferMinutes
});




}
/// @nodoc
class __$AvailabilityCopyWithImpl<$Res>
    implements _$AvailabilityCopyWith<$Res> {
  __$AvailabilityCopyWithImpl(this._self, this._then);

  final _Availability _self;
  final $Res Function(_Availability) _then;

/// Create a copy of Availability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? windows = null,Object? blackouts = null,Object? isOnline = null,Object? bufferMinutes = null,}) {
  return _then(_Availability(
windows: null == windows ? _self._windows : windows // ignore: cast_nullable_to_non_nullable
as List<AvailabilityWindow>,blackouts: null == blackouts ? _self._blackouts : blackouts // ignore: cast_nullable_to_non_nullable
as List<BlackoutDate>,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,bufferMinutes: null == bufferMinutes ? _self.bufferMinutes : bufferMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
