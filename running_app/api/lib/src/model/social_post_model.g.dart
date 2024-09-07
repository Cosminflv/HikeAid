// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_post_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SocialPostModel extends SocialPostModel {
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final String? content;
  @override
  final DateTime? createdAt;
  @override
  final String? imageUrl;

  factory _$SocialPostModel([void Function(SocialPostModelBuilder)? updates]) =>
      (new SocialPostModelBuilder()..update(updates))._build();

  _$SocialPostModel._(
      {this.id, this.userId, this.content, this.createdAt, this.imageUrl})
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
        id == other.id &&
        userId == other.userId &&
        content == other.content &&
        createdAt == other.createdAt &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SocialPostModel')
          ..add('id', id)
          ..add('userId', userId)
          ..add('content', content)
          ..add('createdAt', createdAt)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class SocialPostModelBuilder
    implements Builder<SocialPostModel, SocialPostModelBuilder> {
  _$SocialPostModel? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  SocialPostModelBuilder() {
    SocialPostModel._defaults(this);
  }

  SocialPostModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _content = $v.content;
      _createdAt = $v.createdAt;
      _imageUrl = $v.imageUrl;
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
            id: id,
            userId: userId,
            content: content,
            createdAt: createdAt,
            imageUrl: imageUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
