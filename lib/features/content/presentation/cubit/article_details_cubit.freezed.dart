// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArticleDetailsState {

 LoadState<Article> get article;/// "Recent posts" shown under the article.
 LoadState<List<Article>> get related;/// `null` = follow the app locale.
 ContentLanguage? get language;
/// Create a copy of ArticleDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleDetailsStateCopyWith<ArticleDetailsState> get copyWith => _$ArticleDetailsStateCopyWithImpl<ArticleDetailsState>(this as ArticleDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleDetailsState&&(identical(other.article, article) || other.article == article)&&(identical(other.related, related) || other.related == related)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,article,related,language);

@override
String toString() {
  return 'ArticleDetailsState(article: $article, related: $related, language: $language)';
}


}

/// @nodoc
abstract mixin class $ArticleDetailsStateCopyWith<$Res>  {
  factory $ArticleDetailsStateCopyWith(ArticleDetailsState value, $Res Function(ArticleDetailsState) _then) = _$ArticleDetailsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Article> article, LoadState<List<Article>> related, ContentLanguage? language
});


$LoadStateCopyWith<Article, $Res> get article;$LoadStateCopyWith<List<Article>, $Res> get related;

}
/// @nodoc
class _$ArticleDetailsStateCopyWithImpl<$Res>
    implements $ArticleDetailsStateCopyWith<$Res> {
  _$ArticleDetailsStateCopyWithImpl(this._self, this._then);

  final ArticleDetailsState _self;
  final $Res Function(ArticleDetailsState) _then;

/// Create a copy of ArticleDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? article = null,Object? related = null,Object? language = freezed,}) {
  return _then(_self.copyWith(
article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as LoadState<Article>,related: null == related ? _self.related : related // ignore: cast_nullable_to_non_nullable
as LoadState<List<Article>>,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as ContentLanguage?,
  ));
}
/// Create a copy of ArticleDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Article, $Res> get article {
  
  return $LoadStateCopyWith<Article, $Res>(_self.article, (value) {
    return _then(_self.copyWith(article: value));
  });
}/// Create a copy of ArticleDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Article>, $Res> get related {
  
  return $LoadStateCopyWith<List<Article>, $Res>(_self.related, (value) {
    return _then(_self.copyWith(related: value));
  });
}
}



/// @nodoc


class _ArticleDetailsState implements ArticleDetailsState {
  const _ArticleDetailsState({this.article = const LoadState.idle(), this.related = const LoadState.idle(), this.language});
  

@override@JsonKey() final  LoadState<Article> article;
/// "Recent posts" shown under the article.
@override@JsonKey() final  LoadState<List<Article>> related;
/// `null` = follow the app locale.
@override final  ContentLanguage? language;

/// Create a copy of ArticleDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleDetailsStateCopyWith<_ArticleDetailsState> get copyWith => __$ArticleDetailsStateCopyWithImpl<_ArticleDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleDetailsState&&(identical(other.article, article) || other.article == article)&&(identical(other.related, related) || other.related == related)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,article,related,language);

@override
String toString() {
  return 'ArticleDetailsState(article: $article, related: $related, language: $language)';
}


}

/// @nodoc
abstract mixin class _$ArticleDetailsStateCopyWith<$Res> implements $ArticleDetailsStateCopyWith<$Res> {
  factory _$ArticleDetailsStateCopyWith(_ArticleDetailsState value, $Res Function(_ArticleDetailsState) _then) = __$ArticleDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Article> article, LoadState<List<Article>> related, ContentLanguage? language
});


@override $LoadStateCopyWith<Article, $Res> get article;@override $LoadStateCopyWith<List<Article>, $Res> get related;

}
/// @nodoc
class __$ArticleDetailsStateCopyWithImpl<$Res>
    implements _$ArticleDetailsStateCopyWith<$Res> {
  __$ArticleDetailsStateCopyWithImpl(this._self, this._then);

  final _ArticleDetailsState _self;
  final $Res Function(_ArticleDetailsState) _then;

/// Create a copy of ArticleDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? article = null,Object? related = null,Object? language = freezed,}) {
  return _then(_ArticleDetailsState(
article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as LoadState<Article>,related: null == related ? _self.related : related // ignore: cast_nullable_to_non_nullable
as LoadState<List<Article>>,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as ContentLanguage?,
  ));
}

/// Create a copy of ArticleDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Article, $Res> get article {
  
  return $LoadStateCopyWith<Article, $Res>(_self.article, (value) {
    return _then(_self.copyWith(article: value));
  });
}/// Create a copy of ArticleDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Article>, $Res> get related {
  
  return $LoadStateCopyWith<List<Article>, $Res>(_self.related, (value) {
    return _then(_self.copyWith(related: value));
  });
}
}

// dart format on
