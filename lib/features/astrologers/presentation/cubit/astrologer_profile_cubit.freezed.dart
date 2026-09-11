// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AstrologerProfileState {

 LoadState<Astrologer> get astrologer; LoadState<List<AstrologerReview>> get reviews;/// Tracks the report submission separately so a failed report never
/// blanks the profile behind it.
 LoadState<bool> get reporting; int get tabIndex;/// The completed consultation a review would be attached to, when this
/// seeker has one with this astrologer.
 String? get reviewConsultationId;
/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerProfileStateCopyWith<AstrologerProfileState> get copyWith => _$AstrologerProfileStateCopyWithImpl<AstrologerProfileState>(this as AstrologerProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerProfileState&&(identical(other.astrologer, astrologer) || other.astrologer == astrologer)&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.reporting, reporting) || other.reporting == reporting)&&(identical(other.tabIndex, tabIndex) || other.tabIndex == tabIndex)&&(identical(other.reviewConsultationId, reviewConsultationId) || other.reviewConsultationId == reviewConsultationId));
}


@override
int get hashCode => Object.hash(runtimeType,astrologer,reviews,reporting,tabIndex,reviewConsultationId);

@override
String toString() {
  return 'AstrologerProfileState(astrologer: $astrologer, reviews: $reviews, reporting: $reporting, tabIndex: $tabIndex, reviewConsultationId: $reviewConsultationId)';
}


}

/// @nodoc
abstract mixin class $AstrologerProfileStateCopyWith<$Res>  {
  factory $AstrologerProfileStateCopyWith(AstrologerProfileState value, $Res Function(AstrologerProfileState) _then) = _$AstrologerProfileStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Astrologer> astrologer, LoadState<List<AstrologerReview>> reviews, LoadState<bool> reporting, int tabIndex, String? reviewConsultationId
});


$LoadStateCopyWith<Astrologer, $Res> get astrologer;$LoadStateCopyWith<List<AstrologerReview>, $Res> get reviews;$LoadStateCopyWith<bool, $Res> get reporting;

}
/// @nodoc
class _$AstrologerProfileStateCopyWithImpl<$Res>
    implements $AstrologerProfileStateCopyWith<$Res> {
  _$AstrologerProfileStateCopyWithImpl(this._self, this._then);

  final AstrologerProfileState _self;
  final $Res Function(AstrologerProfileState) _then;

/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? astrologer = null,Object? reviews = null,Object? reporting = null,Object? tabIndex = null,Object? reviewConsultationId = freezed,}) {
  return _then(_self.copyWith(
astrologer: null == astrologer ? _self.astrologer : astrologer // ignore: cast_nullable_to_non_nullable
as LoadState<Astrologer>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as LoadState<List<AstrologerReview>>,reporting: null == reporting ? _self.reporting : reporting // ignore: cast_nullable_to_non_nullable
as LoadState<bool>,tabIndex: null == tabIndex ? _self.tabIndex : tabIndex // ignore: cast_nullable_to_non_nullable
as int,reviewConsultationId: freezed == reviewConsultationId ? _self.reviewConsultationId : reviewConsultationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Astrologer, $Res> get astrologer {
  
  return $LoadStateCopyWith<Astrologer, $Res>(_self.astrologer, (value) {
    return _then(_self.copyWith(astrologer: value));
  });
}/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AstrologerReview>, $Res> get reviews {
  
  return $LoadStateCopyWith<List<AstrologerReview>, $Res>(_self.reviews, (value) {
    return _then(_self.copyWith(reviews: value));
  });
}/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<bool, $Res> get reporting {
  
  return $LoadStateCopyWith<bool, $Res>(_self.reporting, (value) {
    return _then(_self.copyWith(reporting: value));
  });
}
}



/// @nodoc


class _AstrologerProfileState extends AstrologerProfileState {
  const _AstrologerProfileState({this.astrologer = const LoadState.idle(), this.reviews = const LoadState.idle(), this.reporting = const LoadState.idle(), this.tabIndex = 0, this.reviewConsultationId}): super._();
  

@override@JsonKey() final  LoadState<Astrologer> astrologer;
@override@JsonKey() final  LoadState<List<AstrologerReview>> reviews;
/// Tracks the report submission separately so a failed report never
/// blanks the profile behind it.
@override@JsonKey() final  LoadState<bool> reporting;
@override@JsonKey() final  int tabIndex;
/// The completed consultation a review would be attached to, when this
/// seeker has one with this astrologer.
@override final  String? reviewConsultationId;

/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerProfileStateCopyWith<_AstrologerProfileState> get copyWith => __$AstrologerProfileStateCopyWithImpl<_AstrologerProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerProfileState&&(identical(other.astrologer, astrologer) || other.astrologer == astrologer)&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.reporting, reporting) || other.reporting == reporting)&&(identical(other.tabIndex, tabIndex) || other.tabIndex == tabIndex)&&(identical(other.reviewConsultationId, reviewConsultationId) || other.reviewConsultationId == reviewConsultationId));
}


@override
int get hashCode => Object.hash(runtimeType,astrologer,reviews,reporting,tabIndex,reviewConsultationId);

@override
String toString() {
  return 'AstrologerProfileState(astrologer: $astrologer, reviews: $reviews, reporting: $reporting, tabIndex: $tabIndex, reviewConsultationId: $reviewConsultationId)';
}


}

/// @nodoc
abstract mixin class _$AstrologerProfileStateCopyWith<$Res> implements $AstrologerProfileStateCopyWith<$Res> {
  factory _$AstrologerProfileStateCopyWith(_AstrologerProfileState value, $Res Function(_AstrologerProfileState) _then) = __$AstrologerProfileStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Astrologer> astrologer, LoadState<List<AstrologerReview>> reviews, LoadState<bool> reporting, int tabIndex, String? reviewConsultationId
});


@override $LoadStateCopyWith<Astrologer, $Res> get astrologer;@override $LoadStateCopyWith<List<AstrologerReview>, $Res> get reviews;@override $LoadStateCopyWith<bool, $Res> get reporting;

}
/// @nodoc
class __$AstrologerProfileStateCopyWithImpl<$Res>
    implements _$AstrologerProfileStateCopyWith<$Res> {
  __$AstrologerProfileStateCopyWithImpl(this._self, this._then);

  final _AstrologerProfileState _self;
  final $Res Function(_AstrologerProfileState) _then;

/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? astrologer = null,Object? reviews = null,Object? reporting = null,Object? tabIndex = null,Object? reviewConsultationId = freezed,}) {
  return _then(_AstrologerProfileState(
astrologer: null == astrologer ? _self.astrologer : astrologer // ignore: cast_nullable_to_non_nullable
as LoadState<Astrologer>,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as LoadState<List<AstrologerReview>>,reporting: null == reporting ? _self.reporting : reporting // ignore: cast_nullable_to_non_nullable
as LoadState<bool>,tabIndex: null == tabIndex ? _self.tabIndex : tabIndex // ignore: cast_nullable_to_non_nullable
as int,reviewConsultationId: freezed == reviewConsultationId ? _self.reviewConsultationId : reviewConsultationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Astrologer, $Res> get astrologer {
  
  return $LoadStateCopyWith<Astrologer, $Res>(_self.astrologer, (value) {
    return _then(_self.copyWith(astrologer: value));
  });
}/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AstrologerReview>, $Res> get reviews {
  
  return $LoadStateCopyWith<List<AstrologerReview>, $Res>(_self.reviews, (value) {
    return _then(_self.copyWith(reviews: value));
  });
}/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<bool, $Res> get reporting {
  
  return $LoadStateCopyWith<bool, $Res>(_self.reporting, (value) {
    return _then(_self.copyWith(reporting: value));
  });
}
}

// dart format on
