// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_post_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SocialPostDto extends SocialPostDto {
  @override
  final int id;
  @override
  final String content;
  @override
  final String imageUrl;

  factory _$SocialPostDto([void Function(SocialPostDtoBuilder)? updates]) =>
      (new SocialPostDtoBuilder()..update(updates))._build();

  _$SocialPostDto._(
      {required this.id, required this.content, required this.imageUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'SocialPostDto', 'id');
    BuiltValueNullFieldError.checkNotNull(content, r'SocialPostDto', 'content');
    BuiltValueNullFieldError.checkNotNull(
        imageUrl, r'SocialPostDto', 'imageUrl');
  }

  @override
  SocialPostDto rebuild(void Function(SocialPostDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SocialPostDtoBuilder toBuilder() => new SocialPostDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialPostDto &&
        id == other.id &&
        content == other.content &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SocialPostDto')
          ..add('id', id)
          ..add('content', content)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class SocialPostDtoBuilder
    implements Builder<SocialPostDto, SocialPostDtoBuilder> {
  _$SocialPostDto? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  SocialPostDtoBuilder() {
    SocialPostDto._defaults(this);
  }

  SocialPostDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _content = $v.content;
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialPostDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SocialPostDto;
  }

  @override
  void update(void Function(SocialPostDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialPostDto build() => _build();

  _$SocialPostDto _build() {
    final _$result = _$v ??
        new _$SocialPostDto._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'SocialPostDto', 'id'),
          content: BuiltValueNullFieldError.checkNotNull(
              content, r'SocialPostDto', 'content'),
          imageUrl: BuiltValueNullFieldError.checkNotNull(
              imageUrl, r'SocialPostDto', 'imageUrl'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
