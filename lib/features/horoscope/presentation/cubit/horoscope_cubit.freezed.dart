// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'horoscope_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HoroscopeState {

/// Predictions of all twelve signs for [period] (zodiac order).
 LoadState<List<HoroscopePrediction>> get predictions; HoroscopePeriod get period; ZodiacSign get selectedSign;/// Sign whose media clip is currently loaded in the mocked player.
 ZodiacSign? get playingSign;/// True when the loaded clip is the sign's "lucky details" video (second
/// player of the expanded card) rather than the prediction clip.
 bool get playingLuckyClip;/// Playback head of the mocked player.
 Duration get position; bool get isPlaying;/// Signs the user has "liked" (♥ under the sign icon) – session only
/// until a backend exists.
 Set<ZodiacSign> get likedSigns;/// Signs whose "थप विवरण / More Details" area is open.
 Set<ZodiacSign> get expandedSigns;
/// Create a copy of HoroscopeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HoroscopeStateCopyWith<HoroscopeState> get copyWith => _$HoroscopeStateCopyWithImpl<HoroscopeState>(this as HoroscopeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HoroscopeState&&(identical(other.predictions, predictions) || other.predictions == predictions)&&(identical(other.period, period) || other.period == period)&&(identical(other.selectedSign, selectedSign) || other.selectedSign == selectedSign)&&(identical(other.playingSign, playingSign) || other.playingSign == playingSign)&&(identical(other.playingLuckyClip, playingLuckyClip) || other.playingLuckyClip == playingLuckyClip)&&(identical(other.position, position) || other.position == position)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&const DeepCollectionEquality().equals(other.likedSigns, likedSigns)&&const DeepCollectionEquality().equals(other.expandedSigns, expandedSigns));
}


@override
int get hashCode => Object.hash(runtimeType,predictions,period,selectedSign,playingSign,playingLuckyClip,position,isPlaying,const DeepCollectionEquality().hash(likedSigns),const DeepCollectionEquality().hash(expandedSigns));

@override
String toString() {
  return 'HoroscopeState(predictions: $predictions, period: $period, selectedSign: $selectedSign, playingSign: $playingSign, playingLuckyClip: $playingLuckyClip, position: $position, isPlaying: $isPlaying, likedSigns: $likedSigns, expandedSigns: $expandedSigns)';
}


}

/// @nodoc
abstract mixin class $HoroscopeStateCopyWith<$Res>  {
  factory $HoroscopeStateCopyWith(HoroscopeState value, $Res Function(HoroscopeState) _then) = _$HoroscopeStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<HoroscopePrediction>> predictions, HoroscopePeriod period, ZodiacSign selectedSign, ZodiacSign? playingSign, bool playingLuckyClip, Duration position, bool isPlaying, Set<ZodiacSign> likedSigns, Set<ZodiacSign> expandedSigns
});


$LoadStateCopyWith<List<HoroscopePrediction>, $Res> get predictions;

}
/// @nodoc
class _$HoroscopeStateCopyWithImpl<$Res>
    implements $HoroscopeStateCopyWith<$Res> {
  _$HoroscopeStateCopyWithImpl(this._self, this._then);

  final HoroscopeState _self;
  final $Res Function(HoroscopeState) _then;

/// Create a copy of HoroscopeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? predictions = null,Object? period = null,Object? selectedSign = null,Object? playingSign = freezed,Object? playingLuckyClip = null,Object? position = null,Object? isPlaying = null,Object? likedSigns = null,Object? expandedSigns = null,}) {
  return _then(_self.copyWith(
predictions: null == predictions ? _self.predictions : predictions // ignore: cast_nullable_to_non_nullable
as LoadState<List<HoroscopePrediction>>,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as HoroscopePeriod,selectedSign: null == selectedSign ? _self.selectedSign : selectedSign // ignore: cast_nullable_to_non_nullable
as ZodiacSign,playingSign: freezed == playingSign ? _self.playingSign : playingSign // ignore: cast_nullable_to_non_nullable
as ZodiacSign?,playingLuckyClip: null == playingLuckyClip ? _self.playingLuckyClip : playingLuckyClip // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,likedSigns: null == likedSigns ? _self.likedSigns : likedSigns // ignore: cast_nullable_to_non_nullable
as Set<ZodiacSign>,expandedSigns: null == expandedSigns ? _self.expandedSigns : expandedSigns // ignore: cast_nullable_to_non_nullable
as Set<ZodiacSign>,
  ));
}
/// Create a copy of HoroscopeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<HoroscopePrediction>, $Res> get predictions {
  
  return $LoadStateCopyWith<List<HoroscopePrediction>, $Res>(_self.predictions, (value) {
    return _then(_self.copyWith(predictions: value));
  });
}
}



/// @nodoc


class _HoroscopeState extends HoroscopeState {
  const _HoroscopeState({this.predictions = const LoadState.idle(), this.period = HoroscopePeriod.daily, this.selectedSign = ZodiacSign.aries, this.playingSign, this.playingLuckyClip = false, this.position = Duration.zero, this.isPlaying = false, final  Set<ZodiacSign> likedSigns = const <ZodiacSign>{}, final  Set<ZodiacSign> expandedSigns = const <ZodiacSign>{}}): _likedSigns = likedSigns,_expandedSigns = expandedSigns,super._();
  

/// Predictions of all twelve signs for [period] (zodiac order).
@override@JsonKey() final  LoadState<List<HoroscopePrediction>> predictions;
@override@JsonKey() final  HoroscopePeriod period;
@override@JsonKey() final  ZodiacSign selectedSign;
/// Sign whose media clip is currently loaded in the mocked player.
@override final  ZodiacSign? playingSign;
/// True when the loaded clip is the sign's "lucky details" video (second
/// player of the expanded card) rather than the prediction clip.
@override@JsonKey() final  bool playingLuckyClip;
/// Playback head of the mocked player.
@override@JsonKey() final  Duration position;
@override@JsonKey() final  bool isPlaying;
/// Signs the user has "liked" (♥ under the sign icon) – session only
/// until a backend exists.
 final  Set<ZodiacSign> _likedSigns;
/// Signs the user has "liked" (♥ under the sign icon) – session only
/// until a backend exists.
@override@JsonKey() Set<ZodiacSign> get likedSigns {
  if (_likedSigns is EqualUnmodifiableSetView) return _likedSigns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_likedSigns);
}

/// Signs whose "थप विवरण / More Details" area is open.
 final  Set<ZodiacSign> _expandedSigns;
/// Signs whose "थप विवरण / More Details" area is open.
@override@JsonKey() Set<ZodiacSign> get expandedSigns {
  if (_expandedSigns is EqualUnmodifiableSetView) return _expandedSigns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_expandedSigns);
}


/// Create a copy of HoroscopeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HoroscopeStateCopyWith<_HoroscopeState> get copyWith => __$HoroscopeStateCopyWithImpl<_HoroscopeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HoroscopeState&&(identical(other.predictions, predictions) || other.predictions == predictions)&&(identical(other.period, period) || other.period == period)&&(identical(other.selectedSign, selectedSign) || other.selectedSign == selectedSign)&&(identical(other.playingSign, playingSign) || other.playingSign == playingSign)&&(identical(other.playingLuckyClip, playingLuckyClip) || other.playingLuckyClip == playingLuckyClip)&&(identical(other.position, position) || other.position == position)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&const DeepCollectionEquality().equals(other._likedSigns, _likedSigns)&&const DeepCollectionEquality().equals(other._expandedSigns, _expandedSigns));
}


@override
int get hashCode => Object.hash(runtimeType,predictions,period,selectedSign,playingSign,playingLuckyClip,position,isPlaying,const DeepCollectionEquality().hash(_likedSigns),const DeepCollectionEquality().hash(_expandedSigns));

@override
String toString() {
  return 'HoroscopeState(predictions: $predictions, period: $period, selectedSign: $selectedSign, playingSign: $playingSign, playingLuckyClip: $playingLuckyClip, position: $position, isPlaying: $isPlaying, likedSigns: $likedSigns, expandedSigns: $expandedSigns)';
}


}

/// @nodoc
abstract mixin class _$HoroscopeStateCopyWith<$Res> implements $HoroscopeStateCopyWith<$Res> {
  factory _$HoroscopeStateCopyWith(_HoroscopeState value, $Res Function(_HoroscopeState) _then) = __$HoroscopeStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<HoroscopePrediction>> predictions, HoroscopePeriod period, ZodiacSign selectedSign, ZodiacSign? playingSign, bool playingLuckyClip, Duration position, bool isPlaying, Set<ZodiacSign> likedSigns, Set<ZodiacSign> expandedSigns
});


@override $LoadStateCopyWith<List<HoroscopePrediction>, $Res> get predictions;

}
/// @nodoc
class __$HoroscopeStateCopyWithImpl<$Res>
    implements _$HoroscopeStateCopyWith<$Res> {
  __$HoroscopeStateCopyWithImpl(this._self, this._then);

  final _HoroscopeState _self;
  final $Res Function(_HoroscopeState) _then;

/// Create a copy of HoroscopeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? predictions = null,Object? period = null,Object? selectedSign = null,Object? playingSign = freezed,Object? playingLuckyClip = null,Object? position = null,Object? isPlaying = null,Object? likedSigns = null,Object? expandedSigns = null,}) {
  return _then(_HoroscopeState(
predictions: null == predictions ? _self.predictions : predictions // ignore: cast_nullable_to_non_nullable
as LoadState<List<HoroscopePrediction>>,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as HoroscopePeriod,selectedSign: null == selectedSign ? _self.selectedSign : selectedSign // ignore: cast_nullable_to_non_nullable
as ZodiacSign,playingSign: freezed == playingSign ? _self.playingSign : playingSign // ignore: cast_nullable_to_non_nullable
as ZodiacSign?,playingLuckyClip: null == playingLuckyClip ? _self.playingLuckyClip : playingLuckyClip // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,likedSigns: null == likedSigns ? _self._likedSigns : likedSigns // ignore: cast_nullable_to_non_nullable
as Set<ZodiacSign>,expandedSigns: null == expandedSigns ? _self._expandedSigns : expandedSigns // ignore: cast_nullable_to_non_nullable
as Set<ZodiacSign>,
  ));
}

/// Create a copy of HoroscopeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<HoroscopePrediction>, $Res> get predictions {
  
  return $LoadStateCopyWith<List<HoroscopePrediction>, $Res>(_self.predictions, (value) {
    return _then(_self.copyWith(predictions: value));
  });
}
}

// dart format on
