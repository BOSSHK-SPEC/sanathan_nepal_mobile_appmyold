// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArticleListState {

 ArticleType get type; LoadState<List<Article>> get articles;/// `null` = all categories.
 String? get categoryKey;/// `null` = all tags.
 String? get tagKey;/// `null` = follow the app locale.
 ContentLanguage? get language;
/// Create a copy of ArticleListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleListStateCopyWith<ArticleListState> get copyWith => _$ArticleListStateCopyWithImpl<ArticleListState>(this as ArticleListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleListState&&(identical(other.type, type) || other.type == type)&&(identical(other.articles, articles) || other.articles == articles)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.tagKey, tagKey) || other.tagKey == tagKey)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,type,articles,categoryKey,tagKey,language);

@override
String toString() {
  return 'ArticleListState(type: $type, articles: $articles, categoryKey: $categoryKey, tagKey: $tagKey, language: $language)';
}


}

/// @nodoc
abstract mixin class $ArticleListStateCopyWith<$Res>  {
  factory $ArticleListStateCopyWith(ArticleListState value, $Res Function(ArticleListState) _then) = _$ArticleListStateCopyWithImpl;
@useResult
$Res call({
 ArticleType type, LoadState<List<Article>> articles, String? categoryKey, String? tagKey, ContentLanguage? language
});


$LoadStateCopyWith<List<Article>, $Res> get articles;

}
/// @nodoc
class _$ArticleListStateCopyWithImpl<$Res>
    implements $ArticleListStateCopyWith<$Res> {
  _$ArticleListStateCopyWithImpl(this._self, this._then);

  final ArticleListState _self;
  final $Res Function(ArticleListState) _then;

/// Create a copy of ArticleListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? articles = null,Object? categoryKey = freezed,Object? tagKey = freezed,Object? language = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ArticleType,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as LoadState<List<Article>>,categoryKey: freezed == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String?,tagKey: freezed == tagKey ? _self.tagKey : tagKey // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as ContentLanguage?,
  ));
}
/// Create a copy of ArticleListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Article>, $Res> get articles {
  
  return $LoadStateCopyWith<List<Article>, $Res>(_self.articles, (value) {
    return _then(_self.copyWith(articles: value));
  });
}
}



/// @nodoc


class _ArticleListState extends ArticleListState {
  const _ArticleListState({required this.type, this.articles = const LoadState.idle(), this.categoryKey, this.tagKey, this.language}): super._();
  

@override final  ArticleType type;
@override@JsonKey() final  LoadState<List<Article>> articles;
/// `null` = all categories.
@override final  String? categoryKey;
/// `null` = all tags.
@override final  String? tagKey;
/// `null` = follow the app locale.
@override final  ContentLanguage? language;

/// Create a copy of ArticleListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleListStateCopyWith<_ArticleListState> get copyWith => __$ArticleListStateCopyWithImpl<_ArticleListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleListState&&(identical(other.type, type) || other.type == type)&&(identical(other.articles, articles) || other.articles == articles)&&(identical(other.categoryKey, categoryKey) || other.categoryKey == categoryKey)&&(identical(other.tagKey, tagKey) || other.tagKey == tagKey)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,type,articles,categoryKey,tagKey,language);

@override
String toString() {
  return 'ArticleListState(type: $type, articles: $articles, categoryKey: $categoryKey, tagKey: $tagKey, language: $language)';
}


}

/// @nodoc
abstract mixin class _$ArticleListStateCopyWith<$Res> implements $ArticleListStateCopyWith<$Res> {
  factory _$ArticleListStateCopyWith(_ArticleListState value, $Res Function(_ArticleListState) _then) = __$ArticleListStateCopyWithImpl;
@override @useResult
$Res call({
 ArticleType type, LoadState<List<Article>> articles, String? categoryKey, String? tagKey, ContentLanguage? language
});


@override $LoadStateCopyWith<List<Article>, $Res> get articles;

}
/// @nodoc
class __$ArticleListStateCopyWithImpl<$Res>
    implements _$ArticleListStateCopyWith<$Res> {
  __$ArticleListStateCopyWithImpl(this._self, this._then);

  final _ArticleListState _self;
  final $Res Function(_ArticleListState) _then;

/// Create a copy of ArticleListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? articles = null,Object? categoryKey = freezed,Object? tagKey = freezed,Object? language = freezed,}) {
  return _then(_ArticleListState(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ArticleType,articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as LoadState<List<Article>>,categoryKey: freezed == categoryKey ? _self.categoryKey : categoryKey // ignore: cast_nullable_to_non_nullable
as String?,tagKey: freezed == tagKey ? _self.tagKey : tagKey // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as ContentLanguage?,
  ));
}

/// Create a copy of ArticleListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Article>, $Res> get articles {
  
  return $LoadStateCopyWith<List<Article>, $Res>(_self.articles, (value) {
    return _then(_self.copyWith(articles: value));
  });
}
}

// dart format on
