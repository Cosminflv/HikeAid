// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LikeDto extends LikeDto {
  @override
  final int postId;
  @override
  final int userId;

  factory _$LikeDto([void Function(LikeDtoBuilder)? updates]) =>
      (new LikeDtoBuilder()..update(updates))._build();

  _$LikeDto._({required this.postId, required this.userId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(postId, r'LikeDto', 'postId');
    BuiltValueNullFieldError.checkNotNull(userId, r'LikeDto', 'userId');
  }

  @override
  LikeDto rebuild(void Function(LikeDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LikeDtoBuilder toBuilder() => new LikeDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LikeDto && postId == other.postId && userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LikeDto')
          ..add('postId', postId)
          ..add('userId', userId))
        .toString();
  }
}

class LikeDtoBuilder implements Builder<LikeDto, LikeDtoBuilder> {
  _$LikeDto? _$v;

  int? _postId;
  int? get postId => _$this._postId;
  set postId(int? postId) => _$this._postId = postId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  LikeDtoBuilder() {
    LikeDto._defaults(this);
  }

  LikeDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postId = $v.postId;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LikeDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LikeDto;
  }

  @override
  void update(void Function(LikeDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LikeDto build() => _build();

  _$LikeDto _build() {
    final _$result = _$v ??
        new _$LikeDto._(
          postId: BuiltValueNullFieldError.checkNotNull(
              postId, r'LikeDto', 'postId'),
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'LikeDto', 'userId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
