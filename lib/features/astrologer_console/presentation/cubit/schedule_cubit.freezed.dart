// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleState {

 LoadState<Availability> get availability; LoadState<Availability> get saving;/// Edited copy; only [ScheduleCubit.save] promotes it.
 Availability? get draft; String? get saveError;
/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleStateCopyWith<ScheduleState> get copyWith => _$ScheduleStateCopyWithImpl<ScheduleState>(this as ScheduleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleState&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,availability,saving,draft,saveError);

@override
String toString() {
  return 'ScheduleState(availability: $availability, saving: $saving, draft: $draft, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class $ScheduleStateCopyWith<$Res>  {
  factory $ScheduleStateCopyWith(ScheduleState value, $Res Function(ScheduleState) _then) = _$ScheduleStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Availability> availability, LoadState<Availability> saving, Availability? draft, String? saveError
});


$LoadStateCopyWith<Availability, $Res> get availability;$LoadStateCopyWith<Availability, $Res> get saving;$AvailabilityCopyWith<$Res>? get draft;

}
/// @nodoc
class _$ScheduleStateCopyWithImpl<$Res>
    implements $ScheduleStateCopyWith<$Res> {
  _$ScheduleStateCopyWithImpl(this._self, this._then);

  final ScheduleState _self;
  final $Res Function(ScheduleState) _then;

/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availability = null,Object? saving = null,Object? draft = freezed,Object? saveError = freezed,}) {
  return _then(_self.copyWith(
availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as LoadState<Availability>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<Availability>,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as Availability?,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Availability, $Res> get availability {
  
  return $LoadStateCopyWith<Availability, $Res>(_self.availability, (value) {
    return _then(_self.copyWith(availability: value));
  });
}/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Availability, $Res> get saving {
  
  return $LoadStateCopyWith<Availability, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AvailabilityCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $AvailabilityCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}



/// @nodoc


class _ScheduleState extends ScheduleState {
  const _ScheduleState({this.availability = const LoadState.idle(), this.saving = const LoadState.idle(), this.draft, this.saveError}): super._();
  

@override@JsonKey() final  LoadState<Availability> availability;
@override@JsonKey() final  LoadState<Availability> saving;
/// Edited copy; only [ScheduleCubit.save] promotes it.
@override final  Availability? draft;
@override final  String? saveError;

/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleStateCopyWith<_ScheduleState> get copyWith => __$ScheduleStateCopyWithImpl<_ScheduleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleState&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,availability,saving,draft,saveError);

@override
String toString() {
  return 'ScheduleState(availability: $availability, saving: $saving, draft: $draft, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class _$ScheduleStateCopyWith<$Res> implements $ScheduleStateCopyWith<$Res> {
  factory _$ScheduleStateCopyWith(_ScheduleState value, $Res Function(_ScheduleState) _then) = __$ScheduleStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Availability> availability, LoadState<Availability> saving, Availability? draft, String? saveError
});


@override $LoadStateCopyWith<Availability, $Res> get availability;@override $LoadStateCopyWith<Availability, $Res> get saving;@override $AvailabilityCopyWith<$Res>? get draft;

}
/// @nodoc
class __$ScheduleStateCopyWithImpl<$Res>
    implements _$ScheduleStateCopyWith<$Res> {
  __$ScheduleStateCopyWithImpl(this._self, this._then);

  final _ScheduleState _self;
  final $Res Function(_ScheduleState) _then;

/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availability = null,Object? saving = null,Object? draft = freezed,Object? saveError = freezed,}) {
  return _then(_ScheduleState(
availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as LoadState<Availability>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<Availability>,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as Availability?,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Availability, $Res> get availability {
  
  return $LoadStateCopyWith<Availability, $Res>(_self.availability, (value) {
    return _then(_self.copyWith(availability: value));
  });
}/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Availability, $Res> get saving {
  
  return $LoadStateCopyWith<Availability, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AvailabilityCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $AvailabilityCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
