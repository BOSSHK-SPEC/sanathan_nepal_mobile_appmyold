// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleTextModel {

 String get en; String? get ne; String? get hi;
/// Create a copy of ArticleTextModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleTextModelCopyWith<ArticleTextModel> get copyWith => _$ArticleTextModelCopyWithImpl<ArticleTextModel>(this as ArticleTextModel, _$identity);

  /// Serializes this ArticleTextModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleTextModel&&(identical(other.en, en) || other.en == en)&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.hi, hi) || other.hi == hi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,en,ne,hi);

@override
String toString() {
  return 'ArticleTextModel(en: $en, ne: $ne, hi: $hi)';
}


}

/// @nodoc
abstract mixin class $ArticleTextModelCopyWith<$Res>  {
  factory $ArticleTextModelCopyWith(ArticleTextModel value, $Res Function(ArticleTextModel) _then) = _$ArticleTextModelCopyWithImpl;
@useResult
$Res call({
 String en, String? ne, String? hi
});




}
/// @nodoc
class _$ArticleTextModelCopyWithImpl<$Res>
    implements $ArticleTextModelCopyWith<$Res> {
  _$ArticleTextModelCopyWithImpl(this._self, this._then);

  final ArticleTextModel _self;
  final $Res Function(ArticleTextModel) _then;

/// Create a copy of ArticleTextModel
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
@JsonSerializable()

class _ArticleTextModel extends ArticleTextModel {
  const _ArticleTextModel({this.en = '', this.ne, this.hi}): super._();
  factory _ArticleTextModel.fromJson(Map<String, dynamic> json) => _$ArticleTextModelFromJson(json);

@override@JsonKey() final  String en;
@override final  String? ne;
@override final  String? hi;

/// Create a copy of ArticleTextModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleTextModelCopyWith<_ArticleTextModel> get copyWith => __$ArticleTextModelCopyWithImpl<_ArticleTextModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleTextModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleTextModel&&(identical(other.en, en) || other.en == en)&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.hi, hi) || other.hi == hi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,en,ne,hi);

@override
String toString() {
  return 'ArticleTextModel(en: $en, ne: $ne, hi: $hi)';
}


}

/// @nodoc
abstract mixin class _$ArticleTextModelCopyWith<$Res> implements $ArticleTextModelCopyWith<$Res> {
  factory _$ArticleTextModelCopyWith(_ArticleTextModel value, $Res Function(_ArticleTextModel) _then) = __$ArticleTextModelCopyWithImpl;
@override @useResult
$Res call({
 String en, String? ne, String? hi
});




}
/// @nodoc
class __$ArticleTextModelCopyWithImpl<$Res>
    implements _$ArticleTextModelCopyWith<$Res> {
  __$ArticleTextModelCopyWithImpl(this._self, this._then);

  final _ArticleTextModel _self;
  final $Res Function(_ArticleTextModel) _then;

/// Create a copy of ArticleTextModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? en = null,Object? ne = freezed,Object? hi = freezed,}) {
  return _then(_ArticleTextModel(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,ne: freezed == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String?,hi: freezed == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ArticleLabelModel {

 String get key; ArticleTextModel get label;
/// Create a copy of ArticleLabelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleLabelModelCopyWith<ArticleLabelModel> get copyWith => _$ArticleLabelModelCopyWithImpl<ArticleLabelModel>(this as ArticleLabelModel, _$identity);

  /// Serializes this ArticleLabelModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleLabelModel&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label);

@override
String toString() {
  return 'ArticleLabelModel(key: $key, label: $label)';
}


}

/// @nodoc
abstract mixin class $ArticleLabelModelCopyWith<$Res>  {
  factory $ArticleLabelModelCopyWith(ArticleLabelModel value, $Res Function(ArticleLabelModel) _then) = _$ArticleLabelModelCopyWithImpl;
@useResult
$Res call({
 String key, ArticleTextModel label
});


$ArticleTextModelCopyWith<$Res> get label;

}
/// @nodoc
class _$ArticleLabelModelCopyWithImpl<$Res>
    implements $ArticleLabelModelCopyWith<$Res> {
  _$ArticleLabelModelCopyWithImpl(this._self, this._then);

  final ArticleLabelModel _self;
  final $Res Function(ArticleLabelModel) _then;

/// Create a copy of ArticleLabelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as ArticleTextModel,
  ));
}
/// Create a copy of ArticleLabelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextModelCopyWith<$Res> get label {
  
  return $ArticleTextModelCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _ArticleLabelModel extends ArticleLabelModel {
  const _ArticleLabelModel({required this.key, required this.label}): super._();
  factory _ArticleLabelModel.fromJson(Map<String, dynamic> json) => _$ArticleLabelModelFromJson(json);

@override final  String key;
@override final  ArticleTextModel label;

/// Create a copy of ArticleLabelModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleLabelModelCopyWith<_ArticleLabelModel> get copyWith => __$ArticleLabelModelCopyWithImpl<_ArticleLabelModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleLabelModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleLabelModel&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label);

@override
String toString() {
  return 'ArticleLabelModel(key: $key, label: $label)';
}


}

/// @nodoc
abstract mixin class _$ArticleLabelModelCopyWith<$Res> implements $ArticleLabelModelCopyWith<$Res> {
  factory _$ArticleLabelModelCopyWith(_ArticleLabelModel value, $Res Function(_ArticleLabelModel) _then) = __$ArticleLabelModelCopyWithImpl;
@override @useResult
$Res call({
 String key, ArticleTextModel label
});


@override $ArticleTextModelCopyWith<$Res> get label;

}
/// @nodoc
class __$ArticleLabelModelCopyWithImpl<$Res>
    implements _$ArticleLabelModelCopyWith<$Res> {
  __$ArticleLabelModelCopyWithImpl(this._self, this._then);

  final _ArticleLabelModel _self;
  final $Res Function(_ArticleLabelModel) _then;

/// Create a copy of ArticleLabelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,}) {
  return _then(_ArticleLabelModel(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as ArticleTextModel,
  ));
}

/// Create a copy of ArticleLabelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextModelCopyWith<$Res> get label {
  
  return $ArticleTextModelCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}


/// @nodoc
mixin _$ArticleModel {

 String get id;@JsonKey(unknownEnumValue: ArticleType.blog) ArticleType get type; ArticleTextModel get title; ArticleTextModel get excerpt; List<ArticleTextModel> get body; ArticleLabelModel get category; List<ArticleLabelModel> get tags; DateTime get publishedAt; ArticleTextModel get author; int get readTimeMinutes; String? get imageAsset; int get likes; bool get isLiked;
/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleModelCopyWith<ArticleModel> get copyWith => _$ArticleModelCopyWithImpl<ArticleModel>(this as ArticleModel, _$identity);

  /// Serializes this ArticleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.excerpt, excerpt) || other.excerpt == excerpt)&&const DeepCollectionEquality().equals(other.body, body)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.readTimeMinutes, readTimeMinutes) || other.readTimeMinutes == readTimeMinutes)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,excerpt,const DeepCollectionEquality().hash(body),category,const DeepCollectionEquality().hash(tags),publishedAt,author,readTimeMinutes,imageAsset,likes,isLiked);

@override
String toString() {
  return 'ArticleModel(id: $id, type: $type, title: $title, excerpt: $excerpt, body: $body, category: $category, tags: $tags, publishedAt: $publishedAt, author: $author, readTimeMinutes: $readTimeMinutes, imageAsset: $imageAsset, likes: $likes, isLiked: $isLiked)';
}


}

/// @nodoc
abstract mixin class $ArticleModelCopyWith<$Res>  {
  factory $ArticleModelCopyWith(ArticleModel value, $Res Function(ArticleModel) _then) = _$ArticleModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: ArticleType.blog) ArticleType type, ArticleTextModel title, ArticleTextModel excerpt, List<ArticleTextModel> body, ArticleLabelModel category, List<ArticleLabelModel> tags, DateTime publishedAt, ArticleTextModel author, int readTimeMinutes, String? imageAsset, int likes, bool isLiked
});


$ArticleTextModelCopyWith<$Res> get title;$ArticleTextModelCopyWith<$Res> get excerpt;$ArticleLabelModelCopyWith<$Res> get category;$ArticleTextModelCopyWith<$Res> get author;

}
/// @nodoc
class _$ArticleModelCopyWithImpl<$Res>
    implements $ArticleModelCopyWith<$Res> {
  _$ArticleModelCopyWithImpl(this._self, this._then);

  final ArticleModel _self;
  final $Res Function(ArticleModel) _then;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? excerpt = null,Object? body = null,Object? category = null,Object? tags = null,Object? publishedAt = null,Object? author = null,Object? readTimeMinutes = null,Object? imageAsset = freezed,Object? likes = null,Object? isLiked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ArticleType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as ArticleTextModel,excerpt: null == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as ArticleTextModel,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as List<ArticleTextModel>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ArticleLabelModel,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<ArticleLabelModel>,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as ArticleTextModel,readTimeMinutes: null == readTimeMinutes ? _self.readTimeMinutes : readTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextModelCopyWith<$Res> get title {
  
  return $ArticleTextModelCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextModelCopyWith<$Res> get excerpt {
  
  return $ArticleTextModelCopyWith<$Res>(_self.excerpt, (value) {
    return _then(_self.copyWith(excerpt: value));
  });
}/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleLabelModelCopyWith<$Res> get category {
  
  return $ArticleLabelModelCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextModelCopyWith<$Res> get author {
  
  return $ArticleTextModelCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _ArticleModel extends ArticleModel {
  const _ArticleModel({required this.id, @JsonKey(unknownEnumValue: ArticleType.blog) this.type = ArticleType.blog, required this.title, required this.excerpt, final  List<ArticleTextModel> body = const [], required this.category, final  List<ArticleLabelModel> tags = const [], required this.publishedAt, required this.author, this.readTimeMinutes = 1, this.imageAsset, this.likes = 0, this.isLiked = false}): _body = body,_tags = tags,super._();
  factory _ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

@override final  String id;
@override@JsonKey(unknownEnumValue: ArticleType.blog) final  ArticleType type;
@override final  ArticleTextModel title;
@override final  ArticleTextModel excerpt;
 final  List<ArticleTextModel> _body;
@override@JsonKey() List<ArticleTextModel> get body {
  if (_body is EqualUnmodifiableListView) return _body;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_body);
}

@override final  ArticleLabelModel category;
 final  List<ArticleLabelModel> _tags;
@override@JsonKey() List<ArticleLabelModel> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  DateTime publishedAt;
@override final  ArticleTextModel author;
@override@JsonKey() final  int readTimeMinutes;
@override final  String? imageAsset;
@override@JsonKey() final  int likes;
@override@JsonKey() final  bool isLiked;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleModelCopyWith<_ArticleModel> get copyWith => __$ArticleModelCopyWithImpl<_ArticleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.excerpt, excerpt) || other.excerpt == excerpt)&&const DeepCollectionEquality().equals(other._body, _body)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.author, author) || other.author == author)&&(identical(other.readTimeMinutes, readTimeMinutes) || other.readTimeMinutes == readTimeMinutes)&&(identical(other.imageAsset, imageAsset) || other.imageAsset == imageAsset)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,excerpt,const DeepCollectionEquality().hash(_body),category,const DeepCollectionEquality().hash(_tags),publishedAt,author,readTimeMinutes,imageAsset,likes,isLiked);

@override
String toString() {
  return 'ArticleModel(id: $id, type: $type, title: $title, excerpt: $excerpt, body: $body, category: $category, tags: $tags, publishedAt: $publishedAt, author: $author, readTimeMinutes: $readTimeMinutes, imageAsset: $imageAsset, likes: $likes, isLiked: $isLiked)';
}


}

/// @nodoc
abstract mixin class _$ArticleModelCopyWith<$Res> implements $ArticleModelCopyWith<$Res> {
  factory _$ArticleModelCopyWith(_ArticleModel value, $Res Function(_ArticleModel) _then) = __$ArticleModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: ArticleType.blog) ArticleType type, ArticleTextModel title, ArticleTextModel excerpt, List<ArticleTextModel> body, ArticleLabelModel category, List<ArticleLabelModel> tags, DateTime publishedAt, ArticleTextModel author, int readTimeMinutes, String? imageAsset, int likes, bool isLiked
});


@override $ArticleTextModelCopyWith<$Res> get title;@override $ArticleTextModelCopyWith<$Res> get excerpt;@override $ArticleLabelModelCopyWith<$Res> get category;@override $ArticleTextModelCopyWith<$Res> get author;

}
/// @nodoc
class __$ArticleModelCopyWithImpl<$Res>
    implements _$ArticleModelCopyWith<$Res> {
  __$ArticleModelCopyWithImpl(this._self, this._then);

  final _ArticleModel _self;
  final $Res Function(_ArticleModel) _then;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? excerpt = null,Object? body = null,Object? category = null,Object? tags = null,Object? publishedAt = null,Object? author = null,Object? readTimeMinutes = null,Object? imageAsset = freezed,Object? likes = null,Object? isLiked = null,}) {
  return _then(_ArticleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ArticleType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as ArticleTextModel,excerpt: null == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as ArticleTextModel,body: null == body ? _self._body : body // ignore: cast_nullable_to_non_nullable
as List<ArticleTextModel>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ArticleLabelModel,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<ArticleLabelModel>,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as ArticleTextModel,readTimeMinutes: null == readTimeMinutes ? _self.readTimeMinutes : readTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,imageAsset: freezed == imageAsset ? _self.imageAsset : imageAsset // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextModelCopyWith<$Res> get title {
  
  return $ArticleTextModelCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextModelCopyWith<$Res> get excerpt {
  
  return $ArticleTextModelCopyWith<$Res>(_self.excerpt, (value) {
    return _then(_self.copyWith(excerpt: value));
  });
}/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleLabelModelCopyWith<$Res> get category {
  
  return $ArticleLabelModelCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleTextModelCopyWith<$Res> get author {
  
  return $ArticleTextModelCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

// dart format on
