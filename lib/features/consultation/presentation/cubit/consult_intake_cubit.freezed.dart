// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consult_intake_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsultIntakeState {

 ConsultIntake get intake; LoadState<Astrologer> get astrologer; LoadState<Consultation> get starting; double get balance;
/// Create a copy of ConsultIntakeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsultIntakeStateCopyWith<ConsultIntakeState> get copyWith => _$ConsultIntakeStateCopyWithImpl<ConsultIntakeState>(this as ConsultIntakeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsultIntakeState&&(identical(other.intake, intake) || other.intake == intake)&&(identical(other.astrologer, astrologer) || other.astrologer == astrologer)&&(identical(other.starting, starting) || other.starting == starting)&&(identical(other.balance, balance) || other.balance == balance));
}


@override
int get hashCode => Object.hash(runtimeType,intake,astrologer,starting,balance);

@override
String toString() {
  return 'ConsultIntakeState(intake: $intake, astrologer: $astrologer, starting: $starting, balance: $balance)';
}


}

/// @nodoc
abstract mixin class $ConsultIntakeStateCopyWith<$Res>  {
  factory $ConsultIntakeStateCopyWith(ConsultIntakeState value, $Res Function(ConsultIntakeState) _then) = _$ConsultIntakeStateCopyWithImpl;
@useResult
$Res call({
 ConsultIntake intake, LoadState<Astrologer> astrologer, LoadState<Consultation> starting, double balance
});


$ConsultIntakeCopyWith<$Res> get intake;$LoadStateCopyWith<Astrologer, $Res> get astrologer;$LoadStateCopyWith<Consultation, $Res> get starting;

}
/// @nodoc
class _$ConsultIntakeStateCopyWithImpl<$Res>
    implements $ConsultIntakeStateCopyWith<$Res> {
  _$ConsultIntakeStateCopyWithImpl(this._self, this._then);

  final ConsultIntakeState _self;
  final $Res Function(ConsultIntakeState) _then;

/// Create a copy of ConsultIntakeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intake = null,Object? astrologer = null,Object? starting = null,Object? balance = null,}) {
  return _then(_self.copyWith(
intake: null == intake ? _self.intake : intake // ignore: cast_nullable_to_non_nullable
as ConsultIntake,astrologer: null == astrologer ? _self.astrologer : astrologer // ignore: cast_nullable_to_non_nullable
as LoadState<Astrologer>,starting: null == starting ? _self.starting : starting // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of ConsultIntakeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConsultIntakeCopyWith<$Res> get intake {
  
  return $ConsultIntakeCopyWith<$Res>(_self.intake, (value) {
    return _then(_self.copyWith(intake: value));
  });
}/// Create a copy of ConsultIntakeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Astrologer, $Res> get astrologer {
  
  return $LoadStateCopyWith<Astrologer, $Res>(_self.astrologer, (value) {
    return _then(_self.copyWith(astrologer: value));
  });
}/// Create a copy of ConsultIntakeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get starting {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.starting, (value) {
    return _then(_self.copyWith(starting: value));
  });
}
}



/// @nodoc


class _ConsultIntakeState extends ConsultIntakeState {
  const _ConsultIntakeState({required this.intake, this.astrologer = const LoadState.idle(), this.starting = const LoadState.idle(), this.balance = 0}): super._();
  

@override final  ConsultIntake intake;
@override@JsonKey() final  LoadState<Astrologer> astrologer;
@override@JsonKey() final  LoadState<Consultation> starting;
@override@JsonKey() final  double balance;

/// Create a copy of ConsultIntakeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsultIntakeStateCopyWith<_ConsultIntakeState> get copyWith => __$ConsultIntakeStateCopyWithImpl<_ConsultIntakeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsultIntakeState&&(identical(other.intake, intake) || other.intake == intake)&&(identical(other.astrologer, astrologer) || other.astrologer == astrologer)&&(identical(other.starting, starting) || other.starting == starting)&&(identical(other.balance, balance) || other.balance == balance));
}


@override
int get hashCode => Object.hash(runtimeType,intake,astrologer,starting,balance);

@override
String toString() {
  return 'ConsultIntakeState(intake: $intake, astrologer: $astrologer, starting: $starting, balance: $balance)';
}


}

/// @nodoc
abstract mixin class _$ConsultIntakeStateCopyWith<$Res> implements $ConsultIntakeStateCopyWith<$Res> {
  factory _$ConsultIntakeStateCopyWith(_ConsultIntakeState value, $Res Function(_ConsultIntakeState) _then) = __$ConsultIntakeStateCopyWithImpl;
@override @useResult
$Res call({
 ConsultIntake intake, LoadState<Astrologer> astrologer, LoadState<Consultation> starting, double balance
});


@override $ConsultIntakeCopyWith<$Res> get intake;@override $LoadStateCopyWith<Astrologer, $Res> get astrologer;@override $LoadStateCopyWith<Consultation, $Res> get starting;

}
/// @nodoc
class __$ConsultIntakeStateCopyWithImpl<$Res>
    implements _$ConsultIntakeStateCopyWith<$Res> {
  __$ConsultIntakeStateCopyWithImpl(this._self, this._then);

  final _ConsultIntakeState _self;
  final $Res Function(_ConsultIntakeState) _then;

/// Create a copy of ConsultIntakeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intake = null,Object? astrologer = null,Object? starting = null,Object? balance = null,}) {
  return _then(_ConsultIntakeState(
intake: null == intake ? _self.intake : intake // ignore: cast_nullable_to_non_nullable
as ConsultIntake,astrologer: null == astrologer ? _self.astrologer : astrologer // ignore: cast_nullable_to_non_nullable
as LoadState<Astrologer>,starting: null == starting ? _self.starting : starting // ignore: cast_nullable_to_non_nullable
as LoadState<Consultation>,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of ConsultIntakeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConsultIntakeCopyWith<$Res> get intake {
  
  return $ConsultIntakeCopyWith<$Res>(_self.intake, (value) {
    return _then(_self.copyWith(intake: value));
  });
}/// Create a copy of ConsultIntakeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Astrologer, $Res> get astrologer {
  
  return $LoadStateCopyWith<Astrologer, $Res>(_self.astrologer, (value) {
    return _then(_self.copyWith(astrologer: value));
  });
}/// Create a copy of ConsultIntakeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Consultation, $Res> get starting {
  
  return $LoadStateCopyWith<Consultation, $Res>(_self.starting, (value) {
    return _then(_self.copyWith(starting: value));
  });
}
}

// dart format on
