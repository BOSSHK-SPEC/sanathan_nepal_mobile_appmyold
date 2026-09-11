// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArticleText {

 String get en; String? get ne; String? get hi;
/// Create a copy of ArticleText
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleTextCopyWith<ArticleText> get copyWith => _$ArticleTextCopyWithImpl<ArticleText>(this as ArticleText, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleText&&(identical(other.en, en) || other.en == en)&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.hi, hi) || other.hi == hi));
}


@override
int get hashCode => Object.hash(runtimeType,en,ne,hi);

@override
String toString() {
  return 'ArticleText(en: $en, ne: $ne, hi: $hi)';
}


}

/// @nodoc
abstract mixin class $ArticleTextCopyWith<$Res>  {
  factory $ArticleTextCopyWith(ArticleText value, $Res Function(ArticleText) _then) = _$ArticleTextCopyWithImpl;
@useResult
$Res call({
 String en, String? ne, String? hi
});




}
/// @nodoc
class _$ArticleTextCopyWithImpl<$Res>
    implements $ArticleTextCopyWith<$Res> {
  _$ArticleTextCopyWithImpl(this._self, this._then);

  final ArticleText _self;
  final $Res Function(ArticleText) _then;

/// Create a copy of ArticleText
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? en = null,Object? ne = freezed,Object? hi = freezed,}) {
  return _then(_self.copyWith(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,ne: freezed == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String?,hi: freezed == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _ArticleText extends ArticleText {
  const _ArticleText({required this.en, this.ne, this.hi}): super._();
  

@override final  String en;
@override final  String? ne;
@override final  String? hi;

/// Create a copy of ArticleText
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleTextCopyWith<_ArticleText> get copyWith => __$ArticleTextCopyWithImpl<_ArticleText>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleText&&(identical(other.en, en) || other.en == en)&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.hi, hi) || other.hi == hi));
}


@override
int get hashCode => Object.hash(runtimeType,en,ne,hi);

@override
String toString() {
  return 'ArticleText(en: $en, ne: $ne, hi: $hi)';
}


}

/// @nodoc
abstract mixin class _$ArticleTextCopyWith<$Res> implements $ArticleTextCopyWith<$Res> {
  factory _$ArticleTextCopyWith(_ArticleText value, $Res Function(_ArticleText) _then) = __$ArticleTextCopyWithImpl;
@override @useResult
$Res call({
 String en, String? ne, String? hi
});




}
/// @nodoc
class __$ArticleTextCopyWithImpl<$Res>
    implements _$ArticleTextCopyWith<$Res> {
  __$ArticleTextCopyWithImpl(this._self, this._then);

  final _ArticleText _self;
  final $Res Function(_ArticleText) _then;

/// Create a copy of ArticleText
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? en = null,Object? ne = freezed,Object? hi = freezed,}) {
  return _then(_ArticleText(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,ne: freezed == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String?,hi: freezed == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ArticleLabel {

 String get key; ArticleText get label;
/// Create a copy of ArticleLabel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleLabelCopyWith<ArticleLabel> get copyWith => _$ArticleLabelCopyWithImpl<ArticleLabel>(this as ArticleLabel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleLabel&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,key,label);

@override
String toString() {
  return 'ArticleLabel(key: $key, label: $label)';
}


}

/// @nodoc
abstract mixin class $ArticleLabelCopyWith<$Res>  {
  factory $ArticleLabelCopyWith(ArticleLabel value, $Res Function(ArticleLabel) _then) = _$ArticleLabelCopyWithImpl;
@useResult
$Res call({
 String key, ArticleText label
});


$ArticleTextCopyWith<$Res> get label;

}
/// @nodoc
class _$ArticleLabelCopyWithImpl<$Res>
    implements $ArticleLabelCopyWith<$Res> {
  _$ArticleLabelCopyWithImpl(this._self, this._then);

  final ArticleLabel _self;
  final $Res Function(ArticleLabel) _then;

/// Create a copy of ArticleLabel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as ArticleText,
  ));
}
/// Create a copy of ArticleLabel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextCopyWith<$Res> get label {
  
  return $ArticleTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}



/// @nodoc


class _ArticleLabel implements ArticleLabel {
  const _ArticleLabel({required this.key, required this.label});
  

@override final  String key;
@override final  ArticleText label;

/// Create a copy of ArticleLabel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleLabelCopyWith<_ArticleLabel> get copyWith => __$ArticleLabelCopyWithImpl<_ArticleLabel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleLabel&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,key,label);

@override
String toString() {
  return 'ArticleLabel(key: $key, label: $label)';
}


}

/// @nodoc
abstract mixin class _$ArticleLabelCopyWith<$Res> implements $ArticleLabelCopyWith<$Res> {
  factory _$ArticleLabelCopyWith(_ArticleLabel value, $Res Function(_ArticleLabel) _then) = __$ArticleLabelCopyWithImpl;
@override @useResult
$Res call({
 String key, ArticleText label
});


@override $ArticleTextCopyWith<$Res> get label;

}
/// @nodoc
class __$ArticleLabelCopyWithImpl<$Res>
    implements _$ArticleLabelCopyWith<$Res> {
  __$ArticleLabelCopyWithImpl(this._self, this._then);

  final _ArticleLabel _self;
  final $Res Function(_ArticleLabel) _then;

/// Create a copy of ArticleLabel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,}) {
  return _then(_ArticleLabel(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as ArticleText,
  ));
}

/// Create a copy of ArticleLabel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextCopyWith<$Res> get label {
  
  return $ArticleTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}

/// @nodoc
mixin _$Article {

 String get id; ArticleType get type; ArticleText get title; ArticleText get excerpt;/// Body paragraphs (each localised).
 List<ArticleText> get body; ArticleLabel get category; List<ArticleLabel> get tags; DateTime get publishedAt; ArticleText get author; int get readTimeMinutes; String? get imageAsset; int get likes; bool get isLiked;
/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleCopyWith<Article> get copyWith => _$ArticleCopyWithImpl<Article>(this as Article, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Article&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.excerpt, excerpt) || other.excerpt == excerpt)&&const DeepCollectionEquality().equals(other.body, body)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.readTimeMinutes, readTimeMinutes) || other.readTimeMinutes == readTimeMinutes)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,excerpt,const DeepCollectionEquality().hash(body),category,const DeepCollectionEquality().hash(tags),publishedAt,author,readTimeMinutes,imageAsset,likes,isLiked);

@override
String toString() {
  return 'Article(id: $id, type: $type, title: $title, excerpt: $excerpt, body: $body, category: $category, tags: $tags, publishedAt: $publishedAt, author: $author, readTimeMinutes: $readTimeMinutes, imageAsset: $imageAsset, likes: $likes, isLiked: $isLiked)';
}


}

/// @nodoc
abstract mixin class $ArticleCopyWith<$Res>  {
  factory $ArticleCopyWith(Article value, $Res Function(Article) _then) = _$ArticleCopyWithImpl;
@useResult
$Res call({
 String id, ArticleType type, ArticleText title, ArticleText excerpt, List<ArticleText> body, ArticleLabel category, List<ArticleLabel> tags, DateTime publishedAt, ArticleText author, int readTimeMinutes, String? imageAsset, int likes, bool isLiked
});


$ArticleTextCopyWith<$Res> get title;$ArticleTextCopyWith<$Res> get excerpt;$ArticleLabelCopyWith<$Res> get category;$ArticleTextCopyWith<$Res> get author;

}
/// @nodoc
class _$ArticleCopyWithImpl<$Res>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._self, this._then);

  final Article _self;
  final $Res Function(Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? excerpt = null,Object? body = null,Object? category = null,Object? tags = null,Object? publishedAt = null,Object? author = null,Object? readTimeMinutes = null,Object? imageAsset = freezed,Object? likes = null,Object? isLiked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ArticleType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as ArticleText,excerpt: null == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as ArticleText,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as List<ArticleText>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ArticleLabel,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<ArticleLabel>,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as ArticleText,readTimeMinutes: null == readTimeMinutes ? _self.readTimeMinutes : readTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextCopyWith<$Res> get title {
  
  return $ArticleTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextCopyWith<$Res> get excerpt {
  
  return $ArticleTextCopyWith<$Res>(_self.excerpt, (value) {
    return _then(_self.copyWith(excerpt: value));
  });
}/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleLabelCopyWith<$Res> get category {
  
  return $ArticleLabelCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextCopyWith<$Res> get author {
  
  return $ArticleTextCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}



/// @nodoc


class _Article implements Article {
  const _Article({required this.id, required this.type, required this.title, required this.excerpt, required final  List<ArticleText> body, required this.category, required final  List<ArticleLabel> tags, required this.publishedAt, required this.author, required this.readTimeMinutes, this.imageAsset, this.likes = 0, this.isLiked = false}): _body = body,_tags = tags;
  

@override final  String id;
@override final  ArticleType type;
@override final  ArticleText title;
@override final  ArticleText excerpt;
/// Body paragraphs (each localised).
 final  List<ArticleText> _body;
/// Body paragraphs (each localised).
@override List<ArticleText> get body {
  if (_body is EqualUnmodifiableListView) return _body;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_body);
}

@override final  ArticleLabel category;
 final  List<ArticleLabel> _tags;
@override List<ArticleLabel> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime publishedAt;
@override final  ArticleText author;
@override final  int readTimeMinutes;
@override final  String? imageAsset;
@override@JsonKey() final  int likes;
@override@JsonKey() final  bool isLiked;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleCopyWith<_Article> get copyWith => __$ArticleCopyWithImpl<_Article>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Article&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.excerpt, excerpt) || other.excerpt == excerpt)&&const DeepCollectionEquality().equals(other._body, _body)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.readTimeMinutes, readTimeMinutes) || other.readTimeMinutes == readTimeMinutes)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,excerpt,const DeepCollectionEquality().hash(_body),category,const DeepCollectionEquality().hash(_tags),publishedAt,author,readTimeMinutes,imageAsset,likes,isLiked);

@override
String toString() {
  return 'Article(id: $id, type: $type, title: $title, excerpt: $excerpt, body: $body, category: $category, tags: $tags, publishedAt: $publishedAt, author: $author, readTimeMinutes: $readTimeMinutes, imageAsset: $imageAsset, likes: $likes, isLiked: $isLiked)';
}


}

/// @nodoc
abstract mixin class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) _then) = __$ArticleCopyWithImpl;
@override @useResult
$Res call({
 String id, ArticleType type, ArticleText title, ArticleText excerpt, List<ArticleText> body, ArticleLabel category, List<ArticleLabel> tags, DateTime publishedAt, ArticleText author, int readTimeMinutes, String? imageAsset, int likes, bool isLiked
});


@override $ArticleTextCopyWith<$Res> get title;@override $ArticleTextCopyWith<$Res> get excerpt;@override $ArticleLabelCopyWith<$Res> get category;@override $ArticleTextCopyWith<$Res> get author;

}
/// @nodoc
class __$ArticleCopyWithImpl<$Res>
    implements _$ArticleCopyWith<$Res> {
  __$ArticleCopyWithImpl(this._self, this._then);

  final _Article _self;
  final $Res Function(_Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? excerpt = null,Object? body = null,Object? category = null,Object? tags = null,Object? publishedAt = null,Object? author = null,Object? readTimeMinutes = null,Object? imageAsset = freezed,Object? likes = null,Object? isLiked = null,}) {
  return _then(_Article(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ArticleType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as ArticleText,excerpt: null == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as ArticleText,body: null == body ? _self._body : body // ignore: cast_nullable_to_non_nullable
as List<ArticleText>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ArticleLabel,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<ArticleLabel>,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as ArticleText,readTimeMinutes: null == readTimeMinutes ? _self.readTimeMinutes : readTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextCopyWith<$Res> get title {
  
  return $ArticleTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextCopyWith<$Res> get excerpt {
  
  return $ArticleTextCopyWith<$Res>(_self.excerpt, (value) {
    return _then(_self.copyWith(excerpt: value));
  });
}/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleLabelCopyWith<$Res> get category {
  
  return $ArticleLabelCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextCopyWith<$Res> get author {
  
  return $ArticleTextCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

// dart format on
