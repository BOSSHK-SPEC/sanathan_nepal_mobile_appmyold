// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkPreferences {

// --- Alerts ---------------------------------------------------------
 bool get newRequestAlerts; bool get alertSound;/// Keeps ringing until answered or expired. Off means one alert.
 bool get ringUntilAnswered; bool get scheduleReminders; bool get payoutAlerts; bool get reviewAlerts; bool get marketingAlerts;// --- Quiet hours ----------------------------------------------------
 bool get quietHoursEnabled;/// Minutes from midnight. A window may wrap past midnight (22:00 → 07:00),
/// which is the normal case for sleep, so start > end is valid.
 int get quietStartMinute; int get quietEndMinute;// --- Which requests to offer ----------------------------------------
 Set<ConsultChannel> get acceptedChannels;/// Requests beyond this many people already waiting are not offered.
/// 0 means no cap.
 int get maxQueueLength;/// Seconds an offer stays on screen before it is auto-declined. Short
/// enough that a seeker is not left waiting, long enough to answer.
 int get autoDeclineAfterSeconds;/// Auto-accepts requests from clients already consulted. Repeat clients
/// are the profitable ones and the astrologer already knows the case.
 bool get autoAcceptRepeatClients;
/// Create a copy of WorkPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkPreferencesCopyWith<WorkPreferences> get copyWith => _$WorkPreferencesCopyWithImpl<WorkPreferences>(this as WorkPreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkPreferences&&(identical(other.newRequestAlerts, newRequestAlerts) || other.newRequestAlerts == newRequestAlerts)&&(identical(other.alertSound, alertSound) || other.alertSound == alertSound)&&(identical(other.ringUntilAnswered, ringUntilAnswered) || other.ringUntilAnswered == ringUntilAnswered)&&(identical(other.scheduleReminders, scheduleReminders) || other.scheduleReminders == scheduleReminders)&&(identical(other.payoutAlerts, payoutAlerts) || other.payoutAlerts == payoutAlerts)&&(identical(other.reviewAlerts, reviewAlerts) || other.reviewAlerts == reviewAlerts)&&(identical(other.marketingAlerts, marketingAlerts) || other.marketingAlerts == marketingAlerts)&&(identical(other.quietHoursEnabled, quietHoursEnabled) || other.quietHoursEnabled == quietHoursEnabled)&&(identical(other.quietStartMinute, quietStartMinute) || other.quietStartMinute == quietStartMinute)&&(identical(other.quietEndMinute, quietEndMinute) || other.quietEndMinute == quietEndMinute)&&const DeepCollectionEquality().equals(other.acceptedChannels, acceptedChannels)&&(identical(other.maxQueueLength, maxQueueLength) || other.maxQueueLength == maxQueueLength)&&(identical(other.autoDeclineAfterSeconds, autoDeclineAfterSeconds) || other.autoDeclineAfterSeconds == autoDeclineAfterSeconds)&&(identical(other.autoAcceptRepeatClients, autoAcceptRepeatClients) || other.autoAcceptRepeatClients == autoAcceptRepeatClients));
}


@override
int get hashCode => Object.hash(runtimeType,newRequestAlerts,alertSound,ringUntilAnswered,scheduleReminders,payoutAlerts,reviewAlerts,marketingAlerts,quietHoursEnabled,quietStartMinute,quietEndMinute,const DeepCollectionEquality().hash(acceptedChannels),maxQueueLength,autoDeclineAfterSeconds,autoAcceptRepeatClients);

@override
String toString() {
  return 'WorkPreferences(newRequestAlerts: $newRequestAlerts, alertSound: $alertSound, ringUntilAnswered: $ringUntilAnswered, scheduleReminders: $scheduleReminders, payoutAlerts: $payoutAlerts, reviewAlerts: $reviewAlerts, marketingAlerts: $marketingAlerts, quietHoursEnabled: $quietHoursEnabled, quietStartMinute: $quietStartMinute, quietEndMinute: $quietEndMinute, acceptedChannels: $acceptedChannels, maxQueueLength: $maxQueueLength, autoDeclineAfterSeconds: $autoDeclineAfterSeconds, autoAcceptRepeatClients: $autoAcceptRepeatClients)';
}


}

/// @nodoc
abstract mixin class $WorkPreferencesCopyWith<$Res>  {
  factory $WorkPreferencesCopyWith(WorkPreferences value, $Res Function(WorkPreferences) _then) = _$WorkPreferencesCopyWithImpl;
@useResult
$Res call({
 bool newRequestAlerts, bool alertSound, bool ringUntilAnswered, bool scheduleReminders, bool payoutAlerts, bool reviewAlerts, bool marketingAlerts, bool quietHoursEnabled, int quietStartMinute, int quietEndMinute, Set<ConsultChannel> acceptedChannels, int maxQueueLength, int autoDeclineAfterSeconds, bool autoAcceptRepeatClients
});




}
/// @nodoc
class _$WorkPreferencesCopyWithImpl<$Res>
    implements $WorkPreferencesCopyWith<$Res> {
  _$WorkPreferencesCopyWithImpl(this._self, this._then);

  final WorkPreferences _self;
  final $Res Function(WorkPreferences) _then;

/// Create a copy of WorkPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? newRequestAlerts = null,Object? alertSound = null,Object? ringUntilAnswered = null,Object? scheduleReminders = null,Object? payoutAlerts = null,Object? reviewAlerts = null,Object? marketingAlerts = null,Object? quietHoursEnabled = null,Object? quietStartMinute = null,Object? quietEndMinute = null,Object? acceptedChannels = null,Object? maxQueueLength = null,Object? autoDeclineAfterSeconds = null,Object? autoAcceptRepeatClients = null,}) {
  return _then(_self.copyWith(
newRequestAlerts: null == newRequestAlerts ? _self.newRequestAlerts : newRequestAlerts // ignore: cast_nullable_to_non_nullable
as bool,alertSound: null == alertSound ? _self.alertSound : alertSound // ignore: cast_nullable_to_non_nullable
as bool,ringUntilAnswered: null == ringUntilAnswered ? _self.ringUntilAnswered : ringUntilAnswered // ignore: cast_nullable_to_non_nullable
as bool,scheduleReminders: null == scheduleReminders ? _self.scheduleReminders : scheduleReminders // ignore: cast_nullable_to_non_nullable
as bool,payoutAlerts: null == payoutAlerts ? _self.payoutAlerts : payoutAlerts // ignore: cast_nullable_to_non_nullable
as bool,reviewAlerts: null == reviewAlerts ? _self.reviewAlerts : reviewAlerts // ignore: cast_nullable_to_non_nullable
as bool,marketingAlerts: null == marketingAlerts ? _self.marketingAlerts : marketingAlerts // ignore: cast_nullable_to_non_nullable
as bool,quietHoursEnabled: null == quietHoursEnabled ? _self.quietHoursEnabled : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
as bool,quietStartMinute: null == quietStartMinute ? _self.quietStartMinute : quietStartMinute // ignore: cast_nullable_to_non_nullable
as int,quietEndMinute: null == quietEndMinute ? _self.quietEndMinute : quietEndMinute // ignore: cast_nullable_to_non_nullable
as int,acceptedChannels: null == acceptedChannels ? _self.acceptedChannels : acceptedChannels // ignore: cast_nullable_to_non_nullable
as Set<ConsultChannel>,maxQueueLength: null == maxQueueLength ? _self.maxQueueLength : maxQueueLength // ignore: cast_nullable_to_non_nullable
as int,autoDeclineAfterSeconds: null == autoDeclineAfterSeconds ? _self.autoDeclineAfterSeconds : autoDeclineAfterSeconds // ignore: cast_nullable_to_non_nullable
as int,autoAcceptRepeatClients: null == autoAcceptRepeatClients ? _self.autoAcceptRepeatClients : autoAcceptRepeatClients // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _WorkPreferences extends WorkPreferences {
  const _WorkPreferences({this.newRequestAlerts = true, this.alertSound = true, this.ringUntilAnswered = true, this.scheduleReminders = true, this.payoutAlerts = true, this.reviewAlerts = true, this.marketingAlerts = false, this.quietHoursEnabled = false, this.quietStartMinute = 22 * 60, this.quietEndMinute = 7 * 60, final  Set<ConsultChannel> acceptedChannels = const <ConsultChannel>{}, this.maxQueueLength = 0, this.autoDeclineAfterSeconds = 30, this.autoAcceptRepeatClients = false}): _acceptedChannels = acceptedChannels,super._();
  

// --- Alerts ---------------------------------------------------------
@override@JsonKey() final  bool newRequestAlerts;
@override@JsonKey() final  bool alertSound;
/// Keeps ringing until answered or expired. Off means one alert.
@override@JsonKey() final  bool ringUntilAnswered;
@override@JsonKey() final  bool scheduleReminders;
@override@JsonKey() final  bool payoutAlerts;
@override@JsonKey() final  bool reviewAlerts;
@override@JsonKey() final  bool marketingAlerts;
// --- Quiet hours ----------------------------------------------------
@override@JsonKey() final  bool quietHoursEnabled;
/// Minutes from midnight. A window may wrap past midnight (22:00 → 07:00),
/// which is the normal case for sleep, so start > end is valid.
@override@JsonKey() final  int quietStartMinute;
@override@JsonKey() final  int quietEndMinute;
// --- Which requests to offer ----------------------------------------
 final  Set<ConsultChannel> _acceptedChannels;
// --- Which requests to offer ----------------------------------------
@override@JsonKey() Set<ConsultChannel> get acceptedChannels {
  if (_acceptedChannels is EqualUnmodifiableSetView) return _acceptedChannels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_acceptedChannels);
}

/// Requests beyond this many people already waiting are not offered.
/// 0 means no cap.
@override@JsonKey() final  int maxQueueLength;
/// Seconds an offer stays on screen before it is auto-declined. Short
/// enough that a seeker is not left waiting, long enough to answer.
@override@JsonKey() final  int autoDeclineAfterSeconds;
/// Auto-accepts requests from clients already consulted. Repeat clients
/// are the profitable ones and the astrologer already knows the case.
@override@JsonKey() final  bool autoAcceptRepeatClients;

/// Create a copy of WorkPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkPreferencesCopyWith<_WorkPreferences> get copyWith => __$WorkPreferencesCopyWithImpl<_WorkPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkPreferences&&(identical(other.newRequestAlerts, newRequestAlerts) || other.newRequestAlerts == newRequestAlerts)&&(identical(other.alertSound, alertSound) || other.alertSound == alertSound)&&(identical(other.ringUntilAnswered, ringUntilAnswered) || other.ringUntilAnswered == ringUntilAnswered)&&(identical(other.scheduleReminders, scheduleReminders) || other.scheduleReminders == scheduleReminders)&&(identical(other.payoutAlerts, payoutAlerts) || other.payoutAlerts == payoutAlerts)&&(identical(other.reviewAlerts, reviewAlerts) || other.reviewAlerts == reviewAlerts)&&(identical(other.marketingAlerts, marketingAlerts) || other.marketingAlerts == marketingAlerts)&&(identical(other.quietHoursEnabled, quietHoursEnabled) || other.quietHoursEnabled == quietHoursEnabled)&&(identical(other.quietStartMinute, quietStartMinute) || other.quietStartMinute == quietStartMinute)&&(identical(other.quietEndMinute, quietEndMinute) || other.quietEndMinute == quietEndMinute)&&const DeepCollectionEquality().equals(other._acceptedChannels, _acceptedChannels)&&(identical(other.maxQueueLength, maxQueueLength) || other.maxQueueLength == maxQueueLength)&&(identical(other.autoDeclineAfterSeconds, autoDeclineAfterSeconds) || other.autoDeclineAfterSeconds == autoDeclineAfterSeconds)&&(identical(other.autoAcceptRepeatClients, autoAcceptRepeatClients) || other.autoAcceptRepeatClients == autoAcceptRepeatClients));
}


@override
int get hashCode => Object.hash(runtimeType,newRequestAlerts,alertSound,ringUntilAnswered,scheduleReminders,payoutAlerts,reviewAlerts,marketingAlerts,quietHoursEnabled,quietStartMinute,quietEndMinute,const DeepCollectionEquality().hash(_acceptedChannels),maxQueueLength,autoDeclineAfterSeconds,autoAcceptRepeatClients);

@override
String toString() {
  return 'WorkPreferences(newRequestAlerts: $newRequestAlerts, alertSound: $alertSound, ringUntilAnswered: $ringUntilAnswered, scheduleReminders: $scheduleReminders, payoutAlerts: $payoutAlerts, reviewAlerts: $reviewAlerts, marketingAlerts: $marketingAlerts, quietHoursEnabled: $quietHoursEnabled, quietStartMinute: $quietStartMinute, quietEndMinute: $quietEndMinute, acceptedChannels: $acceptedChannels, maxQueueLength: $maxQueueLength, autoDeclineAfterSeconds: $autoDeclineAfterSeconds, autoAcceptRepeatClients: $autoAcceptRepeatClients)';
}


}

/// @nodoc
abstract mixin class _$WorkPreferencesCopyWith<$Res> implements $WorkPreferencesCopyWith<$Res> {
  factory _$WorkPreferencesCopyWith(_WorkPreferences value, $Res Function(_WorkPreferences) _then) = __$WorkPreferencesCopyWithImpl;
@override @useResult
$Res call({
 bool newRequestAlerts, bool alertSound, bool ringUntilAnswered, bool scheduleReminders, bool payoutAlerts, bool reviewAlerts, bool marketingAlerts, bool quietHoursEnabled, int quietStartMinute, int quietEndMinute, Set<ConsultChannel> acceptedChannels, int maxQueueLength, int autoDeclineAfterSeconds, bool autoAcceptRepeatClients
});




}
/// @nodoc
class __$WorkPreferencesCopyWithImpl<$Res>
    implements _$WorkPreferencesCopyWith<$Res> {
  __$WorkPreferencesCopyWithImpl(this._self, this._then);

  final _WorkPreferences _self;
  final $Res Function(_WorkPreferences) _then;

/// Create a copy of WorkPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? newRequestAlerts = null,Object? alertSound = null,Object? ringUntilAnswered = null,Object? scheduleReminders = null,Object? payoutAlerts = null,Object? reviewAlerts = null,Object? marketingAlerts = null,Object? quietHoursEnabled = null,Object? quietStartMinute = null,Object? quietEndMinute = null,Object? acceptedChannels = null,Object? maxQueueLength = null,Object? autoDeclineAfterSeconds = null,Object? autoAcceptRepeatClients = null,}) {
  return _then(_WorkPreferences(
newRequestAlerts: null == newRequestAlerts ? _self.newRequestAlerts : newRequestAlerts // ignore: cast_nullable_to_non_nullable
as bool,alertSound: null == alertSound ? _self.alertSound : alertSound // ignore: cast_nullable_to_non_nullable
as bool,ringUntilAnswered: null == ringUntilAnswered ? _self.ringUntilAnswered : ringUntilAnswered // ignore: cast_nullable_to_non_nullable
as bool,scheduleReminders: null == scheduleReminders ? _self.scheduleReminders : scheduleReminders // ignore: cast_nullable_to_non_nullable
as bool,payoutAlerts: null == payoutAlerts ? _self.payoutAlerts : payoutAlerts // ignore: cast_nullable_to_non_nullable
as bool,reviewAlerts: null == reviewAlerts ? _self.reviewAlerts : reviewAlerts // ignore: cast_nullable_to_non_nullable
as bool,marketingAlerts: null == marketingAlerts ? _self.marketingAlerts : marketingAlerts // ignore: cast_nullable_to_non_nullable
as bool,quietHoursEnabled: null == quietHoursEnabled ? _self.quietHoursEnabled : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
as bool,quietStartMinute: null == quietStartMinute ? _self.quietStartMinute : quietStartMinute // ignore: cast_nullable_to_non_nullable
as int,quietEndMinute: null == quietEndMinute ? _self.quietEndMinute : quietEndMinute // ignore: cast_nullable_to_non_nullable
as int,acceptedChannels: null == acceptedChannels ? _self._acceptedChannels : acceptedChannels // ignore: cast_nullable_to_non_nullable
as Set<ConsultChannel>,maxQueueLength: null == maxQueueLength ? _self.maxQueueLength : maxQueueLength // ignore: cast_nullable_to_non_nullable
as int,autoDeclineAfterSeconds: null == autoDeclineAfterSeconds ? _self.autoDeclineAfterSeconds : autoDeclineAfterSeconds // ignore: cast_nullable_to_non_nullable
as int,autoAcceptRepeatClients: null == autoAcceptRepeatClients ? _self.autoAcceptRepeatClients : autoAcceptRepeatClients // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
