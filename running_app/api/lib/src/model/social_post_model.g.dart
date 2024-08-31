// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_post_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SocialPostModel extends SocialPostModel {
  @override
  final String? content;
  @override
  final DateTime? createdAt;
  @override
  final int? id;
  @override
  final String? imageUrl;
  @override
  final int? userId;

  factory _$SocialPostModel([void Function(SocialPostModelBuilder)? updates]) =>
      (new SocialPostModelBuilder()..update(updates))._build();

  _$SocialPostModel._(
      {this.content, this.createdAt, this.id, this.imageUrl, this.userId})
      : super._();

  @override
  SocialPostModel rebuild(void Function(SocialPostModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SocialPostModelBuilder toBuilder() =>
      new SocialPostModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialPostModel &&
        content == other.content &&
        createdAt == other.createdAt &&
        id == other.id &&
        imageUrl == other.imageUrl &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SocialPostModel')
          ..add('content', content)
          ..add('createdAt', createdAt)
          ..add('id', id)
          ..add('imageUrl', imageUrl)
          ..add('userId', userId))
        .toString();
  }
}

class SocialPostModelBuilder
    implements Builder<SocialPostModel, SocialPostModelBuilder> {
  _$SocialPostModel? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  SocialPostModelBuilder() {
    SocialPostModel._defaults(this);
  }

  SocialPostModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _createdAt = $v.createdAt;
      _id = $v.id;
      _imageUrl = $v.imageUrl;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialPostModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SocialPostModel;
  }

  @override
  void update(void Function(SocialPostModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialPostModel build() => _build();

  _$SocialPostModel _build() {
    final _$result = _$v ??
        new _$SocialPostModel._(
            content: content,
            createdAt: createdAt,
            id: id,
            imageUrl: imageUrl,
            userId: userId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
