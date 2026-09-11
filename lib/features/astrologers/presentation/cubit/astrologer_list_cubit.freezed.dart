// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AstrologerListState {

 LoadState<List<Astrologer>> get astrologers; LoadState<List<String>> get languages;/// Applied to the list.
 AstrologerFilter get filter;/// Being edited in the filter sheet; discarded unless applied.
 AstrologerFilter get draftFilter; List<String> get recentSearches;
/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerListStateCopyWith<AstrologerListState> get copyWith => _$AstrologerListStateCopyWithImpl<AstrologerListState>(this as AstrologerListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerListState&&(identical(other.astrologers, astrologers) || other.astrologers == astrologers)&&(identical(other.languages, languages) || other.languages == languages)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.draftFilter, draftFilter) || other.draftFilter == draftFilter)&&const DeepCollectionEquality().equals(other.recentSearches, recentSearches));
}


@override
int get hashCode => Object.hash(runtimeType,astrologers,languages,filter,draftFilter,const DeepCollectionEquality().hash(recentSearches));

@override
String toString() {
  return 'AstrologerListState(astrologers: $astrologers, languages: $languages, filter: $filter, draftFilter: $draftFilter, recentSearches: $recentSearches)';
}


}

/// @nodoc
abstract mixin class $AstrologerListStateCopyWith<$Res>  {
  factory $AstrologerListStateCopyWith(AstrologerListState value, $Res Function(AstrologerListState) _then) = _$AstrologerListStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<Astrologer>> astrologers, LoadState<List<String>> languages, AstrologerFilter filter, AstrologerFilter draftFilter, List<String> recentSearches
});


$LoadStateCopyWith<List<Astrologer>, $Res> get astrologers;$LoadStateCopyWith<List<String>, $Res> get languages;$AstrologerFilterCopyWith<$Res> get filter;$AstrologerFilterCopyWith<$Res> get draftFilter;

}
/// @nodoc
class _$AstrologerListStateCopyWithImpl<$Res>
    implements $AstrologerListStateCopyWith<$Res> {
  _$AstrologerListStateCopyWithImpl(this._self, this._then);

  final AstrologerListState _self;
  final $Res Function(AstrologerListState) _then;

/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? astrologers = null,Object? languages = null,Object? filter = null,Object? draftFilter = null,Object? recentSearches = null,}) {
  return _then(_self.copyWith(
astrologers: null == astrologers ? _self.astrologers : astrologers // ignore: cast_nullable_to_non_nullable
as LoadState<List<Astrologer>>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as LoadState<List<String>>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as AstrologerFilter,draftFilter: null == draftFilter ? _self.draftFilter : draftFilter // ignore: cast_nullable_to_non_nullable
as AstrologerFilter,recentSearches: null == recentSearches ? _self.recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Astrologer>, $Res> get astrologers {
  
  return $LoadStateCopyWith<List<Astrologer>, $Res>(_self.astrologers, (value) {
    return _then(_self.copyWith(astrologers: value));
  });
}/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<String>, $Res> get languages {
  
  return $LoadStateCopyWith<List<String>, $Res>(_self.languages, (value) {
    return _then(_self.copyWith(languages: value));
  });
}/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AstrologerFilterCopyWith<$Res> get filter {
  
  return $AstrologerFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AstrologerFilterCopyWith<$Res> get draftFilter {
  
  return $AstrologerFilterCopyWith<$Res>(_self.draftFilter, (value) {
    return _then(_self.copyWith(draftFilter: value));
  });
}
}



/// @nodoc


class _AstrologerListState extends AstrologerListState {
  const _AstrologerListState({this.astrologers = const LoadState.idle(), this.languages = const LoadState.idle(), this.filter = const AstrologerFilter(), this.draftFilter = const AstrologerFilter(), final  List<String> recentSearches = const <String>[]}): _recentSearches = recentSearches,super._();
  

@override@JsonKey() final  LoadState<List<Astrologer>> astrologers;
@override@JsonKey() final  LoadState<List<String>> languages;
/// Applied to the list.
@override@JsonKey() final  AstrologerFilter filter;
/// Being edited in the filter sheet; discarded unless applied.
@override@JsonKey() final  AstrologerFilter draftFilter;
 final  List<String> _recentSearches;
@override@JsonKey() List<String> get recentSearches {
  if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSearches);
}


/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerListStateCopyWith<_AstrologerListState> get copyWith => __$AstrologerListStateCopyWithImpl<_AstrologerListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerListState&&(identical(other.astrologers, astrologers) || other.astrologers == astrologers)&&(identical(other.languages, languages) || other.languages == languages)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.draftFilter, draftFilter) || other.draftFilter == draftFilter)&&const DeepCollectionEquality().equals(other._recentSearches, _recentSearches));
}


@override
int get hashCode => Object.hash(runtimeType,astrologers,languages,filter,draftFilter,const DeepCollectionEquality().hash(_recentSearches));

@override
String toString() {
  return 'AstrologerListState(astrologers: $astrologers, languages: $languages, filter: $filter, draftFilter: $draftFilter, recentSearches: $recentSearches)';
}


}

/// @nodoc
abstract mixin class _$AstrologerListStateCopyWith<$Res> implements $AstrologerListStateCopyWith<$Res> {
  factory _$AstrologerListStateCopyWith(_AstrologerListState value, $Res Function(_AstrologerListState) _then) = __$AstrologerListStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<Astrologer>> astrologers, LoadState<List<String>> languages, AstrologerFilter filter, AstrologerFilter draftFilter, List<String> recentSearches
});


@override $LoadStateCopyWith<List<Astrologer>, $Res> get astrologers;@override $LoadStateCopyWith<List<String>, $Res> get languages;@override $AstrologerFilterCopyWith<$Res> get filter;@override $AstrologerFilterCopyWith<$Res> get draftFilter;

}
/// @nodoc
class __$AstrologerListStateCopyWithImpl<$Res>
    implements _$AstrologerListStateCopyWith<$Res> {
  __$AstrologerListStateCopyWithImpl(this._self, this._then);

  final _AstrologerListState _self;
  final $Res Function(_AstrologerListState) _then;

/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? astrologers = null,Object? languages = null,Object? filter = null,Object? draftFilter = null,Object? recentSearches = null,}) {
  return _then(_AstrologerListState(
astrologers: null == astrologers ? _self.astrologers : astrologers // ignore: cast_nullable_to_non_nullable
as LoadState<List<Astrologer>>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as LoadState<List<String>>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as AstrologerFilter,draftFilter: null == draftFilter ? _self.draftFilter : draftFilter // ignore: cast_nullable_to_non_nullable
as AstrologerFilter,recentSearches: null == recentSearches ? _self._recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Astrologer>, $Res> get astrologers {
  
  return $LoadStateCopyWith<List<Astrologer>, $Res>(_self.astrologers, (value) {
    return _then(_self.copyWith(astrologers: value));
  });
}/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<String>, $Res> get languages {
  
  return $LoadStateCopyWith<List<String>, $Res>(_self.languages, (value) {
    return _then(_self.copyWith(languages: value));
  });
}/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AstrologerFilterCopyWith<$Res> get filter {
  
  return $AstrologerFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}/// Create a copy of AstrologerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AstrologerFilterCopyWith<$Res> get draftFilter {
  
  return $AstrologerFilterCopyWith<$Res>(_self.draftFilter, (value) {
    return _then(_self.copyWith(draftFilter: value));
  });
}
}

// dart format on
